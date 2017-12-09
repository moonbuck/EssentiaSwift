//
//  AVAudioPCMBuffer+Extensions.swift
//  EssentiaTests
//
//  Created by Jason Cardwell on 10/15/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
import Foundation
import AVFoundation
import Accelerate

/// Extending `AVAudioPCMBuffer` to more easily work with mono and/or 64 bit formats.
extension AVAudioPCMBuffer {

  /// A type for specifying how a stereo signal should be downmixed into a mono signal.
  internal enum DownmixMethod { case left, right, mix }

  /// Derived property for the buffer downmixed to mono.
  internal var mono: AVAudioPCMBuffer {

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

  /// Creates a mono version of the buffer using the specified method to downmix the signal.
  ///
  /// - Parameters:
  ///   - method: The method to use when downmixing.
  ///   - sampleRate: The sample rate for the new buffer or `nil` to use the buffer's rate.
  /// - Returns: `self` if the buffer is already a mono signal and a downmixed buffer otherwise.
  internal func downmixed(method: DownmixMethod = .mix,
                        sampleRate: Double? = nil) -> AVAudioPCMBuffer
  {

    guard sampleRate == nil || format.sampleRate == sampleRate! else {

      guard let resampledBuffer = try? convert(sourceBuffer: self, to: sampleRate!) else {
        fatalError("Failed to resample buffer to \(sampleRate!).")
      }

      return resampledBuffer.downmixed(method: method)

    }

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

    switch method {

    case .left:

      guard let leftChannel = floatChannelData?.pointee else {
        fatalError("Failed to get left channel from the buffer.")
      }

      guard let monoChannel = monoBuffer.floatChannelData?.pointee else {
        fatalError("Failed to get mono channel from the new buffer.")
      }

      guard stride == 1 else {
        fatalError("Downmixing interleaved buffers not yet implemented.")
      }

      let count = vDSP_Length(frameLength)
      vDSP_mmov(leftChannel, monoChannel, count, 1, count, count)

      monoBuffer.frameLength = frameLength

      return monoBuffer

    case .right:

      assert(format.channelCount > 1, "Expected more than one audio channel.")

      guard let channelData = floatChannelData else {
        fatalError("Failed to get channels from the buffer.")
      }

      let rightChannel = (channelData + 1).pointee

      guard let monoChannel = monoBuffer.floatChannelData?.pointee else {
        fatalError("Failed to get mono channel from the new buffer.")
      }

      guard stride == 1 else {
        fatalError("Downmixing interleaved buffers not yet implemented.")
      }

      let count = vDSP_Length(frameLength)
      vDSP_mmov(rightChannel, monoChannel, count, 1, count, count)

      monoBuffer.frameLength = frameLength

      return monoBuffer


    case .mix:

      // Not sure if this affects anything.
      audioConverter.downmix = true

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



  }

  /// Initializing with the contents of an audio file.
  ///
  /// - Parameters:
  ///   - url: The url for the audio file to load.
  /// - Throws: Any error encountered reading the audio file into the new buffer.
  internal convenience init(contentsOf url: URL) throws {

    // Get the audio file.
    let audioFile = try AVAudioFile(forReading: url)

    // Determine the necessary capacity for the PCM buffer.
    let capacity = AVAudioFrameCount(audioFile.length)

    // Create a PCM buffer with capacity for the contents of `audioFile`.
    self.init(pcmFormat: audioFile.processingFormat, frameCapacity: capacity)!

    // Make sure there are sample to read into the buffer.
    guard audioFile.length > 0 else { return }

    // Read the audio file into the buffer.
    try audioFile.read(into: self)

  }

}

/// Creates and configures a new `AVAudioConverter` instance using the specified formats.
///
/// - Parameters:
///   - sourceFormat: The source format for the converter.
///   - targetFormat: The destination format for the converter.
/// - Returns: The newly created and configured converter.
/// - Throws: `MultirateAudioPCMBuffer.Error.failureToCreateConverter`
private func audioConverter(withSourceFormat sourceFormat: AVAudioFormat,
                            targetFormat: AVAudioFormat) throws -> AVAudioConverter
{

  // Create the converter.
  guard let converter = AVAudioConverter(from: sourceFormat, to: targetFormat) else {

    throw AVAudioPCMBuffer.Error.failureToCreateConverter

  }

  // Configure the converter for maximum quality.
  converter.sampleRateConverterQuality = AVAudioQuality.max.rawValue

  // Configure the converter to use a 'mastering' grade algorithm for down(mixing/sampling).
  converter.sampleRateConverterAlgorithm = AVSampleRateConverterAlgorithm_Mastering

  // Configure the converter to operate without 'priming'.
  converter.primeMethod = .none

  return converter

}

/// Converts a buffer with a stereo or mono signal to a mono signal at the specified sample rate.
///
/// - Parameters:
///   - sourceBuffer: The buffer with the signal to convert.
///   - rate: The sample rate to which the signal will be converted.
/// - Returns: A buffer with the converted signal.
/// - Throws: Any error that arises from a problem audio format or invalid buffer data.
private func convert(sourceBuffer: AVAudioPCMBuffer, to rate: Double) throws -> AVAudioPCMBuffer {

  // Create the target format.
  guard let targetFormat = AVAudioFormat(commonFormat: .pcmFormatFloat32,
                                         sampleRate: rate,
                                         channels: 1,
                                         interleaved: false)
    else
  {
    throw AVAudioPCMBuffer.Error.invalidFormat
  }

  // Get the input format from the buffer.
  let sourceFormat = sourceBuffer.format

  // Create a new audio converter.
  let converter = try audioConverter(withSourceFormat: sourceFormat, targetFormat: targetFormat)

  // Calculate the scaling factor for the sample count.
  let scalingFactor = rate / sourceBuffer.format.sampleRate

  // Get the total number of frames in the source buffer.
  let sourceTotalFrames = Int(sourceBuffer.frameLength)

  // Calculate the frame capacity needed for the downsampled buffer.
  let targetTotalFrames = Int((Float64(sourceTotalFrames) * scalingFactor).rounded(.up))

  // Create a buffer to hold the converted signal.
  guard let targetBuffer = AVAudioPCMBuffer(pcmFormat: targetFormat,
                                            frameCapacity: AVAudioFrameCount(targetTotalFrames))
  else
  {
    throw AVAudioPCMBuffer.Error.invalidBuffer
  }

  // Create a flag for indicating whether the source buffer has been returned from the callback.
  var sourceBufferReturned = false

  // Create the callback that feeds input to the converter.
  let inputBlock: AVAudioConverterInputBlock = {

    guard !sourceBufferReturned else {
      $1.pointee = .endOfStream
      return nil
    }

    $1.pointee = .haveData
    sourceBufferReturned = true

    return sourceBuffer

  }

  // Create an error pointer.
  var error: NSError? = nil

  // Convert the buffer.
  let status = converter.convert(to: targetBuffer, error: &error, withInputFrom: inputBlock)

  // Check thet status.
  switch status {

    case .haveData, .inputRanDry:
      // The target buffer has data.

      return targetBuffer

    case .endOfStream, .error:
      // Conversion failed and/or target buffer has no data.

      throw error ?? AVAudioPCMBuffer.Error.conversionError

  }

}

extension AVAudioPCMBuffer {

  internal enum Error: String, Swift.Error {

    case invalidSampleRate = "The supplied buffer must have a sample rate ≥ 44100 Hz."
    case failureToCreateConverter = "Failed to create the `AVAudioConverter`."
    case invalidFormat = "Invalid audio format configuration."
    case invalidBuffer = "Invalid buffer configuration."
    case conversionError = "Error converting buffer."
    case channelDataError = "Failed to access the buffer's channel data."
    case invalidFile = "Failed to load audio file content."

  }

}
