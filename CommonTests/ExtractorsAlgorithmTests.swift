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

class ExtractorsAlgorithmTests: XCTestCase {

  /// Tests the functionality of the Extractor algorithm.
  func testExtractor() {

    let extractor = ExtractorAlgorithm()
    extractor[realVecInput: .audio] = loadVector(name: "extractor_input")
    extractor.compute()

    let pool = extractor[poolOutput: .pool]

    let accuracy: Float = 1e-4
    let deviation: Float = 1e-4

    var attachmentText = """
      Assertion Parameters:
        accuracy = \(accuracy)
        deviation = \(deviation)
      """

    for descriptor in pool.descriptorNames {

      let expectedFileName = "\(descriptor)_expected"
      let descriptorʹ = "descriptor: '\(descriptor)'"

      switch pool[descriptor: descriptor] {

      case .real(let actual):

        let expected = loadValue(name: expectedFileName)

        let currentFailureCount = testRun!.failureCount

        XCTAssertEqual(actual, expected, accuracy: accuracy, descriptorʹ)

        if testRun!.failureCount > currentFailureCount {
          print("\n\n\(descriptorʹ)", to: &attachmentText)
          dumpComparison(of: [actual], with: [expected], target: &attachmentText)
          print("\n\n", to: &attachmentText)
        }

      case .realVec(let actual):

        let expected = loadVector(name: expectedFileName)

        let results = [
          "accuracy":
            XCTAssertEqual(actual, expected, accuracy: accuracy, descriptorʹ),
          "deviation":
            XCTAssertEqual(actual, expected, deviation: deviation, descriptorʹ),
          "differenceMean":
            XCTAssertDifferenceMeanLessThanOrEqual(actual, expected, accuracy,descriptorʹ),
          "percentDeviation":
            XCTAssertPercentDeviationLessThanOrEqual(actual, expected, deviation, descriptorʹ)
        ]

        if results.values.contains(false) {

          var failures: [String] = []
          if results["accuracy"] == false { failures.append("accuracy") }
          if results["deviation"] == false { failures.append("deviation") }
          if results["differenceMean"] == false { failures.append("differenceMean") }
          if results["percentDeviation"] == false { failures.append("percentDeviation") }
          let failuresʹ = "(failed tests: \(failures.joined(separator: ", ")))"

          print("\n\n", to: &attachmentText)

          print(descriptorʹ, failuresʹ, to: &attachmentText)

          dumpComparison(of: actual, with: expected, target: &attachmentText)

          print("\n\n", to: &attachmentText)

        }

      case .realVecVec(let actual):

        let expected = loadVectorVector(name: expectedFileName)

        let results = [
          "accuracy":
            XCTAssertEqual(actual, expected, accuracy: accuracy, descriptorʹ),
          "deviation":
            XCTAssertEqual(actual, expected, deviation: deviation, descriptorʹ),
          "differenceMean":
            XCTAssertDifferenceMeanLessThanOrEqual(actual, expected, accuracy,descriptorʹ),
          "percentDeviation":
            XCTAssertPercentDeviationLessThanOrEqual(actual, expected, deviation, descriptorʹ)
        ]

        if results.values.contains(false) {

          var failures: [String] = []
          if results["accuracy"] == false { failures.append("accuracy") }
          if results["deviation"] == false { failures.append("deviation") }
          if results["differenceMean"] == false { failures.append("differenceMean") }
          if results["percentDeviation"] == false { failures.append("percentDeviation") }
          let failuresʹ = "(failed tests: \(failures.joined(separator: ", ")))"

          print("\n\n", to: &attachmentText)

          print(descriptorʹ, failuresʹ, to: &attachmentText)

          dumpComparison(of: actual, with: expected, target: &attachmentText)

          print("\n\n", to: &attachmentText)

        }

      case .string(let actual):

        let expected = loadString(name: expectedFileName)

        let currentFailureCount = testRun!.failureCount

        XCTAssertEqual(actual, expected, descriptorʹ)

        if testRun!.failureCount > currentFailureCount {
          print("\n\n\(descriptorʹ)", to: &attachmentText)
          dumpComparison(of: [actual], with: [expected], target: &attachmentText)
          print("\n\n", to: &attachmentText)
        }

      case .stringVec(let actual):

        let expected = loadStringVector(name: expectedFileName)
        
        let currentFailureCount = testRun!.failureCount

        XCTAssertEqual(actual, expected, descriptorʹ)

        if testRun!.failureCount > currentFailureCount {
          print("\n\n\(descriptorʹ)", to: &attachmentText)
          dumpComparison(of: actual, with: expected, target: &attachmentText)
          print("\n\n", to: &attachmentText)
        }

      case .stringVecVec, .realMatrixVec, .stereoSample, .stereoSampleVec, .none:
        XCTFail("Unexpected value type stored for descriptor '\(descriptor)'.")

      }

    }

    add(XCTAttachment(data: attachmentText.data(using: .utf8)!,
                      uniformTypeIdentifier: "public.text",
                      lifetime: .keepAlways))
  }

}
