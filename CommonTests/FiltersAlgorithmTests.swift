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

  /// Tests the functionality of the `DCRemoval` algorithm. Values taken from `test_dcremoval.py`.
  func testDCRemoval() {

    /*
     Test that filtering one by one is the same as all at once.
     */

    let signal1: [Float] = [1, 2, 3, 4, 5, 6, 7]

    let dcRemoval1 = StandardAlgorithm<Standard.DCRemoval>()
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

    let dcRemoval2 = StandardAlgorithm<Standard.DCRemoval>()
    dcRemoval2[realVecInput: .signal] = [0.0] * 20
    dcRemoval2.compute()

    XCTAssertEqual(dcRemoval2[realVecOutput: .signal], [0.0] * 20)

    /*
     Test with constant input.
     */

    let dcRemoval3 = StandardAlgorithm<Standard.DCRemoval>()
    dcRemoval3[realVecInput: .signal] = [1.0] * 20000
    dcRemoval3.compute()

    XCTAssertEqual(Array(dcRemoval3[realVecOutput: .signal].dropFirst(1000)), [0.0] * 19000,
                   accuracy: 3.3e-3)

    /*
     Test with a real signal modified with an artificial DC offset.
     */

    let signal2 = monoBufferData(url: bundleURL(name: "sin_30_seconds", ext: "wav"))

    let dcRemoval4 = StandardAlgorithm<Standard.DCRemoval>()
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

    let equalLoudness1 = StandardAlgorithm<Standard.EqualLoudness>()
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

    let equalLoudness2 = StandardAlgorithm<Standard.EqualLoudness>()
    equalLoudness2[realVecInput: .signal] = [0.0] * 20
    equalLoudness2.compute()

    XCTAssertEqual(equalLoudness2[realVecOutput: .signal], [0.0] * 20)

    /*
     Test with two real signals, the second being the expected result of filtering the first.
     */

    let signal2 = monoBufferData(url: bundleURL(name: "sin_30_seconds", ext: "wav"))
    let expected2 = monoBufferData(url: bundleURL(name: "sin_30_seconds_eqloud", ext: "wav"))

    let equalLoudness3 = StandardAlgorithm<Standard.EqualLoudness>()
    equalLoudness3[realVecInput: .signal] = Array(signal2[...100000])
    equalLoudness3.compute()

    XCTAssertEqual(equalLoudness3[realVecOutput: .signal], Array(expected2[...100000]),
                   accuracy: 1e-4)

  }

}
