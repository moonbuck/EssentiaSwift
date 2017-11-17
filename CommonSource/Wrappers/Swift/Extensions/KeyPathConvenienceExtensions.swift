//
//  KeyPathConvenienceExtensions.swift
//  Essentia
//
//  Created by Jason Cardwell on 10/31/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
import Foundation

extension Sequence {

  /// A version of `map` that takes a key path.
  ///
  /// - Parameter keyPath: The key path used to map each value.
  /// - Returns: An array consisting of the value of `keyPath` for each element.
  public func map<T>(_ keyPath: KeyPath<Element, T>) -> [T] {
    return map { $0[keyPath: keyPath] }
  }

  /// A version of `flatMap` that takes a key path.
  ///
  /// - Parameter keyPath: The key path used to map each value.
  /// - Returns: An array consisting of the value of `keyPath` for each element where `value != nil`.
  public func flatMap<T>(_ keyPath: KeyPath<Element, T?>) -> [T] {
    return flatMap { $0[keyPath: keyPath] }
  }

}

extension Dictionary {

  /// A version of `mapValues(:)` that takes a key path and uses it in a closure passed to
  /// the standard library `mapValues(:)`.
  ///
  /// - Parameter keyPath: The key path used to map the values.
  /// - Returns: A dictionary with the values mapped via `keyPath`.
  public func mapValues<T>(_ keyPath: KeyPath<Value, T>) -> Dictionary<Key, T> {
    return mapValues({ $0[keyPath: keyPath] })
  }

  /// A function that maps key-value pairs to form a new dictionary.
  ///
  /// - Parameters:
  ///   - keyTransform: The closure used to map keys.
  ///   - valueTransform: The closure used to map values.
  /// - Returns: The dictionary of mapped keys and values.
  /// - Throws: Any error thrown within one of the closures provided.
  public func mapKeysValues<K, V>(_ keyTransform: (Key) throws -> K,
                                  _ valueTransform: (Value) throws -> V) rethrows -> Dictionary<K, V>
    where K:Hashable
  {
    return Dictionary<K,V>(uniqueKeysWithValues: try map {
      (try keyTransform($0), try valueTransform($1))
      })
  }

  /// A function that maps key-value pairs to form a new dictionary.
  ///
  /// - Parameters:
  ///   - keyTransform: The key path with which to map the keys.
  ///   - valueTransform: The closure used to map values.
  /// - Returns: The dictionary of mapped keys and values.
  /// - Throws: Any error thrown by `valueTransform`.
  public func mapKeysValues<K, V>(_ keyTransform: KeyPath<Key, K>,
                                  _ valueTransform: (Value) throws -> V) rethrows -> Dictionary<K, V>
    where K:Hashable
  {
    return Dictionary<K,V>(uniqueKeysWithValues: try map {
      ($0[keyPath: keyTransform], try valueTransform($1))
      })
  }

  /// A function that maps key-value pairs to form a new dictionary.
  ///
  /// - Parameters:
  ///   - keyTransform: The closure used to map keys.
  ///   - valueTransform: The key path with which to map the values.
  /// - Returns: The dictionary of mapped keys and values.
  /// - Throws: Any error thrown by `keyTransform`.
  public func mapKeysValues<K, V>(_ keyTransform: (Key) throws -> K,
                                  _ valueTransform: KeyPath<Value, V>) rethrows -> Dictionary<K, V>
    where K:Hashable
  {
    return Dictionary<K,V>(uniqueKeysWithValues: try map {
      (try keyTransform($0), $1[keyPath: valueTransform])
      })
  }

  /// A function that maps key-value pairs to form a new dictionary.
  ///
  /// - Parameters:
  ///   - keyTransform: The key path with which to map the keys.
  ///   - valueTransform: The key path with which to map the values.
  /// - Returns: The dictionary of mapped keys and values.
  public func mapKeysValues<K, V>(_ keyTransform: KeyPath<Key, K>,
                                  _ valueTransform: KeyPath<Value, V>) -> Dictionary<K, V>
    where K:Hashable
  {
    return Dictionary<K,V>(uniqueKeysWithValues: map {
      ($0[keyPath: keyTransform], $1[keyPath: valueTransform])
    })
  }

  /// A function that flat maps key-value pairs to form a new dictionary.
  ///
  /// - Parameters:
  ///   - keyTransform: The closure used to map keys.
  ///   - valueTransform: The closure used to map values.
  /// - Returns: The dictionary of mapped keys and values.
  /// - Throws: Any error thrown within one of the closures provided.
  public func flatMapKeysValues<K, V>(_ keyTransform: (Key) throws -> K?,
                                      _ valueTransform: (Value) throws -> V?) rethrows -> Dictionary<K, V>
    where K:Hashable
  {
    return Dictionary<K,V>(uniqueKeysWithValues: try flatMap {
      guard let newKey = try keyTransform($0), let newValue = try valueTransform($1) else {
        return nil
      }
      return (newKey, newValue)
      })
  }

  /// A function that flat maps key-value pairs to form a new dictionary.
  ///
  /// - Parameters:
  ///   - keyTransform: The key path with which to map the keys.
  ///   - valueTransform: The closure used to map values.
  /// - Returns: The dictionary of mapped keys and values.
  /// - Throws: Any error thrown by `valueTransform`.
  public func flatMapKeysValues<K, V>(_ keyTransform: KeyPath<Key, K?>,
                                      _ valueTransform: (Value) throws -> V?) rethrows -> Dictionary<K, V>
    where K:Hashable
  {
    return Dictionary<K,V>(uniqueKeysWithValues: try flatMap {
      guard let newKey = $0[keyPath: keyTransform], let newValue = try valueTransform($1) else {
        return nil
      }
      return (newKey, newValue)
      })
  }

  /// A function that flat maps key-value pairs to form a new dictionary.
  ///
  /// - Parameters:
  ///   - keyTransform: The closure used to map keys.
  ///   - valueTransform: The key path with which to map the values.
  /// - Returns: The dictionary of mapped keys and values.
  /// - Throws: Any error thrown by `keyTransform`.
  public func flatMapKeysValues<K, V>(_ keyTransform: (Key) throws -> K?,
                                      _ valueTransform: KeyPath<Value, V?>) rethrows -> Dictionary<K, V>
    where K:Hashable
  {
    return Dictionary<K,V>(uniqueKeysWithValues: try flatMap {
      guard let newKey = try keyTransform($0), let newValue = $1[keyPath: valueTransform] else {
        return nil
      }
      return (newKey, newValue)
      })
  }

  /// A function that flat maps key-value pairs to form a new dictionary.
  ///
  /// - Parameters:
  ///   - keyTransform: The key path with which to map the keys.
  ///   - valueTransform: The key path with which to map the values.
  /// - Returns: The dictionary of mapped keys and values.
  public func flatMapKeysValues<K, V>(_ keyTransform: KeyPath<Key, K?>,
                                      _ valueTransform: KeyPath<Value, V?>) -> Dictionary<K, V>
    where K:Hashable
  {
    return Dictionary<K,V>(uniqueKeysWithValues: flatMap {
      guard let newKey = $0[keyPath: keyTransform], let newValue = $1[keyPath: valueTransform] else {
        return nil
      }
      return (newKey, newValue)
      })
  }

  /// A function that forms a new dictionary by mapping the keys in the key-value pairs.
  ///
  /// - Parameters:
  ///   - keyTransform: The closure used to map keys.
  /// - Returns: The dictionary with mapped keys.
  /// - Throws: Any error thrown by `keyTransform`.
  public func mapKeys<K:Hashable>(_ keyTransform: (Key) throws -> K) rethrows -> Dictionary<K, Value> {
    return Dictionary<K,Value>(uniqueKeysWithValues: try map {
      (try keyTransform($0), $1)
      })
  }

  /// A function that forms a new dictionary by mapping the keys in the key-value pairs.
  ///
  /// - Parameters:
  ///   - keyTransform: The key path with which to map the keys.
  /// - Returns: The dictionary with mapped keys.
  public func mapKeys<K:Hashable>(_ keyTransform: KeyPath<Key, K>) -> Dictionary<K, Value> {
    return Dictionary<K,Value>(uniqueKeysWithValues: map {
      ($0[keyPath: keyTransform], $1)
      })
  }

  /// A function that forms a new dictionary by flat mapping the keys in the key-value pairs.
  ///
  /// - Parameters:
  ///   - keyTransform: The closure used to map keys.
  /// - Returns: The dictionary with mapped keys.
  /// - Throws: Any error thrown by `keyTransform`.
  public func flatMapKeys<K:Hashable>(_ keyTransform: (Key) throws -> K?) rethrows -> Dictionary<K, Value> {
    return Dictionary<K,Value>(uniqueKeysWithValues: try flatMap {
      guard let newKey = try keyTransform($0) else { return nil }
      return (newKey, $1)
      })
  }

  /// A function that forms a new dictionary by flat mapping the keys in the key-value pairs.
  ///
  /// - Parameters:
  ///   - keyTransform: The key path with which to map the keys.
  /// - Returns: The dictionary with mapped keys.
  public func flatMapKeys<K:Hashable>(_ keyTransform: KeyPath<Key, K?>) -> Dictionary<K, Value> {
    return Dictionary<K,Value>(uniqueKeysWithValues: flatMap {
      guard let newKey = $0[keyPath: keyTransform] else { return nil }
      return (newKey, $1)
      })
  }

  /// A function that flat maps values to form a new dictionary.
  ///
  /// - Parameters:
  ///   - valueTransform: The closure used to map values.
  /// - Returns: The dictionary with mapped values.
  /// - Throws: Any error thrown by `valueTransform`.
  public func flatMapValues<V>(_ valueTransform: (Value) throws -> V?) rethrows -> Dictionary<Key, V> {
    return Dictionary<Key,V>(uniqueKeysWithValues: try flatMap {
      guard let newValue = try valueTransform($1) else { return nil }
      return ($0, newValue)
      })
  }

  /// A function that flat maps values to form a new dictionary.
  ///
  /// - Parameters:
  ///   - valueTransform: The key path with which to map the values.
  /// - Returns: The dictionary of mapped keys and values.
  public func flatMapValues<V>(_ valueTransform: KeyPath<Value, V?>) -> Dictionary<Key, V> {
    return Dictionary<Key,V>(uniqueKeysWithValues: flatMap {
      guard let newValue = $1[keyPath: valueTransform] else { return nil }
      return ($0, newValue)
      })
  }

  /// A version of `init(grouping:by:` that takes a key path and uses it in a closure
  /// passed to the standard library `init(grouping:by:)`.
  ///
  /// - Parameters:
  ///   - values: The values to group.
  ///   - keyPath: The key path with which to derive keys for the grouped values.
  public init<S>(grouping values: S, by keyPath: KeyPath<S.Element, Key>)
    where Value == [S.Element], S:Sequence
  {
    self = Dictionary<Key, Value>(grouping: values, by: { $0[keyPath: keyPath] })
  }
}
