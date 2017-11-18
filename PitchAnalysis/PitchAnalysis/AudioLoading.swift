//
//  AudioLoading.swift
//  PitchAnalysis
//
//  Created by Jason Cardwell on 11/17/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
import Foundation
import AVFoundation
import Essentia

/// Simple helper for getting a pre-filled mono channel buffer.
///
/// - Parameter url: The URL for the audio file with which to fill the buffer.
/// - Returns: A mono channel buffer with the contents of `url`.
func monoBuffer(url: URL) throws -> AVAudioPCMBuffer {
  return try AVAudioPCMBuffer(contentsOf: url).mono
}

/// Simple helper that extracts the underlying data from a buffer filled with the
/// contents of the specified audio file.
///
/// - Parameters:
///   - url: The URL for the audio file with which to fill the buffer.
///   - forceEvenCount: Flag indicating whether the returned array should have an even count.
/// - Returns: An array with the signal from `url`.
func monoBufferData(url: URL, forceEvenCount: Bool = true) throws -> [Float] {

  let buffer = try monoBuffer(url: url)
  
  guard let signal = buffer.floatChannelData?.pointee else {
    throw NSError()
  }

  var count = Int(buffer.frameLength)
  if count % 2 == 1 && forceEvenCount { count -= 1 }

  return Array(UnsafeBufferPointer(start: signal, count: count))

}

