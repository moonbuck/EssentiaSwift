//
//  TestCaseExtensions.swift
//  Essentia
//
//  Created by Jason Cardwell on 12/3/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
import XCTest
import Foundation
import struct Accelerate.DSPComplex

extension XCTestCase {

  /// An enumeration for possible keys of assertion parameter values.
  public enum AssertionParameterKey: String { case accuracy, deviation }

  /// Asserts that two string arrays contain equal elements, generating a comparison
  /// attachment upon failure.
  ///
  /// - Parameters:
  ///   - actual: The array of actual string values.
  ///   - expected: The array of expected string values.
  ///   - descriptor: The descriptor for the attachment.
  ///   - message: The message to pass through to the assertion.
  ///   - file: The file to pass through to the assertion.
  ///   - line: The line to pass through to the assertion.
  public func performAssertion(with actual: [String],
                               expected: [String],
                               descriptor: String,
                               _ message: @autoclosure () -> String = "",
                               file: StaticString = #file,
                               line: UInt = #line)
  {

    guard let testRun = self.testRun else {
      fatalError("\(#function) requires a running test.")
    }

    let message = message()

    let currentFailureCount = testRun.failureCount

    XCTAssertEqual(actual, expected, message, file: file, line: line)

    guard testRun.failureCount > currentFailureCount else { return }

    add(comparisonAttachment(with: actual,
                             expected: expected,
                             descriptor: descriptor,
                             results: [.equality: false]))

  }

  /// Performs various assertions on two float arrays, generating a comparision attachment
  /// should any of the assertions fail.
  ///
  /// - Parameters:
  ///   - actual: The array of actual float values.
  ///   - expected: The array of expected float values.
  ///   - bases: A set specifying which assertions to perform.
  ///   - parameters: A dictionary with accuracy and deviation values to pass through to
  ///                 assertions. When not specified, a default value of `1e-7` is used.
  ///   - descriptor: The descriptor for the attachment.
  ///   - message: The message to pass through to the assertion.
  ///   - file: The file to pass through to the assertion.
  ///   - line: The line to pass through to the assertion.
  func performAssertion(with actual: [Float],
                           expected: [Float],
                           bases: Set<TestBasis>,
                           parameters: [AssertionParameterKey:Float] = [:],
                           descriptor: String,
                           _ message: @autoclosure () -> String = "",
                           file: StaticString = #file,
                           line: UInt = #line)
  {

    let message = message()

    var results: [TestBasis:Bool] = [:]

    let accuracy = parameters[.accuracy] ?? 1e-7
    let deviation = parameters[.deviation] ?? 1e-7

    for basis in bases {

      switch basis {

      case .equality:
        results[.equality] = XCTAssertEqual(actual, expected,
                                            accuracy: 0,
                                            message, file: file, line: line)

      case .accuracy:
        results[.accuracy] = XCTAssertEqual(actual, expected,
                                            accuracy: accuracy,
                                            message, file: file, line: line)

      case .deviation:
        results[.deviation] = XCTAssertEqual(actual, expected,
                                             deviation: deviation,
                                             message, file: file, line: line)

      case .differenceMean:
        results[.differenceMean] =
          XCTAssertDifferenceMeanLessThanOrEqual(actual, expected, accuracy,
                                                 message, file: file, line: line)

      case  .percentDeviation:
        results[.percentDeviation] =
          XCTAssertPercentDeviationLessThanOrEqual(actual, expected, deviation,
                                                   message, file: file, line: line)

      case .differenceMeanOrDeviation:
        results[.differenceMeanOrDeviation] =
        XCTAssertDifferenceMeanOrDeviationLessThanOrEqual(actual, expected,
                                                          mean: accuracy, deviation: deviation,
                                                          message, file: file, line: line)

      }

    }

    guard results.values.contains(false) else { return }

    add(comparisonAttachment(with: actual,
                             expected: expected,
                             accuracyUsed: accuracy,
                             deviationUsed: deviation,
                             descriptor: descriptor,
                             results: results))

  }

  /// Performs various assertions on two arrays of float arrays, generating a comparision
  /// attachment should any of the assertions fail.
  ///
  /// - Parameters:
  ///   - actual: The array of actual arrays of float values.
  ///   - expected: The array of expected arrays of float values.
  ///   - bases: A set specifying which assertions to perform.
  ///   - parameters: A dictionary with accuracy and deviation values to pass through to
  ///                 assertions. When not specified, a default value of `1e-7` is used.
  ///   - descriptor: The descriptor for the attachment.
  ///   - message: The message to pass through to the assertion.
  ///   - file: The file to pass through to the assertion.
  ///   - line: The line to pass through to the assertion.
  func performAssertion(with actual: [[Float]],
                           expected: [[Float]],
                           bases: Set<TestBasis>,
                           parameters: [AssertionParameterKey:Float] = [:],
                           descriptor: String,
                           _ message: @autoclosure () -> String = "",
                           file: StaticString = #file,
                           line: UInt = #line)
  {

    let message = message()

    var results: [TestBasis:Bool] = [:]

    let accuracy = parameters[.accuracy] ?? 1e-7
    let deviation = parameters[.deviation] ?? 1e-7

    for basis in bases {

      switch basis {

      case .equality:
        results[.equality] = XCTAssertEqual(actual, expected,
                                            accuracy: 0,
                                            message, file: file, line: line)

      case .accuracy:
        results[.accuracy] = XCTAssertEqual(actual, expected,
                                            accuracy: accuracy,
                                            message, file: file, line: line)

      case .deviation:
        results[.deviation] = XCTAssertEqual(actual, expected,
                                             deviation: deviation,
                                             message, file: file, line: line)

      case .differenceMean:
        results[.differenceMean] =
          XCTAssertDifferenceMeanLessThanOrEqual(actual, expected, accuracy,
                                                 message, file: file, line: line)

      case  .percentDeviation:
        results[.percentDeviation] =
          XCTAssertPercentDeviationLessThanOrEqual(actual, expected, deviation,
                                                   message, file: file, line: line)

      case .differenceMeanOrDeviation:
        results[.differenceMeanOrDeviation] =
        XCTAssertDifferenceMeanOrDeviationLessThanOrEqual(actual, expected,
                                                          mean: accuracy, deviation: deviation,
                                                          message, file: file, line: line)

      }

    }

    guard results.values.contains(false) else { return }

    add(comparisonAttachment(with: actual,
                             expected: expected,
                             accuracyUsed: accuracy,
                             deviationUsed: deviation,
                             descriptor: descriptor,
                             results: results))

  }

  /// Performs various assertions on two complex number arrays, generating a comparision
  /// attachment should any of the assertions fail.
  ///
  /// - Parameters:
  ///   - actual: The array of actual complex number values.
  ///   - expected: The array of expected complex number values.
  ///   - bases: A set specifying which assertions to perform.
  ///   - parameters: A dictionary with accuracy and deviation values to pass through to
  ///                 assertions. When not specified, a default value of `1e-7` is used.
  ///   - descriptor: The descriptor for the attachment.
  ///   - message: The message to pass through to the assertion.
  ///   - file: The file to pass through to the assertion.
  ///   - line: The line to pass through to the assertion.
  func performAssertion(with actual: [DSPComplex],
                           expected: [DSPComplex],
                           bases: Set<TestBasis>,
                           parameters: [AssertionParameterKey:Float] = [:],
                           descriptor: String,
                           _ message: @autoclosure () -> String = "",
                           file: StaticString = #file,
                           line: UInt = #line)
  {

    let message = message()

    var results: [TestBasis:Bool] = [:]

    let accuracy = parameters[.accuracy] ?? 1e-7
    let deviation = parameters[.deviation] ?? 1e-7

    for basis in bases {

      switch basis {

      case .equality:
        results[.equality] = XCTAssertEqual(actual, expected,
                                            accuracy: 0,
                                            message, file: file, line: line)

      case .accuracy:
        results[.accuracy] = XCTAssertEqual(actual, expected,
                                            accuracy: accuracy,
                                            message, file: file, line: line)

      case .deviation:
        results[.deviation] = XCTAssertEqual(actual, expected,
                                             deviation: deviation,
                                             message, file: file, line: line)

      case .differenceMean:
        results[.differenceMean] =
          XCTAssertDifferenceMeanLessThanOrEqual(actual, expected, accuracy,
                                                 message, file: file, line: line)

      case  .percentDeviation:
        results[.percentDeviation] =
          XCTAssertPercentDeviationLessThanOrEqual(actual, expected, deviation,
                                                   message, file: file, line: line)

      case .differenceMeanOrDeviation:
        results[.differenceMeanOrDeviation] =
        XCTAssertDifferenceMeanOrDeviationLessThanOrEqual(actual, expected,
                                                          mean: accuracy, deviation: deviation,
                                                          message, file: file, line: line)

      }

    }

    guard results.values.contains(false) else { return }

    add(comparisonAttachment(with: actual,
                             expected: expected,
                             accuracyUsed: accuracy,
                             deviationUsed: deviation,
                             descriptor: descriptor,
                             results: results))

  }

  /// Performs various assertions on two arrays of complex number arrays, generating a
  /// comparision attachment should any of the assertions fail.
  ///
  /// - Parameters:
  ///   - actual: The array of actual arrays of complex number values.
  ///   - expected: The array of expected arrays of complex number values.
  ///   - bases: A set specifying which assertions to perform.
  ///   - parameters: A dictionary with accuracy and deviation values to pass through to
  ///                 assertions. When not specified, a default value of `1e-7` is used.
  ///   - descriptor: The descriptor for the attachment.
  ///   - message: The message to pass through to the assertion.
  ///   - file: The file to pass through to the assertion.
  ///   - line: The line to pass through to the assertion.
  func performAssertion(with actual: [[DSPComplex]],
                           expected: [[DSPComplex]],
                           bases: Set<TestBasis>,
                           parameters: [AssertionParameterKey:Float] = [:],
                           descriptor: String,
                           _ message: @autoclosure () -> String = "",
                           file: StaticString = #file,
                           line: UInt = #line)
  {

    let message = message()

    var results: [TestBasis:Bool] = [:]

    let accuracy = parameters[.accuracy] ?? 1e-7
    let deviation = parameters[.deviation] ?? 1e-7

    for basis in bases {

      switch basis {

      case .equality:
        results[.equality] = XCTAssertEqual(actual, expected,
                                            accuracy: 0,
                                            message, file: file, line: line)

      case .accuracy:
        results[.accuracy] = XCTAssertEqual(actual, expected,
                                            accuracy: accuracy,
                                            message, file: file, line: line)

      case .deviation:
        results[.deviation] = XCTAssertEqual(actual, expected,
                                             deviation: deviation,
                                             message, file: file, line: line)

      case .differenceMean:
        results[.differenceMean] =
          XCTAssertDifferenceMeanLessThanOrEqual(actual, expected, accuracy,
                                                 message, file: file, line: line)

      case  .percentDeviation:
        results[.percentDeviation] =
          XCTAssertPercentDeviationLessThanOrEqual(actual, expected, deviation,
                                                   message, file: file, line: line)

      case .differenceMeanOrDeviation:
        results[.differenceMeanOrDeviation] =
        XCTAssertDifferenceMeanOrDeviationLessThanOrEqual(actual, expected,
                                                          mean: accuracy, deviation: deviation,
                                                          message, file: file, line: line)

      }

    }

    guard results.values.contains(false) else { return }

    add(comparisonAttachment(with: actual,
                             expected: expected,
                             accuracyUsed: accuracy,
                             deviationUsed: deviation,
                             descriptor: descriptor,
                             results: results))

  }

}
