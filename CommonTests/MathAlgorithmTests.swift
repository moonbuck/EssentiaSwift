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

    let magnitude1 = MagnitudeAlgorithm()
    magnitude1[complexRealVecInput: .complex] = [DSPComplex()] * 4
    magnitude1.compute()

    XCTAssertEqual(magnitude1[realVecOutput: .magnitude], [0.0] * 4)

    /*
     Test with empty input.
     */

    let magnitude2 = MagnitudeAlgorithm()
    magnitude2[complexRealVecInput: .complex] = []
    magnitude2.compute()

    XCTAssert(magnitude2[realVecOutput: .magnitude].isEmpty)


    /*
     Test for regression.
     */

    let magnitude3 = MagnitudeAlgorithm()
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

    let cartesianToPolar1 = CartesianToPolarAlgorithm()
    cartesianToPolar1[complexRealVecInput: .complex] = [DSPComplex()] * 4
    cartesianToPolar1.compute()

    XCTAssertEqual(cartesianToPolar1[realVecOutput: .magnitude], [0.0] * 4)
    XCTAssertEqual(cartesianToPolar1[realVecOutput: .phase], [0.0] * 4)

    /*
     Test for regression.
     */

    let cartesianToPolar2 = CartesianToPolarAlgorithm()
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

      let cartesianToPolar = CartesianToPolarAlgorithm()
      cartesianToPolar[complexRealVecInput: .complex] = [input]
      cartesianToPolar.compute()

      XCTAssertEqual(cartesianToPolar[realVecOutput: .magnitude], [magnitude], accuracy: 1e-7)
      XCTAssertEqual(cartesianToPolar[realVecOutput: .phase], [phase], accuracy: 1e-6)

    }

    let cartesianToPolar3 = CartesianToPolarAlgorithm()
    cartesianToPolar3[complexRealVecInput: .complex] = circle.map({$0.0})
    cartesianToPolar3.compute()

    XCTAssertEqual(cartesianToPolar3[realVecOutput: .magnitude],
                   circle.map({$0.magnitude}),
                   accuracy: 1e-7)
    XCTAssertEqual(cartesianToPolar3[realVecOutput: .phase],
                   circle.map({$0.phase}),
                   accuracy: 1e-6)

  }

  /// Tests the functionality of the PolarToCartesian algorithm. Values taken from
  /// `test_polartocartesian.py`.
  func testPolarToCartesian() {

    /*
     Test with empty input.
     */

    let polarToCartesian1 = PolarToCartesianAlgorithm()
    polarToCartesian1[realVecInput: .magnitude] = []
    polarToCartesian1[realVecInput: .phase] = []
    polarToCartesian1.compute()

    XCTAssert(polarToCartesian1[complexRealVecOutput: .complex].isEmpty)

    /*
     Test for regression.
     */

    let magnitudes: [Float] = [1, 4, 1.345, 0.321, -4]
    let phases: [Float] = [0.45, 3.14, 2.543, 6.42, 1]

    let polarToCartesian2 = PolarToCartesianAlgorithm()
    polarToCartesian2[realVecInput: .magnitude] = magnitudes
    polarToCartesian2[realVecInput: .phase] = phases
    polarToCartesian2.compute()

    let expected = (0..<5).map {
      DSPComplex(real: magnitudes[$0] * cosf(phases[$0]), imag: magnitudes[$0] * sinf(phases[$0]))
    }

    XCTAssertEqual(polarToCartesian2[complexRealVecOutput: .complex], expected, accuracy: 1e-6)

    /*
     Test with complex representations of real values.
     */

    let polarToCartesian3 = PolarToCartesianAlgorithm()
    polarToCartesian3[realVecInput: .magnitude] = [1, 2, 3, 4]
    polarToCartesian3[realVecInput: .phase] = [0, 0, 0, 0]
    polarToCartesian3.compute()

    XCTAssertEqual(polarToCartesian3[complexRealVecOutput: .complex],
                   [1+0⍳, 2+0⍳, 3+0⍳, 4+0⍳],
                   accuracy: 0)

  }
  
}
