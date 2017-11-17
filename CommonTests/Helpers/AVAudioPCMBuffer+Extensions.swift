//
//  AVAudioPCMBuffer+Extensions.swift
//  EssentiaTests
//
//  Created by Jason Cardwell on 10/15/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
import Foundation
import AVFoundation

/// Extending `AVAudioPCMBuffer` to more easily work with mono and/or 64 bit formats.
extension AVAudioPCMBuffer {

  /// Derived property for the buffer downmixed to mono.
  public var mono: AVAudioPCMBuffer {

    // Check that the buffer isn't already mono or just return it.
    guard format.channelCount > 1 else { return self }

    // Create a new format the same as the current format except for the number of channels.
    guard let newFormat = AVAudioFormat(commonFormat: format.commonFormat,
                                        sampleRate: format.sampleRate,
                                        channels: 1,
                                        interleaved: format.isInterleaved)
      else
    {
      fatalError("Failed to create single channel audio format.")
    }

    // Create a new audio converter.
    guard let audioConverter = AVAudioConverter(from: format, to: newFormat) else {
      fatalError("Failed to create audio converter.")
    }

    // Create a new buffer to hold the downmixed audio.
    guard let monoBuffer = AVAudioPCMBuffer(pcmFormat: newFormat,
                                            frameCapacity: frameCapacity)
      else
    {
      fatalError("Failed to create new buffer using mono format.")
    }

    // Create a flag for indicating whether the source buffer has been returned from the callback.
    var sourceBufferReturned = false

    // Create the callback that feeds input to the converter.
    let inputBlock: AVAudioConverterInputBlock = {
      [unowned self] in

      // Check whether the buffer's content has already been provided.
      guard !sourceBufferReturned else {
        $1.pointee = .endOfStream
        return nil
      }

      $1.pointee = .haveData
      sourceBufferReturned = true

      return self

    }

    // Create an error pointer.
    var error: NSError? = nil

    // Convert the buffer.
    let status = audioConverter.convert(to: monoBuffer, error: &error, withInputFrom: inputBlock)

    // Check thet status.
    switch status {

    case .haveData, .inputRanDry:
      // The mono buffer has data.

      return monoBuffer

    case .endOfStream, .error:
      // Conversion failed and/or target buffer has no data.

      fatalError("Conversion to single channel failed: \(error!)")

    }

  }

  /// Derived property for the buffer downmixed to mono and with 64 bit values.
  public var mono64: AVAudioPCMBuffer {

    // Check that the buffer isn't already mono or just return it.
    guard format.channelCount > 1 || format.commonFormat != .pcmFormatFloat64 else { return self }

    // Create a new format the same as the current format except for the number of channels.
    guard let newFormat = AVAudioFormat(commonFormat: .pcmFormatFloat64,
                                        sampleRate: format.sampleRate,
                                        channels: 1,
                                        interleaved: format.isInterleaved)
      else
    {
      fatalError("Failed to create single channel audio format.")
    }

    // Create a new audio converter.
    guard let audioConverter = AVAudioConverter(from: format, to: newFormat) else {
      fatalError("Failed to create audio converter.")
    }

    // Create a new buffer to hold the downmixed audio.
    guard let monoBuffer = AVAudioPCMBuffer(pcmFormat: newFormat,
                                            frameCapacity: frameCapacity)
      else
    {
      fatalError("Failed to create new buffer using mono format.")
    }

    // Create a flag for indicating whether the source buffer has been returned from the callback.
    var sourceBufferReturned = false

    // Create the callback that feeds input to the converter.
    let inputBlock: AVAudioConverterInputBlock = {
      [unowned self] in

      // Check whether the buffer's content has already been provided.
      guard !sourceBufferReturned else {
        $1.pointee = .endOfStream
        return nil
      }

      $1.pointee = .haveData
      sourceBufferReturned = true

      return self

    }

    // Create an error pointer.
    var error: NSError? = nil

    // Convert the buffer.
    let status = audioConverter.convert(to: monoBuffer, error: &error, withInputFrom: inputBlock)

    // Check thet status.
    switch status {

    case .haveData, .inputRanDry:
      // The mono buffer has data.

      return monoBuffer

    case .endOfStream, .error:
      // Conversion failed and/or target buffer has no data.

      fatalError("Conversion to single channel failed: \(error!)")

    }

  }

  /// Accessor for the underlying audio as 64 bit values or `nil` if buffer is not 64 bit.
  public var float64ChannelData: UnsafePointer<UnsafeMutablePointer<Float64>>? {

    guard case .pcmFormatFloat64 = format.commonFormat else { return nil }


    let underlyingBuffers = UnsafeMutableAudioBufferListPointer(mutableAudioBufferList)

    let channels = UnsafeMutablePointer<UnsafeMutablePointer<Float64>>.allocate(capacity: Int(format.channelCount))

    for (index, channelBuffer) in underlyingBuffers.enumerated() {

      guard let channelData = channelBuffer.mData else { return nil }

      let float64ChannelData = channelData.bindMemory(to: Float64.self, capacity: Int(frameCapacity))

      (channels + index).initialize(to: float64ChannelData)

    }

    return UnsafePointer(channels)

  }

  /// Initializing with the contents of an audio file.
  ///
  /// - Parameters:
  ///   - url: The url for the audio file to load.
  /// - Throws: Any error encountered reading the audio file into the new buffer.
  public convenience init(contentsOf url: URL) throws {

    // Get the audio file.
    let audioFile = try AVAudioFile(forReading: url)

    // Determine the necessary capacity for the PCM buffer.
    let capacity = AVAudioFrameCount(audioFile.length)

    // Create a PCM buffer with capacity for the contents of `audioFile`.
    self.init(pcmFormat: audioFile.processingFormat, frameCapacity: capacity)!

    // Read the audio file into the buffer.
    try audioFile.read(into: self)

  }

}
