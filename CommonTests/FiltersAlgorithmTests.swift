//
//  FiltersAlgorithmTests.swift
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

class FiltersAlgorithmTests: XCTestCase {

  /// Tests the functionality of the IIRFilter algorithm. Values taken from `test_iir.py`.
  func testIIRFilter() {

    /// Simple helper for creating a trivial `IIRFilter` algorithm instance.
    ///
    /// - Returns: A simple IIR filter.
    func loadSimpleFilter() -> IIRAlgorithm {
      let b = Parameter(value: .realVec(loadVector(name: "iir_b")))
      let a = Parameter(value: .realVec(loadVector(name: "iir_a")))
      return IIRAlgorithm([.numerator: b, .denominator: a])
    }

    /*
     Test with an empty input signal.
     */

    let iir1 = loadSimpleFilter()
    iir1[realVecInput: .signal] = []
    iir1.compute()

    XCTAssert(iir1[realVecOutput: .signal].isEmpty)

    /*
     Test that filtering samples one-by-one yields the same result as by vector.
     */

    let signal1 = loadVector(name: "iir_x")

    let iir2 = loadSimpleFilter()
    iir2[realVecInput: .signal] = signal1
    iir2.compute()

    let iir3 = loadSimpleFilter()
    var filtered: [Float] = []

    for sample in signal1 {

      iir3[realVecInput: .signal] = [sample]
      iir3.compute()
      filtered.append(contentsOf: iir3[realVecOutput: .signal])

    }

    XCTAssertEqual(iir2[realVecOutput: .signal], filtered, accuracy: 1e-6)

    /*
     Test that filtering all-zero input yields zeros.
     */

    let iir4 = loadSimpleFilter()
    iir4[realVecInput: .signal] = [0.0] * 20
    iir4.compute()

    XCTAssertEqual(iir4[realVecOutput: .signal], [0.0] * 20)

    /*
     Test for regression when the number of numerator coefficients is equal to the number of
     denominator coefficients.
     */

    let x = loadVector(name: "iir_x")

    let b1 = Parameter(value: .realVec(loadVector(name: "iir_ba")))
    let a1 = Parameter(value: .realVec(loadVector(name: "iir_ab")))
    let iir5 = IIRAlgorithm([.numerator: b1, .denominator: a1])
    iir5[realVecInput: .signal] = x
    iir5.compute()

    XCTAssertEqual(iir5[realVecOutput: .signal], loadVector(name: "iir_y1"), accuracy: 1e-6)

    /*
     Test for regression when the number of numerator coefficients is greater than the number of
     denominator coefficients.
     */

    let b2 = Parameter(value: .realVec(loadVector(name: "iir_b")))
    let a2 = Parameter(value: .realVec(loadVector(name: "iir_a")))
    let iir6 = IIRAlgorithm([.numerator: b2, .denominator: a2])
    iir6[realVecInput: .signal] = x
    iir6.compute()

    XCTAssertEqual(iir6[realVecOutput: .signal], loadVector(name: "iir_y2"), accuracy: 1e-6)

    /*
     Test for regression when the number of numerator coefficients is less than the number of
     denominator coefficients.
     */

    let iir7 = IIRAlgorithm([.numerator: a2, .denominator: b2])
    iir7[realVecInput: .signal] = x
    iir7.compute()

    XCTAssertEqual(iir7[realVecOutput: .signal], loadVector(name: "iir_y3"), accuracy: 1e-6)

  }

  /// Tests the functionality of the `DCRemoval` algorithm. Values taken from `test_dcremoval.py`.
  func testDCRemoval() {

    /*
     Test that filtering one by one is the same as all at once.
     */

    let signal1: [Float] = [1, 2, 3, 4, 5, 6, 7]

    let dcRemoval1 = DCRemovalAlgorithm()
    dcRemoval1[realVecInput: .signal] = signal1
    dcRemoval1.compute()

    let expected = dcRemoval1[realVecOutput: .signal]

    dcRemoval1.reset()

    var output: [Float] = []

    for sample in signal1 {

      dcRemoval1[realVecInput: .signal] = [sample]
      dcRemoval1.compute()

      output.append(contentsOf: dcRemoval1[realVecOutput: .signal])

    }

    XCTAssertEqual(output, expected)

    /*
     Test with all-zero input.
     */

    let dcRemoval2 = DCRemovalAlgorithm()
    dcRemoval2[realVecInput: .signal] = [0.0] * 20
    dcRemoval2.compute()

    XCTAssertEqual(dcRemoval2[realVecOutput: .signal], [0.0] * 20)

    /*
     Test with constant input.
     */

    let dcRemoval3 = DCRemovalAlgorithm()
    dcRemoval3[realVecInput: .signal] = [1.0] * 20000
    dcRemoval3.compute()

    XCTAssertEqual(Array(dcRemoval3[realVecOutput: .signal].dropFirst(1000)), [0.0] * 19000,
                   accuracy: 3.3e-3)

    /*
     Test with a real signal modified with an artificial DC offset.
     */

    let signal2 = monoBufferData(url: bundleURL(name: "sin_30_seconds", ext: "wav"))

    let dcRemoval4 = DCRemovalAlgorithm()
    dcRemoval4[realVecInput: .signal] = signal2.map({$0 + 0.2})
    dcRemoval4.compute()

    XCTAssertAverageEqual(Array(dcRemoval4[realVecOutput: .signal].dropFirst(2500)), 0.0,
                          accuracy: 1e-6)

  }

  /// Tests the functionality of the `EqualLoudness` algorithm. Values taken from
  /// `test_equalloudness.py`.
  func testEqualLoudness() {

    /*
     Test that filtering one by one is the same as all at once.
     */

    let signal1: [Float] = [1, 2, 3, 4, 5, 6, 7]

    let equalLoudness1 = EqualLoudnessAlgorithm()
    equalLoudness1[realVecInput: .signal] = signal1
    equalLoudness1.compute()

    let expected1 = equalLoudness1[realVecOutput: .signal]

    equalLoudness1.reset()

    var output1: [Float] = []

    for sample in signal1 {

      equalLoudness1[realVecInput: .signal] = [sample]
      equalLoudness1.compute()

      output1.append(contentsOf: equalLoudness1[realVecOutput: .signal])

    }

    XCTAssertEqual(output1, expected1)

    /*
     Test with all-zero input.
     */

    let equalLoudness2 = EqualLoudnessAlgorithm()
    equalLoudness2[realVecInput: .signal] = [0.0] * 20
    equalLoudness2.compute()

    XCTAssertEqual(equalLoudness2[realVecOutput: .signal], [0.0] * 20)

    /*
     Test with two real signals, the second being the expected result of filtering the first.
     */

    let signal2 = monoBufferData(url: bundleURL(name: "sin_30_seconds", ext: "wav"))
    let expected2 = monoBufferData(url: bundleURL(name: "sin_30_seconds_eqloud", ext: "wav"))

    let equalLoudness3 = EqualLoudnessAlgorithm()
    equalLoudness3[realVecInput: .signal] = Array(signal2[...100000])
    equalLoudness3.compute()

    XCTAssertEqual(equalLoudness3[realVecOutput: .signal], Array(expected2[...100000]),
                   accuracy: 1e-4)

  }

  /// Tests the functionality of the MovingAverage algorithm. Values taken from
  /// `test_movingaverage.py`.
  func testMovingAverage() {

    /*
     Test for regression.
     */

    let movingAverage1 = MovingAverageAlgorithm([.size: 6])
    movingAverage1[realVecInput: .signal] = [1.0] * 10
    movingAverage1.compute()

    XCTAssertEqual(movingAverage1[realVecOutput: .signal],
                   [Float(1)/6, Float(2)/6, Float(3)/6, Float(4)/6, Float(5)/6, 1, 1, 1, 1, 1],
                   accuracy: 1e-7)


    /*
     Test that filtering one by one is the same as all at once.
     */

    let movingAverage2 = MovingAverageAlgorithm([.size: 4])
    movingAverage2[realVecInput: .signal] = [1.0] * 10
    movingAverage2.compute()

    XCTAssertEqual(movingAverage2[realVecOutput: .signal],
                   [Float(1)/4, Float(2)/4, Float(3)/4, 1, 1, 1, 1, 1, 1, 1])


    let movingAverage3 = MovingAverageAlgorithm([.size: 4])
    var filtered: [Float] = []

    for _ in 0..<10 {

      movingAverage3[realVecInput: .signal] = [1]
      movingAverage3.compute()
      filtered.append(contentsOf: movingAverage3[realVecOutput: .signal])

    }

    XCTAssertEqual(filtered, [Float(1)/4, Float(2)/4, Float(3)/4, 1, 1, 1, 1, 1, 1, 1])

    /*
     Test with all-zero input.
     */

    let movingAverage4 = MovingAverageAlgorithm()
    movingAverage4[realVecInput: .signal] = [0.0] * 20
    movingAverage4.compute()

    XCTAssertEqual(movingAverage4[realVecOutput: .signal], [0.0] * 20)


    /*
     Test with an empty signal.
     */

    let movingAverage5 = MovingAverageAlgorithm()
    movingAverage5[realVecInput: .signal] = []
    movingAverage5.compute()

    XCTAssert(movingAverage5[realVecOutput: .signal].isEmpty)

  }

}
