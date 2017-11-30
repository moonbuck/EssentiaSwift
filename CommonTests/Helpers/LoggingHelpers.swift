//
//  LoggingHelpers.swift
//  Essentia
//
//  Created by Jason Cardwell on 11/29/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
import Foundation
import Essentia
import Accelerate

private let columnWidth = 18
private let valueWidth = 16
private let indexColumnWidth = 8

private let line = "─" * (columnWidth * 4 + indexColumnWidth)
private let averagesLabel = "Averages:" + " " * ((columnWidth * 2 + indexColumnWidth) - 11)
private let spacer = " " * valueWidth

private let tableHeader: String = {

  let indexLabel = "Index".padded(to: indexColumnWidth, alignment: .center)
  let actualLabel = "Actual".padded(to: columnWidth, alignment: .center)
  let expectedLabel = "Expected".padded(to: columnWidth, alignment: .center)
  let differenceLabel = "Difference".padded(to: columnWidth, alignment: .center)
  let deviationLabel = "Deviation".padded(to: columnWidth, alignment: .center)

  return "\(indexLabel)\(actualLabel)\(expectedLabel)\(differenceLabel)\(deviationLabel)\n\(line)"

}()

/// Helper for creating a formatted string from a value.
///
/// - Parameters:
///   - value: The value to format.
///   - isPercent: Whether to add a trailing `"%"` to the result.
/// - Returns: The formatted string for `value`.
private func format(value: Float, isPercent: Bool = false) -> String {
  let valueDescription = String(format: "%.11f", value)
  let decimalIndex = valueDescription.index(of: ".")!
  var endIndex = valueDescription.index(decimalIndex, offsetBy: 2)
  var currentIndex = valueDescription.index(after: endIndex)
  while currentIndex != valueDescription.endIndex {
    if valueDescription[currentIndex] != "0" { endIndex = currentIndex }
    currentIndex = valueDescription.index(after: currentIndex)
  }
  let text = String(valueDescription[..<endIndex]) + (isPercent ? "%" : "")
  return text.padded(to: valueWidth, alignment: .right)
}

/// Helper for creating a formatted string for an index.
///
/// - Parameter index: The index to format.
/// - Returns: The formatted string for `index`.
private func format(index: Int) -> String {
  return index.description.padded(to: indexColumnWidth - 2, alignment: .right, padCharacter: " ")
}

/// Helper for creating a formatted string with the average for an array of values.
///
/// - Parameters:
///   - array: The array to average and format.
///   - isPercent: Whether to add a trailing `"%"` to the result.
///   - result: Contains the calculated average on output.
/// - Returns: The formatted string for the average of `array`.
private func formatAverage(for array: [Float],
                           isPercent: Bool = false,
                           result: UnsafeMutablePointer<Float>? = nil) -> String {
  let countu = vDSP_Length(array.count)
  let countf = Float(array.count)
  var sum: Float = 0
  vDSP_sve(array, 1, &sum, countu)
  let average = sum / countf
  result?.pointee = average
  return format(value: average, isPercent: isPercent)
}

/// Helper that logs a two column table comparing actual and expected arrays.
///
/// - Parameters:
///   - array1: The first array.
///   - array2: The second array.
///   - target: The output stream to which the text will be written.
/// - Returns: The average difference and the average deviation.
@discardableResult
public func dumpComparison<Target>(of array1: [Float],
                                   with array2: [Float],
                                   target: inout Target) -> (difference: Float, deviation: Float)?
  where Target:TextOutputStream
{

  print(tableHeader, to: &target)

  var differenceValues: [Float] = []
  var deviationValues: [Float] = []

  for (index, (value1, value2)) in zip(array1, array2).enumerated() {

    let difference = value2 - value1
    differenceValues.append(difference)

    let deviation = percentDeviation(value1, value2)
    deviationValues.append(deviation)

    print(format(index: index),
          format(value: value1),
          format(value: value2),
          format(value: difference),
          format(value: deviation, isPercent: true),
          separator: "  ",
          to: &target)

  }

  if array1.count > array2.count {
    for (index, value) in zip(array2.count..<array1.count, array1[array2.count...]) {
      print(format(index: index), format(value: value), separator: "  ", to: &target)
    }
    return nil
  } else if array2.count > array1.count {
    for (index, value) in zip(array1.count..<array2.count, array2[array1.count...]) {
      print(format(index: index),
            spacer,
            format(value: value),
            separator: "  ",
            to: &target)
    }
    return nil
  } else {
    var averageDifference: Float = 0, averageDeviation: Float = 0
    print(line, to: &target)
    print(averagesLabel,
          formatAverage(for: differenceValues, result: &averageDifference),
          formatAverage(for: deviationValues, isPercent: true, result: &averageDeviation),
          separator: "  ",
          to: &target)
    return (difference: averageDifference, deviation: averageDeviation)
  }

}

/// Helper that logs a two column tables comparing actual and expected arrays of arrays.
///
/// - Parameters:
///   - array1: The first array.
///   - array2: The second array.
///   - target: The output stream to which the text will be written.
public func dumpComparison<Target>(of array1: [[Float]], with array2: [[Float]], target: inout Target)
  where Target:TextOutputStream
{

  var nilResult = false

  var differenceValues: [Float] = []
  var deviationValues: [Float] = []

  for (index, (subarray1, subarray2)) in zip(array1, array2).enumerated() {
    print("Subarray index: \(index)\n", to: &target)
    let result = dumpComparison(of: subarray1, with: subarray2, target: &target)
    if let result = result {
      differenceValues.append(result.difference)
      deviationValues.append(result.deviation)
    } else {
      nilResult = true
    }
    print("", to: &target)
  }

  if array1.count > array2.count {
    for (index, subarray) in zip(array2.count..<array1.count, array1[array2.count...]) {
      print("Subarray index: \(index)", to: &target)
      dumpComparison(of: subarray, with: [], target: &target)
    }
  } else if array2.count > array1.count {
    for (index, subarray) in zip(array1.count..<array2.count, array2[array1.count...]) {
      print("Subarray index: \(index)", to: &target)
      dumpComparison(of: [], with: subarray, target: &target)
    }
  } else if !nilResult {
    print("", to: &target)
    print("Average difference for array:\(formatAverage(for: differenceValues))", to: &target)
    print("Average deviation for array:\(formatAverage(for: deviationValues, isPercent: true))",
      to: &target)
  }

}

/// Helper that logs a two column table comparing actual and expected arrays.
///
/// - Parameters:
///   - array1: The first array.
///   - array2: The second array.
///   - target: The output stream to which the text will be written.
public func dumpComparison<Target>(of array1: [String],
                                   with array2: [String],
                                   target: inout Target)
  where Target:TextOutputStream
{

  let indexLabel = "Index".padded(to: indexColumnWidth, alignment: .center)
  let actualColumnWidth = max(8, array1.map(\.count).max() ?? 0)
  let actualLabel = "Actual".padded(to: actualColumnWidth, alignment: .center)
  let expectedColumnWidth = max(10, array2.map(\.count).max() ?? 0)
  let expectedLabel = "Expected".padded(to: expectedColumnWidth, alignment: .center)

  print(indexLabel, actualLabel, expectedLabel, separator: "", to: &target)
  print("─" * (indexColumnWidth + actualColumnWidth + expectedColumnWidth), to: &target)

  for (index, (value1, value2)) in zip(array1, array2).enumerated() {
    print(format(index: index),
          "  ",
          value1.padded(to: actualColumnWidth, alignment: .center),
          value2.padded(to: expectedColumnWidth, alignment: .center),
          separator: "",
          to: &target)
  }

  if array1.count > array2.count {
    for (index, value) in zip(array2.count..<array1.count, array1[array2.count...]) {
      print(format(index: index),
            "  ",
            value.padded(to: actualColumnWidth, alignment: .center),
            separator: "",
            to: &target)
    }
  } else if array2.count > array1.count {
    let spacer = " " * actualColumnWidth
    for (index, value) in zip(array1.count..<array2.count, array2[array1.count...]) {
      print(format(index: index),
            "  ",
            spacer,
            value.padded(to: expectedColumnWidth, alignment: .center),
            separator: "",
            to: &target)
    }
  }

}

