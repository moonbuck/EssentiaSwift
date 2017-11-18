//
//  Output.swift
//  PitchAnalysis
//
//  Created by Jason Cardwell on 11/18/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
import Foundation
import Essentia

/// Prints the top of a box that includes a header row with the specified labels.
///
/// - Parameters:
///   - labels: The labels to use as column headers.
///   - minColumnWidth: The minimum width for the column. Defaults to `0`.
/// - Returns: An array containing the actual column widths used.
func printBoxTop(labels: [String], minColumnWidth: Int = 0) -> [Int] {

  let widths = labels.map({max($0.count, minColumnWidth)})

  print("┌", widths.map({"─" * $0}).joined(separator: "┬"), "┐", separator: "")

  print("│",
        zip(labels, widths).map({$0.padded(to: $1, alignment: .center)}).joined(separator: "│"),
        "│",
        separator: "")

  print("├", widths.map({"─" * $0}).joined(separator: "┼"), "┤", separator: "")

  return widths

}

/// Prints a row values within a box using the specified column widths.
///
/// - Parameters:
///   - values: A values for each column in the box.
///   - columnWidths: A width for each column in the box.
///   - alignment: The alignment for the value within the column.
///   - offset: The number of spaces to add between the value and the edge of the column.
func printBoxRow(values: [CustomStringConvertible],
                 columnWidths: [Int],
                 alignment: String.PadAlignment = .right,
                 offset: Int = 2)
{

  assert(values.count == columnWidths.count,
         "Expected an equal count for values and column widths.")

  func columnContent(for value: CustomStringConvertible, columnWidth: Int) -> String {

    let padLength: Int

    switch alignment {
      case .center: padLength = columnWidth - 2 * offset
      case .left, .right: padLength = columnWidth - offset
    }

    let content = value.description.padded(to: padLength, alignment: alignment)

    guard content.count < columnWidth else { return content }

    switch alignment {
      case .center: return " " * offset + content + " " * offset
      case .left:   return " " * offset + content
      case .right:  return content + " " * offset
    }

  }

  print("│",
        zip(values, columnWidths).map(columnContent(for:columnWidth:)).joined(separator: "│"),
        "│",
        separator: "")

}

/// Prints the bottom of a box using the specified column widths.
///
/// - Parameter columnWidths: A width for each column in the box.
func printBoxBottom(columnWidths: [Int]) {

  print("└", columnWidths.map({"─" * $0}).joined(separator: "┴"), "┘", separator: "")

}
