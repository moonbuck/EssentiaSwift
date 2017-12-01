//
//  MathExtensions.swift
//  Essentia
//
//  Created by Jason Cardwell on 11/30/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
import Foundation
import struct Accelerate.DSPComplex

extension FloatingPoint {

  /// Calculates the amount of deviation between the value and another value.
  ///
  /// - Parameter other: The other value.
  /// - Returns: The amount of deviation between `self` and `other`.
  public func deviation(from other: Self) -> Self {
    let deviation: Self
    switch (self, other) {
      case (0, 0): deviation = 0
      case (_, 0): deviation = .infinity
      case (0, _): deviation = 100
      default:     deviation = abs(other - self) / abs(other) * 100
    }
    return deviation
  }

  /// Determines equality with another value given an allowable deviation.
  ///
  /// - Parameters:
  ///   - other: The other value.
  ///   - deviation: The allowable deviation.
  /// - Returns: `true` if the values are equal within `deviation` and `false` otherwise.
  public func isEqual(to other: Self, deviation: Self) -> Bool {
    guard other != self else { return true }
    guard !(isNaN || isInfinite || other.isNaN || other.isInfinite) else { return false }
    let actualDeviation = self.deviation(from: other)
    let isOkay = actualDeviation <= deviation
    return isOkay
  }

}

extension DSPComplex {

  /// Calculates the amount of deviation between the value and another value.
  ///
  /// - Parameter other: The other value.
  /// - Returns: The amount of deviation between `self` and `other`.
  public func deviation(from other: DSPComplex) -> Float {
    return (real.deviation(from: other.real) + imag.deviation(from: other.imag)) / 2
  }

  /// Determines equality with another value given an allowable deviation.
  ///
  /// - Parameters:
  ///   - other: The other value.
  ///   - deviation: The allowable deviation.
  /// - Returns: `true` if the values are equal within `deviation` and `false` otherwise.
  public func isEqual(to other: DSPComplex, deviation: Float) -> Bool {
    guard !(   real.isNaN || real.isInfinite
            || imag.isNaN || imag.isInfinite
            || other.real.isNaN || other.real.isInfinite
            || other.imag.isNaN || other.imag.isInfinite)
      else
    {
      return false
    }
    return real.deviation(from: other.real) <= deviation
        && imag.deviation(from: other.imag) <= deviation
  }

}

extension Array where Element:FloatingPoint {

  /// The mean value of the array's elements.
  public var mean: Element { return reduce(0, +) / Element(count) }

  /// Calculates the average of the absolute values of the differences of array elements.
  ///
  /// - Parameters:
  ///   - other: The other array.
  ///   - countMismatch: Flag for indicating the array counts do not math.
  /// - Returns: The average difference between the arrays.
  public func averageDifference(with other: [Element],
                                     countMismatch: UnsafeMutablePointer<Bool>? = nil) -> Element
  {
    guard count == other.count else { countMismatch?.pointee = true; return .infinity }
    return zip(self, other).map(-).map(abs).mean
  }

  /// Calculates the average of the deviation values of array elements.
  ///
  /// - Parameters:
  ///   - other: The other array.
  ///   - countMismatch: Flag for indicating the array counts do not math.
  /// - Returns: The average deviation between the arrays.
  public func averageDeviation(from other: [Element],
                               countMismatch: UnsafeMutablePointer<Bool>? = nil) -> Element
  {
    guard count == other.count else { countMismatch?.pointee = true; return .infinity }
    return zip(self, other).map({$0.deviation(from: $1)}).mean
  }

}

extension Array where Element == DSPComplex {

  /// The mean value of the real parts of the array's elements.
  public var realMean: Float {  return map(\.real).mean  }

  /// The mean value of the imaginary parts of the array's elements.
  public var imaginaryMean: Float {  return map(\.imag).mean  }


  /// Calculates the average of the absolute values of the differences of array elements.
  ///
  /// - Parameters:
  ///   - other: The other array.
  ///   - countMismatch: Flag for indicating the array counts do not math.
  /// - Returns: The average difference between the arrays.
  public func averageDifference(with other: [Element],
                                countMismatch: UnsafeMutablePointer<Bool>? = nil) -> Float
  {
    guard count == other.count else { countMismatch?.pointee = true; return .infinity }
    let realAverage = zip(map(\.real), other.map(\.real)).map(-).map(abs).mean
    let imaginaryAverage = zip(map(\.imag), other.map(\.imag)).map(-).map(abs).mean
    return (realAverage + imaginaryAverage) / 2
  }

  /// Calculates the average of the deviation values of the array elements.
  ///
  /// - Parameters:
  ///   - other: The other array.
  ///   - countMismatch: Flag for indicating the array counts do not math.
  /// - Returns: The average deviation between the arrays.
  public func averageDeviation(from other: [Element],
                               countMismatch: UnsafeMutablePointer<Bool>? = nil) -> Float
  {
    guard count == other.count else { countMismatch?.pointee = true; return .infinity }
    return zip(self, other).map({$0.deviation(from: $1)}).mean
  }

}
