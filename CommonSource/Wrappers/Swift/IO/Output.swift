//
//  Output.swift
//  Essentia
//
//  Created by Jason Cardwell on 10/31/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
import Foundation

/// A class that further wraps the Objective-C `OutputWrapper` with a Swift interface.
public class Output: CustomStringConvertible {

  /// The Objective-C wrapper that bridges the C++ `Output` class.
  internal let wrapper: OutputWrapper

  /// Initializing with the Objective-C wrapper.
  ///
  /// - Parameter wrapper: The wrapper to wrap.
  internal init(wrapper: OutputWrapper) { self.wrapper = wrapper }

  /// Accessor for the data held by the output.
  public var value: IOValue { return IOValue(data: wrapper.data, dataType: wrapper.dataType) }

  /// The data type held by the output.
  public var type: IODataType { return wrapper.dataType }

  /// The output's name.
  public var name: String { return wrapper.name }

  /// The full name of the output.
  public var fullName: String { return wrapper.fullName }

  /// A string with the output's name and data type.
  public var description: String { return "\(name) (\(type))" }

  /// Joins the output wrapper with the specified input wrapper so that the data for the input
  /// wrapper becomes the data from the output wrapper.
  ///
  /// - Parameter input: The input wrapper to feed the output wrapper's data.
  public func connect(to input: Input) {
    wrapper.connect(to: input.wrapper)
  }

}

