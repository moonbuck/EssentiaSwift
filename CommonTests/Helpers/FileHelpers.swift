//
//  FileHelpers.swift
//  Essentia
//
//  Created by Jason Cardwell on 11/22/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
import Foundation
import AVFoundation
import Essentia

/// Simple helper for retrieving the URL for a bundled file.
///
/// - Parameters:
///   - name: The file's name.
///   - ext: The file's extension.
/// - Returns: The URL for the bundled file `name`.`ext`.
public func bundleURL(name: String, ext: String) -> URL {
  let bundle = Bundle(for: EssentiaTests.self)
  guard let url = bundle.url(forResource: name, withExtension: ext) else {
    fatalError("Failed to get url for '\(name).\(ext)'.")
  }
  return url
}

/// Simple helper for getting a pre-filled mono channel buffer.
///
/// - Parameter url: The URL for the audio file with which to fill the buffer.
/// - Returns: A mono channel buffer with the contents of `url`.
public func monoBuffer(url: URL) -> AVAudioPCMBuffer {
  guard let buffer = (try? AVAudioPCMBuffer(contentsOf: url)) else {
    fatalError("Failed to create audio buffer using `url`.")
  }
  return buffer.downmixed()
}

/// Simple helper that extracts the underlying data from a buffer filled with the
/// contents of the specified audio file.
///
/// - Parameters:
///   - url: The URL for the audio file with which to fill the buffer.
///   - forceEvenCount: Flag indicating whether the returned array should have an even count.
/// - Returns: An array with the signal from `url`.
public func monoBufferData(url: URL, forceEvenCount: Bool = false) -> [Float] {
  let buffer = monoBuffer(url: url)
  guard let signal = buffer.floatChannelData?.pointee else {
    fatalError("Failed to get raw signal from buffer`.")
  }

  var count = Int(buffer.frameLength)
  if count % 2 == 1 && forceEvenCount { count -= 1 }

  return Array(UnsafeBufferPointer(start: signal, count: count))

}

/// Simple helper that loads values from a text file into an array of float values.
///
/// - Parameter name: The name of the bundled file.
/// - Returns: An array with the float values parsed from the file.
public func loadVector(name: String) -> [Float] {
  let url = bundleURL(name: name, ext: "txt")
  guard let text = try? String(contentsOf: url) else {
    fatalError("Failed to load text from file: '\(name).txt'.")
  }
  return (text.split(separator: "\n") as [NSString]).map(\.floatValue)
}

/// Simple helper that loads values from a text file into a two dimensional array of float values.
/// Inner arrays are delimited by consecutive newline characters.
///
/// - Parameters:
///   - name: The name of the bundled file.
/// - Returns: A two dimensional array of the float values parsed from the file.
public func loadVectorVector(name: String) -> [[Float]] {
  let url = bundleURL(name: name, ext: "txt")
  guard let text = try? String(contentsOf: url) else {
    fatalError("Failed to load text from file: '\(name).txt'.")
  }

  return (text as NSString).components(separatedBy: "\n\n")
          .map({($0.split(separator: "\n") as [NSString]).map(\.floatValue)})
}

/// Simple helper that loads space-delimited real and imaginary parts for newline-delimited
/// complex values from a text file into an array of complex values.
///
/// - Parameter name: The name of the bundled file.
/// - Returns: An array with the complex values parsed from the file.
public func loadComplexVector(name: String) -> [DSPComplex] {
  let url = bundleURL(name: name, ext: "txt")
  guard let text = try? String(contentsOf: url) else {
    fatalError("Failed to load text from file: '\(name).txt'.")
  }
  return text.split(separator: "\n").map {
    let parts = $0.split(separator: " ") as [NSString]
    guard parts.count == 2 else {
      fatalError("Unexpected number of spaces: \(max(0, parts.count - 1))")
    }
    return DSPComplex(real: parts[0].floatValue, imag: parts[1].floatValue)
  }
}
