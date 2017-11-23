//
//  MathAlgorithmTests.swift
//  Essentia
//
//  Created by Jason Cardwell on 11/22/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
import XCTest
@testable import Essentia
import AVFoundation
import Accelerate

// Declare custom operators since they cannot be exported from `Essentia`.
infix operator >>
infix operator >!
postfix operator >>|
postfix operator >>>

class MathAlgorithmTests: XCTestCase {

  /// Tests the functionality of the Magnitude algorithm. Values taken from `test_magnitude.py`.
  func testMagnitude() {

    /*
     Test with all-zero input.
     */

    let magnitude1 = StandardAlgorithm<Standard.Magnitude>()
    magnitude1[complexRealVecInput: .complex] = [DSPComplex()] * 4
    magnitude1.compute()

    XCTAssertEqual(magnitude1[realVecOutput: .magnitude], [0.0] * 4)

    /*
     Test with empty input.
     */

    let magnitude2 = StandardAlgorithm<Standard.Magnitude>()
    magnitude2[complexRealVecInput: .complex] = []
    magnitude2.compute()

    XCTAssert(magnitude2[realVecOutput: .magnitude].isEmpty)


    /*
     Test for regression.
     */

    let magnitude3 = StandardAlgorithm<Standard.Magnitude>()
    magnitude3[complexRealVecInput: .complex] = [
      DSPComplex(real: 1, imag: -5),
      DSPComplex(real: 2, imag: -6),
      DSPComplex(real: -3, imag: 7),
      DSPComplex(real: -4, imag: 8)
    ]
    magnitude3.compute()

    XCTAssertEqual(magnitude3[realVecOutput: .magnitude],
                   [sqrtf(26), sqrtf(40), sqrtf(58), sqrtf(80)])


  }

  /// Tests the functionality of the CartesianToPolar algorithm. Values taken from
  /// `test_cartesiantopolar.py`.
  func testCartesionToPolar() {

    /*
     Test with all-zero input.
     */

    let cartesianToPolar1 = StandardAlgorithm<Standard.CartesianToPolar>()
    cartesianToPolar1[complexRealVecInput: .complex] = [DSPComplex()] * 4
    cartesianToPolar1.compute()

    XCTAssertEqual(cartesianToPolar1[realVecOutput: .magnitude], [0.0] * 4)
    XCTAssertEqual(cartesianToPolar1[realVecOutput: .phase], [0.0] * 4)

    /*
     Test for regression.
     */

    let cartesianToPolar2 = StandardAlgorithm<Standard.CartesianToPolar>()
    cartesianToPolar2[complexRealVecInput: .complex] = [
      DSPComplex(real: 1, imag: -5),
      DSPComplex(real: 2, imag: -6),
      DSPComplex(real: -3, imag: 7),
      DSPComplex(real: -4, imag: 8)
    ]
    cartesianToPolar2.compute()

    XCTAssertEqual(cartesianToPolar2[realVecOutput: .magnitude],
                   [5.0990, 6.3246, 7.6158, 8.9443],
                   accuracy: 1e-4)
    XCTAssertEqual(cartesianToPolar2[realVecOutput: .phase],
                   [-1.3734, -1.2490, 1.9757, 2.0344],
                   accuracy: 1e-4)

    let circle: [(DSPComplex, magnitude: Float, phase: Float)] = [
      (DSPComplex(real: 1, imag: 0), magnitude: 1, phase: 0),
      (DSPComplex(real: sqrtf(2) / 2, imag: sqrtf(2) / 2), magnitude: 1, phase: Float.pi / 4),
      (DSPComplex(real: 1, imag: 1), magnitude: sqrtf(2), phase: Float.pi / 4),
      (DSPComplex(real: 0, imag: 1), magnitude: 1, phase: Float.pi / 2),
      (DSPComplex(real: -1, imag: 0), magnitude: 1, phase: Float.pi),
      (DSPComplex(real: 0, imag: -1), magnitude: 1, phase: -Float.pi / 2)
    ]

    /*
     Test with some points on a circle.
     */

    for (input, magnitude, phase) in circle {

      let cartesianToPolar = StandardAlgorithm<Standard.CartesianToPolar>()
      cartesianToPolar[complexRealVecInput: .complex] = [input]
      cartesianToPolar.compute()

      XCTAssertEqual(cartesianToPolar[realVecOutput: .magnitude], [magnitude], accuracy: 1e-7)
      XCTAssertEqual(cartesianToPolar[realVecOutput: .phase], [phase], accuracy: 1e-6)

    }

    let cartesianToPolar3 = StandardAlgorithm<Standard.CartesianToPolar>()
    cartesianToPolar3[complexRealVecInput: .complex] = circle.map({$0.0})
    cartesianToPolar3.compute()

    XCTAssertEqual(cartesianToPolar3[realVecOutput: .magnitude],
                   circle.map({$0.magnitude}),
                   accuracy: 1e-7)
    XCTAssertEqual(cartesianToPolar3[realVecOutput: .phase],
                   circle.map({$0.phase}),
                   accuracy: 1e-6)

  }

}
