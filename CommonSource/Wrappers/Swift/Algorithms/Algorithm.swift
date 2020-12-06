//
//  Algorithm.swift
//  Essentia
//
//  Created by Jason Cardwell on 10/27/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
import Foundation

/// Base class for a wrapper around the Objective-C `AlgorithmWrapper` that uses the string-based
/// interface for inputs, outputs, and parameters.
public class AnyAlgorithm: WrappingType {

  public typealias Wrapped = AlgorithmWrapper

  /// The bridge between the C++ `Algorithm` and the Swift `Algorithm`.
  internal var wrapper: AlgorithmWrapper

  /// The names of the parameters declared by the configurable.
  public var parameterNames: [String] { return wrapper.parameterNames }

  /// An index of parameter descriptions keyed by parameter name.
  public var parameterDescription: [String:String] { return wrapper.parameterDescription }

  /// An index of default parameters keyed by parameter name.
  public var defaultParameters: [String:Parameter] {
    return wrapper.defaultParameters.mapValues({Parameter($0)})
  }

  /// Updates the specified parameter values for the configurable. Parameters not included
  /// in `parameters` maintain their current values.
  ///
  /// - Parameter parameters: The parameter values to set for the configurable.
  public func set(parameters: [String:Parameter]) {
    let parameterMap = parameters.filter({$0.value.type != .undefined}).mapValues({$0.wrapper})
    wrapper.set(parameters: parameterMap)
  }

  /// Reconfigures the algorithm with the specified parameter values.
  ///
  /// - Parameter parameters: The values with which to reconfigure the configurable.
  public func configure(parameters: [String:Parameter]) {
    let parameterMap = parameters.filter({$0.value.type != .undefined}).mapValues({$0.wrapper})
    wrapper.configure(parameters: parameterMap)
  }

  /// Accessor for one of the algoritm's parameters.
  ///
  /// - Parameter parameter: The parameter's identifier.
  public subscript(parameter parameter: String) -> Parameter? {
    guard let wrappedParameter = wrapper.parameter(name: name) else { return nil }
    return Parameter(wrappedParameter)
  }

  /// The algorithm's name.
  public var name: String { get { return wrapper.name } set { wrapper.name = newValue } }

  /// Initializing with a wrapped algorithm.
  ///
  /// - Parameter wrapper: The wrapped algorithm.
  internal init(wrapper: AlgorithmWrapper) { self.wrapper = wrapper }

}

/// Base class for a wrapper around the Objective-C `AlgorithmWrapper` that uses the
/// `AlgorithmSpecification` structure to add safety around inputs, outputs, and parameters.
public class Algorithm<Spec:AlgorithmSpecification>: WrappingType {

  public typealias Wrapped = AlgorithmWrapper

  /// The bridge between the C++ `Algorithm` and the Swift `Algorithm`.
  internal var wrapper: AlgorithmWrapper

  /// An index of parameter descriptions keyed by parameter name.
  public var parameterDescription: [Spec.Parameter:String] {
    return wrapper.parameterDescription.flatMapKeys(Spec.Parameter.init(rawValue:))
  }

  /// An index of default parameters keyed by parameter name.
  public var defaultParameters: [Spec.Parameter:Parameter] {
    return wrapper.defaultParameters.flatMapKeysValues(Spec.Parameter.init(rawValue:), Parameter.init)
  }

  /// Updates the specified parameter values for the configurable. Parameters not included
  /// in `parameters` maintain their current values.
  ///
  /// - Parameter parameters: The parameter values to set for the configurable.
  public func set(parameters: [Spec.Parameter:Parameter]) {
    guard !Spec.Parameter.isEmpty else { return }
    wrapper.set(parameters: parameters.mapKeysValues(\.rawValue, \.wrapper))
  }

  /// Reconfigures the configurable with the specified parameter values.
  ///
  /// - Parameter parameters: The values with which to reconfigure the configurable.
  public func configure(parameters: [Spec.Parameter:Parameter]) {
    guard !Spec.Parameter.isEmpty else { return }
    wrapper.configure(parameters: parameters.mapKeysValues(\.rawValue, \.wrapper))
  }


  /// Accessor for one of the algorithm's parameters.
  ///
  /// - Parameter parameter: The identifier for the parameter
  public subscript(parameter parameter: Spec.Parameter) -> Parameter {
    guard !Spec.Parameter.isEmpty else { fatalError("Algorithm `\(name) has no parameters.") }
    guard let wrappedParameter = wrapper.parameter(name: parameter.rawValue) else {
      fatalError("Unexpected `nil` value returned for parameter '\(parameter.rawValue)'.")
    }
    return Parameter(wrappedParameter)
  }

  /// Convenience accessor/mutator for a parameter's value. Invoking with an parameter that does
  /// not hold a real value results in a fatal error.
  ///
  /// - Parameter parameter: The parameter holding a real value.
  public subscript(realParameter parameter: Spec.Parameter) -> Float {
    get {
      guard case .real(let result) = self[parameter: parameter].value else {
        fatalError("Failed to retrieve '\(parameter.rawValue)' as `Float`.")
      }
      return result
    }
    set {
      configure(parameters: [parameter: Parameter(value: .real(newValue))])
    }
  }

  /// Convenience accessor/mutator for a parameter's value. Invoking with an parameter that does
  /// not hold a string value results in a fatal error.
  ///
  /// - Parameter parameter: The parameter holding a string value.
  public subscript(stringParameter parameter: Spec.Parameter) -> String {
    get {
      guard case .string(let result) = self[parameter: parameter].value else {
        fatalError("Failed to retrieve '\(parameter.rawValue)' as `String`.")
      }
      return result
    }
    set {
      configure(parameters: [parameter: Parameter(value: .string(newValue))])
    }
  }

  /// Convenience accessor/mutator for a parameter's value. Invoking with an parameter that does
  /// not hold a boolean value results in a fatal error.
  ///
  /// - Parameter parameter: The parameter holding a boolean value.
  public subscript(booleanParameter parameter: Spec.Parameter) -> Bool {
    get {
      guard case .boolean(let result) = self[parameter: parameter].value else {
        fatalError("Failed to retrieve '\(parameter.rawValue)' as `Bool`.")
      }
      return result
    }
    set {
      configure(parameters: [parameter: Parameter(value: .boolean(newValue))])
    }
  }

  /// Convenience accessor/mutator for a parameter's value. Invoking with an parameter that does
  /// not hold a integer value results in a fatal error.
  ///
  /// - Parameter parameter: The parameter holding a integer value.
  public subscript(integerParameter parameter: Spec.Parameter) -> Int32 {
    get {
      guard case .integer(let result) = self[parameter: parameter].value else {
        fatalError("Failed to retrieve '\(parameter.rawValue)' as `Int32`.")
      }
      return result
    }
    set {
      configure(parameters: [parameter: Parameter(value: .integer(newValue))])
    }
  }

  /// Convenience accessor/mutator for a parameter's value. Invoking with an parameter that does
  /// not hold a real vector value results in a fatal error.
  ///
  /// - Parameter parameter: The parameter holding a real vector value.
  public subscript(realVecParameter parameter: Spec.Parameter) -> [Float] {
    get {
      guard case .realVec(let result) = self[parameter: parameter].value else {
        fatalError("Failed to retrieve '\(parameter.rawValue)' as `[Float]`.")
      }
      return result
    }
    set {
      configure(parameters: [parameter: Parameter(value: .realVec(newValue))])
    }
  }

  /// Convenience accessor/mutator for a parameter's value. Invoking with an parameter that does
  /// not hold a string vector value results in a fatal error.
  ///
  /// - Parameter parameter: The parameter holding a string vector value.
  public subscript(stringVecParameter parameter: Spec.Parameter) -> [String] {
    get {
      guard case .stringVec(let result) = self[parameter: parameter].value else {
        fatalError("Failed to retrieve '\(parameter.rawValue)' as `[String]`.")
      }
      return result
    }
    set {
      configure(parameters: [parameter: Parameter(value: .stringVec(newValue))])
    }
  }

  /// Convenience accessor/mutator for a parameter's value. Invoking with an parameter that does
  /// not hold a string vector map value results in a fatal error.
  ///
  /// - Parameter parameter: The parameter holding a string vector map value.
  public subscript(stringVecMapParameter parameter: Spec.Parameter) -> [String:[String]] {
    get {
      guard case .stringVecMap(let result) = self[parameter: parameter].value else {
        fatalError("Failed to retrieve '\(parameter.rawValue)' as `[String:[String]]`.")
      }
      return result
    }
    set {
      configure(parameters: [parameter: Parameter(value: .stringVecMap(newValue))])
    }
  }

  /// The algorithm's name.
  public var name: String { get { return wrapper.name } set { wrapper.name = newValue } }

  /// Initializing with a wrapped algorithm.
  ///
  /// - Parameter wrapper: The wrapped algorithm.
  internal init(wrapper: AlgorithmWrapper) { self.wrapper = wrapper }

}
