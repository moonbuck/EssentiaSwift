//
//  VectorOutput.swift
//  Essentia
//
//  Created by Jason Cardwell on 10/31/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
import Foundation

/// The Swift-facing interface for streaming vector output.
public class VectorOutput<VectorElement>: StreamingAlgorithm<Streaming.IO.VectorOutput> {

  /// Overridden to ensure the wrapper is an instance of `VectorOutputWrapper`.
  ///
  /// - Parameter wrapper: The `VectorOutputWrapper`.
  internal override init(wrapper: AlgorithmWrapper) {
    guard wrapper is VectorOutputWrapper else {
      fatalError("An instance of `VectorOutputWrapper` is required.")
    }
    super.init(wrapper: wrapper)
  }

  /// The default initializer has no parameters but the generic type `VectorElement` must
  /// resolve into one of the supported data types for `VectorOutputWrapper`.
  public init() {

    let dataType: IODataType

    if VectorElement.self  == Float.self {
      dataType = .realVec
    } else if VectorElement.self == String.self {
      dataType = .stringVec
    } else if VectorElement.self == StereoSample.self {
      dataType = .stereoSampleVec
    } else if VectorElement.self == DSPComplex.self {
      dataType = .complexRealVec
    } else if VectorElement.self == Array<Float>.self {
      dataType = .realVecVec
    } else if VectorElement.self == Array<DSPComplex>.self {
      dataType = .complexRealVecVec
    } else {
      fatalError("Unsupported type for `VectorElement`: '\(VectorElement.self)'.")
    }

    let wrapper = VectorOutputWrapper(for: dataType)
    super.init(wrapper: wrapper)

  }

  /// The vector of output data.
  public var vector: [VectorElement] {
    let wrapper = self.wrapper as! VectorOutputWrapper
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

}
