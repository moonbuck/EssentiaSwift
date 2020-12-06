//
//  Parameter.swift
//  Essentia
//
//  Created by Jason Cardwell on 10/10/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//

import Foundation

extension ParameterWrapperType: CustomStringConvertible {

  /// A string containing the capitalized name of the enumeration case.
  public var description: String {
    switch self {
      case .undefined:    return "Undefined"
      case .real:         return "Real"
      case .string:       return "String"
      case .boolean:      return "Bool"
      case .integer:      return "Int"
      case .realVec:      return "RealVec"
      case .stringVec:    return "StringVec"
      case .stringVecMap: return "StringVecMap"
    @unknown default:
      return "Undefined"
    }
  }

}

/// Type used to specify parameter values for an instandce of `Algorithm`.
public final class Parameter: CustomStringConvertible {

  /// Type for specifying the kind of value held by the wrapped parameter.
  public typealias ParameterType = ParameterWrapperType

  /// The bridge between the C++ `Parameter` and the Swift `Parameter`.
  internal var wrapper: ParameterWrapper

  /// The type of value associated with the parameter.
  public var type: ParameterType { return wrapper.dataType }

  /// Whether the parameter has been supplied a value.
  public var isConfigured: Bool { return wrapper.isConfigured }

  /// The value held by the wrapped parameter.
  public var value: ParameterValue {

    guard wrapper.isConfigured else { return .none }

    switch wrapper.dataType {

      case .undefined:
        return .none

      case .real:
        guard let realValue = wrapper.value as? Float else { return .none }
        return .real(realValue)

      case .string:
        guard let stringValue = wrapper.value as? String else { return .none }
        return .string(stringValue)

      case .boolean:
        guard let boolValue = wrapper.value as? Bool else { return .none }
        return .boolean(boolValue)

      case .integer:
        guard let intValue = wrapper.value as? Int32 else { return .none }
        return .integer(intValue)

      case .realVec:
        guard let realVecValue = wrapper.value as? [Float] else { return .none }
        return .realVec(realVecValue)

      case .stringVec:
        guard let stringVecValue = wrapper.value as? [String] else { return .none }
        return .stringVec(stringVecValue)

      case .stringVecMap:
        guard let stringVecMapValue = wrapper.value as? [String:[String]] else { return .none }
        return .stringVecMap(stringVecMapValue)

    @unknown default:
      return .none
    }

  }

  /// Initializing with a wrapped parameter.
  ///
  /// - Parameter wrapper: The wrapped parameter.
  internal init(_ wrapper: ParameterWrapper) { self.wrapper = wrapper }

  /// Initializing with a parameter value.
  ///
  /// - Parameter value: The value with which to initialize the parameter.
  public init(value: ParameterValue) {
    switch value {
      case .none:                    wrapper = ParameterWrapper(type: .undefined)
      case .real(let value):         wrapper = ParameterWrapper(real: value as OBJCReal)
      case .string(let value):       wrapper = ParameterWrapper(string: value)
      case .boolean(let value):      wrapper = ParameterWrapper(bool: value as OBJCBool)
      case .integer(let value):      wrapper = ParameterWrapper(int: value as OBJCInt)
      case .realVec(let value):      wrapper = ParameterWrapper(realVec: value as [NSNumber])
      case .stringVec(let value):    wrapper = ParameterWrapper(stringVec: value)
      case .stringVecMap(let value): wrapper = ParameterWrapper(stringVecMap: value)
    }
  }

  /// A description of the parameter.
  public var description: String { return wrapper.description }

}

extension Parameter: ExpressibleByFloatLiteral {

  /// Intializing with a literal real value.
  ///
  /// - Parameter value: The parameter value.
  public convenience init(floatLiteral value: Float) { self.init(value: .real(value)) }

}

extension Parameter: ExpressibleByBooleanLiteral {

  /// Intializing with a literal boolean value.
  ///
  /// - Parameter value: The parameter value.
  public convenience init(booleanLiteral value: Bool) { self.init(value: .boolean(value)) }

}

extension Parameter: ExpressibleByStringLiteral {

  /// Intializing with a literal string value.
  ///
  /// - Parameter value: The parameter value.
  public convenience init(stringLiteral value: String) { self.init(value: .string(value)) }

}

extension Parameter: ExpressibleByIntegerLiteral {

  /// Initializing with a literal integer value.
  ///
  /// - Parameter value: The parameter value.
  public convenience init(integerLiteral value: Int32) { self.init(value: .integer(value)) }

}

extension Parameter: ExpressibleByArrayLiteral {

  /// Intializing with an array literal value. If `elements is [Float]` then the instance
  /// is intialized to case `realVec`. If `elements is [String]` then the instance is
  /// initialized to case `stringVec`. Any other type for `elements` results in the instance
  /// being intialized to case `none`.
  ///
  /// - Parameter elements: The parameter value.
  public convenience init(arrayLiteral elements: Any...) {
    if let realVecValue = elements as? [Float] {
      self.init(value: .realVec(realVecValue))
    } else if let realVecValue = elements as? [Double] {
      self.init(value: .realVec(realVecValue.map(Float.init)))
    } else if let stringVecValue = elements as? [String] {
      self.init(value: .stringVec(stringVecValue))
    } else {
      self.init(value: .none)
    }

  }

}

extension Parameter: ExpressibleByDictionaryLiteral {

  /// Intializing with a dictionary literal value.
  ///
  /// - Parameter elements: The parameter value.
  public convenience init(dictionaryLiteral elements: (String, [String])...) {
    self.init(value: .stringVecMap(Dictionary(uniqueKeysWithValues: elements)))
  }

}

/// An enumeration for values held by instances of `Parameter`.
///
/// - none: Used to express a `nil` value.
/// - real: A real value.
/// - string: A string value.
/// - boolean: A boolean value.
/// - integer: An integer value.
/// - realVec: A real vector value.
/// - stringVec: A string vector value.
/// - stringVecMap: A string vector map value.
public enum ParameterValue {

  case none
  case real (Float)
  case string (String)
  case boolean (Bool)
  case integer (Int32)
  case realVec ([Float])
  case stringVec ([String])
  case stringVecMap ([String:[String]])

}

extension ParameterValue: ExpressibleByNilLiteral {

  /// Initializing with a `nil`.
  ///
  /// - Parameter nilLiteral: Empty parameter.
  public init(nilLiteral: ()) { self = .none }

}

extension ParameterValue: ExpressibleByFloatLiteral {

  /// Intializing with a literal real value.
  ///
  /// - Parameter value: The parameter value.
  public init(floatLiteral value: Float) { self = .real(value) }

}

extension ParameterValue: ExpressibleByBooleanLiteral {

  /// Intializing with a literal boolean value.
  ///
  /// - Parameter value: The parameter value.
  public init(booleanLiteral value: Bool) { self = .boolean(value) }

}

extension ParameterValue: ExpressibleByStringLiteral {

  /// Intializing with a literal string value.
  ///
  /// - Parameter value: The parameter value.
  public init(stringLiteral value: String) { self = .string(value) }

}

extension ParameterValue: ExpressibleByIntegerLiteral {

  /// Initializing with a literal integer value.
  ///
  /// - Parameter value: The parameter value.
  public init(integerLiteral value: Int32) { self = .integer(value) }

}

extension ParameterValue: ExpressibleByArrayLiteral {

  /// Intializing with an array literal value. If `elements is [Float]` then the instance
  /// is intialized to case `realVec`. If `elements is [String]` then the instance is
  /// initialized to case `stringVec`. Any other type for `elements` results in the instance
  /// being intialized to case `none`.
  ///
  /// - Parameter elements: The parameter value.
  public init(arrayLiteral elements: Any...) {

    if let realVecValue = elements as? [Float] {
      self = .realVec(realVecValue)
    } else if let stringVecValue = elements as? [String] {
      self = .stringVec(stringVecValue)
    } else {
      self = .none
    }

  }

}

extension ParameterValue: ExpressibleByDictionaryLiteral {

  /// Intializing with a dictionary literal value.
  ///
  /// - Parameter elements: The parameter value.
  public init(dictionaryLiteral elements: (String, [String])...) {
    self = .stringVecMap(Dictionary(uniqueKeysWithValues: elements))
  }

}
