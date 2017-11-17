//
//  Wrapping.swift
//  Essentia
//
//  Created by Jason Cardwell on 10/27/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
import Foundation

/// A protocol for types being wrapped by another type.
internal protocol WrappedType {
  associatedtype Wrapper
}

/// A protocol for types that wrap another type.
internal protocol WrappingType {
  associatedtype Wrapped
}
