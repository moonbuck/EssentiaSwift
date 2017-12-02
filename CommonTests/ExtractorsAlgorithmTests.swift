//
//  ExtractorsAlgorithmTests.swift
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

private let accuracy: Float = 1e-2
private let deviation: Float = 1e-3

class ExtractorsAlgorithmTests: XCTestCase {

  /// Tests the functionality of the Extractor algorithm.
  func testExtractor() {

    let extractor = ExtractorAlgorithm()
    extractor[realVecInput: .audio] = loadVector(name: "extractor_input")
    extractor.compute()

    let pool = extractor[poolOutput: .pool]

    for descriptor in pool.descriptorNames {

      let expectedFileName = "\(descriptor)_expected"
      let descriptorʹ = "descriptor: '\(descriptor)'"

      switch pool[descriptor: descriptor] {

      case .real(let actual):

       XCTAssertEqual(actual, loadValue(name: expectedFileName), accuracy: accuracy, descriptorʹ)

      case .realVec(let actual):

        let expected = loadVector(name: expectedFileName)

        if !XCTAssertDifferenceMeanOrDeviationLessThanOrEqual(actual, expected,
                                                              mean: accuracy,
                                                              deviation: deviation,
                                                              descriptorʹ)
        {
          add(comparisonAttachment(with: actual,
                                   expected: expected,
                                   accuracyUsed: accuracy,
                                   deviationUsed: deviation,
                                   descriptor: descriptor,
                                   results: [.differenceMeanOrDeviation: false]))
        }

      case .realVecVec(let actual):

        let expected = loadVectorVector(name: expectedFileName)

        if !XCTAssertDifferenceMeanOrDeviationLessThanOrEqual(actual, expected,
                                                              mean: accuracy,
                                                              deviation: deviation,
                                                              descriptorʹ)
        {
          add(comparisonAttachment(with: actual,
                                   expected: expected,
                                   accuracyUsed: accuracy,
                                   deviationUsed: deviation,
                                   descriptor: descriptor,
                                   results: [.differenceMeanOrDeviation: false]))
        }

      case .string(let actual):

        XCTAssertEqual(actual, loadString(name: expectedFileName), descriptorʹ)

      case .stringVec(let actual):

        let currentFailureCount = testRun!.failureCount
        let expected = loadStringVector(name: expectedFileName)
        XCTAssertEqual(actual, expected, descriptorʹ)

        if testRun!.failureCount > currentFailureCount {

          add(comparisonAttachment(with: actual,
                                   expected: expected,
                                   descriptor: descriptor,
                                   results: [.equality: false]))

        }

      case .stringVecVec, .realMatrixVec, .stereoSample, .stereoSampleVec, .none:

        XCTFail("Unexpected value type stored for descriptor '\(descriptor)'.")

      }

    }

  }

}
