//
//  DictionaryMerging.swift
//  Essentia
//
//  Created by Jason Cardwell on 11/7/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
import Foundation

extension Dictionary {

  /// Merges the dictionary with another dictionary to form a new dictionary use a combining
  /// closure to produce a new value for each key.
  ///
  /// - Parameters:
  ///   - other: The dictionary with which to merge.
  ///   - combine: A closure that takes a key and the optional values for the key and returns an
  ///              optional value of the type stored by the new dictionary.
  /// - Returns: A new dictionary formed by merging `self` and `other` using `combine`.
  /// - Throws: Any error encountered within `combine`.
  public func mappingMerge<T,U>(_ other: [Key:T],
                              uniquingKeysWith combine: (Key, Value?, T?) throws -> U?)
    rethrows -> [Key:U]
  {

    var result: [Key:U] = [:]

    for key in Set(keys).union(other.keys) {

      guard let value =  try combine(key, self[key], other[key]) else { continue }

      result[key] = value

    }

    return result

  }

  /// Merges the dictionary with a sequence of key-value pairs to form a new dictionary use
  /// a combining closure to produce a new value for each key.
  ///
  /// - Parameters:
  ///   - other: The key-value pairs with which to merge.
  ///   - combine: A closure that takes a key and the optional values for the key and returns an
  ///              optional value of the type stored by the new dictionary.
  /// - Returns: A new dictionary formed by merging `self` and `other` using `combine`.
  /// - Throws: Any error encountered within `combine`.
  public func mappingMerge<S, T, U>(_ other: S,
                                 uniquingKeysWith combine: (Key, Value?, T?) throws -> U?)
    rethrows -> [Key:U]
    where S:Sequence, S.Element == (Key, T)
  {
    return try mappingMerge(Dictionary<Key, T>(uniqueKeysWithValues: other),
                            uniquingKeysWith: combine)
  }

}
