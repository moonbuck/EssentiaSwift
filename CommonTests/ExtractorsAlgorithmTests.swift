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

    var attachmentText = ""

    for descriptor in pool.descriptorNames {

      let expectedFileName = "\(descriptor)_expected"
      let descriptorʹ = "descriptor: '\(descriptor)'"

      switch pool[descriptor: descriptor] {

      case .real(let actual):
        let expected = loadValue(name: expectedFileName)
        XCTAssertEqual(actual, expected, accuracy: 1e-6,
                       "descriptor: '\(descriptor)'")

      case .realVec(let actual):
        let expected = loadVector(name: expectedFileName)

        let results = [
          "accuracy":
            XCTAssertEqual(actual, expected, accuracy: 1e-5, descriptorʹ),
          "deviation":
            XCTAssertEqual(actual, expected, deviation: 1e-5, descriptorʹ),
          "differenceMean":
            XCTAssertDifferenceMeanLessThanOrEqual(actual, expected, 1e-5,descriptorʹ),
          "percentDeviation":
            XCTAssertPercentDeviationLessThanOrEqual(actual, expected, 1e-5, descriptorʹ)
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

          dumpComparison(of: "Actual", actual,
                         with: "Expected", expected,
                         valueFormat: "%.11f",
                         target: &attachmentText)

          print("\n\n", to: &attachmentText)
        }

      case .realVecVec(let actual):
        let expected = loadVectorVector(name: expectedFileName)
        XCTAssertEqual(actual, expected, accuracy: 1e-5, descriptorʹ)
        XCTAssertEqual(actual, expected, deviation: 1e-5, descriptorʹ)
        XCTAssertDifferenceMeanLessThanOrEqual(actual, expected, 1e-5, descriptorʹ)
        XCTAssertPercentDeviationLessThanOrEqual(actual, expected, 1e-5, descriptorʹ)

      case .string(let actual):
        let expected = loadString(name: expectedFileName)
        XCTAssertEqual(actual, expected, descriptorʹ)

      case .stringVec(let actual):
        let expected = loadStringVector(name: expectedFileName)
        XCTAssertEqual(actual, expected, descriptorʹ)

      case .stringVecVec, .realMatrixVec, .stereoSample, .stereoSampleVec, .none:
        XCTFail("Unexpected value type stored for descriptor '\(descriptor)'.")

      }

    }

    add(XCTAttachment(data: attachmentText.data(using: .utf8)!,
                      uniformTypeIdentifier: "public.text",
                      lifetime: .keepAlways))
  }

}
