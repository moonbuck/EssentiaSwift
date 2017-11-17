//
//  RTFHelpers.swift
//  EssentiaTests
//
//  Created by Jason Cardwell on 11/7/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
import Foundation
import Essentia

/// Helper that combines a dictionary of parameters with a dictionary of descriptions to
/// form an array of `ParameterInfo` tuples.
///
/// - Parameters:
///   - parameters: The parameters to include.
///   - descriptions: The descriptions for `parameters`.
/// - Returns: The array of `ParameterInfo` tuples formed using `parameters` and `descriptions`.
private func generateParameterInfos(parameters: [String:ParameterWrapper],
                                    descriptions: [String:String]) -> [ParameterInfo]
{

  let infos: [String:ParameterInfo] = parameters.mappingMerge(descriptions) {
    (name: String, parameter: ParameterWrapper?, description: String?) -> ParameterInfo? in

    guard let parameter = parameter, var description = description else { return nil }

    let type = parameter.dataType.description

    var valueDescription: String
    switch parameter.value {
    case let value as [Float]:
      valueDescription = "[" + value.map({"\($0)"}).joined(separator: ", ") + "]"
    case let value as [String]:
      valueDescription = "[" + value.map({"'\($0)'"}).joined(separator: ", ") + "]"
    case let value as String:
      valueDescription = "'" + value + "'"
    case let value as Bool:
      valueDescription = value.description
    case let value?:
      valueDescription = "\(value)"
    default:
      valueDescription = ""
    }

    if valueDescription.count > 50 {
      valueDescription =
        String(valueDescription.dropLast(valueDescription.count - 25))
        + " … "
        + String(valueDescription.dropFirst(valueDescription.count - 25))
    }

    if let firstChar = description.first {
      description = String(firstChar).uppercased() + String(description.dropFirst())
    }

    if (description.last == ".") == false {
      description.append(".")
    }

    return (name: name, type: type, value: valueDescription, desc: description)

  }

  return Array(infos.values)

}

/// Generates text in rich text format containing a description for the algorithm associated
/// with each of the provided infos. The descriptions will appear grouped by category.
///
/// - Parameters:
///   - infos: The array of infos from which to generate algorithm descriptions.
///   - title: The title to place at the head of the document.
/// - Returns: The raw data for the generated text.
public func generateAlgorithmRTFDocument(with infos: [AlgorithmInfoWrapper],
                                         title: String) -> Data
{

  // Create a string for accumulating text in rich text format.
  var output = ""

  // Add the preamble to `output`.
  rtfPrintPreamble(to: &output)

  // Add a title to `output`.
  rtfPrint(title: title, to: &output)

  // Group the info by algorithm category.
  let infosByCategory = Dictionary(grouping: infos, by: {$0.algorithmCategory})

  // Iterate the categories.
  for (category, infos) in infosByCategory {

    // Add the category name to `output`.
    rtfPrint(category: category, to: &output)

    // Iterate the infos in `category`.
    for info in infos {

      // Create a new algorithm wrapper instance using `info`.
      let algorithm = info.createAlgorithm()

      // Map the algorithm's inputs and outputs to `IOInfo` tuples.
      let inputInfos: [IOInfo], outputInfos: [IOInfo]

      switch algorithm {

        case let algorithm as StandardAlgorithmWrapper:
          inputInfos = algorithm.inputs.map { (name: $0, type: $1.dataType.description) }
          outputInfos = algorithm.outputs.map { (name: $0, type: $1.dataType.description) }

        case let algorithm as StreamingAlgorithmWrapper:
          inputInfos = algorithm.inputs.map  { (name: $0, type: $1.dataType.description) }
          outputInfos = algorithm.outputs.map { (name: $0, type: $1.dataType.description) }

        default:
          fatalError("Unable to downcast `algorithm` to standard or streaming.")

      }

      // Generate the parameter infos.
      let parameterInfos = generateParameterInfos(parameters: algorithm.defaultParameters,
                                                  descriptions: algorithm.parameterDescription)

      // Add a complete description of `algorithm` to `output`.
      rtfPrintAlgorithm(name: info.algorithmName,
                        inputs: inputInfos,
                        outputs: outputInfos,
                        parameters: parameterInfos,
                        description: info.algorithmDescription,
                        to: &output)


    }

    // Add a blank line to `output`.
    rtfPrintBlankLines(count: 1, to: &output)

  }

  // Add text to terminate the RTF text to `output`.
  rtfPrintPostamble(to: &output)

  // Get `output` as raw data.
  guard let outputData = rtfData(for: output) else {
    fatalError("Failed to get the output string as raw data.")
  }

  return outputData

}

/// Inserts the opening text for an RTF document into the specified target. The preamble
/// includes declarations for the following fonts:
/// - InputMonoCompressed-Regular
/// - InputMonoCompressed-ThinItalic
/// - InputMonoCompressed-Bold
/// - InputMonoCompressed-MediumItalic
/// - InputMonoCompressed-ExtraLightItalic
///
/// - Parameter target: The stream to which the text will be written.
public func rtfPrintPreamble<Target>(to target: inout Target) where Target:TextOutputStream {
  print("""
    {\\rtf1\\ansi\\ansicpg1252\\cocoartf1561
    {\\fonttbl\\f0\\fnil\\fcharset0 InputMonoCompressed-Regular;\\f1\\fnil\\fcharset0 \
    InputMonoCompressed-ThinItalic;\\f2\\fnil\\fcharset0 InputMonoCompressed-Bold;\
    \\f3\\fnil\\fcharset0 InputMonoCompressed-MediumItalic;\\f4\\fnil\\fcharset0 \
    InputMonoCompressed-ExtraLightItalic;\\f5\\fnil\\fcharset0 InputMonoCompressed-Thin;\
    \\f6\\fnil\\fcharset0 InputMonoCompressed-Black;}
    {\\colortbl;\\red255\\green255\\blue255;}
    {\\*\\expandedcolortbl;;}
    \\vieww33400\\viewh19600\\viewkind0
    \\deftab720
    \\pard\\pardeftab720\\partightenfactor0

    \\f0\\fs24 \\cf0
    """, to: &target)
}

/// Inserts the closing text for an RTF document into the specified target.
///
/// - Parameter target: The stream to which the text will be written.
public func rtfPrintPostamble<Target>(to target: inout Target) where Target:TextOutputStream {
  print("}", terminator: "", to: &target)
}

/// Inserts a title for an RTF document into the specified target.
///
/// - Parameters:
///   - title: The text for the title.
///   - target: The stream to which the text will be written.
public func rtfPrint<Target>(title: String, to target: inout Target) where Target:TextOutputStream {
  print("\\f6\\fs48\(title)\\\n\\\n\\f0\\fs24", terminator: "\\\n", to: &target)
}

/// Inserts the specified number of blank lines in RTF format into the specified target.
///
/// - Parameters:
///   - count: The number of blank lines to insert.
///   - target: The stream to which the text will be written.
public func rtfPrintBlankLines<Target>(count: Int, to target: inout Target) where Target:TextOutputStream {
  print(String(repeating: "\\\n", count: count), terminator: "\\\n", to: &target)
}

/// Inserts header text for an algorithm category in RTF format into the specified target .
///
/// - Parameters:
///   - category: The category name.
///   - target: The stream to which the text will be written.
public func rtfPrint<Target>(category: String, to target: inout Target) where Target:TextOutputStream {
  let hBar = "\\f1\\i \\uc0" + String(repeating: "\\u9472 ", count: 120) + "\n\\f0\\i0 "
  print("\n\\f1\\i\\fs36 \(category)\n\\f0\\i0\\fs24 ", hBar,
        separator: "\\\n",
        terminator: "\\\n\\\n\\\n",
        to: &target)
}

/// A typealias for a tuple describing an algorithm's input or output.
public typealias IOInfo = (name: String, type: String)

/// Generates a string of text in RTF format describing an algorithm's inputs or outputs.
///
/// - Parameter infos: Info for each input or output for an algorithm.
/// - Returns: The description of the inputs or outputs in RTF format.
public func rtfIODescription(infos: [IOInfo]) -> String {
  return infos.map({"\($0.name) (\\f5\($0.type)\\f0)"}).joined(separator: "\\\n           ")
}

/// A typealias for a tuple describing an algorithm's parameter.
public typealias ParameterInfo = (name: String, type: String, value: String, desc: String)

/// Generates a string of text in RTF format describing an algorithm's parameters.
///
/// - Parameter infos: Info for each of the algorithm's parameters.
/// - Returns: The description of the parameters in RTF format.
public func rtfParameterDescription(infos: [ParameterInfo]) -> String {

  guard !infos.isEmpty else { return "none" }

  let maxNameCount = infos.map({$0.name.count}).max() ?? 0
  let indent = 16 + maxNameCount

  return infos.map({

    let (name, type, value, desc) = $0

    var result = ""

    print(name, ": ", separator: "", terminator: "", to: &result)


    let typeAndDefault = "(\\f5\(type)\\f0|\\f4\\i \(value)\\f0\\i0 )"
    let typeAndDefaultCount = typeAndDefault.count - 17

    let (wrappedDescription, remainingCols) = rtfLineWrap(text: desc,
                                                          at: 120,
                                                          indent: indent,
                                                          indentFirstLine: false)

    print(String(repeating: " ", count: maxNameCount - name.count), terminator: "", to: &result)

    if remainingCols < typeAndDefaultCount {

      print(wrappedDescription, String(repeating: " ", count: indent), typeAndDefault,
            separator: "", terminator: "", to: &result)

     } else {
      print(wrappedDescription.dropLast(2), typeAndDefault, terminator: "", to: &result)
    }

    return result

  }).joined(separator: "\\\n              ")

}

/// Generates a string of text in RTF format by line wrapping the specified string.
///
/// - Parameters:
///   - text: The string to wrap using RTF format.
///   - column: The column at which a line will be wrapped.
///   - indent: The number of spaces to insert at the head of each line.
///   - preserveBlankLines: Whether blank lines will be reproduced in the output string.
///   - indentFirstLine: Whether to apply indentation to the first line.
/// - Returns: `text` line-wrapped and in RTF format and the number of columns between the
///            final character of last line of text and `column`.
public func rtfLineWrap(text: String,
                        at column: Int,
                        indent: Int,
                        preserveBlankLines: Bool = false,
                        indentFirstLine: Bool = true) -> (text: String, remainingCols: Int)
{

  var result = ""

  let lines = text.split(separator: "\n")
  let spaces = String(repeating: " ", count: indent)

  let printCount = column - indent

  let markerRegex = try! NSRegularExpression(pattern: "^\\s*(?:-|(?:\\[[0-9]\\]))\\s*(\\S)",
                                             options: [])

  var remainingCols = 0

  for line in lines {

    switch line.count {

    case ...printCount:

      guard preserveBlankLines || !line.isEmpty else { break }

      remainingCols = printCount - line.count
      print("\(indentFirstLine ? spaces : "")\(line)", terminator: "\\\n", to: &result)

    default:

      var printIndex = line.startIndex

      var subsequentSpaces = spaces

      if let markerRange = markerRegex
                             .firstMatch(in: String(line), options: [],
                                         range: NSRange(location: 0, length: line.utf16.count))?
                             .range(at: 1),
          markerRange.location != NSNotFound
      {
        subsequentSpaces += String(repeating: " ", count: markerRange.location)
      }

      while printIndex != line.endIndex {

        let appliedSpaces = printIndex == line.startIndex
                              ? indentFirstLine
                                ? spaces
                                : ""
                              : subsequentSpaces

        guard line.distance(from: printIndex, to: line.endIndex) > printCount,
              var splitIndex = line.index(of: " ")
          else
        {
          let text = line[printIndex...]
          remainingCols = printCount - text.count
          print(appliedSpaces, text, separator: "", terminator: "\\\n", to: &result)
          break
        }

        while let nextSplitIndex = line[line.index(after: splitIndex)...].index(of: " "),
              line.distance(from: printIndex, to: nextSplitIndex) < printCount
        {
          splitIndex = nextSplitIndex
        }

        if line.distance(from: printIndex, to: splitIndex) < 0 {

          while let nextSplitIndex = line[line.index(after: splitIndex)...].index(of: "/"),
            line.distance(from: printIndex, to: nextSplitIndex) < printCount
          {
            splitIndex = nextSplitIndex
          }

        }

        assert(line.distance(from: printIndex, to: splitIndex) > 0)

        let text = line[printIndex..<splitIndex]
        remainingCols = printCount - text.count
        print(appliedSpaces, text, separator: "", terminator: "\\\n", to: &result)
        printIndex = line.index(after: splitIndex)

      }

    }

  }

  return (text: result, remainingCols: remainingCols)

}

/// Inserts text describing an algorithm in RTF format into the specified target using the
/// parameters provided.
///
/// - Parameters:
///   - name: The name of the algorithm.
///   - inputs: Descriptions of the algorithm's inputs.
///   - outputs: Descriptions of the algorithm's outputs.
///   - parameters: Descriptions of the algorithm's parameters.
///   - description: A description of the algorithm.
///   - target: The stream to which the text will be written.
public func rtfPrintAlgorithm<Target>(name: String,
                                      inputs: [IOInfo],
                                      outputs: [IOInfo],
                                      parameters: [ParameterInfo],
                                      description: String,
                                      to target: inout Target) where Target:TextOutputStream
{

  print("""
     \\
     \\f2\\b\\fs28 \(name)\n\\f0\\b0\\fs24 \\
     \\f0\\b0 \\
       \\f1\\i inputs:  \\f0\\i0 \(rtfIODescription(infos: inputs))\\
       \\f1\\i outputs: \\f0\\i0 \(rtfIODescription(infos: outputs))\\
     \\
       \\f1\\i parameters: \\f0\\i0 \(rtfParameterDescription(infos: parameters))\\
     \\
     \(rtfLineWrap(text: description, at: 120, indent: 2).text)
     \\\n\\
     """, to: &target)

}

/// Helper that returns raw data for an RTF file given a string of text. Non-ASCII characters
/// are converted to character codes before the conversion to raw data.
///
/// - Parameter string: The string of text.
/// - Returns: The formatted data for `string`.
public func rtfData(for string: String) -> Data? {

  var encodedString = ""

  for character in string {

    for scalar in character.unicodeScalars {

      if scalar.isASCII { scalar.write(to: &encodedString) }
      else {
        "\\u\(scalar.value) ".write(to: &encodedString)
      }

    }

  }

  return encodedString.data(using: .utf8)

}
