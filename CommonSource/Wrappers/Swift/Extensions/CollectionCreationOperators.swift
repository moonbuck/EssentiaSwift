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

/// Range creation operator support for creating an array of float values. The two
/// bounds are first converted into integers and these integers are used to create and
/// map a countable range.
///
/// - Parameters:
///   - lhs: The lower bound for the half open range.
///   - rhs: The upper bound for the half open range.
/// - Returns: The array of floating point values.
public func ..<<F:BinaryFloatingPoint>(lhs: F, rhs: F) -> [F] {
  return (Int(lhs)..<Int(rhs)).map(F.init)
}
