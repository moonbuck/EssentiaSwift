//
//  Assertions.swift
//  EssentiaTests
//
//  Created by Jason Cardwell on 11/7/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
import Foundation
import XCTest
import _SwiftXCTestOverlayShims
import struct Accelerate.DSPComplex

/// Gemerates a description of an array suitable for inclusion in a failure message.
///
/// - Parameter values: The array of values.
/// - Returns: An appropriate description of `values`.
private func description<T>(of values: [T]) -> String {
  return "[\(values.count) elements]"
}

/// Asserts that two floating point values are equal with a specified allowable deviation.
///
/// - Parameters:
///   - actual: The actual floating point value.
///   - expected: The expected floating point value.
///   - deviation: Describes the maximum allowable deviation between `actual` and `expected`.
///   - message: An optional description of the failure.
///   - file: The file in which failure occurred. Defaults to the file name of the test case in
///           which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this
///           function was called.
/// - Returns: `true` if the assertion does not fail and `false` otherwise.
@discardableResult
public func XCTAssertEqual<T:FloatingPoint>(_ actual: T,
                                            _ expected: T,
                                            deviation: T = 0,
                                            _ message: @autoclosure () -> String = "",
                                            file: StaticString = #file,
                                            line: UInt = #line) -> Bool
{

  guard !actual.isEqual(to: expected, deviation: deviation) else { return true }

  let failureDescription = """
    XCTAssertEqual failed: ("\(actual)") is not equal to \
    ("\(expected)") with deviation ("\(deviation)")
    """

  _XCTPreformattedFailureHandler(_XCTCurrentTestCase(),
                                 true,
                                 file.description,
                                 Int(line),
                                 failureDescription, message())
  return false

}


/// Asserts that two two dimensional arrays are equal.
///
/// - Parameters:
///   - array1: A two dimensional array.
///   - array2: Another two dimensional array.
///   - message: An optional description of the failure.
///   - file: The file in which failure occurred. Defaults to the file name of the test case in
///           which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this
///           function was called.
/// - Returns: `true` if the assertion does not fail and `false` otherwise.
@discardableResult
public func XCTAssertEqual<T:Equatable>(_ array1: [[T]],
                                        _ array2: [[T]],
                                        _ message: @autoclosure () -> String = "",
                                        file: StaticString = #file,
                                        line: UInt = #line) -> Bool
{

  var countMismatch = false
  guard !test(array: array1, against: array2, countMismatch: &countMismatch, using: ==) else {
    return true
  }

  let failureDescription =
    countMismatch
      ? """
        XCTAssertEqual failed: The two arrays do not contain the same number of elements.
        """
      : """
        XCTAssertEqual failed: ("\(description(of: array1))") is not equal to \
        ("\(description(of: array2))")
        """

  _XCTPreformattedFailureHandler(_XCTCurrentTestCase(),
                                 true,
                                 file.description,
                                 Int(line),
                                 failureDescription, message())

  return false

}

/// Asserts that two three dimensional arrays are equal.
///
/// - Parameters:
///   - array1: A three dimensional array.
///   - array2: Another three dimensional array.
///   - message: An optional description of the failure.
///   - file: The file in which failure occurred. Defaults to the file name of the test case in
///           which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this
///           function was called.
/// - Returns: `true` if the assertion does not fail and `false` otherwise.
@discardableResult
public func XCTAssertEqual<T:Equatable>(_ array1: [[[T]]],
                                        _ array2: [[[T]]],
                                        _ message: @autoclosure () -> String = "",
                                        file: StaticString = #file,
                                        line: UInt = #line) -> Bool
{

  var countMismatch = false
  guard !test(array: array1, against: array2, countMismatch: &countMismatch, using: ==) else {
    return true
  }

  let failureDescription =
    countMismatch
      ? """
        XCTAssertEqual failed: The two arrays do not contain the same number of elements.
        """
      : """
        XCTAssertEqual failed: ("\(description(of: array1))") is not equal to \
        ("\(description(of: array2))")
        """

  _XCTPreformattedFailureHandler(_XCTCurrentTestCase(),
                                 true,
                                 file.description,
                                 Int(line),
                                 failureDescription, message())

  return false

}

/// Asserts that two arrays of floating point numbers are equal with a certain accuracy.
///
/// - Parameters:
///   - array1: An array of floating point numbers.
///   - array2: Another array of floating point numbers.
///   - accuracy: Describes the maximum difference between values before considering them unequal.
///   - message: An optional description of the failure.
///   - file: The file in which failure occurred. Defaults to the file name of the test case in
///           which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this
///           function was called.
/// - Returns: `true` if the assertion does not fail and `false` otherwise.
@discardableResult
public func XCTAssertEqual<T:FloatingPoint>(_ array1: [T],
                                            _ array2: [T],
                                            accuracy: T = 0,
                                            _ message: @autoclosure () -> String = "",
                                            file: StaticString = #file,
                                            line: UInt = #line) -> Bool
{

  var countMismatch = false
  guard !test(array: array1, against: array2, countMismatch: &countMismatch, using: {
    !($0.isNaN || $1.isNaN) && abs($0 - $1) <= accuracy
  }) else { return true }

  let failureDescription =
    countMismatch
      ? """
        XCTAssertEqual failed: The two arrays do not contain the same number of elements.
        """
      : """
        XCTAssertEqual failed: ("\(description(of: array1))") is not equal to \
        ("\(description(of: array2))") +/- ("\(accuracy)")
        """

  _XCTPreformattedFailureHandler(_XCTCurrentTestCase(),
                                 true,
                                 file.description,
                                 Int(line),
                                 failureDescription, message())

  return false

}

/// Asserts that two two dimensional arrays of floating point numbers are equal with a certain
/// accuracy.
///
/// - Parameters:
///   - array1: A two dimensional array of floating point numbers.
///   - array2: Another two dimensional array of floating point numbers.
///   - accuracy: Describes the maximum difference between values before considering them unequal.
///   - message: An optional description of the failure.
///   - file: The file in which failure occurred. Defaults to the file name of the test case in
///           which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this
///           function was called.
/// - Returns: `true` if the assertion does not fail and `false` otherwise.
@discardableResult
public func XCTAssertEqual<T:FloatingPoint>(_ array1: [[T]],
                                            _ array2: [[T]],
                                            accuracy: T = 0,
                                            _ message: @autoclosure () -> String = "",
                                            file: StaticString = #file,
                                            line: UInt = #line) -> Bool
{

  var countMismatch = false
  guard !test(array: array1, against: array2, countMismatch: &countMismatch, using: {
    !($0.isNaN || $1.isNaN) && abs($0 - $1) <= accuracy
  }) else { return true }

  let failureDescription =
    countMismatch
      ? """
        XCTAssertEqual failed: The two arrays do not contain the same number of elements.
        """
      : """
        XCTAssertEqual failed: ("\(description(of: array1))") is not equal to \
        ("\(description(of: array2))") +/- ("\(accuracy)")
        """

  _XCTPreformattedFailureHandler(_XCTCurrentTestCase(),
                                 true,
                                 file.description,
                                 Int(line),
                                 failureDescription, message())

  return false

}

/// Asserts that two three dimensional arrays of floating point numbers are equal with a certain
/// accuracy.
///
/// - Parameters:
///   - array1: A three dimensional array of floating point numbers.
///   - array2: Another three dimensional array of floating point numbers.
///   - accuracy: Describes the maximum difference between values before considering them unequal.
///   - message: An optional description of the failure.
///   - file: The file in which failure occurred. Defaults to the file name of the test case in
///           which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this
///           function was called.
/// - Returns: `true` if the assertion does not fail and `false` otherwise.
@discardableResult
public func XCTAssertEqual<T:FloatingPoint>(_ array1: [[[T]]],
                                            _ array2: [[[T]]],
                                            accuracy: T = 0,
                                            _ message: @autoclosure () -> String = "",
                                            file: StaticString = #file,
                                            line: UInt = #line) -> Bool
{

  var countMismatch = false
  guard !test(array: array1, against: array2, countMismatch: &countMismatch, using: {
    !($0.isNaN || $1.isNaN) && abs($0 - $1) <= accuracy
  }) else { return true }

  let failureDescription =
    countMismatch
      ? """
        XCTAssertEqual failed: The two arrays do not contain the same number of elements.
        """
      : """
        XCTAssertEqual failed: ("\(description(of: array1))") is not equal to \
        ("\(description(of: array2))") +/- ("\(accuracy)")
        """

  _XCTPreformattedFailureHandler(_XCTCurrentTestCase(),
                                 true,
                                 file.description,
                                 Int(line),
                                 failureDescription, message())

  return false

}

/// Asserts that two arrays of complex numbers are equal with a certain accuracy.
///
/// - Parameters:
///   - array1: An array of complex numbers.
///   - array2: Another array of complex numbers.
///   - accuracy: Describes the maximum difference between values before considering them unequal.
///   - message: An optional description of the failure.
///   - file: The file in which failure occurred. Defaults to the file name of the test case in
///           which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this
///           function was called.
/// - Returns: `true` if the assertion does not fail and `false` otherwise.
@discardableResult
public func XCTAssertEqual(_ array1: [DSPComplex],
                           _ array2: [DSPComplex],
                           accuracy: Float = 0,
                           _ message: @autoclosure () -> String = "",
                           file: StaticString = #file,
                           line: UInt = #line) -> Bool
{

  var countMismatch = false
  guard !test(array: array1, against: array2, countMismatch: &countMismatch, using: {
    !($0.real.isNaN || $1.real.isNaN || $0.imag.isNaN || $1.imag.isNaN)
      && abs($0.real - $1.real) <= accuracy
      && abs($0.imag - $1.imag) <= accuracy
  }) else { return true }

  let failureDescription =
    countMismatch
      ? """
        XCTAssertEqual failed: The two arrays do not contain the same number of elements.
        """
      : """
        XCTAssertEqual failed: ("\(description(of: array1))") is not equal to \
        ("\(description(of: array2))") +/- ("\(accuracy)")
        """

  _XCTPreformattedFailureHandler(_XCTCurrentTestCase(),
                                 true,
                                 file.description,
                                 Int(line),
                                 failureDescription, message())

  return false

}

/// Asserts that two two dimensional arrays of complex numbers are equal with a certain accuracy.
///
/// - Parameters:
///   - array1: A two dimensional array of complex numbers.
///   - array2: Another two dimensional array of complex numbers.
///   - accuracy: Describes the maximum difference between values before considering them unequal.
///   - message: An optional description of the failure.
///   - file: The file in which failure occurred. Defaults to the file name of the test case in
///           which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this
///           function was called.
/// - Returns: `true` if the assertion does not fail and `false` otherwise.
@discardableResult
public func XCTAssertEqual(_ array1: [[DSPComplex]],
                           _ array2: [[DSPComplex]],
                           accuracy: Float = 0,
                           _ message: @autoclosure () -> String = "",
                           file: StaticString = #file,
                           line: UInt = #line) -> Bool
{

  var countMismatch = false
  guard !test(array: array1, against: array2, countMismatch: &countMismatch, using: {
    !($0.real.isNaN || $1.real.isNaN || $0.imag.isNaN || $1.imag.isNaN)
      && abs($0.real - $1.real) <= accuracy
      && abs($0.imag - $1.imag) <= accuracy
  }) else { return true }

  let failureDescription =
    countMismatch
      ? """
        XCTAssertEqual failed: The two arrays do not contain the same number of elements.
        """
      : """
        XCTAssertEqual failed: ("\(description(of: array1))") is not equal to \
        ("\(description(of: array2))") +/- ("\(accuracy)")
        """

  _XCTPreformattedFailureHandler(_XCTCurrentTestCase(),
                                 true,
                                 file.description,
                                 Int(line),
                                 failureDescription, message())

  return false

}

/// Asserts that two three dimensional arrays of complex numbers are equal with a certain accuracy.
///
/// - Parameters:
///   - array1: A three dimensional array of complex numbers.
///   - array2: Another three dimensional array of complex numbers.
///   - accuracy: Describes the maximum difference between values before considering them unequal.
///   - message: An optional description of the failure.
///   - file: The file in which failure occurred. Defaults to the file name of the test case in
///           which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this
///           function was called.
/// - Returns: `true` if the assertion does not fail and `false` otherwise.
@discardableResult
public func XCTAssertEqual(_ array1: [[[DSPComplex]]],
                           _ array2: [[[DSPComplex]]],
                           accuracy: Float = 0,
                           _ message: @autoclosure () -> String = "",
                           file: StaticString = #file,
                           line: UInt = #line) -> Bool
{

  var countMismatch = false
  guard !test(array: array1, against: array2, countMismatch: &countMismatch, using: {
    !($0.real.isNaN || $1.real.isNaN || $0.imag.isNaN || $1.imag.isNaN)
      && abs($0.real - $1.real) <= accuracy
      && abs($0.imag - $1.imag) <= accuracy
  }) else { return true }

  let failureDescription =
    countMismatch
      ? """
        XCTAssertEqual failed: The two arrays do not contain the same number of elements.
        """
      : """
        XCTAssertEqual failed: ("\(description(of: array1))") is not equal to \
        ("\(description(of: array2))") +/- ("\(accuracy)")
        """

  _XCTPreformattedFailureHandler(_XCTCurrentTestCase(),
                                 true,
                                 file.description,
                                 Int(line),
                                 failureDescription, message())

  return false

}

/// Asserts that two arrays of floating point numbers are equal with a certain accuracy.
///
/// - Parameters:
///   - array1: An array of floating point numbers.
///   - array2: Another array of floating point numbers.
///   - deviation: Describes the maximum deviation between values before considering them unequal.
///   - message: An optional description of the failure.
///   - file: The file in which failure occurred. Defaults to the file name of the test case in
///           which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this
///           function was called.
/// - Returns: `true` if the assertion does not fail and `false` otherwise.
@discardableResult
public func XCTAssertEqual<T:FloatingPoint>(_ array1: [T],
                                            _ array2: [T],
                                            deviation: T = 0,
                                            _ message: @autoclosure () -> String = "",
                                            file: StaticString = #file,
                                            line: UInt = #line) -> Bool
{

  var countMismatch = false
  guard !test(array: array1, against: array2, countMismatch: &countMismatch, using: {
    $0.isEqual(to: $1, deviation: deviation)
  }) else { return true }

  let failureDescription =
    countMismatch
      ? """
        XCTAssertEqual failed: The two arrays do not contain the same number of elements.
        """
      : """
        XCTAssertEqual failed: ("\(description(of: array1))") is not equal to \
        ("\(description(of: array2))") with deviation ("\(deviation)")
        """

  _XCTPreformattedFailureHandler(_XCTCurrentTestCase(),
                                 true,
                                 file.description,
                                 Int(line),
                                 failureDescription, message())

  return false

}

/// Asserts that two two dimensional arrays of floating point numbers are equal with a certain
/// accuracy.
///
/// - Parameters:
///   - array1: A two dimensional array of floating point numbers.
///   - array2: Another two dimensional array of floating point numbers.
///   - deviation: Describes the maximum deviation between values before considering them unequal.
///   - message: An optional description of the failure.
///   - file: The file in which failure occurred. Defaults to the file name of the test case in
///           which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this
///           function was called.
/// - Returns: `true` if the assertion does not fail and `false` otherwise.
@discardableResult
public func XCTAssertEqual<T:FloatingPoint>(_ array1: [[T]],
                                            _ array2: [[T]],
                                            deviation: T = 0,
                                            _ message: @autoclosure () -> String = "",
                                            file: StaticString = #file,
                                            line: UInt = #line) -> Bool
{

  var countMismatch = false
  guard !test(array: array1, against: array2, countMismatch: &countMismatch, using: {
    $0.isEqual(to: $1, deviation: deviation)
  }) else { return true }

  let failureDescription =
    countMismatch
      ? """
        XCTAssertEqual failed: The two arrays do not contain the same number of elements.
        """
      : """
        XCTAssertEqual failed: ("\(description(of: array1))") is not equal to \
        ("\(description(of: array2))") with deviation ("\(deviation)")
        """

  _XCTPreformattedFailureHandler(_XCTCurrentTestCase(),
                                 true,
                                 file.description,
                                 Int(line),
                                 failureDescription, message())

  return false

}

/// Asserts that two three dimensional arrays of floating point numbers are equal with a certain
/// accuracy.
///
/// - Parameters:
///   - array1: A three dimensional array of floating point numbers.
///   - array2: Another three dimensional array of floating point numbers.
///   - deviation: Describes the maximum deviation between values before considering them unequal.
///   - message: An optional description of the failure.
///   - file: The file in which failure occurred. Defaults to the file name of the test case in
///           which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this
///           function was called.
/// - Returns: `true` if the assertion does not fail and `false` otherwise.
@discardableResult
public func XCTAssertEqual<T:FloatingPoint>(_ array1: [[[T]]],
                                            _ array2: [[[T]]],
                                            deviation: T = 0,
                                            _ message: @autoclosure () -> String = "",
                                            file: StaticString = #file,
                                            line: UInt = #line) -> Bool
{

  var countMismatch = false
  guard !test(array: array1, against: array2, countMismatch: &countMismatch, using: {
    $0.isEqual(to: $1, deviation: deviation)
  }) else { return true }

  let failureDescription =
    countMismatch
      ? """
        XCTAssertEqual failed: The two arrays do not contain the same number of elements.
        """
      : """
        XCTAssertEqual failed: ("\(description(of: array1))") is not equal to \
        ("\(description(of: array2))") with deviation ("\(deviation)")
        """

  _XCTPreformattedFailureHandler(_XCTCurrentTestCase(),
                                 true,
                                 file.description,
                                 Int(line),
                                 failureDescription, message())

  return false

}

/// Asserts that two arrays of complex numbers are equal with a certain accuracy.
///
/// - Parameters:
///   - array1: An array of complex numbers.
///   - array2: Another array of complex numbers.
///   - deviation: Describes the maximum deviation between values before considering them unequal.
///   - message: An optional description of the failure.
///   - file: The file in which failure occurred. Defaults to the file name of the test case in
///           which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this
///           function was called.
/// - Returns: `true` if the assertion does not fail and `false` otherwise.
@discardableResult
public func XCTAssertEqual(_ array1: [DSPComplex],
                           _ array2: [DSPComplex],
                           deviation: Float = 0,
                           _ message: @autoclosure () -> String = "",
                           file: StaticString = #file,
                           line: UInt = #line) -> Bool
{

  var countMismatch = false
  guard !test(array: array1, against: array2, countMismatch: &countMismatch, using: {
    $0.isEqual(to: $1, deviation: deviation)
  }) else { return true }

  let failureDescription =
    countMismatch
      ? """
        XCTAssertEqual failed: The two arrays do not contain the same number of elements.
        """
      : """
        XCTAssertEqual failed: ("\(description(of: array1))") is not equal to \
        ("\(description(of: array2))") with deviation ("\(deviation)")
        """

  _XCTPreformattedFailureHandler(_XCTCurrentTestCase(),
                                 true,
                                 file.description,
                                 Int(line),
                                 failureDescription, message())

  return false

}

/// Asserts that two two dimensional arrays of complex numbers are equal with a certain accuracy.
///
/// - Parameters:
///   - array1: A two dimensional array of complex numbers.
///   - array2: Another two dimensional array of complex numbers.
///   - deviation: Describes the maximum deviation between values before considering them unequal.
///   - message: An optional description of the failure.
///   - file: The file in which failure occurred. Defaults to the file name of the test case in
///           which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this
///           function was called.
/// - Returns: `true` if the assertion does not fail and `false` otherwise.
@discardableResult
public func XCTAssertEqual(_ array1: [[DSPComplex]],
                           _ array2: [[DSPComplex]],
                           deviation: Float = 0,
                           _ message: @autoclosure () -> String = "",
                           file: StaticString = #file,
                           line: UInt = #line) -> Bool
{

  var countMismatch = false
  guard !test(array: array1, against: array2, countMismatch: &countMismatch, using: {
    $0.isEqual(to: $1, deviation: deviation)
  }) else { return true }

  let failureDescription =
    countMismatch
      ? """
        XCTAssertEqual failed: The two arrays do not contain the same number of elements.
        """
      : """
        XCTAssertEqual failed: ("\(description(of: array1))") is not equal to \
        ("\(description(of: array2))") with deviation ("\(deviation)")
        """

  _XCTPreformattedFailureHandler(_XCTCurrentTestCase(),
                                 true,
                                 file.description,
                                 Int(line),
                                 failureDescription, message())

  return false

}

/// Asserts that two three dimensional arrays of complex numbers are equal with a certain accuracy.
///
/// - Parameters:
///   - array1: A three dimensional array of complex numbers.
///   - array2: Another three dimensional array of complex numbers.
///   - deviation: Describes the maximum deviation between values before considering them unequal.
///   - message: An optional description of the failure.
///   - file: The file in which failure occurred. Defaults to the file name of the test case in
///           which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this
///           function was called.
/// - Returns: `true` if the assertion does not fail and `false` otherwise.
@discardableResult
public func XCTAssertEqual(_ array1: [[[DSPComplex]]],
                           _ array2: [[[DSPComplex]]],
                           deviation: Float = 0,
                           _ message: @autoclosure () -> String = "",
                           file: StaticString = #file,
                           line: UInt = #line) -> Bool
{

  var countMismatch = false
  guard !test(array: array1, against: array2, countMismatch: &countMismatch, using: {
    $0.isEqual(to: $1, deviation: deviation)
  }) else { return true }

  let failureDescription =
    countMismatch
      ? """
        XCTAssertEqual failed: The two arrays do not contain the same number of elements.
        """
      : """
        XCTAssertEqual failed: ("\(description(of: array1))") is not equal to \
        ("\(description(of: array2))") with deviation ("\(deviation)")
        """

  _XCTPreformattedFailureHandler(_XCTCurrentTestCase(),
                                 true,
                                 file.description,
                                 Int(line),
                                 failureDescription, message())

  return false

}

/// Asserts that a floating point value is not `nan` or `inf`.
///
/// - Parameters:
///   - value: The floating point number to check.
///   - message: An optional description of the failure.
///   - file: The file in which failure occurred. Defaults to the file name of the test case in
///           which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this
///           function was called.
/// - Returns: `true` if the assertion does not fail and `false` otherwise.
@discardableResult
public func XCTAssertNotNaNOrInf<T:FloatingPoint>(_ value: T,
                                                  _ message: @autoclosure () -> String = "",
                                                  file: StaticString = #file,
                                                  line: UInt = #line) -> Bool
{

  guard value.isNaN || value.isInfinite else  { return true }

  let failureDescription = """
  XCTAssertNotNaNOrInf failed: ("\(value)") is either 'nan' or 'inf'.
  """

  _XCTPreformattedFailureHandler(_XCTCurrentTestCase(),
                                 true,
                                 file.description,
                                 Int(line),
                                 failureDescription, message())

  return false

}

/// Asserts that an array of floating point numbers contains no `nan` or `inf`
/// values.
///
/// - Parameters:
///   - array: An array of floating point numbers.
///   - message: An optional description of the failure.
///   - file: The file in which failure occurred. Defaults to the file name of the test case in
///           which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this
///           function was called.
/// - Returns: `true` if the assertion does not fail and `false` otherwise.
@discardableResult
public func XCTAssertNotNaNOrInf<T:FloatingPoint>(_ array: [T],
                                                  _ message: @autoclosure () -> String = "",
                                                  file: StaticString = #file,
                                                  line: UInt = #line) -> Bool
{

  guard !test(array: array, using: {!($0.isNaN || $0.isInfinite)}) else  { return true }

  let failureDescription = """
    XCTAssertNotNaNOrInf failed: ("\(description(of: array))") contains at least one \
    'nan' or 'inf' value.
    """

  _XCTPreformattedFailureHandler(_XCTCurrentTestCase(),
                                 true,
                                 file.description,
                                 Int(line),
                                 failureDescription, message())

  return false

}

/// Asserts that a two dimensional array of floating point numbers contains no `nan` or `inf`
/// values.
///
/// - Parameters:
///   - array: A two dimensional array of floating point numbers.
///   - message: An optional description of the failure.
///   - file: The file in which failure occurred. Defaults to the file name of the test case in
///           which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this
///           function was called.
/// - Returns: `true` if the assertion does not fail and `false` otherwise.
@discardableResult
public func XCTAssertNotNaNOrInf<T:FloatingPoint>(_ array: [[T]],
                                                  _ message: @autoclosure () -> String = "",
                                                  file: StaticString = #file,
                                                  line: UInt = #line) -> Bool
{

  guard !test(array: array, using: {!($0.isNaN || $0.isInfinite)}) else  { return true }

  let failureDescription = """
    XCTAssertNotNaNOrInf failed: ("\(description(of: array))") contains at least one \
    'nan' or 'inf' value.
    """

  _XCTPreformattedFailureHandler(_XCTCurrentTestCase(),
                                 true,
                                 file.description,
                                 Int(line),
                                 failureDescription, message())

  return false

}

/// Asserts that a three dimensional array of floating point numbers contains no `nan` or `inf`
/// values.
///
/// - Parameters:
///   - array: A three dimensional array of floating point numbers.
///   - message: An optional description of the failure.
///   - file: The file in which failure occurred. Defaults to the file name of the test case in
///           which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this
///           function was called.
/// - Returns: `true` if the assertion does not fail and `false` otherwise.
@discardableResult
public func XCTAssertNotNaNOrInf<T:FloatingPoint>(_ array: [[[T]]],
                                                  _ message: @autoclosure () -> String = "",
                                                  file: StaticString = #file,
                                                  line: UInt = #line) -> Bool
{

  guard !test(array: array, using: {!($0.isNaN || $0.isInfinite)}) else  { return true }

  let failureDescription = """
    XCTAssertNotNaNOrInf failed: ("\(description(of: array))") contains at least one \
    'nan' or 'inf' value.
    """

  _XCTPreformattedFailureHandler(_XCTCurrentTestCase(),
                                 true,
                                 file.description,
                                 Int(line),
                                 failureDescription, message())

  return false

}

/// Asserts that an array of floating point numbers contains no values less than a given value.
///
/// - Parameters:
///   - array: An array of floating point numbers.
///   - value: The value to which all values in `array` must be greater than or equal.
///   - message: An optional description of the failure.
///   - file: The file in which failure occurred. Defaults to the file name of the test case in
///           which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this
///           function was called.
/// - Returns: `true` if the assertion does not fail and `false` otherwise.
@discardableResult
public func XCTAssertGreaterThanOrEqual<T:FloatingPoint>(_ array: [T],
                                                         _ value: T,
                                                         _ message: @autoclosure () -> String = "",
                                                         file: StaticString = #file,
                                                         line: UInt = #line) -> Bool
{

  guard !test(array: array, against: value, using: >=) else  { return true }

  let failureDescription = """
    XCTAssertGreaterThanOrEqual failed: ("\(description(of: array))") contains at least one \
    value < ("\(value)").
    """

  _XCTPreformattedFailureHandler(_XCTCurrentTestCase(),
                                 true,
                                 file.description,
                                 Int(line),
                                 failureDescription, message())

  return false

}

/// Asserts that a two dimensional array of floating point numbers contains values greater than
/// or equal to a given value.
///
/// - Parameters:
///   - array: A two dimensional array of floating point numbers.
///   - value: The value to which all values in `array` must be greater than or equal.
///   - message: An optional description of the failure.
///   - file: The file in which failure occurred. Defaults to the file name of the test case in
///           which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this
///           function was called.
/// - Returns: `true` if the assertion does not fail and `false` otherwise.
@discardableResult
public func XCTAssertGreaterThanOrEqual<T:FloatingPoint>(_ array: [[T]],
                                                         _ value: T,
                                                         _ message: @autoclosure () -> String = "",
                                                         file: StaticString = #file,
                                                         line: UInt = #line) -> Bool
{

  guard !test(array: array, against: value, using: >=) else { return true }

  let failureDescription = """
    XCTAssertGreaterThanOrEqual failed: ("\(description(of: array))") contains at least one \
    value < ("\(value)").
    """

  _XCTPreformattedFailureHandler(_XCTCurrentTestCase(),
                                 true,
                                 file.description,
                                 Int(line),
                                 failureDescription, message())

  return false

}

/// Asserts that a three dimensional array of floating point numbers contains values greater than
/// or equal to a given value.
///
/// - Parameters:
///   - array: A three dimensional array of floating point numbers.
///   - value: The value to which all values in `array` must be greater than or equal.
///   - message: An optional description of the failure.
///   - file: The file in which failure occurred. Defaults to the file name of the test case in
///           which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this
///           function was called.
/// - Returns: `true` if the assertion does not fail and `false` otherwise.
@discardableResult
public func XCTAssertGreaterThanOrEqual<T:FloatingPoint>(_ array: [[[T]]],
                                                         _ value: T,
                                                         _ message: @autoclosure () -> String = "",
                                                         file: StaticString = #file,
                                                         line: UInt = #line) -> Bool
{

  guard !test(array: array, against: value, using: >=) else { return true }

  let failureDescription = """
    XCTAssertGreaterThanOrEqual failed: ("\(description(of: array))") contains at least one \
    value < ("\(value)").
    """

  _XCTPreformattedFailureHandler(_XCTCurrentTestCase(),
                                 true,
                                 file.description,
                                 Int(line),
                                 failureDescription, message())

  return false

}

/// Asserts that the average of the floating point numbers in an array is equal to an expected
/// value with a certain accuracy.
///
/// - Parameters:
///   - array: An array of floating point numbers.
///   - expected: The expected average for the values in `array`.
///   - accuracy: Describes the maximum difference between the average of `array` and `expected`.
///   - message: An optional description of the failure.
///   - file: The file in which failure occurred. Defaults to the file name of the test case in
///           which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this
///           function was called.
/// - Returns: `true` if the assertion does not fail and `false` otherwise.
@discardableResult
public func XCTAssertAverageEqual<T:FloatingPoint>(_ array: [T],
                                                   _ expected: T,
                                                   accuracy: T = 0,
                                                   _ message: @autoclosure () -> String = "",
                                                   file: StaticString = #file,
                                                   line: UInt = #line) -> Bool
{

  let average = array.mean

  guard average != expected && abs(average - expected) > accuracy else  { return true }

  let failureDescription = """
    XCTAssertAverageEqual failed: ("\(average)") is not equal to ("\(expected)") \
    +/- ("\(accuracy)")
    """

  _XCTPreformattedFailureHandler(_XCTCurrentTestCase(),
                                 true,
                                 file.description,
                                 Int(line),
                                 failureDescription, message())

  return false

}

/// Asserts that the average of the floating point numbers in an array is equal to an expected
/// value with a certain accuracy.
///
/// - Parameters:
///   - array: An array of floating point numbers.
///   - expected: The expected average for the values in `array`.
///   - deviation: Describes the maximum deviation between the average of `array` and `expected`.
///   - message: An optional description of the failure.
///   - file: The file in which failure occurred. Defaults to the file name of the test case in
///           which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this
///           function was called.
/// - Returns: `true` if the assertion does not fail and `false` otherwise.
@discardableResult
public func XCTAssertAverageEqual<T:FloatingPoint>(_ array: [T],
                                                   _ expected: T,
                                                   deviation: T = 0,
                                                   _ message: @autoclosure () -> String = "",
                                                   file: StaticString = #file,
                                                   line: UInt = #line) -> Bool
{

  let average = array.mean

  guard average != expected && average.deviation(from: expected) > deviation else { return true }

  let failureDescription = """
    XCTAssertAverageEqual failed: ("\(average)") is not equal to ("\(expected)") \
    with deviation ("\(deviation)")
    """

  _XCTPreformattedFailureHandler(_XCTCurrentTestCase(),
                                 true,
                                 file.description,
                                 Int(line),
                                 failureDescription, message())

  return false

}

/// Asserts that the mean of the difference between two arrays of floating point numbers is
/// less than or equal to a given value.
///
/// - Parameters:
///   - array1: The first array of floating point numbers.
///   - array2: The second array of floating point numbers.
///   - mean: The value that the difference mean of `array1` and `array2` must not be above.
///   - message: An optional description of the failure.
///   - file: The file in which failure occurred. Defaults to the file name of the test case in
///           which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this
///           function was called.
/// - Returns: `true` if the assertion does not fail and `false` otherwise.
@discardableResult
public func XCTAssertDifferenceMeanLessThanOrEqual<T>(_ array1: [T],
                                                      _ array2: [T],
                                                      _ mean: T,
                                                      _ message: @autoclosure () -> String = "",
                                                      file: StaticString = #file,
                                                      line: UInt = #line) -> Bool
  where T:FloatingPoint
{

  var countMismatch = false

  let averageDifference = array1.averageDifference(with: array2, countMismatch: &countMismatch)

  guard countMismatch || averageDifference > mean else { return true }

  let failureDescription =
    countMismatch
      ? """
        XCTAssertEqual failed: The two arrays do not contain the same number of elements.
        """
      : """
        XCTAssertDifferenceMeanLessThanOrEqual failed: ("\(averageDifference)") is not less than or equal \
        to ("\(mean)")
        """

  _XCTPreformattedFailureHandler(_XCTCurrentTestCase(),
                                 true,
                                 file.description,
                                 Int(line),
                                 failureDescription, message())

  return false

}

/// Asserts that the mean of the difference between two arrays of floating point numbers is
/// less than or equal to a given value.
///
/// - Parameters:
///   - array1: The first array of floating point numbers.
///   - array2: The second array of floating point numbers.
///   - mean: The value that the difference mean of `array1` and `array2` must not be above.
///   - message: An optional description of the failure.
///   - file: The file in which failure occurred. Defaults to the file name of the test case in
///           which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this
///           function was called.
/// - Returns: `true` if the assertion does not fail and `false` otherwise.
@discardableResult
public func XCTAssertDifferenceMeanLessThanOrEqual<T>(_ array1: [[T]],
                                                      _ array2: [[T]],
                                                      _ mean: T,
                                                      _ message: @autoclosure () -> String = "",
                                                      file: StaticString = #file,
                                                      line: UInt = #line) -> Bool
  where T:FloatingPoint
{

  var countMismatch = array1.count != array2.count

  var calculatedMean: T = T.infinity

  if !countMismatch {

    var sumMean: T = 0

    for (subarray1, subarray2) in zip(array1, array2) {
      sumMean += subarray1.averageDifference(with: subarray2, countMismatch: &countMismatch)
      guard !countMismatch else { break }
    }

    if !countMismatch {  calculatedMean = sumMean / T(array1.count)  }

  }

  guard countMismatch || calculatedMean > mean else { return true }

  let failureDescription =
    countMismatch
      ? """
        XCTAssertEqual failed: The two arrays do not contain the same number of elements.
        """
      : """
        XCTAssertDifferenceMeanLessThan failed: ("\(calculatedMean)") is not less than ("\(mean)")
        """

  _XCTPreformattedFailureHandler(_XCTCurrentTestCase(),
                                 true,
                                 file.description,
                                 Int(line),
                                 failureDescription, message())

  return false

}

/// Asserts that the mean of the difference between two arrays of complex numbers is
/// less than or equal to a given value.
///
/// - Parameters:
///   - array1: The first array of complex numbers.
///   - array2: The second array of complex numbers.
///   - mean: The value that the difference mean of `array1` and `array2` must not be above.
///   - message: An optional description of the failure.
///   - file: The file in which failure occurred. Defaults to the file name of the test case in
///           which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this
///           function was called.
/// - Returns: `true` if the assertion does not fail and `false` otherwise.
@discardableResult
public func XCTAssertDifferenceMeanLessThanOrEqual(_ array1: [DSPComplex],
                                                   _ array2: [DSPComplex],
                                                   _ mean: Float,
                                                   _ message: @autoclosure () -> String = "",
                                                   file: StaticString = #file,
                                                   line: UInt = #line) -> Bool
{

  var countMismatch = false

  let calculatedMean = array1.averageDifference(with: array2, countMismatch: &countMismatch)

  guard countMismatch || calculatedMean > mean else { return true }

  let failureDescription =
    countMismatch
      ? """
        XCTAssertEqual failed: The two arrays do not contain the same number of elements.
        """
      : """
        XCTAssertDifferenceMeanLessThanOrEqual failed: ("\(calculatedMean)") is not less than or \
        equal to ("\(mean)")
        """

  _XCTPreformattedFailureHandler(_XCTCurrentTestCase(),
                                 true,
                                 file.description,
                                 Int(line),
                                 failureDescription, message())

  return false

}

/// Asserts that the percent deviation between two arrays of floating point numbers is
/// less than or equal to a given value.
///
/// - Parameters:
///   - array1: The first array of floating point numbers.
///   - array2: The second array of floating point numbers.
///   - deviation: The value which the deviation of `array1` from `array2` must not be above.
///   - message: An optional description of the failure.
///   - file: The file in which failure occurred. Defaults to the file name of the test case in
///           which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this
///           function was called.
/// - Returns: `true` if the assertion does not fail and `false` otherwise.
@discardableResult
public func XCTAssertPercentDeviationLessThanOrEqual<T>(_ array1: [T],
                                                        _ array2: [T],
                                                        _ deviation: T,
                                                        _ message: @autoclosure () -> String = "",
                                                        file: StaticString = #file,
                                                        line: UInt = #line) -> Bool
  where T:FloatingPoint
{

  var countMismatch = false
  let actualDeviation = array1.averageDeviation(from: array2, countMismatch: &countMismatch)

  guard countMismatch || actualDeviation > deviation else { return true }

  let failureDescription =
    countMismatch
      ? """
        XCTAssertEqual failed: The two arrays do not contain the same number of elements.
        """
      : """
        XCTAssertPercentDeviationLessThanOrEqual failed: ("\(actualDeviation)") is not less
        than or equal to ("\(deviation)")
        """

  _XCTPreformattedFailureHandler(_XCTCurrentTestCase(),
                                 true,
                                 file.description,
                                 Int(line),
                                 failureDescription, message())

  return false

}

/// Asserts that the percent deviation between two arrays of floating point numbers is
/// less than or equal to a given value.
///
/// - Parameters:
///   - array1: The first array of floating point numbers.
///   - array2: The second array of floating point numbers.
///   - deviation: The value which the deviation of `array1` from `array2` must not be above.
///   - message: An optional description of the failure.
///   - file: The file in which failure occurred. Defaults to the file name of the test case in
///           which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this
///           function was called.
/// - Returns: `true` if the assertion does not fail and `false` otherwise.
@discardableResult
public func XCTAssertPercentDeviationLessThanOrEqual<T>(_ array1: [[T]],
                                                        _ array2: [[T]],
                                                        _ deviation: T,
                                                        _ message: @autoclosure () -> String = "",
                                                        file: StaticString = #file,
                                                        line: UInt = #line) -> Bool
  where T:FloatingPoint
{

  var countMismatch = array1.count != array2.count

  var actualDeviation: T = T.infinity

  if !countMismatch {

    var sumDeviation: T = 0

    for (subarray1, subarray2) in zip(array1, array2) {
      sumDeviation += subarray1.averageDeviation(from: subarray2, countMismatch: &countMismatch)
      guard !countMismatch else { break }
    }

    if !countMismatch {  actualDeviation = sumDeviation / T(array1.count)  }

  }

  guard countMismatch || actualDeviation > deviation else { return true }

  let failureDescription =
    countMismatch
      ? """
        XCTAssertEqual failed: The two arrays do not contain the same number of elements.
        """
      : """
        XCTAssertPercentDeviationLessThanOrEqual failed: ("\(actualDeviation)") is not less
        than or equal to ("\(deviation)")
        """

  _XCTPreformattedFailureHandler(_XCTCurrentTestCase(),
                                 true,
                                 file.description,
                                 Int(line),
                                 failureDescription, message())

  return false

}

/// Asserts that the percent deviation between two arrays of complex numbers is less than or equal
/// to a given value.
///
/// - Parameters:
///   - array1: The first array of complex numbers.
///   - array2: The second array of complex numbers.
///   - deviation: The value which the deviation of `array1` from `array2` must not be above.
///   - message: An optional description of the failure.
///   - file: The file in which failure occurred. Defaults to the file name of the test case in
///           which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this
///           function was called.
/// - Returns: `true` if the assertion does not fail and `false` otherwise.
@discardableResult
public func XCTAssertPercentDeviationLessThanOrEqual(_ array1: [DSPComplex],
                                                     _ array2: [DSPComplex],
                                                     _ deviation: Float,
                                                     _ message: @autoclosure () -> String = "",
                                                     file: StaticString = #file,
                                                     line: UInt = #line) -> Bool
{

  var countMismatch = false
  let actualDeviation = array1.averageDeviation(from: array2, countMismatch: &countMismatch)

  guard countMismatch || actualDeviation > deviation else { return true }

  let failureDescription =
    countMismatch
      ? """
        XCTAssertEqual failed: The two arrays do not contain the same number of elements.
        """
      : """
        XCTAssertPercentDeviationLessThanOrEqual failed: ("\(actualDeviation)") is not less
        than or equal to ("\(deviation)")
        """

  _XCTPreformattedFailureHandler(_XCTCurrentTestCase(),
                                 true,
                                 file.description,
                                 Int(line),
                                 failureDescription, message())

  return false

}

/// Asserts that at least one of the following is true:
///  1) That the percent deviation between two arrays is less than or equal to a given value.
///  2) That the mean of the difference between two arrays is less than or equal to a given value.
///
/// - Parameters:
///   - array1: The first array of complex numbers.
///   - array2: The second array of complex numbers.
///   - differenceMean: The value which the average difference must not be above.
///   - deviation: The value which the percent deviation must not be above.
///   - message: An optional description of the failure.
///   - file: The file in which failure occurred. Defaults to the file name of the test case in
///           which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this
///           function was called.
/// - Returns: `true` if the assertion does not fail and `false` otherwise.
@discardableResult
public func XCTAssertDifferenceMeanOrDeviationLessThanOrEqual<T:FloatingPoint>(
  _ array1: [T],
  _ array2: [T],
  differenceMean: T,
  deviation: T,
  _ message: @autoclosure () -> String = "",
  file: StaticString = #file,
  line: UInt = #line) -> Bool
{

  var countMismatch = false

  let averageDifference = array1.averageDifference(with: array2, countMismatch: &countMismatch)
  let meanFail = averageDifference > differenceMean

  let actualDeviation = array1.averageDeviation(from: array2, countMismatch: &countMismatch)
  let deviationFail = actualDeviation > deviation

  guard countMismatch || (meanFail && deviationFail) else { return true }

  let failureDescription: String

  switch (meanFail, deviationFail) {

  case (_, _) where countMismatch:
    failureDescription = """
      XCTAssertDifferenceMeanOrDeviationLessThanOrEqual failed: The two arrays do not contain \
      the same number of elements.
      """

  case (true, false):
    failureDescription = """
      XCTAssertDifferenceMeanOrDeviationLessThanOrEqual failed: average difference \
      ("\(averageDifference)") is not less than or equal to ("\(differenceMean)")
      """

  case (false, true):
    failureDescription = """
    XCTAssertDifferenceMeanOrDeviationLessThanOrEqual failed: deviation \
    ("\(actualDeviation)") is not less than or equal to ("\(deviation)")
    """

  case (true, true):
    failureDescription = """
    XCTAssertDifferenceMeanOrDeviationLessThanOrEqual failed: average difference \
    ("\(averageDifference)") is not less than or equal to ("\(differenceMean)") and deviation \
    ("\(actualDeviation)") is not less than or equal to ("\(deviation)")
    """

  case (false, false):
    fatalError("The impossible happened.")

  }

  _XCTPreformattedFailureHandler(_XCTCurrentTestCase(),
                                 true,
                                 file.description,
                                 Int(line),
                                 failureDescription, message())

  return false

}

/// Asserts that at least one of the following is true:
///  1) That the percent deviation between two arrays is less than or equal to a given value.
///  2) That the mean of the difference between two arrays is less than or equal to a given value.
///
/// - Parameters:
///   - array1: The first array of complex numbers.
///   - array2: The second array of complex numbers.
///   - differenceMean: The value which the average difference must not be above.
///   - deviation: The value which the percent deviation must not be above.
///   - message: An optional description of the failure.
///   - file: The file in which failure occurred. Defaults to the file name of the test case in
///           which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this
///           function was called.
/// - Returns: `true` if the assertion does not fail and `false` otherwise.
@discardableResult
public func XCTAssertDifferenceMeanOrDeviationLessThanOrEqual<T:FloatingPoint>(
  _ array1: [[T]],
  _ array2: [[T]],
  differenceMean: T,
  deviation: T,
  _ message: @autoclosure () -> String = "",
  file: StaticString = #file,
  line: UInt = #line) -> Bool
{

  var countMismatch = array1.count != array2.count

  var averageDifference: T = T.infinity

  if !countMismatch {

    var sumMean: T = 0

    for (subarray1, subarray2) in zip(array1, array2) {
      sumMean += subarray1.averageDifference(with: subarray2, countMismatch: &countMismatch)
      guard !countMismatch else { break }
    }

    if !countMismatch {  averageDifference = sumMean / T(array1.count)  }

  }

  let meanFail = averageDifference > differenceMean

  var actualDeviation: T = T.infinity

  if !countMismatch {

    var sumDeviation: T = 0

    for (subarray1, subarray2) in zip(array1, array2) {
      sumDeviation += subarray1.averageDeviation(from: subarray2, countMismatch: &countMismatch)
      guard !countMismatch else { break }
    }

    if !countMismatch {  actualDeviation = sumDeviation / T(array1.count)  }

  }

  let deviationFail = actualDeviation > deviation

  guard countMismatch || (meanFail && deviationFail) else { return true }

  let failureDescription: String

  switch (meanFail, deviationFail) {

  case (_, _) where countMismatch:
    failureDescription = """
      XCTAssertDifferenceMeanOrDeviationLessThanOrEqual failed: The two arrays do not contain \
      the same number of elements.
      """

  case (true, false):
    failureDescription = """
      XCTAssertDifferenceMeanOrDeviationLessThanOrEqual failed: average difference \
      ("\(averageDifference)") is not less than or equal to ("\(differenceMean)")
      """

  case (false, true):
    failureDescription = """
    XCTAssertDifferenceMeanOrDeviationLessThanOrEqual failed: deviation \
    ("\(actualDeviation)") is not less than or equal to ("\(deviation)")
    """

  case (true, true):
    failureDescription = """
    XCTAssertDifferenceMeanOrDeviationLessThanOrEqual failed: average difference \
    ("\(averageDifference)") is not less than or equal to ("\(differenceMean)") and deviation \
    ("\(actualDeviation)") is not less than or equal to ("\(deviation)")
    """

  case (false, false):
    fatalError("The impossible happened.")

  }

  _XCTPreformattedFailureHandler(_XCTCurrentTestCase(),
                                 true,
                                 file.description,
                                 Int(line),
                                 failureDescription, message())

  return false

}

/// Asserts that at least one of the following is true:
///  1) That the percent deviation between two arrays is less than or equal to a given value.
///  2) That the mean of the difference between two arrays is less than or equal to a given value.
///
/// - Parameters:
///   - array1: The first array of complex numbers.
///   - array2: The second array of complex numbers.
///   - differenceMean: The value which the average difference must not be above.
///   - deviation: The value which the percent deviation must not be above.
///   - message: An optional description of the failure.
///   - file: The file in which failure occurred. Defaults to the file name of the test case in
///           which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this
///           function was called.
/// - Returns: `true` if the assertion does not fail and `false` otherwise.
@discardableResult
public func XCTAssertDifferenceMeanOrDeviationLessThanOrEqual(
  _ array1: [DSPComplex],
  _ array2: [DSPComplex],
  differenceMean: Float,
  deviation: Float,
  _ message: @autoclosure () -> String = "",
  file: StaticString = #file,
  line: UInt = #line) -> Bool
{

  var countMismatch = false

  let averageDifference = array1.averageDifference(with: array2, countMismatch: &countMismatch)
  let meanFail = averageDifference > differenceMean

  let actualDeviation = array1.averageDeviation(from: array2, countMismatch: &countMismatch)
  let deviationFail = actualDeviation > deviation

  guard countMismatch || (meanFail && deviationFail) else { return true }

  let failureDescription: String

  switch (meanFail, deviationFail) {

  case (_, _) where countMismatch:
    failureDescription = """
      XCTAssertDifferenceMeanOrDeviationLessThanOrEqual failed: The two arrays do not contain \
      the same number of elements.
      """

  case (true, false):
    failureDescription = """
      XCTAssertDifferenceMeanOrDeviationLessThanOrEqual failed: average difference \
      ("\(averageDifference)") is not less than or equal to ("\(differenceMean)")
      """

  case (false, true):
    failureDescription = """
    XCTAssertDifferenceMeanOrDeviationLessThanOrEqual failed: deviation \
    ("\(actualDeviation)") is not less than or equal to ("\(deviation)")
    """

  case (true, true):
    failureDescription = """
    XCTAssertDifferenceMeanOrDeviationLessThanOrEqual failed: average difference \
    ("\(averageDifference)") is not less than or equal to ("\(differenceMean)") and deviation \
    ("\(actualDeviation)") is not less than or equal to ("\(deviation)")
    """

  case (false, false):
    fatalError("The impossible happened.")

  }

  _XCTPreformattedFailureHandler(_XCTCurrentTestCase(),
                                 true,
                                 file.description,
                                 Int(line),
                                 failureDescription, message())

  return false

}
