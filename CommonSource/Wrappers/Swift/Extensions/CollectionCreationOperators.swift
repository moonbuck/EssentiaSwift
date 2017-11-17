//
//  CollectionCreationOperators.swift
//  Essentia
//
//  Created by Jason Cardwell on 11/13/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
import Foundation

extension Array {

  /// Operator providing a more convenient way to create an array of repeated elements.
  ///
  /// - Parameters:
  ///   - lhs: The array whose elements will be repeated. Must not be empty.
  ///   - rhs: The number of times to repeat `lhs`.
  /// - Returns: An array with `rhs` elements all equal to `lhs[0]`.
  public static func *(lhs: Array<Element>, rhs: Int) -> Array<Element> {
    assert(!lhs.isEmpty, "`*` cannot be used to create an array from an empty array.")
    guard lhs.count > 1 else { return Array<Element>(repeating: lhs[0], count: rhs) }
    return Array(repeatElement(lhs, count: rhs).joined())
  }

  /// A version of map that takes a parameter to pass into the transformation closure.
  ///
  /// - Parameters:
  ///   - parameter: The value to pass along with each element into `transform`.
  ///   - transform: The closure used to generate the new array.
  /// - Returns: The array generated via `transform`.
  /// - Throws: Any error thrown within `transform`.
  public func map<T, U>(_ parameter: T, _ transform: (Element, T) throws -> U) rethrows -> [U] {
    return try map { try transform($0, parameter) }
  }

}

extension String {

  /// Operator providing a more convenient way to create a string of a repeated characeter
  /// sequence.
  ///
  /// - Parameters:
  ///   - lhs: The character sequence to repeat.
  ///   - rhs: The number of times to repeat `lhs`.
  /// - Returns: A string composed of `lhs` repeated `rhs` times.
  public static func *(lhs: String, rhs: Int) -> String {
    return String(repeating: lhs, count: rhs)
  }

}
