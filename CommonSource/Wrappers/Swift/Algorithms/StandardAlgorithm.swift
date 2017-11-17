//
//  StandardAlgorithm.swift
//  Essentia
//
//  Created by Jason Cardwell on 9/26/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
import Foundation

/// The Swift-facing interface for an algorithm instance.
public class AnyStandardAlgorithm: AnyAlgorithm {

  /// Initializing with a wrapped algorithm.
  ///
  /// - Parameter wrapper: The wrapped algorithm.
  internal override init(wrapper: AlgorithmWrapper) {

    guard let wrapper = wrapper as? StandardAlgorithmWrapper else {
      fatalError("An instance of `StreamingAlgorithmWrapper` is required.")
    }

    inputs = wrapper.inputs.mapValues(Input.init(wrapper:))
    outputs = wrapper.outputs.mapValues(Output.init(wrapper:))

    // Initialize the `wrapper` property.
    super.init(wrapper: wrapper)

  }

  /// Downcast of the inherited `wrapper`.
  internal var standardWrapper: StandardAlgorithmWrapper {
    return wrapper as! StandardAlgorithmWrapper
  }

  /// Creates a specialized `StandardAlgorithm` by fetching the `StandardSpecification` that
  /// corresponds with the wrapped algorithm's name.
  ///
  /// - Returns: The specialized `StandardAlgorithm` instance.
  public func downCast<Spec:StandardSpecification>() -> StandardAlgorithm<Spec> {

    guard let algorithmID = Standard.AlgorithmID(rawValue: wrapper.name) else {
      fatalError("Failed to retrieve algorithm ID using name '\(wrapper.name)'.")
    }

    let standardSpec: Spec.Type = algorithmID.spec()

    let algorithm = standardSpec.downCast(wrapper: standardWrapper)

    return algorithm
  }

  /// The inputs connected to the algorithm.
  private let inputs: [String:Input]

  /// Accessor for one of the algorithm's inputs.
  ///
  /// - Parameter input: The input's identifier.
  public subscript(input input: String) -> Input? { return inputs[input] }

  /// The outputs connected to the algorithm.
  private let outputs: [String:Output]

  /// Accessor for one of the algorithm's outputs.
  ///
  /// - Parameter output: The output's identifier.
  public subscript(output output: String) -> Output? { return outputs[output] }

  /// Executes the algorithm with its current parameters and input/output connections.
  public func compute() { standardWrapper.compute() }

  /// Resets the algorithm's state.
  public func reset() { standardWrapper.reset() }

}

/// The Swift-facing interface for an algorithm instance.
public class StandardAlgorithm<Spec:StandardSpecification>: Algorithm<Spec> {

  /// Initializing with a wrapped algorithm.
  ///
  /// - Parameter wrapper: The wrapped algorithm.
  internal override init(wrapper: AlgorithmWrapper) {

    guard let wrapper = wrapper as? StandardAlgorithmWrapper else {
      fatalError("An instance of `StreamingAlgorithmWrapper` is required.")
    }

    inputs = wrapper.inputs.flatMapKeysValues(Spec.Input.init(rawValue:), Input.init(wrapper:))
    outputs = wrapper.outputs.flatMapKeysValues(Spec.Output.init(rawValue:), Output.init(wrapper:))

    // Initialize the `wrapper` property.
    super.init(wrapper: wrapper)

  }

  /// Initializing with an optional dictionary of parameter values.
  ///
  /// - Parameter parameters: The parameter values with which to configure the algorithm or `nil`.
  public convenience init(_ parameters: [Spec.Parameter:Parameter]? = nil) {

    guard let algorithm = AlgorithmFactoryWrapper
      .createStandardAlgorithm(withName: Spec.name,
                               parameterValues: parameters?.mapKeysValues(\.rawValue, \.wrapper))
      else
    {
      fatalError("Failed to create standard algorithm for specifier '\(Spec.name)'. ")
    }

    self.init(wrapper: algorithm)

  }

  /// Downcast of the inherited `wrapper`.
  internal var standardWrapper: StandardAlgorithmWrapper {
    return wrapper as! StandardAlgorithmWrapper
  }

  /// The inputs connected to the algorithm.
  private let inputs: [Spec.Input:Input]

  /// Accessor for one of the algorithm's inputs.
  ///
  /// - Parameter input: The input's identifier.
  public subscript(input input: Spec.Input) -> Input {
    guard !Spec.Input.isEmpty else { fatalError("Algorithm `\(name) has no inputs.") }
    guard let result = inputs[input] else {
      fatalError("Failed to retrieve input '\(input.rawValue)'.")
    }
    return result
  }

  /// Convenience accessor/mutator for an input's value. Invoking with an input that does not hold
  /// a real value results in a fatal error.
  ///
  /// - Parameter input: The input storing a real value.
  public subscript(realInput input: Spec.Input) -> Float {
    get {
      guard case .real(let result) = self[input: input].value else {
        fatalError("Failed to retrieve the value for input '\(input.rawValue)' as a `Float`.")
      }
      return result
    }
    set {
      self[input: input].value = .real(newValue)
    }
  }

  /// Convenience accessor/mutator for an input's value. Invoking with an input that does not hold
  /// a string value results in a fatal error.
  ///
  /// - Parameter input: The input storing a string value.
  public subscript(stringInput input: Spec.Input) -> String {
    get {
      guard case .string(let result) = self[input: input].value else {
        fatalError("Failed to retrieve the value for input '\(input.rawValue)' as a `String`.")
      }
      return result
    }
    set {
      self[input: input].value = .string(newValue)
    }
  }

  /// Convenience accessor/mutator for an input's value. Invoking with an input that does not hold
  /// an integer value results in a fatal error.
  ///
  /// - Parameter input: The input storing an integer value.
  public subscript(integerInput input: Spec.Input) -> Int32 {
    get {
      guard case .integer(let result) = self[input: input].value else {
        fatalError("Failed to retrieve the value for input '\(input.rawValue)' as a `Int32`.")
      }
      return result
    }
    set {
      self[input: input].value = .integer(newValue)
    }
  }

  /// Convenience accessor/mutator for an input's value. Invoking with an input that does not hold
  /// a complex real value results in a fatal error.
  ///
  /// - Parameter input: The input storing a complex real value.
  public subscript(complexRealInput input: Spec.Input) -> DSPComplex {
    get {
      guard case .complexReal(let result) = self[input: input].value else {
        fatalError("Failed to retrieve the value for input '\(input.rawValue)' as a `DSPComplex`.")
      }
      return result
    }
    set {
      self[input: input].value = .complexReal(newValue)
    }
  }

  /// Convenience accessor/mutator for an input's value. Invoking with an input that does not hold
  /// a stereo sample value results in a fatal error.
  ///
  /// - Parameter input: The input storing a stereo sample value.
  public subscript(stereoSampleInput input: Spec.Input) -> StereoSample {
    get {
      guard case .stereoSample(let result) = self[input: input].value else {
        fatalError("Failed to retrieve the value for input '\(input.rawValue)' as a `StereoSample`.")
      }
      return result
    }
    set {
      self[input: input].value = .stereoSample(newValue)
    }
  }

  /// Convenience accessor/mutator for an input's value. Invoking with an input that does not hold
  /// a pool value results in a fatal error.
  ///
  /// - Parameter input: The input storing a pool value.
  public subscript(poolInput input: Spec.Input) -> Pool {
    get {
      guard case .pool(let result) = self[input: input].value else {
        fatalError("Failed to retrieve the value for input '\(input.rawValue)' as a `Pool`.")
      }
      return result
    }
    set {
      self[input: input].value = .pool(newValue)
    }
  }

  /// Convenience accessor/mutator for an input's value. Invoking with an input that does not hold
  /// a real matrix value results in a fatal error.
  ///
  /// - Parameter input: The input storing a real matrix value.
  public subscript(realMatrixInput input: Spec.Input) -> [[Float]] {
    get {
      guard case .realMatrix(let result) = self[input: input].value else {
        fatalError("Failed to retrieve the value for input '\(input.rawValue)' as a `[[Float]]`.")
      }
      return result
    }
    set {
      self[input: input].value = .realMatrix(newValue)
    }
  }

  /// Convenience accessor/mutator for an input's value. Invoking with an input that does not hold
  /// a complex real vector value results in a fatal error.
  ///
  /// - Parameter input: The input storing a complex real vector value.
  public subscript(complexRealVecInput input: Spec.Input) -> [DSPComplex] {
    get {
      guard case .complexRealVec(let result) = self[input: input].value else {
        fatalError("Failed to retrieve the value for input '\(input.rawValue)' as a `[DSPComplex]`.")
      }
      return result
    }
    set {
      self[input: input].value = .complexRealVec(newValue)
    }
  }


  /// Convenience accessor/mutator for an input's value. Invoking with an input that does not hold
  /// a real vector value results in a fatal error.
  ///
  /// - Parameter input: The input storing a real vector value.
  public subscript(realVecInput input: Spec.Input) -> [Float] {
    get {
      guard case .realVec(let result) = self[input: input].value else {
        fatalError("Failed to retrieve the value for input '\(input.rawValue)' as a `[Float]`.")
      }
      return result
    }
    set {
      self[input: input].value = .realVec(newValue)
    }
  }

  /// Convenience accessor/mutator for an input's value. Invoking with an input that does not hold
  /// a string vector value results in a fatal error.
  ///
  /// - Parameter input: The input storing a string vector value.
  public subscript(stringVecInput input: Spec.Input) -> [String] {
    get {
      guard case .stringVec(let result) = self[input: input].value else {
        fatalError("Failed to retrieve the value for input '\(input.rawValue)' as a `[String]`.")
      }
      return result
    }
    set {
      self[input: input].value = .stringVec(newValue)
    }
  }

  /// Convenience accessor/mutator for an input's value. Invoking with an input that does not hold
  /// a stereo sample vector value results in a fatal error.
  ///
  /// - Parameter input: The input storing a stereo sample vector value.
  public subscript(stereoSampleVecInput input: Spec.Input) -> [StereoSample] {
    get {
      guard case .stereoSampleVec(let result) = self[input: input].value else {
        fatalError("Failed to retrieve the value for input '\(input.rawValue)' as a `[StereoSample]`.")
      }
      return result
    }
    set {
      self[input: input].value = .stereoSampleVec(newValue)
    }
  }

  /// Convenience accessor/mutator for an input's value. Invoking with an input that does not hold
  /// a real vector vector value results in a fatal error.
  ///
  /// - Parameter input: The input storing a real vector vector value.
  public subscript(realVecVecInput input: Spec.Input) -> [[Float]] {
    get {
      guard case .realVecVec(let result) = self[input: input].value else {
        fatalError("Failed to retrieve the value for input '\(input.rawValue)' as a `[[Float]]`.")
      }
      return result
    }
    set {
      self[input: input].value = .realVecVec(newValue)
    }
  }

  /// Convenience accessor/mutator for an input's value. Invoking with an input that does not hold
  /// a complex real vector vector value results in a fatal error.
  ///
  /// - Parameter input: The input storing a complex real vector vector value.
  public subscript(complexRealVecVecInput input: Spec.Input) -> [[DSPComplex]] {
    get {
      guard case .complexRealVecVec(let result) = self[input: input].value else {
        fatalError("Failed to retrieve the value for input '\(input.rawValue)' as a `[[DSPComplex]]`.")
      }
      return result
    }
    set {
      self[input: input].value = .complexRealVecVec(newValue)
    }
  }

  /// The outputs connected to the algorithm.
  private let outputs: [Spec.Output:Output]

  /// Accessor for one of the algorithm's outputs.
  ///
  /// - Parameter output: The output's identifier.
  public subscript(output output: Spec.Output) -> Output {
    guard !Spec.Output.isEmpty else { fatalError("Algorithm `\(name) has no outputs.") }
    guard let result = outputs[output] else {
      fatalError("Failed to retrieve output '\(output.rawValue)'.")
    }
    return result
  }

  /// Convenience accessor for an output's value. Invoking with an output that does not hold
  /// a real value results in a fatal error.
  ///
  /// - Parameter output: The output storing a real value.
  public subscript(realOutput output: Spec.Output) -> Float {
    guard case .real(let result) = self[output: output].value else {
      fatalError("Failed to retrieve the value for output '\(output.rawValue)' as a `Float`.")
    }
    return result
  }

  /// Convenience accessor for an output's value. Invoking with an output that does not hold
  /// a string value results in a fatal error.
  ///
  /// - Parameter output: The output storing a string value.
  public subscript(stringOutput output: Spec.Output) -> String {
    guard case .string(let result) = self[output: output].value else {
      fatalError("Failed to retrieve the value for output '\(output.rawValue)' as a `String`.")
    }
    return result
  }

  /// Convenience accessor for an output's value. Invoking with an output that does not hold
  /// an integer value results in a fatal error.
  ///
  /// - Parameter output: The output storing an integer value.
  public subscript(integerOutput output: Spec.Output) -> Int32 {
    guard case .integer(let result) = self[output: output].value else {
      fatalError("Failed to retrieve the value for output '\(output.rawValue)' as a `Int32`.")
    }
    return result
  }

  /// Convenience accessor for an output's value. Invoking with an output that does not hold
  /// a complex real value results in a fatal error.
  ///
  /// - Parameter output: The output storing a complex real value.
  public subscript(complexRealOutput output: Spec.Output) -> DSPComplex {
    guard case .complexReal(let result) = self[output: output].value else {
      fatalError("Failed to retrieve the value for output '\(output.rawValue)' as a `DSPComplex`.")
    }
    return result
  }

  /// Convenience accessor for an output's value. Invoking with an output that does not hold
  /// a stereo sample value results in a fatal error.
  ///
  /// - Parameter output: The output storing a stereo sample value.
  public subscript(stereoSampleOutput output: Spec.Output) -> StereoSample {
    guard case .stereoSample(let result) = self[output: output].value else {
      fatalError("Failed to retrieve the value for output '\(output.rawValue)' as a `StereoSample`.")
    }
    return result
  }

  /// Convenience accessor for an output's value. Invoking with an output that does not hold
  /// a pool value results in a fatal error.
  ///
  /// - Parameter output: The output storing a pool value.
  public subscript(poolOutput output: Spec.Output) -> Pool {
    guard case .pool(let result) = self[output: output].value else {
      fatalError("Failed to retrieve the value for output '\(output.rawValue)' as a `Pool`.")
    }
    return result
  }

  /// Convenience accessor for an output's value. Invoking with an output that does not hold
  /// a real matrix value results in a fatal error.
  ///
  /// - Parameter output: The output storing a real matrix value.
  public subscript(realMatrixOutput output: Spec.Output) -> [[Float]] {
    guard case .realMatrix(let result) = self[output: output].value else {
      fatalError("Failed to retrieve the value for output '\(output.rawValue)' as a `[[Float]]`.")
    }
    return result
  }

  /// Convenience accessor for an output's value. Invoking with an output that does not hold
  /// a complex real vector value results in a fatal error.
  ///
  /// - Parameter output: The output storing a complex real vector value.
  public subscript(complexRealVecOutput output: Spec.Output) -> [DSPComplex] {
    guard case .complexRealVec(let result) = self[output: output].value else {
      fatalError("Failed to retrieve the value for output '\(output.rawValue)' as a `[DSPComplex]`.")
    }
    return result
  }


  /// Convenience accessor for an output's value. Invoking with an output that does not hold
  /// a real vector value results in a fatal error.
  ///
  /// - Parameter output: The output storing a real vector value.
  public subscript(realVecOutput output: Spec.Output) -> [Float] {
    guard case .realVec(let result) = self[output: output].value else {
      fatalError("Failed to retrieve the value for output '\(output.rawValue)' as a `[Float]`.")
    }
    return result
  }

  /// Convenience accessor for an output's value. Invoking with an output that does not hold
  /// a string vector value results in a fatal error.
  ///
  /// - Parameter output: The output storing a string vector value.
  public subscript(stringVecOutput output: Spec.Output) -> [String] {
    guard case .stringVec(let result) = self[output: output].value else {
      fatalError("Failed to retrieve the value for output '\(output.rawValue)' as a `[String]`.")
    }
    return result
  }

  /// Convenience accessor for an output's value. Invoking with an output that does not hold
  /// a stereo sample vector value results in a fatal error.
  ///
  /// - Parameter output: The output storing a stereo sample vector value.
  public subscript(stereoSampleVecOutput output: Spec.Output) -> [StereoSample] {
    guard case .stereoSampleVec(let result) = self[output: output].value else {
      fatalError("Failed to retrieve the value for output '\(output.rawValue)' as a `[StereoSample]`.")
    }
    return result
  }

  /// Convenience accessor for an output's value. Invoking with an output that does not hold
  /// a real vector vector value results in a fatal error.
  ///
  /// - Parameter output: The output storing a real vector vector value.
  public subscript(realVecVecOutput output: Spec.Output) -> [[Float]] {
    guard case .realVecVec(let result) = self[output: output].value else {
      fatalError("Failed to retrieve the value for output '\(output.rawValue)' as a `[[Float]]`.")
    }
    return result
  }

  /// Convenience accessor for an output's value. Invoking with an output that does not hold
  /// a complex real vector vector value results in a fatal error.
  ///
  /// - Parameter output: The output storing a complex real vector vector value.
  public subscript(complexRealVecVecOutput output: Spec.Output) -> [[DSPComplex]] {
    guard case .complexRealVecVec(let result) = self[output: output].value else {
      fatalError("Failed to retrieve the value for output '\(output.rawValue)' as a `[[DSPComplex]]`.")
    }
    return result
  }

  /// Executes the algorithm with its current parameters and input/output connections.
  public func compute() { standardWrapper.compute() }

  /// Resets the algorithm's state.
  public func reset() { standardWrapper.reset() }

}
