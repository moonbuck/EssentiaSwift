//
//  Sink.swift
//  Essentia
//
//  Created by Jason Cardwell on 10/24/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
import Foundation

/// A class that further wraps the Objective-C `SinkWrapper` with a Swift interface.
public class Sink: CustomStringConvertible {

  /// The Objective-C wrapper that bridges the C++ `Sink` class.
  internal let wrapper: SinkWrapper

  /// Initializing with the Objective-C wrapper.
  ///
  /// - Parameter wrapper: The wrapper to wrap.
  internal init(wrapper: SinkWrapper) { self.wrapper = wrapper }

  /// Accessors for the sink's data.
  public var value: IOValue {

    get {
      return IOValue(data: wrapper.data, dataType: wrapper.dataType)
    }

    set {

      switch (newValue, wrapper.dataType) {

        case (.real(let value), .real):
          wrapper.data = value

        case (.string(let value), .string):
          wrapper.data = value

        case (.integer(let value), .int):
          wrapper.data = value

        case (.complexReal(let value), .complexReal):
          wrapper.data = value

        case (.stereoSample(let value), .stereoSample):
          wrapper.data = value

        case (.pool(let value), .pool):
          wrapper.data = value.wrapper

        case (.realMatrix(let value), .realMatrix):
          wrapper.data = value

        case (.complexRealVec(let value), .complexRealVec):
          let convertedValue = value.map({NSValue(complex: $0)})
          wrapper.data = convertedValue

        case (.realVec(let value), .realVec):
          wrapper.data = value

        case (.stringVec(let value), .stringVec):
          wrapper.data = value

        case (.stereoSampleVec(let value), .stereoSampleVec):
          wrapper.data = value.map({NSValue(stereoSample: $0)})

        case (.realVecVec(let value), .realVecVec):
          wrapper.data = value

        case (.complexRealVecVec(let value), .complexRealVecVec):
          wrapper.data = value

        default: break

      }

    }

  }

  /// The type of data held by the sink.
  public var type: IODataType { return wrapper.dataType }

  /// The name of the sink.
  public var name: String { return wrapper.name }

  /// The full name of the sink.
  public var fullName: String { return wrapper.fullName }

  /// A string with the sink's name and data type.
  public var description: String { return "\(name) (\(type))" }

}

