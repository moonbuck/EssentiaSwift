//
//  VectorInput.swift
//  Essentia
//
//  Created by Jason Cardwell on 10/31/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
import Foundation

/// The Swift-facing interface for streaming vector input.
public class VectorInput<VectorElement>: StreamingAlgorithm<Streaming.IO.VectorInput> {

  /// Overridden to ensure the wrapper is an instance of `VectorInputWrapper`.
  ///
  /// - Parameter wrapper: The `VectorInputWrapper`.
  internal override init(wrapper: AlgorithmWrapper) {
    guard wrapper is VectorInputWrapper else {
      fatalError("An instance of `VectorInputWrapper` is required.")
    }
    super.init(wrapper: wrapper)
  }

  /// Initializing with a vector to use as the input data. The following types are
  /// supported for the vector elements:
  /// - `Float`
  /// - `[[Float]]`
  /// - `String`
  /// - `StereoSample`
  /// - `[Float]`
  /// - `DSPComplex`
  ///
  /// - Parameter vector: The input data.
  public init(_ vector: [VectorElement]) {

    let wrapper: VectorInputWrapper

    if let vector = vector as? [Float] {
      wrapper = VectorInputWrapper(realVec: vector as [NSNumber])
    } else if let vector = vector as? [[[Float]]] {
      wrapper = VectorInputWrapper(realMatrixVec: vector as [[[NSNumber]]])
    } else if let vector = vector as? [String] {
      wrapper = VectorInputWrapper(stringVec: vector)
    } else if let vector = vector as? [StereoSample] {
      wrapper = VectorInputWrapper(stereoSampleVec: vector.map(NSValue.init(stereoSample:)))
    } else if let vector = vector as? [[Float]] {
      wrapper = VectorInputWrapper(realVecVec: vector as [[NSNumber]])
    } else if let vector = vector as? [DSPComplex] {
      wrapper = VectorInputWrapper(complexRealVec: vector.map(NSValue.init(complex:)))
    } else if let vector = vector as? [[DSPComplex]] {
      wrapper = VectorInputWrapper(complexRealVecVec: vector.map({$0.map(NSValue.init(complex:))}))
    } else {
      fatalError("Unsupported type vector type: \(type(of: vector)).")
    }

    super.init(wrapper: wrapper)

  }

  /// The vector used as the input data.
  public var vector: [VectorElement] {
    get {
      let wrapper = self.wrapper as! VectorInputWrapper
      if VectorElement.self == StereoSample.self,
        let vector = wrapper.vector as? [NSValue]
      {
        return vector.map(\.stereoSampleValue) as! [VectorElement]
      }
      else if VectorElement.self == DSPComplex.self,
        let vector = wrapper.vector as? [NSValue]
      {
        return vector.map(\.complexValue) as! [VectorElement]
      }
      else if VectorElement.self == Array<DSPComplex>.self,
        let vector = wrapper.vector as? [[NSValue]]
      {
        return vector.map({$0.map(\.complexValue)}) as! [VectorElement]
      }
      else if let vector = wrapper.vector as? [VectorElement] {
        return vector
      }
      else {
        fatalError("Failed to downcast the wrapper's `vector` to `[\(VectorElement.self)]`.")
      }
    }
    set {
      let wrapper = self.wrapper as! VectorInputWrapper
      if let vector = newValue as? [Float] {
        wrapper.vector = vector as [NSNumber]
      } else if let vector = newValue as? [[[Float]]] {
        wrapper.vector = vector as [[[NSNumber]]]
      } else if let vector = newValue as? [String] {
        wrapper.vector = vector
      } else if let vector = newValue as? [StereoSample] {
        wrapper.vector = vector.map(NSValue.init(stereoSample:))
      } else if let vector = newValue as? [[Float]] {
        wrapper.vector = vector as [[NSNumber]]
      } else if let vector = newValue as? [DSPComplex] {
        wrapper.vector = vector.map(NSValue.init(complex:))
      } else if let vector = newValue as? [[DSPComplex]] {
        wrapper.vector = vector.map({$0.map(NSValue.init(complex:))})
      }
    }
  }

}
