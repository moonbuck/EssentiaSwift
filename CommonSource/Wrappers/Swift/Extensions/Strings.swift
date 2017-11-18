//
//  Strings.swift
//  Essentia
//
//  Created by Jason Cardwell on 11/18/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
import Foundation

extension Character {

  /// Operator providing a more convenient way to create a string by characeter repetition.
  ///
  /// - Parameters:
  ///   - lhs: The character to repeat.
  ///   - rhs: The number of times to repeat `lhs`.
  /// - Returns: A string composed of `lhs` repeated `rhs` times.
  public static func *(lhs: Character, rhs: Int) -> String {
    return String(repeating: lhs, count: rhs)
  }

}

extension String {

  /// Operator providing a more convenient way to create a string of a repeated characeter
  /// sequence.
  ///
  /// - Parameters:
  ///   - lhs: The character sequence to repeat.
  ///   - rhs: The number of times to repeat `lhs`.
  /// - Returns: A string composed of `lhs` repeated `rhs` times.
  public static func *(lhs: String, rhs: Int) -> String {
    return String(repeating: lhs, count: rhs)
  }

  /// An enumeration for specifying the location of a string's content within a padded string.
  public enum PadAlignment {

    /// The padding follows the content.
    case left

    /// Half the padding precedes the content and half the padding follows the content.
    case center

    /// The padding precedes the content.
    case right

  }

  /// Pads the string to create a new string.
  ///
  /// - Parameters:
  ///   - length: The length to which the string will be padded.
  ///   - alignment: The location of the string's content within the padded string.
  ///                Defaults to `left` alignment.
  ///   - padCharacter: The character used to pad the string to `length`.
  ///                   Defaults to `" "`.
  /// - Returns: The string padded to `length` using `padCharacter` and aligned via `alignment`.
  public func padded(to length: Int,
                     alignment: PadAlignment = .left,
                     padCharacter: Character = " ") -> String
  {

    // Check that the string does not satisfy `length`. If it does, just return the string.
    guard count < length else { return self }

    // Switch on the specified pad alignment.
    switch alignment {

      case .left:
        // Add the string's content. Add the padding.

        let pad = length - count
        return self + padCharacter * pad

      case .center:
        // Add half the padding. Add the string's content. Add the remaing padding.

        let leftPad = (length - count) / 2
        let rightPad = length - count - leftPad
        return padCharacter * leftPad + self + padCharacter * rightPad

      case .right:
        // Add the padding. Add the string's content.

        let pad = length - count
        return padCharacter * pad + self

    }

  }

}
