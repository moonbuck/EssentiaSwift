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

/// Helper that logs a two column table for comparing values for two arrays.
///
/// - Parameters:
///   - label1: The header for the first array.
///   - array1: The first array.
///   - label2: The header for the second array.
///   - array2: The second array.
///   - valueFormat: The string format specifier to apply to array values. Default is `"%e"`.
///   - target: The output stream to which the text will be written.
public func dumpComparison<Target>(of label1: String, _ array1: [Float],
                           with label2: String, _ array2: [Float],
                           valueFormat: String = "%e", target: inout Target)
  where Target:TextOutputStream
{

  /// Helper that calculates the percent deviation from one value to another.
  ///
  /// - Parameters:
  ///   - v1: The first value.
  ///   - v2: The second value.
  /// - Returns: The percent deviation from `v1` to `v2`.
  func percentDeviation(_ v1: Float, _ v2: Float) -> Float {
    return v2 == 0 ? .infinity : v1 == 0 ? 100 : abs(v2 - v1) / abs(v2) * 100
  }

  let indexColumnWidth = max(array1.count, array2.count, 5).description.count + 2

  let indexLabel = "Index".padded(to: indexColumnWidth, alignment: .center, padCharacter: " ")

  let columnWidth = max(label1.count, label2.count, 18)

  let label1 = label1.padded(to: columnWidth, alignment: .center, padCharacter: " ")
  let label2 = label2.padded(to: columnWidth, alignment: .center, padCharacter: " ")

  let differenceLabel = "Difference".padded(to: columnWidth, alignment: .center, padCharacter: " ")
  let deviationLabel = "Deviation".padded(to: columnWidth, alignment: .center, padCharacter: " ")

  print(indexLabel, label1, label2, differenceLabel, deviationLabel, separator: "", to: &target)

  let line = "─" * (columnWidth * 4 + indexColumnWidth)

  print(line, to: &target)

  let valueWidth = columnWidth - 2

  var differenceValues: [Float] = []
  var deviationValues: [Float] = []

  for (index, (value1, value2)) in zip(array1, array2).enumerated() {

    let index = index.description
                  .padded(to: indexColumnWidth - 2, alignment: .right, padCharacter: " ")

    let difference = value2 - value1
    differenceValues.append(difference)

    let deviation = percentDeviation(value1, value2)
    deviationValues.append(deviation)

    let differenceʹ = String(format: valueFormat, difference)
                       .padded(to: valueWidth, alignment: .right, padCharacter: " ")
    let deviationʹ = (String(format: valueFormat, deviation) + "%")
                      .padded(to: valueWidth, alignment: .right, padCharacter: " ")
    let value1 = String(format: valueFormat, value1)
                   .padded(to: valueWidth, alignment: .right, padCharacter: " ")
    let value2 = String(format: valueFormat, value2)
                   .padded(to: valueWidth, alignment: .right, padCharacter: " ")


    print(index, value1, value2, differenceʹ, deviationʹ, separator: "  ", to: &target)

  }

  if array1.count > array2.count {

    for (index, value) in zip(array2.count..<array1.count, array1[array2.count...]) {

      let index = index.description
                    .padded(to: indexColumnWidth - 2, alignment: .right, padCharacter: " ")

      let value = String(format: valueFormat, value)
                    .padded(to: valueWidth, alignment: .right, padCharacter: " ")

      print(index, value, separator: "  ", to: &target)

    }

  }

  else if array2.count > array1.count {

    let spacer = " " * valueWidth

    for (index, value) in zip(array1.count..<array2.count, array2[array1.count...]) {

      let index = index.description
                    .padded(to: indexColumnWidth - 2, alignment: .right, padCharacter: " ")

      let value = String(format: valueFormat, value)
                    .padded(to: valueWidth, alignment: .right, padCharacter: " ")

      print(index, spacer, value, separator: "  ", to: &target)

    }

  }

  else {

    print(line, to: &target)
    let averagesLabel = "Averages:" + " " * ((columnWidth * 2 + indexColumnWidth) - 11)

    let countu = vDSP_Length(array1.count)
    let countf = Float(array1.count)
    var sum: Float = 0

    vDSP_sve(differenceValues, 1, &sum, countu)

    let averageDifference = sum / countf

    let averageDifferenceʹ = String(format: valueFormat, averageDifference)
                               .padded(to: valueWidth, alignment: .right, padCharacter: " ")

    vDSP_sve(deviationValues, 1, &sum, countu)

    let averageDeviation = sum / countf

    let averageDeviationʹ = (String(format: valueFormat, averageDeviation) + "%")
                              .padded(to: valueWidth, alignment: .right, padCharacter: " ")


    print(averagesLabel, averageDifferenceʹ, averageDeviationʹ, separator: "  ", to: &target)

  }


}
