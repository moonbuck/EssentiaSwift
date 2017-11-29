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

    for descriptor in pool.descriptorNames {

      let expectedFileName = "\(descriptor)_expected"

      switch pool[descriptor: descriptor] {

      case .real(let actual):
        let expected = loadValue(name: expectedFileName)
        XCTAssertEqual(actual, expected, accuracy: 1e-6,
                       "descriptor: '\(descriptor)'")

      case .realVec(let actual):
        let expected = loadVector(name: expectedFileName)
        XCTAssertEqual(actual, expected, deviation: 1e-5,
                       "descriptor: '\(descriptor)'")

      case .realVecVec(let actual):
        let expected = loadVectorVector(name: expectedFileName)
        XCTAssertEqual(actual, expected, deviation: 1e-5,
                       "descriptor: '\(descriptor)'")

      case .string(let actual):
        let expected = loadString(name: expectedFileName)
        XCTAssertEqual(actual, expected,
                       "descriptor: '\(descriptor)'")

      case .stringVec(let actual):
        let expected = loadStringVector(name: expectedFileName)
        XCTAssertEqual(actual, expected,
                       "descriptor: '\(descriptor)'")

      case .stringVecVec, .realMatrixVec, .stereoSample, .stereoSampleVec, .none:
        XCTFail("Unexpected value type stored for descriptor '\(descriptor)'.")

      }

    }

  }

}
