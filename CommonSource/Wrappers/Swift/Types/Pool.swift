//
//  Pool.swift
//  Essentia
//
//  Created by Jason Cardwell on 10/9/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
import Foundation

/// The pool is a storage structure which can hold frames of all kinds of descriptors. More
/// specifically, a pool maps descriptor names to data. A descriptor name is a period delimited
/// string of identifiers that are associated with the values of some audio descriptor (or any
/// other piece of data). For example, the descriptor name "lowlevel.bpm" identifies a low-level
/// value of beats per minute. The following data types can be stored in a pool:
///
/// - `Float` (Real)
/// - `String` (String)
/// - `[Float]` (RealVec)
/// - `[String]` (StringVec)
/// - `[[Float]]` (RealMatrix)
/// - `StereoSample` (StereoSample)
///
/// `Pool` supports the ability to repeatedly add data under the same descriptor name as well as
/// associating a descriptor name with only one datum. The `set` function is used in the latter
/// case, and the former is explained in the next paragraph.
///
/// When data is added to the pool under a given descriptor name, it is added to a vector of data
/// for that descriptor name. When the data is retrieved, a vector of data which was stored under
/// that descriptor name is returned. For example, in the case of the descriptor name, "foo.bar",
/// which maps to `Float` values, every time a `Float` is added under the name "foo.bar", it is
/// actually stored in a vector. When the data for "foo.bar" is retrieved, a `[Float]` is returned,
/// even if only one `Float` value was added under "foo.bar". In the case of data of type
/// `[Float]`, a `[[Float]]` is returned when the data is retrieved.
///
/// It is not allowed to mix data types under the same descriptor name. Each of the four types
/// listed above are treated as separate types. In addition, a descriptor name that maps to a
/// single datum is considered mapping to a different type than a descriptor name that maps to a
/// vector of the same type.
public final class Pool: WrappingType {

  internal typealias Wrapped = PoolWrapper

  /// The bridge between the C++ `Pool` and the Swift `Pool`.
  internal let wrapper: PoolWrapper

  /// Initializing with a wrapped pool.
  ////
  /// - Parameter wrapper: The wrapped pool.
  internal init(wrapper: PoolWrapper) {
    self.wrapper = wrapper
  }

  /// Initializing with an empty pool.
  public init() {
    wrapper = PoolWrapper()
  }

  /// Adds a value for a descriptor name to one of the non-single pools. The valid cases for
  /// `value` are `.real`, `.realVec`, `.realVecVec`, `.string`, `.stringVec`, and
  /// `.stereoSample`. Any other case used for `value` does nothing.
  ///
  /// If `name` already exists in the pool and points to data with the same data type as
  /// `realValue`, then `realValue` is concatenated to the vector stored therein. If, however,
  /// `name` already exists in the pool and points to a different data type than `realValue`, then
  /// this can cause unwanted behavior for the rest of the member functions of pool. To avoid this,
  /// do not add data into the pool whose descriptor name already exists in the pool and points to
  /// a different data type than `realValue`.
  ///
  /// If `name` has child descriptor names, this function will throw an exception. For example, if
  /// "foo.bar" exists in the pool, this function can no longer be called with "foo" as its `name`
  /// parameter, because "bar" is a child descriptor name of "foo".
  ///
  /// - Parameters:
  ///   - value: The value to add to the collection of data for `name`.
  ///   - name: A descriptor name identifying the collection to which to add `realValue`.
  public func add(_ value: StoredValue, for name: String) {

    switch value {
      case .real(let value):
        wrapper.addRealValue(value as NSNumber, forName: name)
      case .realVec(let value):
        wrapper.addRealVecValue(value as [NSNumber], forName: name)
      case .realVecVec(let value):
        wrapper.addRealMatrixValue(value as [[NSNumber]], forName: name)
      case .string(let value):
        wrapper.addStringValue(value, forName: name)
      case .stringVec(let value):
        wrapper.addStringVecValue(value, forName: name)
      case .stereoSample(let value):
        wrapper.addStereoSampleValue(NSValue(stereoSample: value), forName: name)
      default:
        break
    }

  }

  /// Sets the value of a descriptor name in one of the single pools. The valid cases for `value`
  /// are `.real`, `.realVec`, `.string`, `.stringVec`. Any other case used for `value`
  /// does nothing.
  ///
  /// This function is different than the add functions because set does not append data to the
  /// existing data under a given descriptor name, it sets it. Thus there can only be one datum
  /// associated with a descriptor name introduced to the pool via the set function. This function
  /// is useful when there is only one value associated with a given descriptor name.
  ///
  /// The set function cannot be used to override the data of a descriptor name that was introduced
  /// to the pool via `add(_:name:)`. An `EssentiaException` will be thrown if the given descriptor
  /// name already exists in the pool and was put there via a call to `add(_:name:)`.
  ///
  /// - Parameters:
  ///   - value: The datum to associate with `name`.
  ///   - name: The descriptor name of the datum to set.
  public func set(_ value: StoredValue, for name: String) {

    switch value {
      case .real(let value):
        wrapper.setRealValue(value as NSNumber, forName: name)
      case .realVec(let value):
        wrapper.setRealVecValue(value as [NSNumber], forName: name)
      case .string(let value):
        wrapper.setStringValue(value, forName: name)
      case .stringVec(let value):
        wrapper.setStringVecValue(value, forName: name)
      default:
        break
    }

  }

  /// An enumeration for specifying the kind of merge operation to perform on the pool.
  public enum MergeType: String {

    /// If descriptor is not found it will be added to the pool otherwise it will remove the
    /// existing descriptor and subsitute it by the given one, regardless of type
    case replace

    /// If descriptor is not found it will be added to the pool otherwise it will appended to
    /// the existing descriptor if and only if they share the same type.
    case append

    /// If descriptor is already in the pool, the new values will be interleaved with the
    /// existing ones if and only if they have the same type. If the descriptor is not
    /// found int the pool it will be added.
    case interleave

    /// If the pool contains a descriptor with name _name_, the current pool will keep its original
    /// descriptor values
    case none = ""

  }

  /// Merges the pool with the another pool.
  ///
  /// See documentation for `MergeType` for a discussion of the `type` parameter.
  ///
  ///  - Parameters:
  ///    - pool: The pool with which to merge.
  ///    - type: The type of merge to perform.
  public func merge(with otherPool: Pool, type: MergeType = .none) {
    wrapper.merge(withPool: otherPool.wrapper, type: type.rawValue)
  }

  /// Merges the specified values into the pool for `name`. The valid cases for `value`
  /// are `.realVec`, `.realVecVec`, `.stringVec`, `.stringVecVec`,
  /// `.realMatrixVec`, and `.stereoSampleVec`. Any other case used for `value`
  /// does nothing.
  ///
  /// See documentation for `MergeType` for a discussion of the `type` parameter.
  ///
  /// - Parameters:
  ///   - value: The value to merge into the pool.
  ///   - name: The descriptor name underwhich to merge `realVecValue`.
  ///   - type: The type of merge to perform.
  public func merge(_ value: StoredValue, for name: String, type: MergeType = .none) {

    switch value {

      case .realVec(let value):
        wrapper.mergeRealVecValue(value as [NSNumber], forName: name, type: type.rawValue)

      case .realVecVec(let value):
        wrapper.mergeRealVecVecValue(value as [[NSNumber]],
                                           forName: name,
                                           type: type.rawValue)

      case .stringVec(let value):
        wrapper.mergeStringVecValue(value, forName: name, type: type.rawValue)

      case .stringVecVec(let value):
        wrapper.mergeStringVecVecValue(value, forName: name, type: type.rawValue)

      case .realMatrixVec(let value):
        wrapper.mergeRealMatrixVecValue(value as [[[NSNumber]]],
                                           forName: name,
                                           type: type.rawValue)

      case .stereoSampleVec(let value):
        wrapper.mergeStereoSampleVecValue(value.map(NSValue.init(stereoSample:)),
                                             forName: name,
                                             type: type.rawValue)

      default:
        break

    }

  }

  /// Merges the specified value into the 'single' pool for `name`. The valid cases for `value`
  /// are `.real`, `.realVec`, `.string`, and `.stringVec`. Any other case used for
  /// `value` does nothing.
  ///
  /// See documentation for `MergeType` for a discussion of the `type` parameter.
  ///
  /// - Parameters:
  ///   - value: The value to merge into the pool.
  ///   - name: The descriptor name under which to merge `realValue`.
  ///   - type: The type of merge to perform.
  public func mergeSingle(_ value: StoredValue, for name: String, type: MergeType = .none) {

    switch value {

      case .real(let value):
        wrapper.mergeSingleRealValue(value as NSNumber, forName: name, type: type.rawValue)

      case .realVec(let value):
        wrapper.mergeSingleRealVecValue(value as [NSNumber], forName: name, type: type.rawValue)

      case .string(let value):
        wrapper.mergeSingleStringValue(value, forName: name, type: type.rawValue)

      case .stringVec(let value):
        wrapper.mergeSingleStringVecValue(value, forName: name, type: type.rawValue)

      default:
        break

    }

  }

  /// Removes the descriptor `name` from the pool along with the data it points to. This function
  /// does nothing if `name` does not exist in the pool.
  ///
  /// - Parameter name: The name of the descriptor to remove.
  public func remove(name: String) {
    wrapper.removeName(name)
  }

  /// Removes the entire descriptor `nameSpace` from the pool along with the data it points to.
  /// This function does nothing if `nameSpace` does not exist in the pool.
  ///
  /// - Parameter nameSpace: The name of the descriptor to remove.
  public func remove(namespace: String) {
    wrapper.removeNameSpace(namespace)
  }

  /// Accessor for the data associated with a descriptor. This subscript is safe to call even
  /// if the pool has no value for descriptor `name`. In such a case this subscript returns
  /// `.none`. For valid descriptors, the possible data types and their method(s) of insertion
  /// are as follows:
  /// - `.real` (`set(.real)`)
  /// - `.realVec` (`add(.real)`, `set(.realVec)`)
  /// - `.realVecVec` (`add(.realVec)`)
  /// - `.string` (`set(.string)`)
  /// - `.stringVec` (`add(.string)`, `set(.stringVec)`)
  /// - `.stringVecVec` (`add(.stringVec)`)
  /// - `.realMatrixVec` (`add(.realMatrix)`)
  /// - `.stereoSampleVec` (`add(.stereoSample)`)
  ///
  /// - Parameter name: The descriptor for which to retrieve associated data.
  /// - Returns: The data associated with `name` or `.none` if no such data could be found.
  public subscript(name: String) -> StoredValue {

    let result: Any

    if containsReal(forName: name) {
      result = wrapper.realValue(forName: name)
    } else if containsRealVec(forName: name) {
      result = wrapper.realVecValue(forName: name)
    } else if containsRealVecVec(forName: name) {
      result = wrapper.realVecVecValue(forName: name)
    } else if containsString(forName: name) {
      result = wrapper.stringValue(forName: name)
    } else if containsStringVec(forName: name) {
      result = wrapper.stringVecValue(forName: name)
    } else if containsStringVecVec(forName: name) {
      result = wrapper.stringVecVecValue(forName: name)
    } else if containsRealMatrixVec(forName: name) {
      result = wrapper.realMatrixVecValue(forName: name)
    } else if containsStereoSampleVec(forName: name) {
      result = wrapper.stereoSampleVecValue(forName: name)
    } else {
      return .none
    }

    guard let wrappedResult = StoredValue(value: result) else { return .none }

    return wrappedResult

  }

  /// Accessor of convenience for getting an unwrapped real value.
  ///
  /// - Parameter name: The descriptor name for the value.
  public subscript(real name: String) -> Float {
    guard case .real(let result) = self[name] else {
      fatalError("Failed to retrieve real value for '\(name)'.")
    }
    return result
  }

  /// Accessor of convenience for getting an unwrapped real vector value.
  ///
  /// - Parameter name: The descriptor name for the value.
  public subscript(realVec name: String) -> [Float] {
    guard case .realVec(let result) = self[name] else {
      fatalError("Failed to retrieve real vector value for '\(name)'.")
    }
    return result
  }

  /// Accessor of convenience for getting an unwrapped real vector vector value.
  ///
  /// - Parameter name: The descriptor name for the value.
  public subscript(realVecVec name: String) -> [[Float]] {
    guard case .realVecVec(let result) = self[name] else {
      fatalError("Failed to retrieve real vector vector value for '\(name)'.")
    }
    return result
  }

  /// Accessor of convenience for getting an unwrapped string value.
  ///
  /// - Parameter name: The descriptor name for the value.
  public subscript(string name: String) -> String {
    guard case .string(let result) = self[name] else {
      fatalError("Failed to retrieve string value for '\(name)'.")
    }
    return result
  }

  /// Accessor of convenience for an unwrapped string vector value.
  ///
  /// - Parameter name: The descriptor name for the value.
  public subscript(stringVec name: String) -> [String] {
    guard case .stringVec(let result) = self[name] else {
      fatalError("Failed to retrieve string vector value for '\(name)'.")
    }
    return result
  }

  /// Accessor of convenience for an unwrapped string vector vector value.
  ///
  /// - Requires: The pool contains a value for `name` of the appropriate data type.
  /// - Parameter name: The descriptor name for the value to retrieve.
  public subscript(stringVecVec name: String) -> [[String]] {
    guard case .stringVecVec(let result) = self[name] else {
      fatalError("Failed to retrieve string vector vector value for '\(name)'.")
    }
    return result
  }

  /// Accessor of convenience for an unwrapped real matrix vector value.
  ///
  /// - Requires: The pool contains a value for `name` of the appropriate data type.
  /// - Parameter name: The descriptor name for the value to retrieve.
  public subscript(realMatrixVec name: String) -> [[[Float]]] {
    guard case .realMatrixVec(let result) = self[name] else {
      fatalError("Failed to retrieve real matrix vector value for '\(name)'.")
    }
    return result
  }

  /// Accessor of convenience for an unwrapped stereo sample vector value.
  ///
  /// - Requires: The pool contains a value for `name` of the appropriate data type.
  /// - Parameter name: The descriptor name for the value to retrieve.
  public subscript(stereoSampleVec name: String) -> [StereoSample] {
    guard case .stereoSampleVec(let result) = self[name] else {
      fatalError("Failed to retrieve stereo sample vector value for '\(name)'.")
    }
    return result
  }

  /// Subscript of convenience for getting/setting real value in the single pool.
  ///
  /// - Parameter name: The descriptor name for the value.
//  public subscript (singleReal name: String) -> Float {
//    get {
//      guard isSingleValueDescriptor(name: name),
//            case .real(let result) = self[name]
//        else
//      {
//        fatalError("Failed to retrieve real value for '\(name)'.")
//      }
//      return result
//    }
//    set {
//      set(.real(newValue), for: name)
//    }
//  }

  /// Subscript of convenience for getting/setting real vector value in the single pool.
  ///
  /// - Parameter name: The descriptor name for the value.
//  public subscript (singleRealVec name: String) -> [Float] {
//    get {
//      guard isSingleValueDescriptor(name: name),
//        case .realVec(let result) = self[name]
//        else
//      {
//        fatalError("Failed to retrieve real vector value for '\(name)'.")
//      }
//      return result
//    }
//    set {
//      set(.realVec(newValue), for: name)
//    }
//  }

  /// Subscript of convenience for getting/setting string value in the single pool.
  ///
  /// - Parameter name: The descriptor name for the value.
//  public subscript (singleString name: String) -> String {
//    get {
//      guard isSingleValueDescriptor(name: name),
//        case .string(let result) = self[name]
//        else
//      {
//        fatalError("Failed to retrieve real value for '\(name)'.")
//      }
//      return result
//    }
//    set {
//      set(.string(newValue), for: name)
//    }
//  }

  /// Subscript of convenience for getting/setting string vector value in the single pool.
  ///
  /// - Parameter name: The descriptor name for the value.
//  public subscript (singleStringVec name: String) -> [String] {
//    get {
//      guard isSingleValueDescriptor(name: name),
//        case .stringVec(let result) = self[name]
//        else
//      {
//        fatalError("Failed to retrieve real vector value for '\(name)'.")
//      }
//      return result
//    }
//    set {
//      set(.stringVec(newValue), for: name)
//    }
//  }

  /// Queries for the existence of the specified descriptor for any data type.
  ///
  /// - Parameter name: The descriptor name for which to query the pool.
  /// - Returns: `true` if the pool contains `name` and `false` otherwise.
  public func contains(name: String) -> Bool {
    return wrapper.containsName(name)
  }

  /// Queries for the existence of the specified descriptor within the real
  /// single pool.
  ///
  /// - Parameter name: The descriptor name for which to query the pool.
  /// - Returns: `true` if the pool contains `name` and `false` otherwise.
  public func containsReal(forName name: String) -> Bool {
    return wrapper.containsReal(forName: name)
  }

  /// Queries for the existence of the specified descriptor within the real pool
  /// and the real vector single pool.
  ///
  /// - Parameter name: The descriptor name for which to query the pool.
  /// - Returns: `true` if the pool contains `name` and `false` otherwise.
  public func containsRealVec(forName name: String) -> Bool {
    return wrapper.containsRealVec(forName: name)
  }

  /// Queries for the existence of the specified descriptor within the real vector
  /// pool.
  ///
  /// - Parameter name: The descriptor name for which to query the pool.
  /// - Returns: `true` if the pool contains `name` and `false` otherwise.
  public func containsRealVecVec(forName name: String) -> Bool {
    return wrapper.containsRealVecVec(forName: name)
  }

  /// Queries for the existence of the specified descriptor within the string
  /// single pool.
  ///
  /// - Parameter name: The descriptor name for which to query the pool.
  /// - Returns: `true` if the pool contains `name` and `false` otherwise.
  public func containsString(forName name: String) -> Bool {
    return wrapper.containsString(forName: name)
  }

  /// Queries for the existence of the specified descriptor within the string pool
  /// and the string vector single pool.
  ///
  /// - Parameter name: The descriptor name for which to query the pool.
  /// - Returns: `true` if the pool contains `name` and `false` otherwise.
  public func containsStringVec(forName name: String) -> Bool {
    return wrapper.containsStringVec(forName: name)
  }

  /// Queries for the existence of the specified descriptor within the string vector
  /// pool.
  ///
  /// - Parameter name: The descriptor name for which to query the pool.
  /// - Returns: `true` if the pool contains `name` and `false` otherwise.
  public func containsStringVecVec(forName name: String) -> Bool {
    return wrapper.containsStringVecVec(forName: name)
  }

  /// Queries for the existence of the specified descriptor within the real matrix
  /// pool.
  ///
  /// - Parameter name: The descriptor name for which to query the pool.
  /// - Returns: `true` if the pool contains `name` and `false` otherwise.
  public func containsRealMatrixVec(forName name: String) -> Bool {
    return wrapper.containsRealMatrixVec(forName: name)
  }

  /// Queries for the existence of the specified descriptor within the stereo sample
  /// pool.
  ///
  /// - Parameter name: The descriptor name for which to query the pool.
  /// - Returns: `true` if the pool contains `name` and `false` otherwise.
  public func containsStereoSampleVec(forName name: String) -> Bool {
    return wrapper.containsStereoSampleVec(forName: name)
  }

  /// The list of descriptor names in the pool.
  public var descriptorNames: [String] {
    return wrapper.descriptorNames
  }

  /// Queries for all descriptors in the pool under a specified namespace.
  ///
  /// - Parameter namespace: The namespace for which to query.
  /// - Returns: An array of all descriptors in the pool under `namespace`.
  public func descriptorNames(namespace: String) -> [String] {
    return wrapper.descriptorNames(forNamespace: namespace)
  }

  /// A map of real values inserted into the pool via `add(_:name:)`.
  public var realPool: [String:[Float]] {
    return wrapper.realPool.mapValues({$0.map({$0.floatValue})})
  }

  /// A map of real vector values inserted into the pool via `add(_:name:)`.
  public var realVecPool: [String:[[Float]]] {
    return wrapper.realVecPool.mapValues({$0.map({$0.map({$0.floatValue})})})
  }

  /// A map of string values inserted into the pool via `add(_:name:)`.
  public var stringPool: [String:[String]] {
    return wrapper.stringPool
  }

  /// A map of string vector values inserted into the pool via `add(_:name:)`.
  public var stringVecPool: [String:[[String]]] {
    return wrapper.stringVecPool
  }

  /// A map of real matrix values inserted into the pool via `add(_:name:)`.
  public var realMatrixPool: [String:[[[Float]]]] {
    return wrapper.realMatrixPool.mapValues({$0.map({$0.map({$0.map({$0.floatValue})})})})
  }

  /// A map of stereo sample values inserted into the pool via `add(_:name:)`.
  public var stereoSamplePool: [String:[StereoSample]] {
    return wrapper.stereoSamplePool.mapValues({$0.map({$0.stereoSampleValue})})
  }

  /// A map of real values inserted into the pool via `set(_:name:)`.
  public var realSinglePool: [String:Float] {
    return wrapper.realSinglePool.mapValues({$0.floatValue})
  }

  /// A map of string values inserted into the pool via `set(_:name:)`.
  public var stringSinglePool: [String:String] {
    return wrapper.stringSinglePool
  }

  /// A map of real vector values inserted into the pool via `set(_:name:)`.
  public var realVecSinglePool: [String:[Float]] {
    return wrapper.realVecSinglePool.mapValues({$0.map({$0.floatValue})})
  }

  /// A map of string vector values inserted into the pool via `set(_:name:)`.
  public var stringVecSinglePool: [String:[String]] {
    return wrapper.stringVecSinglePool
  }

  /// Checks that no descriptor name is in two different inner pool types at the same time;
  /// otherwise, an exception is thrown.
  public func checkIntegrity() {
    wrapper.checkIntegrity()
  }

  /// Clears all the values contained in the pool.
  public func clear() {
    wrapper.clear()
  }

  /// Queries whether the pool contains a given descriptor and that it appears in one of the single
  /// value pools.
  ///
  /// - Parameter name: The descriptor name for which to query the pool.
  /// - Returns: `true` if the pool contains `name` and it is part of a single value pool and
  ///            `false` otherwise.
  public func isSingleValueDescriptor(name: String) -> Bool {
    return wrapper.isSingleValueDescriptorName(name)
  }

  /// A typealias for a tuple containing the necessary information for connecting a streaming
  /// algorithm source to a pool.
  public typealias PoolConnection = (pool: Pool, descriptorName: String, setSingle: Bool)

  /// Helper subscript for the `>>` connection operator for connecting a source to the pool.
  ///
  /// - Parameter name: The descriptor name to be used for the connection to a regular pool.
  public subscript(input name: String) -> PoolConnection {
    return (pool: self, descriptorName: name, setSingle: false)
  }

  /// Helper subscript for the `>>` connection operator for connecting a source to the pool and
  ///
  /// - Parameter name: The descriptor name to be used for the connection to a single pool.
  public subscript(singleInput name: String) -> PoolConnection {
    return (pool: self, descriptorName: name, setSingle: true)
  }

}

extension Pool: CustomStringConvertible {

  public var description: String {

    return """
    Pool {
      real: \(realPool.count)
      realVec: \(realVecPool.count)
      string: \(stringPool.count)
      stringVec: \(stringVecPool.count)
      realMatrix: \(realMatrixPool.count);
      stereoSample: \(stereoSamplePool.count)
      realSingle: \(realSinglePool.count)
      realVecSingle: \(realVecSinglePool.count)
      stringSingle: \(stringSinglePool.count)
      stringVecSingle: \(stringVecSinglePool.count)
    }
    """

  }

}

extension Pool {

  /// A type for representing a node in the tree representation of a `Pool`.
  internal class Node: Encodable {

    /// The node name. This is equivalent to a single part within a key path.
    internal let name: String

    /// The value associated with the node or `nil` if the node has only children.
    internal var value: StoredValue?

    /// The child nodes belonging to the node. This should be empty when `value != nil`.
    internal var children: [Node] = []

    /// The node and its children represented as a `Dictionary`.
    internal var dictionary: [String:Any] {
      if let value = value?.value { return [name: value] }
      else { return [name: children.map(\.dictionary)] }
    }

    /// Initializing with a name for the node.
    ///
    /// - Parameter name: The node name. This is equivalent to a single part within a key path.
    internal init(name: String) { self.name = name }

    /// Creates a tree structure of `PoolNode` instances representative of the data stored within
    /// the pool properties of a `Pool` instance.
    ///
    /// - Parameter pool: The pool from which to generate the tree.
    /// - Returns: The root node of the tree generated from `pool`.
    internal static func generateTree(for pool: Pool) -> Node {

      // Create a node for the root of the tree using a name unlikely to collide with any part of
      // an actual key path present in `pool`.
      let root = Node(name: "\u{1}")

      /// Helper function that inserts nodes into `root` for the specified key path and value.
      ///
      /// - Parameters:
      ///   - keyPath: The key path for leading to `value`.
      ///   - value: The value to be given the leaf node for `keyPath`.
      func insert<T>(keyPath: String, value: T) {

        // Wrap `value` as a `Pool.Value`.
        guard let poolValue = StoredValue(value: value) else { return }

        // Get the individual keys out of `keyPath`.
        let pathParts = keyPath.split(separator: ".")

        // Create a variable for the node serving as the currently visted node.
        var currentNode = root

        // Iterate the keys.
        for key in pathParts {

          // Look among the current node's children for a name matching `key`.
          if let childNode = currentNode.children.first(where: {$0.name == key}) {
            currentNode = childNode
          }

          // Create a new node for `key`, append it to the current node's list of children and set
          // it to be the current node.
          else {
            let node = Node(name: String(key))
            currentNode.children.append(node)
            currentNode = node
          }

        }

        // With `currentNode` now representing the destination for `keyPath`, give it `poolValue`.
        currentNode.value = poolValue

      }

      // Create an array of the value pool properties of `pool`.
      let valuePools: [[String:Any]] = [
        pool.realSinglePool,
        pool.realPool,
        pool.realVecSinglePool,
        pool.realVecPool,
        pool.stringSinglePool,
        pool.stringPool,
        pool.stringVecPool,
        pool.stringVecSinglePool,
        pool.realMatrixPool,
        pool.stereoSamplePool
      ]

      // Insert nodes for each key-value pair within each value pool in `valuePools`.
      for valuePool in valuePools {
        for (keyPath, value) in valuePool {
          insert(keyPath: keyPath, value: value)
        }
      }

      return root

    }

    /// A structure to support dynamic string keys when encoding `Node` instances.
    private struct NodeEncodingKey: CodingKey {

      /// The string value for the key.
      let stringValue: String

      /// The integer value for the key. This is always equal to `nil`.
      let intValue: Int? = nil

      /// Initializing with the key's string value. This initializer always succeeds.
      ///
      /// - Parameter stringValue: The string value for the key.
      init(stringValue: String) { self.stringValue = stringValue }


      /// Initializing with an integer value. This initializer always returns `nil`.
      ///
      /// - Parameter intValue: The integer value to ignore entirely.
      init?(intValue: Int) { return nil }

    }

    /// Encodes the node's value keyed by the node's name when `value != nil` and encodes
    /// the node's children keyed by their names otherwise.
    ///
    /// - Parameter encoder: The encoder to which the node is to be encoded.
    /// - Throws: Any error thrown while attempting to encode the node.
    internal func encode(to encoder: Encoder) throws {

      // Get a keyed container from `encoder`.
      var container = encoder.container(keyedBy: NodeEncodingKey.self)

      // Check whether the node has a valid value.
      if let value = value {

        // Encode `value` keyed by `name`.
        try container.encode(value, forKey: NodeEncodingKey(stringValue: name))

      }

      // Otherwise encode the child nodes.
      else {

        // Iterate the child nodes.
        for child in children {

          // Check whether the child node has a valid value.
          if let childValue = child.value {

            // Encode `childValue` keyed by `child.name`.
            try container.encode(childValue, forKey: NodeEncodingKey(stringValue: child.name))

          }

          // Otherwise encode the child.
          else {

            // Encode `child` keyed by `child.name`.
            try container.encode(child, forKey: NodeEncodingKey(stringValue: child.name))

          }

        }

      }

    }

  }

}

extension Pool {

  /// An enumeration for wrapping values from an pool property of `Pool`.
  public enum StoredValue: Encodable {

    /// A `nil` value.
    case none

    /// The type stored in `Pool.realSinglePool`.
    case real (Float)

    /// The type stored in `Pool.realPool` and `Pool.realVecSinglePool.
    case realVec ([Float])

    /// The type stored in `Pool.realMatrixPool` and returned for `Pool.realVecPool`.
    case realVecVec ([[Float]])

    /// The type stored in `Pool.stringSinglePool`.
    case string (String)

    /// The type stored in `Pool.stringPool` and `Pool.stringVecSinglePool`.
    case stringVec ([String])

    /// The type stored in `Pool.stringVecPool`.
    case stringVecVec ([[String]])

    /// The type returned for `Pool.realMatrixPool`.
    case realMatrixVec ([[[Float]]])

    /// The type stored in `Pool.stereoSamplePool`.
    case stereoSample (StereoSample)

    /// The type returned for `Pool.stereoSamplePool`.
    case stereoSampleVec ([StereoSample])

    /// The wrapped value or `nil` if `case .none = self`.
    public var value: Any? {
      switch self {
        case .none:                       return nil
        case .real(let value):            return value
        case .realVec(let value):         return value
        case .realVecVec(let value):      return value
        case .string(let value):          return value
        case .stringVec(let value):       return value
        case .stringVecVec(let value):    return value
        case .realMatrixVec(let value):   return value
        case .stereoSample(let value):    return value
        case .stereoSampleVec(let value): return value
      }
    }

    /// Initializing with a generic value. Initializes to `.none` if generic type `T` does not
    /// match one of the types stored by the other enumeration cases.
    ///
    /// - Parameter value: The value to wrap within an enumeration case.
    public init?<T>(value: T) {
      switch value {
        case let value as Float:
          self = .real(value)
        case let value as [Float]:
          self = .realVec(value)
        case let value as [NSNumber]:
          self = .realVec(value.map(\.floatValue))
        case let value as String:
          self = .string(value)
        case let value as [String]:
          self = .stringVec(value)
        case let value as [[String]]:
          self = .stringVecVec(value)
        case let value as [[Float]]:
          self = .realVecVec(value)
        case let value as [[NSNumber]]:
          self = .realVecVec(value.map({$0.map(\.floatValue)}))
        case let value as [[[Float]]]:
          self = .realMatrixVec(value)
        case let value as [[[NSNumber]]]:
          self = .realMatrixVec(value.map({$0.map({$0.map(\.floatValue)})}))
        case let value as StereoSample:
          self = .stereoSample(value)
        case let value as NSValue:
          self = .stereoSample(value.stereoSampleValue)
        case let value as [StereoSample]:
          self = .stereoSampleVec(value)
        case let value as [NSValue]:
          self = .stereoSampleVec(value.map(\.stereoSampleValue))
        default:
          self = .none
      }
    }

    /// Encodes the wrapped value using the unkeyed container of `encoder`.
    ///
    /// - Parameter encoder: The encoder to which the wrapped value is to be encoded.
    /// - Throws: Any error thrown while attempting to encode the wrapped value.
    public func encode(to encoder: Encoder) throws {
      var container = encoder.singleValueContainer()
      switch self {
        case .none:                       try container.encodeNil()
        case .real(let value):            try container.encode(value)
        case .realVec(let value):         try container.encode(value)
        case .realVecVec(let value):      try container.encode(value)
        case .string(let value):          try container.encode(value)
        case .stringVec(let value):       try container.encode(value)
        case .stringVecVec(let value):    try container.encode(value)
        case .realMatrixVec(let value):   try container.encode(value)
        case .stereoSample(let value):    try container.encode(value)
        case .stereoSampleVec(let value): try container.encode(value)
      }
    }

  }

}

extension Pool.StoredValue: ExpressibleByNilLiteral {

  /// Initializing to `nil`
  ///
  /// - Parameter nilLiteral: An empty parameter list.
  public init(nilLiteral: ()) { self = .none }

}

extension Pool.StoredValue: ExpressibleByArrayLiteral {

  /// Initializing with an array of strings, floats or stereo samples.
  ///
  /// - Parameter elements: The values.
  public init(arrayLiteral elements: Any...) {

    if let elements = elements as? [String] {
      self = .stringVec(elements)
    } else if let elements = elements as? [Float] {
      self = .realVec(elements)
    } else if let elements = elements as? [Double] {
      self = .realVec(elements.map(Float.init))
    } else if let elements = elements as? [Int] {
      self = .realVec(elements.map(Float.init))
    } else if let elements = elements as? [StereoSample] {
      self = .stereoSampleVec(elements)
    } else if let elements = elements as? [[String]] {
      self = .stringVecVec(elements)
    } else if let elements = elements as? [[Float]] {
      self = .realVecVec(elements)
    } else if let elements = elements as? [[Double]] {
      self = .realVecVec(elements.map({$0.map(Float.init)}))
    } else if let elements = elements as? [[Int]] {
      self = .realVecVec(elements.map({$0.map(Float.init)}))
    } else if let elements = elements as? [[[Float]]] {
      self = .realMatrixVec(elements)
    } else if let elements = elements as? [[[Double]]] {
      self = .realMatrixVec(elements.map({$0.map({$0.map(Float.init)})}))
    } else if let elements = elements as? [[[Int]]] {
      self = .realMatrixVec(elements.map({$0.map({$0.map(Float.init)})}))
    } else {
      fatalError("Array elements are of an unsupported type.")
    }

  }

}

extension Pool.StoredValue: ExpressibleByFloatLiteral {

  /// Initializing with a literal float.
  ///
  /// - Parameter value: The float value.
  public init(floatLiteral value: Float) {
    self = .real(value)
  }

}

extension Pool.StoredValue: ExpressibleByStringLiteral {

  /// Initializing with a literal string.
  ///
  /// - Parameter value: The string.
  public init(stringLiteral value: String) {
    self = .string(value)
  }

}

extension Pool: Collection {

  public var startIndex: Int {
    return 0
  }

  public var endIndex: Int {
    return descriptorNames.count
  }

  public func index(after i: Int) -> Int {
    return i &+ 1
  }


}

extension Pool: ExpressibleByDictionaryLiteral {

  /// Initializing with a dictionary literal of descriptor-value tuples.
  ///
  /// - Parameter elements: The descriptor-value tuples.
  public convenience init(dictionaryLiteral elements: (String, Any)...) {

    self.init()

    for (descriptor, value) in elements {

      switch value {

      case let value as Float:
        set(.real(value), for: descriptor)

      case let value as Int:
        set(.real(Float(value)), for: descriptor)

      case let value as Double:
        set(.real(Float(value)), for: descriptor)

      case let value as String:
        set(.string(value), for: descriptor)

      case let valueArray as [Float]:
        for value in valueArray {
          add(.real(value), for: descriptor)
        }

      case let valueArray as [Int]:
        for value in valueArray {
          add(.real(Float(value)), for: descriptor)
        }

      case let valueArray as [Double]:
        for value in valueArray {
          add(.real(Float(value)), for: descriptor)
        }

      case let valueArray as [String]:
        for value in valueArray {
          add(.string(value), for: descriptor)
        }

      case let valueArray as [StereoSample]:
        for value in valueArray {
          add(.stereoSample(value), for: descriptor)
        }

      case let valueArray as [[Float]]:
        for value in valueArray {
         add(.realVec(value), for: descriptor)
        }

      case let valueArray as [[Int]]:
        for value in valueArray {
          add(.realVec(value.map(Float.init)), for: descriptor)
        }

      case let valueArray as [[Double]]:
        for value in valueArray {
          add(.realVec(value.map(Float.init)), for: descriptor)
        }

      case let valueArray as [[String]]:
        for value in valueArray {
          add(.stringVec(value), for: descriptor)
        }

      case let valueArray as [[[Float]]]:
        for value in valueArray {
          add(.realVecVec(value), for: descriptor)
        }

      case let valueArray as [[[Int]]]:
        for value in valueArray {
          add(.realVecVec(value.map({$0.map(Float.init)})), for: descriptor)
        }

      case let valueArray as [[[Double]]]:
        for value in valueArray {
          add(.realVecVec(value.map({$0.map(Float.init)})), for: descriptor)
        }

      case let value as StoredValue:
        set(value, for: descriptor)

      case let valueArray as [StoredValue]:
        for value in valueArray {
          add(value, for: descriptor)
        }

      default:
        break

      }

    }

  }

}

extension Pool {

  /// A JSON representation of the pool's data.
  public var jsonRepresentation: String {

    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    encoder.nonConformingFloatEncodingStrategy = .convertToString(positiveInfinity: "inf",
                                                                  negativeInfinity: "-inf",
                                                                  nan: "nan")

    guard let data = try? encoder.encode(Node.generateTree(for: self)),
          let string = String(data: data, encoding: .utf8)
      else
    {
      fatalError("Failed to convert pool to JSON.")
    }

    return string

  }

}
