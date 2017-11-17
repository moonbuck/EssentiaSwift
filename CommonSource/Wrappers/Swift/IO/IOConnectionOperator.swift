//
//  IOConnectionOperator.swift
//  Essentia
//
//  Created by Jason Cardwell on 11/1/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
import Foundation

/// An operator for connecting an output to a compatible input.
infix operator >>

/// Standard IO operator for connecting an output to an input.
///
/// - Parameters:
///   - lhs: The output to connect.
///   - rhs: The input to connect.
public func >>(lhs: Output, rhs: Input) { lhs.connect(to: rhs) }


/// Streaming IO operator for connecting a source to a sink.
///
/// - Parameters:
///   - lhs: The source to connect.
///   - rhs: The sink to connect.
public func >>(lhs: Source, rhs: Sink) { lhs.connect(to: rhs) }

/// Streaming IO operator for connecting a source to a pool.
///
/// - Parameters:
///   - lhs: The source to connect.
///   - rhs: The pool connection tuple containing the necessary information for the connection.
public func >>(lhs: Source, rhs: Pool.PoolConnection) {
  lhs.connectTo(pool: rhs.pool, descriptorName: rhs.descriptorName, setSingle: rhs.setSingle)
}

/// An operator for connecting an output to a compatible input.
infix operator >!

/// Streaming IO operator for disconnecting a source from a sink.
///
/// - Parameters:
///   - lhs: The source to disconnect.
///   - rhs: The sink to disconnect.
public func >!(lhs: Source, rhs: Sink) { lhs.disconnect(from: rhs) }

/// Streaming IO operator for disconnecting a source from a pool.
///
/// - Parameters:
///   - lhs: The source to disconnect.
///   - rhs: The pool connection tuple containing the necessary information about the connection.
public func >!(lhs: Source, rhs: Pool.PoolConnection) {
  lhs.disconnect(from: rhs.pool, descriptorName: rhs.descriptorName)
}

/// A postfix operator for capping a connection.
postfix operator >>|

/// Streaming IO operator for capping a connection.
///
/// - Parameter operand: The source connection to cap.
public postfix func >>|(operand: Source) {
  operand.capConnection()
}

/// A postfix operator for uncapping a connection.
postfix operator >>>

/// Streaming IO operator for uncapping a connection.
///
/// - Parameter operand: The source connection to uncap.
public postfix func >>>(operand: Source) {
  operand.capConnection()
}

