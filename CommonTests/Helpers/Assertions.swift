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

  guard values.count > 20 else { return values.description }

  let prefix = values[...10].map({"\($0)"}).joined(separator: ", ")
  let suffix = values[(values.count - 10)...].map({"\($0)"}).joined(separator: ", ")
  return "[\(prefix) ... \(suffix)]"

}

/// Gemerates a description of a two dimensional array suitable for inclusion in a failure message.
///
/// - Parameter values: The two dimensional array of values.
/// - Returns: An appropriate description of `values`.
private func description<T>(of values: [[T]]) -> String {

  guard values.count > 20 else { return values.description }

  let prefix = values[...10].map({"\(description(of: $0))"}).joined(separator: ", ")
  let suffix = values[(values.count - 10)...].map({"\(description(of: $0))"}).joined(separator: ", ")
  return "[\(prefix) ... \(suffix)]"

}

/// Gemerates a description of a three dimensional array suitable for inclusion in a failure message.
///
/// - Parameter values: The three dimensional array of values.
/// - Returns: An appropriate description of `values`.
private func description<T>(of values: [[[T]]]) -> String {

  guard values.count > 20 else { return values.description }

  let prefix = values[...10].map({"\($0)"}).joined(separator: ", ")
  let suffix = values[(values.count - 10)...].map({"\($0)"}).joined(separator: ", ")
  return "[\(prefix) ... \(suffix)]"

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
public func XCTAssertEqual<T:Equatable>(_ array1: [[T]],
                                        _ array2: [[T]],
                                        _ message: @autoclosure () -> String = "",
                                        file: StaticString = #file,
                                        line: UInt = #line)
{

  var didFail = array1.count != array2.count

  if !didFail {

    for (first, second) in zip(array1, array2) {
      guard first.elementsEqual(second) else { didFail = true; break }
    }

  }

  guard didFail else  { return }

  let failureDescription = String(format: _XCTFailureFormat(.equal, 100),
                                  description(of: array1), description(of: array2))

  _XCTPreformattedFailureHandler(_XCTCurrentTestCase(),
                                 true,
                                 file.description,
                                 Int(line),
                                 failureDescription, message())

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
public func XCTAssertEqual<T:Equatable>(_ array1: [[[T]]],
                                        _ array2: [[[T]]],
                                        _ message: @autoclosure () -> String = "",
                                        file: StaticString = #file,
                                        line: UInt = #line)
{

  var didFail = array1.count != array2.count

  if !didFail {

    Outer: for (firstOuter, secondOuter) in zip(array1, array2) {

      guard firstOuter.count == secondOuter.count else { didFail = true; break Outer }

      for (first, second) in zip(firstOuter, secondOuter) {
        guard first.elementsEqual(second) else { didFail = true; break Outer }
      }

    }

  }

  guard didFail else  { return }


  let failureDescription = String(format: _XCTFailureFormat(.equal, 100),
                                  description(of: array1), description(of: array2))

  _XCTPreformattedFailureHandler(_XCTCurrentTestCase(),
                                 true,
                                 file.description,
                                 Int(line),
                                 failureDescription, message())

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
public func XCTAssertEqual<T:FloatingPoint>(_ array1: [T],
                                            _ array2: [T],
                                            accuracy: T = 0,
                                            _ message: @autoclosure () -> String = "",
                                            file: StaticString = #file,
                                            line: UInt = #line)
{

  let didFail = array1.count != array2.count || !array1.elementsEqual(array2, by: {
    !($0.isNaN || $1.isNaN) && abs($0 - $1) <= accuracy
  })

  guard didFail else  { return }

  let failureDescription = String(format: _XCTFailureFormat(.equalWithAccuracy, 100),
                                  description(of: array1), description(of: array2), "\(accuracy)")

  _XCTPreformattedFailureHandler(_XCTCurrentTestCase(),
                                 true,
                                 file.description,
                                 Int(line),
                                 failureDescription, message())

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
public func XCTAssertEqual<T:FloatingPoint>(_ array1: [[T]],
                                            _ array2: [[T]],
                                            accuracy: T = 0,
                                            _ message: @autoclosure () -> String = "",
                                            file: StaticString = #file,
                                            line: UInt = #line)
{

  var didFail = array1.count != array2.count

  if !didFail {

    for (first, second) in zip(array1, array2) {
      guard first.elementsEqual(second, by: {
        !($0.isNaN || $1.isNaN) && abs($0 - $1) <= accuracy
      }) else { didFail = true; break }
    }

  }

  guard didFail else  { return }

  let failureDescription = String(format: _XCTFailureFormat(.equalWithAccuracy, 100),
                                  description(of: array1), description(of: array2), "\(accuracy)")

  _XCTPreformattedFailureHandler(_XCTCurrentTestCase(),
                                 true,
                                 file.description,
                                 Int(line),
                                 failureDescription, message())

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
public func XCTAssertEqual<T:FloatingPoint>(_ array1: [[[T]]],
                                            _ array2: [[[T]]],
                                            accuracy: T = 0,
                                            _ message: @autoclosure () -> String = "",
                                            file: StaticString = #file,
                                            line: UInt = #line)
{

  var didFail = array1.count != array2.count

  if !didFail {

    Outer: for (firstOuter, secondOuter) in zip(array1, array2) {

      guard firstOuter.count == secondOuter.count else { didFail = true; break Outer }

      for (first, second) in zip(firstOuter, secondOuter) {
        guard first.elementsEqual(second, by: {
          !($0.isNaN || $1.isNaN) && abs($0 - $1) <= accuracy
        }) else { didFail = true; break Outer }
      }

    }

  }

  guard didFail else  { return }

  let failureDescription = String(format: _XCTFailureFormat(.equalWithAccuracy, 100),
                                  description(of: array1), description(of: array2), "\(accuracy)")

  _XCTPreformattedFailureHandler(_XCTCurrentTestCase(),
                                 true,
                                 file.description,
                                 Int(line),
                                 failureDescription, message())

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
public func XCTAssertEqual(_ array1: [DSPComplex],
                           _ array2: [DSPComplex],
                           accuracy: Float = 0,
                           _ message: @autoclosure () -> String = "",
                           file: StaticString = #file,
                           line: UInt = #line)
{

  let didFail = array1.count != array2.count || !array1.elementsEqual(array2, by: {
    !($0.real.isNaN || $1.real.isNaN || $0.imag.isNaN || $1.imag.isNaN)
      && abs($0.real - $1.real) <= accuracy
      && abs($0.imag - $1.imag) <= accuracy
  })

  guard didFail else  { return }

  let failureDescription = String(format: _XCTFailureFormat(.equalWithAccuracy, 100),
                                  description(of: array1), description(of: array2),
                                  accuracy.description)

  _XCTPreformattedFailureHandler(_XCTCurrentTestCase(),
                                 true,
                                 file.description,
                                 Int(line),
                                 failureDescription, message())

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
public func XCTAssertEqual(_ array1: [[DSPComplex]],
                           _ array2: [[DSPComplex]],
                           accuracy: Float = 0,
                           _ message: @autoclosure () -> String = "",
                           file: StaticString = #file,
                           line: UInt = #line)
{

  var didFail = array1.count != array2.count

  if !didFail {

    for (first, second) in zip(array1, array2) {
      guard first.elementsEqual(second, by: {
        !($0.real.isNaN || $1.real.isNaN || $0.imag.isNaN || $1.imag.isNaN)
          && abs($0.real - $1.real) <= accuracy
          && abs($0.imag - $1.imag) <= accuracy
      }) else { didFail = true; break }
    }

  }

  guard didFail else  { return }

  let failureDescription = String(format: _XCTFailureFormat(.equalWithAccuracy, 100),
                                  description(of: array1), description(of: array2),
                                  accuracy.description)

  _XCTPreformattedFailureHandler(_XCTCurrentTestCase(),
                                 true,
                                 file.description,
                                 Int(line),
                                 failureDescription, message())

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
public func XCTAssertEqual(_ array1: [[[DSPComplex]]],
                           _ array2: [[[DSPComplex]]],
                           accuracy: Float = 0,
                           _ message: @autoclosure () -> String = "",
                           file: StaticString = #file,
                           line: UInt = #line)
{

  var didFail = array1.count != array2.count

  if !didFail {

    Outer: for (firstOuter, secondOuter) in zip(array1, array2) {

      guard firstOuter.count == secondOuter.count else { didFail = true; break Outer }

      for (first, second) in zip(firstOuter, secondOuter) {
        guard first.elementsEqual(second, by: {
          !($0.real.isNaN || $1.real.isNaN || $0.imag.isNaN || $1.imag.isNaN)
            && abs($0.real - $1.real) <= accuracy
            && abs($0.imag - $1.imag) <= accuracy
        }) else { didFail = true; break Outer }
      }

    }

  }

  guard didFail else  { return }

  let failureDescription = String(format: _XCTFailureFormat(.equalWithAccuracy, 100),
                                  description(of: array1), description(of: array2),
                                  accuracy.description)

  _XCTPreformattedFailureHandler(_XCTCurrentTestCase(),
                                 true,
                                 file.description,
                                 Int(line),
                                 failureDescription, message())

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
public func XCTAssertNotNaNOrInf<T:FloatingPoint>(_ array: [T],
                                                  _ message: @autoclosure () -> String = "",
                                                  file: StaticString = #file,
                                                  line: UInt = #line)
{

  var didFail = false

  for value in array {
    guard !(value.isNaN || value.isInfinite) else {
      didFail = true
      break
    }
  }

  guard didFail else  { return }

  let failureDescription = """
    XCTAssertNotNaNOrInf failed: ("\(description(of: array))") contains at least one \
    'nan' or 'inf' value.
    """

  _XCTPreformattedFailureHandler(_XCTCurrentTestCase(),
                                 true,
                                 file.description,
                                 Int(line),
                                 failureDescription, message())

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
public func XCTAssertNotNaNOrInf<T:FloatingPoint>(_ array: [[T]],
                                                  _ message: @autoclosure () -> String = "",
                                                  file: StaticString = #file,
                                                  line: UInt = #line)
{

  var didFail = false

  for innerArray in array {
    for value in innerArray {
      guard !(value.isNaN || value.isInfinite) else {
        didFail = true
        break
      }
    }
  }

  guard didFail else  { return }

  let failureDescription = """
    XCTAssertNotNaNOrInf failed: ("\(description(of: array))") contains at least one \
    'nan' or 'inf' value.
    """

  _XCTPreformattedFailureHandler(_XCTCurrentTestCase(),
                                 true,
                                 file.description,
                                 Int(line),
                                 failureDescription, message())

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
public func XCTAssertNotNaNOrInf<T:FloatingPoint>(_ array: [[[T]]],
                                                  _ message: @autoclosure () -> String = "",
                                                  file: StaticString = #file,
                                                  line: UInt = #line)
{

  var didFail = false

  for innerArray in array {
    for anotherInnerArray in innerArray {
      for value in anotherInnerArray {
        guard !(value.isNaN || value.isInfinite) else {
          didFail = true
          break
        }
      }
    }
  }

  guard didFail else  { return }

  let failureDescription = """
    XCTAssertNotNaNOrInf failed: ("\(description(of: array))") contains at least one \
    'nan' or 'inf' value.
    """

  _XCTPreformattedFailureHandler(_XCTCurrentTestCase(),
                                 true,
                                 file.description,
                                 Int(line),
                                 failureDescription, message())

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
public func XCTAssertGreaterThanOrEqual<T:FloatingPoint>(_ array: [T],
                                                         _ value: T,
                                                         _ message: @autoclosure () -> String = "",
                                                         file: StaticString = #file,
                                                         line: UInt = #line)
{

  var didFail = false

  for actual in array {
    guard actual >= value else {
      didFail = true
      break
    }
  }

  guard didFail else  { return }

  let failureDescription = """
    XCTAssertGreaterThanOrEqual failed: ("\(description(of: array))") contains at least one \
    value < ("\(value)").
    """

  _XCTPreformattedFailureHandler(_XCTCurrentTestCase(),
                                 true,
                                 file.description,
                                 Int(line),
                                 failureDescription, message())

}
/// Asserts that a two dimensional array of floating point numbers contains  values less than a
/// given value.
///
/// - Parameters:
///   - array: A two dimensional array of floating point numbers.
///   - value: The value to which all values in `array` must be greater than or equal.
///   - message: An optional description of the failure.
///   - file: The file in which failure occurred. Defaults to the file name of the test case in
///           which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this
///           function was called.
public func XCTAssertGreaterThanOrEqual<T:FloatingPoint>(_ array: [[T]],
                                                         _ value: T,
                                                         _ message: @autoclosure () -> String = "",
                                                         file: StaticString = #file,
                                                         line: UInt = #line)
{

  var didFail = false

  for innerArray in array {
    for actual in innerArray {
      guard actual >= value else {
        didFail = true
        break
      }
    }
  }

  guard didFail else  { return }

  let failureDescription = """
    XCTAssertGreaterThanOrEqual failed: ("\(description(of: array))") contains at least one \
    value < ("\(value)").
    """

  _XCTPreformattedFailureHandler(_XCTCurrentTestCase(),
                                 true,
                                 file.description,
                                 Int(line),
                                 failureDescription, message())

}

/// Asserts that a three dimensional array of floating point numbers contains  values less than a
/// given value.
///
/// - Parameters:
///   - array: A three dimensional array of floating point numbers.
///   - value: The value to which all values in `array` must be greater than or equal.
///   - message: An optional description of the failure.
///   - file: The file in which failure occurred. Defaults to the file name of the test case in
///           which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this
///           function was called.
public func XCTAssertGreaterThanOrEqual<T:FloatingPoint>(_ array: [[[T]]],
                                                         _ value: T,
                                                         _ message: @autoclosure () -> String = "",
                                                         file: StaticString = #file,
                                                         line: UInt = #line)
{

  var didFail = false

  for innerArray in array {
    for anotherInnerArray in innerArray {
      for actual in anotherInnerArray {
        guard actual >= value else {
          didFail = true
          break
        }
      }
    }
  }

  guard didFail else  { return }

  let failureDescription = """
    XCTAssertGreaterThanOrEqual failed: ("\(description(of: array))") contains at least one \
    value < ("\(value)").
    """

  _XCTPreformattedFailureHandler(_XCTCurrentTestCase(),
                                 true,
                                 file.description,
                                 Int(line),
                                 failureDescription, message())

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
public func XCTAssertAverageEqual<T:FloatingPoint>(_ array: [T],
                                                   _ expected: T,
                                                   accuracy: T = 0,
                                                   _ message: @autoclosure () -> String = "",
                                                   file: StaticString = #file,
                                                   line: UInt = #line)
{

  let average = array.reduce(0, +) / T(array.count)

  guard abs(average - expected) > accuracy else  { return }

  let failureDescription = """
    XCTAssertAverageEqual failed: ("\(average)") is not equal to ("\(expected)") \
    +/- ("\(accuracy)")
    """

  _XCTPreformattedFailureHandler(_XCTCurrentTestCase(),
                                 true,
                                 file.description,
                                 Int(line),
                                 failureDescription, message())

}

