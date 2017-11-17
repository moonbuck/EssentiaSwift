//
//  StereoSample.swift
//  Essentia
//
//  Created by Jason Cardwell on 11/4/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
import Foundation

extension StereoSample: Equatable {

  /// Determines whether two stereo sample instances are equivalent.
  ///
  /// - Parameters:
  ///   - lhs: The first stereo sample being compared.
  ///   - rhs: The second stereo sample being compared.
  /// - Returns: `true` if the `left` and `right` values are equal and `false` otherwise.
  public static func ==(lhs: StereoSample, rhs: StereoSample) -> Bool {
    return lhs.left == rhs.left && lhs.right == rhs.right
  }

}

extension StereoSample: Encodable {

  public enum CodingKeys: String, CodingKey { case left, right }

  /// Encodes the stereo sample via the provided encoder.
  ///
  /// - Parameter encoder: The encoder to use for encoding the stereo sample.
  /// - Throws: Any error encountered while encoding the stereo sample.
  public func encode(to encoder: Encoder) throws {

    var container = encoder.container(keyedBy: CodingKeys.self)

    try container.encode(left, forKey: .left)
    try container.encode(right, forKey: .right)

  }

}
