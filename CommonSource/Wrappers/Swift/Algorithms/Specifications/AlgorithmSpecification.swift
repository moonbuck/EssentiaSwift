//
//  AlgorithmSpecification.swift
//  Essentia
//
//  Created by Jason Cardwell on 10/27/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
import Foundation

/// A protocol whose only job is to specify a type as representing a mode of operation for
/// running algorithms.
public protocol AlgorithmMode {}

/// A protocol whose only job is to specifiy a type as representing an algorithm category.
public protocol AlgorithmCategory {}

/// A protocol for types that serve as an enumeration of string keys.
public protocol KeyEnumeration: Hashable, RawRepresentable where Self.RawValue == String {

  /// An array of all enumeration cases.
  static var allKeys: Set<Self> { get }

}

extension KeyEnumeration {

  /// Whether there are any valid enumeration cases (ignoring `.none` if present). 
  public static var isEmpty: Bool { return allKeys.isEmpty }

}

/// The base protocol for types that describe an algorithm specification.
public protocol AlgorithmSpecification {

  /// The name of the algorithm.
  static var name: String { get }

  /// The mode of operation for the algorithm.
  static var mode: AlgorithmMode.Type { get }

  /// The category for the algorithm.
  static var category: AlgorithmCategory.Type { get }

  /// The type used to specify valid algorithm inputs.
  associatedtype Input: KeyEnumeration

  /// The type used to specifiy valid algorithm outputs.
  associatedtype Output: KeyEnumeration

  /// The type used to specify valid algorithm parameters.
  associatedtype Parameter: KeyEnumeration

}

