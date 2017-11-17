//
//  Source.swift
//  Essentia
//
//  Created by Jason Cardwell on 10/31/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
import Foundation

/// A class that further wraps the Objective-C `SourceWrapper` with a Swift interface.
public class Source: CustomStringConvertible {

  /// The Objective-C wrapper that bridges the C++ `Output` class.
  internal let wrapper: SourceWrapper

  /// Initializing with the Objective-C wrapper.
  ///
  /// - Parameter wrapper: The wrapper to wrap.
  internal init(wrapper: SourceWrapper) { self.wrapper = wrapper }

  /// Accessor for the data held by the source.
  public var value: IOValue { return IOValue(data: wrapper.data, dataType: wrapper.dataType) }

  /// The data type held by the source.
  public var type: IODataType { return wrapper.dataType }

  /// The source's name.
  public var name: String { return wrapper.name }

  /// The full name of the source.
  public var fullName: String { return wrapper.fullName }

  /// A string with the source's name and data type.
  public var description: String { return "\(name) (\(type))" }

  /// Connects the source to the specified sink.
  ///
  /// - Parameter sink: The sink to which the source will be connected.
  public func connect(to sink: Sink) {
    wrapper.connect(to: sink.wrapper)
  }

  /// Disconnects the source from the specified sink.
  ///
  /// - Parameter sink: The sink from which the source will be disconnected.
  public func disconnect(from sink: Sink) {
    wrapper.disconnect(from: sink.wrapper)
  }

  /// Connects the source to the 'null' sink so that any output is simple ignored.
  public func capConnection() {
    wrapper.capConnection()
  }

  /// Disconnects the source from the 'null' sink.
  public func uncapConnection() {
    wrapper.uncapConnection()
  }

  /// Connects the wrappers vector storage as the sink to which the source flows.
  public func connectInternalStorage() {
    guard type.isVector else { fatalError("The data type of the source is not a vector.") }
    wrapper.connectInternalStorage()
  }

  /// Connects the source to the specified pool using the specified descriptor name.
  ///
  /// - Parameters:
  ///   - pool: The pool to which the source will be connected.
  ///   - descriptorName: The descriptor to use when connecting to the pool.
  ///   - setSingle: Whether to use the single value pool for the connection.
  public func connectTo(pool: Pool, descriptorName: String, setSingle: Bool = false) {
    wrapper.connect(to: pool.wrapper, usingDescriptor: descriptorName, setSingle: setSingle)
  }

  /// Disconnects the source from the specified pool for the specified descriptor name.
  ///
  /// - Parameters:
  ///   - pool: The pool from which the source will be connected.
  ///   - descriptorName: The descriptor used by the connection to disconnect.
  public func disconnect(from pool: Pool, descriptorName: String) {
    wrapper.disconnect(from: pool.wrapper, descriptorName: descriptorName)
  }

}
