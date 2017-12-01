//
//  DSPComplex.swift
//  Essentia
//
//  Created by Jason Cardwell on 11/23/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
import Foundation
import struct Accelerate.DSPComplex

extension DSPComplex: CustomStringConvertible {

  /// A simple description for the complex number of the form 'a±bi'.
  public var description: String {
    return imag.sign == .minus ? "\(real)\(imag)i" : "\(real)+\(imag)i"
  }

  /// Stores the absolute value of a complex number's imaginary part.
  public struct ImaginaryPart {
    public let value: Float
    public init(value: Float) { self.value = abs(value) }
  }

}

extension DSPComplex: Equatable {

  /// Equatable support.
  ///
  /// - Parameters:
  ///   - lhs: The first value.
  ///   - rhs: The second value.
  /// - Returns: `true` if `lhs.real == rhs.real` and `lhs.imag == rhs.imag`; `false` otherwise.
  public static func ==(lhs: DSPComplex, rhs: DSPComplex) -> Bool {
    return lhs.real == rhs.real && lhs.imag == rhs.imag
  }

}

/// An operator for designating a complex number's imaginary part.
postfix operator ⍳

/// Specifies a complex number's imaginary part. Used for operator constructed complex numbers.
///
/// - Parameter lhs: The absolute value of a complex number's imaginary part.
/// - Returns: The imaginary part structure.
public postfix func ⍳(lhs: Float) -> DSPComplex.ImaginaryPart {
  return DSPComplex.ImaginaryPart(value: lhs)
}

/// Construct a complex number with a positive imaginary part.
///
/// - Parameters:
///   - lhs: The value for the complex number's real part.
///   - rhs: The imaginary part.
/// - Returns: The complex number constructed using `lhs` and `rhs`.
public func +(lhs: Float, rhs: DSPComplex.ImaginaryPart) -> DSPComplex {
  return DSPComplex(real: lhs, imag: rhs.value)
}

/// Construct a complex number with a negative imaginary part.
///
/// - Parameters:
///   - lhs: The value for the complex number's real part.
///   - rhs: The imaginary part.
/// - Returns: The complex number constructed using `lhs` and `rhs`.
public func -(lhs: Float, rhs: DSPComplex.ImaginaryPart) -> DSPComplex {
  return DSPComplex(real: lhs, imag: -rhs.value)
}
