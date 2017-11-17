//
//  SpecificationHelpers.swift
//  EssentiaTests
//
//  Created by Jason Cardwell on 11/7/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
import Foundation
import Essentia

/// Inserts the begining of an algorithm mode enumeration declaration into the specified stream.
///
/// - Parameters:
///   - name: The name of the algorithm mode.
///   - target: The stream to which the text will be written.
public func beginAlgorithmMode<Target>(name: String, isExtension: Bool, target: inout Target)
  where Target:TextOutputStream
{

  if isExtension {

    print("""
      extension \(name) {
      
      """, to: &target)

  } else {

    print("""
      /// An enumeration serving as both a namespace and a mode of operation for algorithm specifications.
      public enum \(name): AlgorithmMode {

      """, to: &target)

  }

}

/// Inserts characters for closing an open algorithm mode declaration into the specified stream.
///
/// - Parameter target: The stream to which the text will be written.
public func endAlgorithmMode<Target>(target: inout Target)
  where Target:TextOutputStream
{

  print("}\n", to: &target)

}

/// Inserts an enumeration declaration for `AlgorithmID` into the specified stream of text.
///
/// - Parameters:
///   - caseNamesByCategory: A collection of case names for the enumeration grouped by category.
///   - mode: The algorithm mode with which the enumeration is to be associated.
///   - target: The stream to which the text will be written.
public func appendAlgorithmID<Target>(namesByCategory: [String:[String]],
                                      mode: String,
                                      target: inout Target)
  where Target:TextOutputStream
{

  // Begin the declaration of the `AlgorithmID` enumeration.
  print("""
        /// An enumeration of identifiers for all supported \(mode.lowercased()) algorithms.
        public enum AlgorithmID: String {

      """, to: &target)

  // Convert the dictionary into an array so the last category name can be determined.
  let categories = Array(namesByCategory)

  // Iterate the categories.
  for (categoryName, caseNames) in categories {

    // Get a category name that is a valid Swift identifier.
    let category = formattedCategory(categoryName)

    // Add a comment with the name of the category.
    print("    /// \(category)\n    case ", terminator: "", to: &target)

    // Keep count of the length of the current line.
    var currentCount = 0

    // Iterate case name indices.
    for index in caseNames.indices {

      // Determine if this is the last case name for the current category.
      let isLast = caseNames.index(after: index) == caseNames.endIndex

      // Get the case name.
      let name = caseNames[index]

      // Check whether `name` would make the current line longer than `90` characters.
      if currentCount + name.count > 90 {

        // Begin a new line and indent so that the case name is aligned with the first case in
        // the previous line.
        print("\n         ", terminator: "", to: &target)

        // Reset the counter.
        currentCount = 0
      }

      // Add the case name.
      print(name, terminator: "", to: &target)

      // Update the character count.
      currentCount += name.count

      // Check whether there are more cases for the current category.
      if !isLast {

        // Append a separator.
        print(", ", terminator: "", to: &target)

        // Update the character count.
        currentCount += 2

      } else {

        // There are no more cases for this category so end the line.
        print("\n", to: &target)

      }


    }

  }

  // Begin the declaration of a static property consisting of an array of all the cases.
  print("""
        /// The set of all enumeration cases.
        public static let allIDs: Set<AlgorithmID> = [
    """, to: &target)

  // Keep track of the length of the current line.
  var currentCount = 0

  // Add indentation for the first array element.
  print("       ", terminator: "", to: &target)

  // Iterate the categories.
  for (categoryName, caseNames) in categories {

    // Determine whether this is the last category.
    let isLastCategory = categoryName == categories.last!.key

    // Iterate the case name indices.
    for index in caseNames.indices {

      // Determine whether this is the last case for the last category.
      let isLastCase = isLastCategory && caseNames.index(after: index) == caseNames.endIndex

      // Get the case name.
      let name = caseNames[index]

      // Check whether `name` would make the current line longer than `90` characters.
      if currentCount + name.count > 90 {

        // Begin a new line and add indentation
        print("\n       ", terminator: "", to: &target)

        // Reset the counter.
        currentCount = 0

      }

      // Add the case name and a separator or newline character according to `isLastCase`.
      print(".\(name)", terminator: isLastCase ? "\n" : ", ", to: &target)

      // Update the counter.
      currentCount += name.count + (isLastCase ? 1 : 3)

    }

  }

  // End the array of all cases and begin a declaration for a func that returns the specification
  // corresponding to a case.
  print("""
        ]

        /// Function for retrieving the specification corresponding to the identifier.
        ///
        /// - Returns: The corresponding specification.
        public func spec<Spec:\(mode)Specification>() -> Spec.Type {
          switch self {
    """, to: &target)

  // Iterate the categories.
  for (categoryName, caseNames) in categories {

    // Get a category name that is a valid Swift identifier.
    let category = formattedCategory(categoryName)

    // Iterate the case names for the current category.
    for name in caseNames  {

      // Add a case to the switch statment for `name`.
      print("        case .\(name): return \(category).\(name).self as! Spec.Type", to: &target)

    }

  }

  // Close the switch statement, the function, and the enumeration declaration.
  print("""
        }
      }

    }

  """, to: &target)

}

/// Inserts typealias declarations into the specified stream.
///
/// - Parameters:
///   - caseNamesByCategory: A collection of specification names grouped by category.
///   - target: The stream to which the text will be written.
public func appendSpecificationTypealiases<Target>(namesByCategory: [String:[String]],
                                                   target: inout Target)
  where Target:TextOutputStream
{

  // Iterate the categories.
  for (categoryName, caseNames) in namesByCategory {

    // Get a category name that is a valid Swift identifier.
    let category = formattedCategory(categoryName)

    // Iterate the names for the current category.
    for name in caseNames {

      // Append a typealias that bypasses the category.
      print("""
          /// A typealias for `\(category).\(name)` so that it can be used without knowing the category.
          public typealias \(name) = \(category).\(name)

        """, to: &target)

    }

  }

}

/// Inserts the begining of an algorithm category enumeration declaration into the specified stream.
///
/// - Parameters:
///   - name: The name of the algorithm category.
///   - target: The stream to which the text will be written.
public func beginAlgorithmCategory<Target>(name: String, target: inout Target)
  where Target:TextOutputStream
{

  // Get a category name that is a valid Swift identifier.
  let category = formattedCategory(name)

  // Add the beginning of the category declaration and a static property returning the
  // non-formatted name.
  print("""
      /// An enumeration serving as both a namespace and a category for algorithm specifications.
      public enum \(category): AlgorithmCategory {

        /// The name of the category as it appears in info structs.
        public static var name: String { return "\(name)" }

    """, to: &target)

}

/// Inserts a the declartion of a `struct` conforming to `AlgorithmSpecification` into the
/// specified stream.
///
/// - Parameters:
///   - createAlgorithm: The closure to use for creating an algorithm instance.
///   - categoryName: The unformatted name of the algorithm's category.
///   - description: An optional algorithm description to use when there is no factory info.
///                  If used, `description` is expected to include any necessary quotes properly
///                  escaped as well as any indentation for wrapping lines.
///   - target: he stream to which the text will be written.
public func appendSpecification<Target>(createAlgorithm: () -> AlgorithmWrapper,
                                        categoryName: String,
                                        description: String? = nil,
                                        target: inout Target)
  where Target:TextOutputStream
{

  // Create an algorithm instance using `info`.
  let algorithm = createAlgorithm()

  // Declare arrays for the input, output, and parameter names.
  let inputNames: [String], outputNames: [String], parameterNames: [String]

  // Declare a string for the algorithm mode.
  let mode: String

  // Switch on the algorithm to downcast and retrieve the neccessary names.
  switch algorithm {

  case let algorithm as StandardAlgorithmWrapper:
    mode = "Standard"
    inputNames = Array(algorithm.inputs.keys)
    outputNames = Array(algorithm.outputs.keys)
    parameterNames = Array(algorithm.parameterNames)

  case let algorithm as StreamingAlgorithmWrapper:
    mode = "Streaming"
    inputNames = Array(algorithm.inputs.keys)
    outputNames = Array(algorithm.outputs.keys)
    parameterNames = Array(algorithm.parameterNames)

  default:
    fatalError("Unable to downcast `algorithm` to standard or streaming.")

  }

  // Get the algorithm name.
  let name = algorithm.name

  // Get a category name that is a valid Swift identifier.
  let category = formattedCategory(categoryName)

  // Create a separator for joining cases.
  let caseSeparator = "\n        case "

  // Create the opening of an array for `allKeys` declarations.
  let opening = "[\n             "

  // Create a separator for elements of an array for `allKeys` declarations.
  let separator = ",\n             "

  // Create the closing of an array for `allKeys` declarations.
  let closing = "\n          ]"

  // Create a string for empty arrays.
  let emptyArray = "[]"

  // Create a string containing the input cases.
  let inputCases = inputNames.isEmpty ? "none" : inputNames.joined(separator: caseSeparator)

  // Create a string containing the output cases.
  let outputCases = outputNames.isEmpty ? "none" : outputNames.joined(separator: caseSeparator)

  // Create a string containing the parameter cases.
  let parameterCases = parameterNames.isEmpty ? "none" : parameterNames.joined(separator: caseSeparator)

  // Create a string containing the array of all input keys.
  let allInputKeys = inputNames.isEmpty
    ? emptyArray
    : opening + inputNames.map({".\($0)"}).joined(separator: separator) + closing

  // Create a string containing the array of all output keys.
  let allOutputKeys = outputNames.isEmpty
    ? emptyArray
    : opening + outputNames.map({".\($0)"}).joined(separator: separator) + closing

  // Create a string containing the array of all parameter keys.
  let allParameterKeys = parameterNames.isEmpty
    ? emptyArray
    : opening + parameterNames.map({".\($0)"}).joined(separator: separator) + closing

  // Create content for a comment documenting the `Input` declaration.
  let inputComment = inputNames.isEmpty
    ? "An enumeration with the sole case of `none` specifying that the algorithm has no inputs."
    : "An enumeration of the valid input names for the algorithm."

  // Create content for a comment documenting the `Output` declaration.
  let outputComment = outputNames.isEmpty
    ? "An enumeration with the sole case of `none` specifying that the algorithm has no outputs."
    : "An enumeration of the valid output names for the algorithm."

  // Create content for a comment documenting the `Parameter` declaration.
  let parameterComment = parameterNames.isEmpty
    ? "An enumeration with the sole case of `none` specifying that the algorithm has no parameters."
    : "An enumeration of the valid parameter names for the algorithm."

  // Create the body for the `description` property.
  let descriptionBody: String

  if let description = description {

    descriptionBody = description

  } else {

    descriptionBody = """
    AlgorithmFactoryWrapper.\(mode.lowercased())Info(forName: name)?.algorithmDescription ?? ""
    """

  }

  // Add the specification.
  print("""
        /// The specification for the \(mode.lowercased()) `\(name)` algorithm.
        public struct \(name): \(mode)Specification {

          public static func downCast(wrapper: \(mode)AlgorithmWrapper) -> \(mode)Algorithm<\(name)> {
            guard wrapper.name == name else {
              fatalError("Invalid cast from \\(wrapper.name) to \\(name).")
            }
            return \(mode)Algorithm<\(name)>(wrapper: wrapper)
          }

          /// The algorithm's name. This is equal to `info.algorithmName`.
          public static var name: String { return "\(name)" }

          /// The algorithm's operating mode.
          public static var mode: AlgorithmMode.Type { return Essentia.\(mode).self }

          /// The algorithm's category.
          public static var category: AlgorithmCategory.Type { return \(category).self }

          /// The algorithm's description. This is equal to `info.algorithmDescription`.
          public static var description: String {
            return \(descriptionBody)
          }

          /// \(inputComment)
          public enum Input: String, KeyEnumeration {

            case \(inputCases)

            public static var allKeys: Set<Input> {
              return \(allInputKeys)
            }

          }

          /// \(outputComment)
          public enum Output: String, KeyEnumeration {

            case \(outputCases)

            public static var allKeys: Set<Output> {
              return \(allOutputKeys)
            }

          }

          /// \(parameterComment)
          public enum Parameter: String, KeyEnumeration {

            case \(parameterCases)

            public static var allKeys: Set<Parameter> {
              return \(allParameterKeys)
            }

          }

        }

    """, to: &target)

}

/// Inserts the ending of an algorithm category enumeration declaration into the specified stream.
///
/// - Parameters:
///   - target: The stream to which the text will be written.
public func endAlgorithmCategory<Target>(target: inout Target) where Target:TextOutputStream {

  print("  }\n", to: &target)

}

/// Converts a category name appearing in a description into a name suitable for use as
/// an identifier in Swift code.
///
/// - Parameter category: The category name to format.
/// - Returns: `category` mapped to a string that contains no illegal characters.
public func formattedCategory(_ category: String) -> String {
  switch category {
  case "Input/output": return "IO"
  case "Loudness/dynamics": return "Loudness_Dynamics"
  case "Duration/silence": return "Duration_Silence"
  case "Envelope/SFX": return "Envelope_SFX"
  default: return category
  }
}


