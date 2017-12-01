//
//  StandardAlgorithmTests.swift
//  Essentia
//
//  Created by Jason Cardwell on 11/22/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
import XCTest
@testable import Essentia
import AVFoundation
import Accelerate

// Declare custom operators since they cannot be exported from `Essentia`.
infix operator >>
infix operator >!
postfix operator >>|
postfix operator >>>
postfix operator ⍳

class StandardAlgorithmTests: XCTestCase {

  /// Tests the STFT/FFT functionality.
  func testFFT() {

    /*
     Test with DC signal input.
     */

    let fft1 = FFTAlgorithm()
    fft1[realVecInput: .frame] = [1.0] + [0.0] * 511
    fft1.compute()

    XCTAssertEqual(fft1[complexRealVecOutput: .fft],
                   [DSPComplex(real: 1, imag: 0)] * 257,
                   accuracy: 1e-7)

    /*
     Test with a Fs/2 sine wave to check the nyquist value.
     */

    let fft2 = FFTAlgorithm()
    fft2[realVecInput: .frame] = [1.0, -1.0] * 512
    fft2.compute()

    XCTAssertEqual(fft2[complexRealVecOutput: .fft],
                   [DSPComplex()] * 512 + [DSPComplex(real: 1024, imag: 0)],
                   accuracy: 1e-7)

    /*
     Test for regression.
     Note: Instead of porting the expected result for this case from `test_fft.py`,
           'fft_output.txt' has been filled with the algorithm's result when run with
           'fft_input.txt' in python.
     */

    let fft3 = FFTAlgorithm()
    fft3[realVecInput: .frame] = loadVector(name: "fft_input")
    fft3.compute()

    XCTAssertEqual(fft3[complexRealVecOutput: .fft],
                   loadComplexVector(name: "fft_output"),
                   accuracy: 1e-3)

    /*
     Test with all-zero input.
     */

    let fft4 = FFTAlgorithm()
    fft4[realVecInput: .frame] = [0.0] * 2048
    fft4.compute()

    XCTAssertEqual(fft4[complexRealVecOutput: .fft], [DSPComplex()] * 1025, accuracy: 0)

    /*
     Test with a real signal, comparing that standard and streaming return the same result and
     generating an attachment with the FFT frames as a CSV document.
     */

    let url = bundleURL(name: "C4-E♭4-G4_Boesendorfer_Grand_Piano-Trimmed", ext: "aif")
    let signal = monoBufferData(url: url)

    // Compute using the standard algorithm.

    let frameCutter1 = FrameCutterAlgorithm([
      .frameSize: 1024,
      .hopSize: 256,
      .startFromZero: false
      ])

    let windowing1 = WindowingAlgorithm([.type: "hann"])

    let fft5 = FFTAlgorithm([.size: 1024])

    frameCutter1[realVecInput: .signal] = signal

    frameCutter1[output: .frame] >> windowing1[input: .frame]
    windowing1[output: .frame] >> fft5[input: .frame]


    var complexFrames1: [[DSPComplex]] = []

    repeat {
      frameCutter1.compute()
      let frame = frameCutter1[realVecOutput: .frame]
      if frame.isEmpty { break }
      windowing1.compute()
      fft5.compute()
      complexFrames1.append(fft5[complexRealVecOutput: .fft])
    } while true

    // Compute using the streaming algorithm.

    let vectorInput = VectorInput<Float>(signal)

    let frameCutter2 = FrameCutterSAlgorithm([
      .frameSize: 1024,
      .hopSize: 256,
      .startFromZero: false
      ])

    let windowing2 = WindowingSAlgorithm([.type: "hann"])

    let fft6 = FFTSAlgorithm([.size: 1024])

    let vectorOutput = VectorOutput<[DSPComplex]>()

    vectorInput[output: .data] >> frameCutter2[input: .signal]
    frameCutter2[output: .frame] >> windowing2[input: .frame]
    windowing2[output: .frame] >> fft6[input: .frame]
    fft6[output: .fft] >> vectorOutput[input: .data]

    let network = Network(generator: vectorInput)
    network.run()

    let complexFrames2 = vectorOutput.vector

    XCTAssertEqual(complexFrames1, complexFrames2, accuracy: 0)

    // Convert the complex output into real output by calculating energies.

    guard !complexFrames2.isEmpty else {
      XCTFail("No complex FFT frames were produced.")
      return
    }

    var accelBuffer = DSPSplitComplex(realp: UnsafeMutablePointer<Float>.allocate(capacity: 512),
                                      imagp: UnsafeMutablePointer<Float>.allocate(capacity: 512))

    var realFrames:[[Float]] = []

    for complexFrame in complexFrames2 {
      vDSP_ctoz(complexFrame, 2, &accelBuffer, 1, 512)
      var realFrame = Array<Float>(repeating: 0, count: 512)
      vDSP_zvmags(&accelBuffer, 1, &realFrame, 1, 512)
      realFrames.append(realFrame)
    }

    // Create and attach the CSV document.

    var text = ""
    for bin in 0 ..< 512 {
      print(realFrames.map({"\($0[bin])"}).joined(separator: ","), to: &text)
    }

    add(XCTAttachment(data: text.data(using: .utf8)!,
                      uniformTypeIdentifier: "public.csv",
                      lifetime: .keepAlways))

  }

  /// Tests the functionality of the FFTC algorithm. This is basically `testFFT()` with
  /// input converted to a complex representation.
  /// TODO: There seems to be some kind of undefined behavior in `FFTC`. Diagnosis it.
  func testFFTC() {

    XCTFail("Undefined behavior in `FFTC` yet to be diagnosed.")

    /*
     Test with DC signal input.
     */

    let fft1 = FFTCAlgorithm()
    fft1[complexRealVecInput: .frame] = [1+0⍳] + [0+0⍳] * 511
    fft1.compute()

    XCTAssertEqual(fft1[complexRealVecOutput: .fft], [1+0⍳] * 257, accuracy: 1e-7)


    /*
     Test with a Fs/2 sine wave to check the nyquist value.
     */

    let fft2 = FFTCAlgorithm()
    fft2[complexRealVecInput: .frame] = [1+0⍳, -1+0⍳] * 512
    fft2.compute()

    XCTAssertEqual(fft2[complexRealVecOutput: .fft], [0+0⍳] * 512 + [1024+0⍳], accuracy: 1e-7)

    /*
     Test for regression.
     Note: Instead of porting the expected result for this case from `test_fft.py`,
           'fft_output.txt' has been filled with the algorithm's result when run with
           'fft_input.txt' in python.
     */

    let fft3 = FFTCAlgorithm()
    let complexSignal = loadComplexVector(name: "fftc_input")
    fft3[complexRealVecInput: .frame] = complexSignal
    fft3.compute()

    XCTAssertEqual(fft3[complexRealVecOutput: .fft],
                   loadComplexVector(name: "fft_output"),
                   accuracy: 1e-3)

    /*
     Test with all-zero input.
     */

    let fft4 = FFTCAlgorithm()
    fft4[complexRealVecInput: .frame] = [0+0⍳] * 2048
    fft4.compute()

    XCTAssertEqual(fft4[complexRealVecOutput: .fft], [DSPComplex()] * 1025, accuracy: 0)

    /*
     Test with a real signal, comparing that standard and streaming return the same result and
     generating an attachment with the FFT frames as a CSV document.
     */

    let url = bundleURL(name: "C4-E♭4-G4_Boesendorfer_Grand_Piano-Trimmed", ext: "aif")
    let signal = monoBufferData(url: url)

    // Compute using the standard algorithm.

    let frameCutter1 = FrameCutterAlgorithm([
      .frameSize: 1024,
      .hopSize: 256,
      .startFromZero: false
      ])

    let windowing1 = WindowingAlgorithm([.type: "hann"])
    

    let fft5 = FFTCAlgorithm([.size: 1024])

    frameCutter1[realVecInput: .signal] = signal

    frameCutter1[output: .frame] >> windowing1[input: .frame]


    var complexFrames1: [[DSPComplex]] = []

    repeat {
      frameCutter1.compute()
      let frame = frameCutter1[realVecOutput: .frame]
      if frame.isEmpty { break }
      windowing1.compute()
      fft5[complexRealVecInput: .frame] = windowing1[realVecOutput: .frame].map {
        DSPComplex(real: $0, imag: 0)
      }
      fft5.compute()
      complexFrames1.append(fft5[complexRealVecOutput: .fft])
    } while true

    // Compute using the streaming algorithm.

    let vectorInput1 = VectorInput<Float>(signal)

    let frameCutter2 = FrameCutterSAlgorithm([
      .frameSize: 1024,
      .hopSize: 256,
      .startFromZero: false
      ])

    let windowing2 = WindowingSAlgorithm([.type: "hann"])

    let windowedSignal = VectorOutput<[Float]>()

    let fft6 = FFTCSAlgorithm([.size: 1024])

    let vectorOutput = VectorOutput<[DSPComplex]>()

    vectorInput1[output: .data] >> frameCutter2[input: .signal]
    frameCutter2[output: .frame] >> windowing2[input: .frame]
    windowing2[output: .frame] >> windowedSignal[input: .data]

    let network1 = Network(generator: vectorInput1)
    network1.run()

    let vectorInput2 = VectorInput<[DSPComplex]>(windowedSignal.vector.map {
      $0.map { DSPComplex(real: $0, imag: 0) }
    })

    vectorInput2[output: .data] >> fft6[input: .frame]
    fft6[output: .fft] >> vectorOutput[input: .data]

    let network2 = Network(generator: vectorInput2)
    network2.run()

    let complexFrames2 = vectorOutput.vector

    XCTAssertEqual(complexFrames1, complexFrames2, accuracy: 0)

    // Convert the complex output into real output by calculating energies.

    guard !complexFrames2.isEmpty else {
      XCTFail("No complex FFT frames were produced.")
      return
    }

    var accelBuffer = DSPSplitComplex(realp: UnsafeMutablePointer<Float>.allocate(capacity: 512),
                                      imagp: UnsafeMutablePointer<Float>.allocate(capacity: 512))

    var realFrames:[[Float]] = []

    for complexFrame in complexFrames2 {
      vDSP_ctoz(complexFrame, 2, &accelBuffer, 1, 512)
      var realFrame = Array<Float>(repeating: 0, count: 512)
      vDSP_zvmags(&accelBuffer, 1, &realFrame, 1, 512)
      realFrames.append(realFrame)
    }

    // Create and attach the CSV document.

    var text = ""
    for bin in 0 ..< 512 {
      print(realFrames.map({"\($0[bin])"}).joined(separator: ","), to: &text)
    }

    add(XCTAttachment(data: text.data(using: .utf8)!,
                      uniformTypeIdentifier: "public.csv",
                      lifetime: .keepAlways))

  }

  /// Tests the functionality ofthe IFFT algorithm. Values taken from `test_ifft.py`.
  func testIFFT() {

    /*
     Test with DC.
     */

    let ifft1 = IFFTAlgorithm()
    ifft1[complexRealVecInput: .fft] = [1+0⍳] * 257
    ifft1.compute()

    XCTAssertEqual(ifft1[realVecOutput: .frame], [512.0] + [0.0] * 511)

    /*
     Test with nyquist.
     */

    let ifft2 = IFFTAlgorithm()
    ifft2[complexRealVecInput: .fft] = [0+0⍳] * 512 + [1024+0⍳]
    ifft2.compute()

    XCTAssertEqual(ifft2[realVecOutput: .frame], [1024.0, -1024.0] * 512)

    /*
     Test with all-zero input.
     */

    let ifft3 = IFFTAlgorithm()
    ifft3[complexRealVecInput: .fft] = [0+0⍳] * 1025
    ifft3.compute()

    XCTAssertEqual(ifft3[realVecOutput: .frame], [0.0] * 2048)


    /*
     Test for regression.
     */

    let ifft4 = IFFTAlgorithm()
    ifft4[complexRealVecInput: .fft] = loadComplexVector(name: "ifft_input")
    ifft4.compute()

    XCTAssertEqual(ifft4[realVecOutput: .frame], loadVector(name: "ifft_output"), accuracy: 1e-2)

  }

  /// Tests the DCT algorithm. Values taken from 'test_dct.py'.
  func testDCT() {

    let input = VectorInput<[Float]>([[0.0, 0.0, 1.0, 0.0, 1.0]])

    let dct = DCTSAlgorithm([.inputSize: 5,
                                                 .outputSize: 5,
                                                 .dctType: 2,
                                                 .liftering: 0])

    let output = VectorOutput<[Float]>()

    input[output: .data] >> dct[input: .array]
    dct[output: .dct] >> output[input: .data]

    let network = Network(generator: input)
    network.run()

    var expected: [[Float]] = [
      [0.89442719099, -0.60150095500, -0.12078825843, -0.37174803446, 0.82789503961]
    ]

    XCTAssertEqual(output.vector, expected, accuracy: 1e-6)

    input.vector = [[1, 1, 0, 0, 1]]
    input.reset()
    dct[integerParameter: .dctType] = 3
    dct[integerParameter: .liftering] = 2

    network.run()

    expected.append([1.8973666010509538, 0.74349607, 0.82789504, -0, -0.12078826])

    XCTAssertEqual(output.vector, expected, accuracy: 1e-5)

  }

  /// Tests the functionality of the `Envelope` algorithm. Values taken from `test_envelope.py`.
  func testEnvelope() {

    /*
      Test that the algorithm produces no nan or inf values for a given file.
     */

    let audioSignal = monoBufferData(url: bundleURL(name: "sin_pattern_decreasing", ext: "wav"))

    let envelope1 = EnvelopeAlgorithm([
      .sampleRate: 44100,
      .attackTime: 5,
      .releaseTime: 100
      ])

    envelope1[realVecInput: .signal] = audioSignal
    envelope1.compute()

    XCTAssertNotNaNOrInf(envelope1[realVecOutput: .signal])

    /*
      Test with all-zero input.
     */

    let envelope2 = EnvelopeAlgorithm([
      .sampleRate: 44100,
      .attackTime: 5,
      .releaseTime: 100
      ])

    envelope2[realVecInput: .signal] = [0.0] * 100000
    envelope2.compute()

    XCTAssertEqual(envelope2[realVecOutput: .signal], [0.0] * 100000)


    /*
     Test rectification.
     */

    let envelope3 = EnvelopeAlgorithm([
      .sampleRate: 44100,
      .attackTime: 0,
      .releaseTime: 100,
      .applyRectification: true
      ])

    envelope3[realVecInput: .signal] = [-0.5]
    envelope3.compute()

    XCTAssertEqual(envelope3[realVecOutput: .signal], [0.5])

  }

  /// Tests the functionality of the `Spectrum` algorithm. Values taken from `test_spectrum.py`.
  func testSpectrum() {

    /*
     Regression test with known input and output values.
     */

    let spectrum1 = SpectrumAlgorithm()
    spectrum1[realVecInput: .frame] = loadVector(name: "spectrumInput")
    spectrum1.compute()

    XCTAssertEqual(spectrum1[realVecOutput: .spectrum], loadVector(name: "spectrumOutput"),
                   accuracy: 1e-4)


    /*
     Test with a DC signal.
     */

    let spectrum2 = SpectrumAlgorithm()
    spectrum2[realVecInput: .frame] = [1.0] * 512
    spectrum2.compute()

    XCTAssertEqual(spectrum2[realVecOutput: .spectrum], [512.0] + [0.0] * 256)

    /*
      Test nyquist values.
     */

    let spectrum3 = SpectrumAlgorithm()
    spectrum3[realVecInput: .frame] = [-1.0, 1.0] * 256
    spectrum3.compute()

    XCTAssertEqual(spectrum3[realVecOutput: .spectrum], [0.0] * 256 + [512.0])

    /*
     Test with all-zero input.
     */

    let spectrum4 = SpectrumAlgorithm()
    spectrum4[realVecInput: .frame] = [0.0] * 512
    spectrum4.compute()

    XCTAssertEqual(spectrum4[realVecOutput: .spectrum], [0.0] * 257)

    /*
     Test that the size parameter does not cause improperly-sized output.
     */

    let spectrum5 = SpectrumAlgorithm([.size: 514])
    spectrum5[realVecInput: .frame] = [1.0] * 512
    spectrum5.compute()

    XCTAssertEqual(spectrum5[realVecOutput: .spectrum].count, 257)

  }

  /// Tests the functionality of the Windowing algorithm. Values taken from `test_windowing.py`.
  func testWindowing() {

    /*
     Test that the output frame has the expected size.
     */

    let windowing1 = WindowingAlgorithm([
      .size: 4095,
      .zeroPadding: 12288,
      .type: "hann"
      ])

    windowing1[realVecInput: .frame] = [1.0] * 2047
    windowing1.compute()

    XCTAssertEqual(windowing1[realVecOutput: .frame].count, 14335)

    /*
     Test zero padding.
     */

    let windowing2 = WindowingAlgorithm([
      .size: 9,
      .zeroPadding: 9,
      .type: "square"
      ])

    windowing2[realVecInput: .frame] = [1.0] * 9
    windowing2.compute()

    XCTAssertEqual(Array(windowing2[realVecOutput: .frame][5..<14]), [Float()] * 9)

    /*
     Test with all-zero input.
     */

    let windowing3 = WindowingAlgorithm([
      .size: 10,
      .zeroPadding: 10,
      .type: "square"
      ])

    windowing3[realVecInput: .frame] = [0.0] * 10
    windowing3.compute()

    XCTAssertEqual(windowing3[realVecOutput: .frame], [0.0] * 20)

    func normalize(_ array: inout [Float]) {

      let count = vDSP_Length(array.count)

      var sum: Float = 0
      vDSP_sve(array, 1, &sum, count)

      var two: Float = 2
      vDSP_vsmul(array, 1, &two, &array, 1, count)

      vDSP_vsdiv(array, 1, &sum, &array, 1, count)

    }

    /*
     Test each window type for regression.
     */

    let input: [Float] = [1.0] * 1024

    let windowing4 = WindowingAlgorithm([
      .size: 1024,
      .zeroPadding: 0,
      .type: "hamming",
      .zeroPhase: false
      ])

    windowing4[realVecInput: .frame] = input
    windowing4.compute()

    var expected = loadVector(name: "windowing_hamming")
    normalize(&expected)

    XCTAssertEqual(windowing4[realVecOutput: .frame], expected, accuracy: 1e-6)

    let windowing5 = WindowingAlgorithm([
      .size: 1024,
      .zeroPadding: 0,
      .type: "hann",
      .zeroPhase: false
      ])

    windowing5[realVecInput: .frame] = input
    windowing5.compute()

    expected = loadVector(name: "windowing_hann")
    normalize(&expected)

    XCTAssertEqual(windowing5[realVecOutput: .frame], expected, accuracy: 1e-6)

    let windowing6 = WindowingAlgorithm([
      .size: 1024,
      .zeroPadding: 0,
      .type: "triangular",
      .zeroPhase: false
      ])

    windowing6[realVecInput: .frame] = input
    windowing6.compute()

    expected = loadVector(name: "windowing_triangular")
    normalize(&expected)

    XCTAssertEqual(windowing6[realVecOutput: .frame], expected, accuracy: 1e-6)

    let windowing7 = WindowingAlgorithm([
      .size: 1024,
      .zeroPadding: 0,
      .type: "square",
      .zeroPhase: false
      ])

    windowing7[realVecInput: .frame] = input
    windowing7.compute()

    expected = [1.0] * 1024
    normalize(&expected)

    XCTAssertEqual(windowing7[realVecOutput: .frame], expected, accuracy: 1e-7)

    let windowing8 = WindowingAlgorithm([
      .size: 1024,
      .zeroPadding: 0,
      .type: "blackmanharris62",
      .zeroPhase: false
      ])

    windowing8[realVecInput: .frame] = input
    windowing8.compute()

    expected = loadVector(name: "windowing_blackmanharris62")
    normalize(&expected)

    XCTAssertEqual(windowing8[realVecOutput: .frame], expected, accuracy: 1e-5)

    let windowing9 = WindowingAlgorithm([
      .size: 1024,
      .zeroPadding: 0,
      .type: "blackmanharris70",
      .zeroPhase: false
      ])

    windowing9[realVecInput: .frame] = input
    windowing9.compute()

    expected = loadVector(name: "windowing_blackmanharris70")
    normalize(&expected)

    XCTAssertEqual(windowing9[realVecOutput: .frame], expected, accuracy: 1e-5)

    let windowing10 = WindowingAlgorithm([
      .size: 1024,
      .zeroPadding: 0,
      .type: "blackmanharris74",
      .zeroPhase: false
      ])

    windowing10[realVecInput: .frame] = input
    windowing10.compute()

    expected = loadVector(name: "windowing_blackmanharris74")
    normalize(&expected)

    XCTAssertEqual(windowing10[realVecOutput: .frame], expected, accuracy: 1e-5)

    let windowing11 = WindowingAlgorithm([
      .size: 1024,
      .zeroPadding: 0,
      .type: "blackmanharris92",
      .zeroPhase: false
      ])

    windowing11[realVecInput: .frame] = input
    windowing11.compute()

    expected = loadVector(name: "windowing_blackmanharris92")
    normalize(&expected)

    XCTAssertEqual(windowing11[realVecOutput: .frame], expected, accuracy: 1e-3)

  }

  /// Tests the functionality of the FrameCutter algorithm in standard mode. Values taken
  /// from `test_framecutter.py`.
  func testStandardFrameCutter() {

    /// Helper that uses the specified options and range to generate an input signal to
    /// run through the `FrameCutter` algorithm.
    ///
    /// - Parameters:
    ///   - parameters: The parameters with which to configure the frame cutter.
    ///   - input: The range that will be converted into an input signal to be cut.
    /// - Returns: The resulting frames.
    func cutFrames(parameters: [Standard.FrameCutter.Parameter:Parameter],
                   input: [Float]) -> [[Float]]
    {

      var parameters = parameters
      if parameters[.validFrameThresholdRatio] == nil {
        parameters[.validFrameThresholdRatio] = 0
      }

      let frameCutter = FrameCutterAlgorithm(parameters)
      frameCutter[realVecInput: .signal] = input

      var frames: [[Float]] = []

      while true {

        frameCutter.compute()

        let frame = frameCutter[realVecOutput: .frame]

        guard !frame.isEmpty else { break }

        frames.append(frame)

      }

      return frames

    }

    /*
     Test with an empty input signal.
     */

    XCTAssert(cutFrames(parameters: [.frameSize: 100,
                                     .hopSize: 60,
                                     .startFromZero: false], input: 0..<0).isEmpty)

    XCTAssert(cutFrames(parameters: [.frameSize: 100,
                                     .hopSize: 60,
                                     .startFromZero: true], input: 0..<0).isEmpty)

    /*
     Test with a single sample.
     */

    let expected1: [[Float]] =  [[23.0] + [0.0] * 99]

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 100,
                                          .hopSize: 60,
                                          .startFromZero: true], input: 23..<24),
                   expected1)

    var expected2: [[Float]] = [[0.0] * 100]
    expected2[0][50] = 23

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 100,
                                          .hopSize: 60,
                                          .startFromZero: false], input: 23..<24),
                   expected2)

    /*
     Test last frame.
     */

    let expected3: [[Float]] = [0..<100]

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 100,
                                          .hopSize: 60,
                                          .startFromZero: true], input: 0..<100),
                   expected3)

    let expected4: [[Float]] = [0..<100 as [Float] + [0.0]]

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 101,
                                          .hopSize: 60,
                                          .startFromZero: true], input: 0..<100),
                   expected4)

    var expected5: [[Float]] = [[0.0] * 50, 10..<100 as [Float], 70..<100 as [Float]]
    expected5[0] += 0..<50
    expected5[1] += [0.0] * 10
    expected5[2] += [0.0] * 70

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 100,
                                          .hopSize: 60,
                                          .startFromZero: false], input: 0..<100),
                   expected5)

    var expected6: [[Float]] = [[0.0] * 51, 9..<100 as [Float], 69..<100 as [Float]]
    expected6[0] += 0..<51
    expected6[1] += [0.0] * 11
    expected6[2] += [0.0] * 71

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 102,
                                          .hopSize: 60,
                                          .startFromZero: false], input: 0..<100),
                   expected6)

    var expected29: [[Float]] = [[0.0] * 51, 9..<100 as [Float], 69..<100 as [Float]]
    expected29[0] += 0..<50
    expected29[1] += [0.0] * 10
    expected29[2] += [0.0] * 70

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 101,
                                          .hopSize: 60,
                                          .startFromZero: false], input: 0..<100),
                   expected29)

    /*
     Test with a big hop size.
     */

    let expected7: [[Float]] = [0..<20]

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 20,
                                          .hopSize: 100,
                                          .startFromZero: true], input: 0..<100),
                   expected7)

    var expected8: [[Float]] = [0..<20, 40..<60, 80..<100]

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 20,
                                          .hopSize: 40,
                                          .startFromZero: true], input: 0..<100),
                   expected8)

    var expected9: [[Float]] = [[0.0] * 10, 90..<100 as [Float]]
    expected9[0] += 0..<10
    expected9[1] += [0.0] * 10

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 20,
                                          .hopSize: 100,
                                          .startFromZero: false], input: 0..<100),
                   expected9)

    var expected28: [[Float]] = [[0.0] * 10, 30..<50 as [Float], 70..<90 as [Float]]
    expected28[0] += 0..<10

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 20,
                                          .hopSize: 40,
                                          .startFromZero: false], input: 0..<100),
                   expected28)

    /*
     Test more complex cases.
     */

    let expected10: [[Float]] = [[1, 2, 3], [3, 4, 5]]

    XCTAssertEqual(cutFrames(parameters: [ .frameSize: 3,
                                           .hopSize: 2,
                                           .startFromZero: true], input: 1..<6),
                   expected10)

    let expected11: [[Float]] = [[1, 2], [2, 3]]

    XCTAssertEqual(cutFrames(parameters: [ .frameSize: 2,
                                           .hopSize: 1,
                                           .startFromZero: true], input: 1..<4),
                   expected11)

    let expected12: [[Float]] = [[0, 0, 1], [1, 2, 3], [3, 4, 5], [5, 0, 0]]

    XCTAssertEqual(cutFrames(parameters: [ .frameSize: 3,
                                           .hopSize: 2,
                                           .startFromZero: false], input: 1..<6),
                   expected12)

   let expected13: [[Float]] = [[0, 1], [1, 2], [2, 3], [3, 0]]

    XCTAssertEqual(cutFrames(parameters: [ .frameSize: 2,
                                           .hopSize: 1,
                                           .startFromZero: false], input: 1..<4),
                   expected13)


    /*
     Test dropping last frame when starting from zero and provided an even frame size.
     */

    let expected14: [[Float]] = [1..<11, 11..<21, 21..<31, 31..<41, 41..<51]

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 10,
                                          .hopSize: 10,
                                          .startFromZero: true,
                                          .validFrameThresholdRatio: 1], input: 1..<60),
                   expected14)

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 10,
                                          .hopSize: 10,
                                          .startFromZero: true,
                                          .validFrameThresholdRatio: 0.9], input: 1..<59),
                   expected14)

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 10,
                                          .hopSize: 10,
                                          .startFromZero: true,
                                          .validFrameThresholdRatio: 0.2], input: 1..<52),
                   expected14)

    /*
     Test not dropping last frame when starting from zero and provided an even frame size.
     */

    let expected15: [[Float]] = [1..<11, 11..<21, 21..<31, 31..<41, 41..<51, 51..<61]

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 10,
                                          .hopSize: 10,
                                          .startFromZero: true,
                                          .validFrameThresholdRatio: 1], input: 1..<61),
                   expected15)

    let expected16: [[Float]] = [1..<11, 11..<21, 21..<31, 31..<41,
                                 41..<51, 51..<60 as [Float] + [0]]

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 10,
                                          .hopSize: 10,
                                          .startFromZero: true,
                                          .validFrameThresholdRatio: 0.9], input: 1..<60),
                   expected16)

    let expected17: [[Float]] = [1..<11, 11..<21, 21..<31, 31..<41,
                                 41..<51, [51, 52, 0, 0, 0, 0, 0, 0, 0, 0]]

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 10,
                                          .hopSize: 10,
                                          .startFromZero: true,
                                          .validFrameThresholdRatio: 0.2], input: 1..<53),
                   expected17)

    /*
     Test dropping last frame starting from zero and provided an odd frame size.
     */

    let expected18: [[Float]] = [1..<12, 12..<23, 23..<34, 34..<45, 45..<56]

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 11,
                                          .hopSize: 11,
                                          .startFromZero: true,
                                          .validFrameThresholdRatio: 1], input: 1..<66),
                   expected18)

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 11,
                                          .hopSize: 11,
                                          .startFromZero: true,
                                          .validFrameThresholdRatio: 0.9], input: 1..<65),
                   expected18)

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 11,
                                          .hopSize: 11,
                                          .startFromZero: true,
                                          .validFrameThresholdRatio: 0.2], input: 1..<57),
                   expected18)

    /*
     Test not dropping last frame starting from zero and provided an odd frame size.
     */

    let expected19: [[Float]] = [1..<12, 12..<23, 23..<34, 34..<45, 45..<56, 56..<67]

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 11,
                                          .hopSize: 11,
                                          .startFromZero: true,
                                          .validFrameThresholdRatio: 1], input: 1..<67),
                   expected19)

    let expected20: [[Float]] = [1..<12, 12..<23, 23..<34,
                                 34..<45, 45..<56, 56..<66 as [Float] + [0]]

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 11,
                                          .hopSize: 11,
                                          .startFromZero: true,
                                          .validFrameThresholdRatio: 0.9], input: 1..<66),
                   expected20)

    let expected21: [[Float]] = [1..<12, 12..<23, 23..<34,
                                 34..<45, 45..<56, [56, 57, 58, 0, 0, 0, 0, 0, 0, 0, 0]]

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 11,
                                          .hopSize: 11,
                                          .startFromZero: true,
                                          .validFrameThresholdRatio: 0.2], input: 1..<59),
                   expected21)

    /*
     Test dropping last frame when not starting from zero and provided an even frame size.
     */

    let expected22: [[Float]] = [[0, 0, 0, 0, 0, 1, 2, 3, 4, 5], 6..<16,
                                 16..<26, 26..<36, 36..<46, 46..<56]

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 10,
                                          .hopSize: 10,
                                          .startFromZero: false,
                                          .validFrameThresholdRatio: 0.5], input: 1..<60),
                   expected22)

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 10,
                                          .hopSize: 10,
                                          .startFromZero: false,
                                          .validFrameThresholdRatio: 0.2], input: 1..<57),
                   expected22)

    /*
     Test not dropping last frame when not starting from zero and provided an even frame size.
     */

    let expected23: [[Float]] = [[0, 0, 0, 0, 0, 1, 2, 3, 4, 5], 6..<16, 16..<26,
                                 26..<36, 36..<46, 46..<56, [56, 57, 58, 59, 60, 0, 0, 0, 0, 0]]

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 10,
                                          .hopSize: 10,
                                          .startFromZero: false,
                                          .validFrameThresholdRatio: 0.5], input: 1..<61),
                   expected23)

    let expected24: [[Float]] = [[0, 0, 0, 0, 0, 1, 2, 3, 4, 5], 6..<16, 16..<26,
                                 26..<36, 36..<46, 46..<56, [56, 57, 0, 0, 0, 0, 0, 0, 0, 0]]

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 10,
                                          .hopSize: 10,
                                          .startFromZero: false,
                                          .validFrameThresholdRatio: 0.2], input: 1..<58),
                   expected24)

    /*
     Test dropping last frame when not starting from zero and provided an odd frame size.
     */

    let expected25: [[Float]] = [[0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5], 6..<17,
                                 17..<28, 28..<39, 39..<50]

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 11,
                                          .hopSize: 11,
                                          .startFromZero: false,
                                          .validFrameThresholdRatio: 0.5], input: 1..<55),
                   expected25)

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 11,
                                          .hopSize: 11,
                                          .startFromZero: false,
                                          .validFrameThresholdRatio: 0.2], input: 1..<51),
                   expected25)

    /*
     Test not dropping last frame when not starting from zero and provided an odd frame size.
     */

    let expected26: [[Float]] = [[0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5], 6..<17, 17..<28,
                                 28..<39, 39..<50, [50, 51, 52, 53, 54, 55, 0, 0, 0, 0, 0]]

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 11,
                                          .hopSize: 11,
                                          .startFromZero: false,
                                          .validFrameThresholdRatio: 0.5], input: 1..<56),
                   expected26)

    let expected27: [[Float]] = [[0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5], 6..<17, 17..<28,
                                 28..<39, 39..<50, [50, 51, 52, 0, 0, 0, 0, 0, 0, 0, 0]]

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 11,
                                          .hopSize: 11,
                                          .startFromZero: false,
                                          .validFrameThresholdRatio: 0.2], input: 1..<53),
                   expected27)

    /*
     Test end of file.
     Note: I believe the tests in `test_framecutter.py` are incorrect here because of a bug
           introduced by the `FrameGenerator` class used to wrap `FrameCutter` with an
           iterator interface. An additional frame has been added to each array of expected
           frames to correctly test the cut frames .When the `FrameCutter` algorithm is used
           directly it produces the same results as below.
     */

    let expected30: [[Float]] = [[1, 2, 3], [3, 4, 5], [5, 0, 0]]

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 3,
                                          .hopSize: 2,
                                          .startFromZero: true,
                                          .lastFrameToEndOfFile: true], input: 1..<6),
                   expected30)

    let expected31: [[Float]] = [[1, 2], [2, 3], [3, 0]]

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 2,
                                          .hopSize: 1,
                                          .startFromZero: true,
                                          .lastFrameToEndOfFile: true], input: 1..<4),
                   expected31)

    let expected32: [[Float]] = [[1, 2], [4, 5]]

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 2,
                                          .hopSize: 3,
                                          .startFromZero: true,
                                          .lastFrameToEndOfFile: true], input: 1..<6),
                   expected32)

    let expected33: [[Float]] = [[1, 2], [4, 5], [7, 0]]

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 2,
                                          .hopSize: 3,
                                          .startFromZero: true,
                                          .lastFrameToEndOfFile: true], input: 1..<8),
                   expected33)

    let expected34: [[Float]] = [[1, 2, 3, 4], [3, 4, 5, 6], [5, 6, 7, 0], [7, 0, 0, 0]]

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 4,
                                          .hopSize: 2,
                                          .startFromZero: true,
                                          .lastFrameToEndOfFile: true], input: 1..<8),
                   expected34)

    /// Helper that loads an audio file, cuts it using the specified parameters and returns
    /// the total number of frames cut.
    ///
    /// - Parameters:
    ///   - url: The URL for the audio file to cut.
    ///   - parameters: The parameters to use when cutting the audio file.
    /// - Returns: The total number of frames cut.
    func cutAudioFile(url: URL, parameters: [Standard.FrameCutter.Parameter:Parameter]) -> Int {
      return cutFrames(parameters: parameters, input: monoBufferData(url: url)).count
    }

    /*
     Test short audio files with a normal hop size.
     */

    XCTAssertEqual(cutAudioFile(url: bundleURL(name: "1024_samples", ext: "wav"),
                                parameters: [.frameSize: 512,
                                             .hopSize: 256,
                                             .startFromZero: true]),
                   3)

    XCTAssertEqual(cutAudioFile(url: bundleURL(name: "1989_samples", ext: "wav"),
                                parameters: [.frameSize: 512,
                                             .hopSize: 256,
                                             .startFromZero: true]),
                   7)

    XCTAssertEqual(cutAudioFile(url: bundleURL(name: "1024_samples", ext: "wav"),
                                parameters: [.frameSize: 512,
                                             .hopSize: 256,
                                             .startFromZero: false]),
                   5)

    XCTAssertEqual(cutAudioFile(url: bundleURL(name: "1989_samples", ext: "wav"),
                                parameters: [.frameSize: 512,
                                             .hopSize: 256,
                                             .startFromZero: false]),
                   9)

    /*
     Test short audio files with a hop size larger than the frame size.
     */

    XCTAssertEqual(cutAudioFile(url: bundleURL(name: "1024_samples", ext: "wav"),
                                parameters: [.frameSize: 256,
                                             .hopSize: 512,
                                             .startFromZero: true]),
                   2)

    XCTAssertEqual(cutAudioFile(url: bundleURL(name: "1989_samples", ext: "wav"),
                                parameters: [.frameSize: 256,
                                             .hopSize: 512,
                                             .startFromZero: true]),
                   4)

    XCTAssertEqual(cutAudioFile(url: bundleURL(name: "1024_samples", ext: "wav"),
                                parameters: [.frameSize: 256,
                                             .hopSize: 512,
                                             .startFromZero: false]),
                   3)

    XCTAssertEqual(cutAudioFile(url: bundleURL(name: "1989_samples", ext: "wav"),
                                parameters: [.frameSize: 256,
                                             .hopSize: 512,
                                             .startFromZero: false]),
                   5)

    /*
     Test short audio files with a hop size that passes the end of the stream.
     */

    XCTAssertEqual(cutAudioFile(url: bundleURL(name: "1024_samples", ext: "wav"),
                                parameters: [.frameSize: 512,
                                             .hopSize: 8192,
                                             .startFromZero: true]),
                   1)

    XCTAssertEqual(cutAudioFile(url: bundleURL(name: "1989_samples", ext: "wav"),
                                parameters: [.frameSize: 512,
                                             .hopSize: 8192,
                                             .startFromZero: true]),
                   1)

    XCTAssertEqual(cutAudioFile(url: bundleURL(name: "1024_samples", ext: "wav"),
                                parameters: [.frameSize: 512,
                                             .hopSize: 8192,
                                             .startFromZero: false]),
                   1)

    XCTAssertEqual(cutAudioFile(url: bundleURL(name: "1989_samples", ext: "wav"),
                                parameters: [.frameSize: 512,
                                             .hopSize: 8192,
                                             .startFromZero: false]),
                   1)

  }

  /// Tests the functionality of the FrameCutter algorithm in streaming mode. Values taken
  /// from `test_framecutter_streaming.py`.
  func testStreamingFrameCutter() {

    /// Helper that uses the specified options and range to generate an input signal to
    /// run through the `FrameCutter` algorithm.
    ///
    /// - Parameters:
    ///   - parameters: The parameters with which to configure the frame cutter.
    ///   - input: The range that will be converted into an input signal to be cut.
    /// - Returns: The resulting frames.
    func cutFrames(parameters: [Streaming.FrameCutter.Parameter:Parameter],
                   input: [Float]) -> [[Float]]
    {

      let vectorInput = VectorInput<Float>(input)

      var parameters = parameters
      if parameters[.validFrameThresholdRatio] == nil { parameters[.validFrameThresholdRatio] = 0 }
      let frameCutter = FrameCutterSAlgorithm(parameters)

      let vectorOutput = VectorOutput<[Float]>()

      vectorInput[output: .data] >> frameCutter[input: .signal]
      frameCutter[output: .frame] >> vectorOutput[input: .data]

      let network = Network(generator: vectorInput)
      network.run()

      return vectorOutput.vector

    }

    /*
     Test with an empty input signal.
     */

    XCTAssert(cutFrames(parameters: [.frameSize: 100,
                                     .hopSize: 60,
                                     .startFromZero: false], input: 0..<0).isEmpty)

    XCTAssert(cutFrames(parameters: [.frameSize: 100,
                                     .hopSize: 60,
                                     .startFromZero: true], input: 0..<0).isEmpty)

    /*
     Test with a single sample.
     */

    let expected1: [[Float]] =  [[23.0] + [0.0] * 99]

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 100,
                                          .hopSize: 60,
                                          .startFromZero: true], input: 23..<24),
                   expected1)

    var expected2: [[Float]] = [[0.0] * 100]
    expected2[0][50] = 23

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 100,
                                          .hopSize: 60,
                                          .startFromZero: false], input: 23..<24),
                   expected2)

    /*
     Test last frame.
     */

    let expected3: [[Float]] = [0..<100]

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 100,
                                          .hopSize: 60,
                                          .startFromZero: true], input: 0..<100),
                   expected3)

    let expected4: [[Float]] = [0..<100 as [Float] + [0.0]]

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 101,
                                          .hopSize: 60,
                                          .startFromZero: true], input: 0..<100),
                   expected4)

    var expected5: [[Float]] = [[0.0] * 50, 10..<100 as [Float], 70..<100 as [Float]]
    expected5[0] += 0..<50
    expected5[1] += [0.0] * 10
    expected5[2] += [0.0] * 70

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 100,
                                          .hopSize: 60,
                                          .startFromZero: false], input: 0..<100),
                   expected5)

    var expected6: [[Float]] = [[0.0] * 51, 9..<100 as [Float], 69..<100 as [Float]]
    expected6[0] += 0..<51
    expected6[1] += [0.0] * 11
    expected6[2] += [0.0] * 71

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 102,
                                          .hopSize: 60,
                                          .startFromZero: false], input: 0..<100),
                   expected6)

    /*
     Test with a big hop size.
     */

    let expected7: [[Float]] = [0..<20]

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 20,
                                          .hopSize: 100,
                                          .startFromZero: true], input: 0..<100),
                   expected7)

    var expected8: [[Float]] = [0..<20, [99]]
    expected8[1] +=  [0.0] * 19

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 20,
                                          .hopSize: 99,
                                          .startFromZero: true], input: 0..<100),
                   expected8)

    var expected9: [[Float]] = [[0.0] * 10, 90..<100 as [Float]]
    expected9[0] += 0..<10
    expected9[1] += [0.0] * 10

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 20,
                                          .hopSize: 100,
                                          .startFromZero: false], input: 0..<100),
                   expected9)

    /*
     Test more complex cases.
     */

    let expected10: [[Float]] = [[1, 2, 3], [3, 4, 5]]

    XCTAssertEqual(cutFrames(parameters: [ .frameSize: 3,
                                           .hopSize: 2,
                                           .startFromZero: true], input: 1..<6),
                   expected10)

    let expected11: [[Float]] = [[1, 2], [2, 3]]

    XCTAssertEqual(cutFrames(parameters: [ .frameSize: 2,
                                           .hopSize: 1,
                                           .startFromZero: true], input: 1..<4),
                   expected11)

    let expected12: [[Float]] = [[0, 0, 1], [1, 2, 3], [3, 4, 5], [5, 0, 0]]

    XCTAssertEqual(cutFrames(parameters: [ .frameSize: 3,
                                           .hopSize: 2,
                                           .startFromZero: false], input: 1..<6),
                   expected12)

    let expected13: [[Float]] = [[0, 1], [1, 2], [2, 3], [3, 0]]

    XCTAssertEqual(cutFrames(parameters: [ .frameSize: 2,
                                           .hopSize: 1,
                                           .startFromZero: false], input: 1..<4),
                   expected13)

    /*
     Test dropping last frame when starting from zero and provided an even frame size.
     */

    let expected14: [[Float]] = [1..<11, 11..<21, 21..<31, 31..<41, 41..<51]

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 10,
                                          .hopSize: 10,
                                          .startFromZero: true,
                                          .validFrameThresholdRatio: 1], input: 1..<60),
                   expected14)

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 10,
                                          .hopSize: 10,
                                          .startFromZero: true,
                                          .validFrameThresholdRatio: 0.9], input: 1..<59),
                   expected14)

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 10,
                                          .hopSize: 10,
                                          .startFromZero: true,
                                          .validFrameThresholdRatio: 0.2], input: 1..<52),
                   expected14)

    /*
     Test not dropping last frame when starting from zero and provided an even frame size.
     */

    let expected15: [[Float]] = [1..<11, 11..<21, 21..<31, 31..<41, 41..<51, 51..<61]

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 10,
                                          .hopSize: 10,
                                          .startFromZero: true,
                                          .validFrameThresholdRatio: 1], input: 1..<61),
                   expected15)

    let expected16: [[Float]] = [1..<11, 11..<21, 21..<31, 31..<41,
                                 41..<51, 51..<60 as [Float] + [0]]

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 10,
                                          .hopSize: 10,
                                          .startFromZero: true,
                                          .validFrameThresholdRatio: 0.9], input: 1..<60),
                   expected16)

    let expected17: [[Float]] = [1..<11, 11..<21, 21..<31, 31..<41,
                                 41..<51, [51, 52, 0, 0, 0, 0, 0, 0, 0, 0]]

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 10,
                                          .hopSize: 10,
                                          .startFromZero: true,
                                          .validFrameThresholdRatio: 0.2], input: 1..<53),
                   expected17)

    /*
     Test dropping last frame starting from zero and provided an odd frame size.
     */

    let expected18: [[Float]] = [1..<12, 12..<23, 23..<34, 34..<45, 45..<56]

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 11,
                                          .hopSize: 11,
                                          .startFromZero: true,
                                          .validFrameThresholdRatio: 1], input: 1..<66),
                   expected18)

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 11,
                                          .hopSize: 11,
                                          .startFromZero: true,
                                          .validFrameThresholdRatio: 0.9], input: 1..<65),
                   expected18)

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 11,
                                          .hopSize: 11,
                                          .startFromZero: true,
                                          .validFrameThresholdRatio: 0.2], input: 1..<57),
                   expected18)

    /*
     Test not dropping last frame starting from zero and provided an odd frame size.
     */

    let expected19: [[Float]] = [1..<12, 12..<23, 23..<34, 34..<45, 45..<56, 56..<67]

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 11,
                                          .hopSize: 11,
                                          .startFromZero: true,
                                          .validFrameThresholdRatio: 1], input: 1..<67),
                   expected19)

    let expected20: [[Float]] = [1..<12, 12..<23, 23..<34,
                                 34..<45, 45..<56, 56..<66 as [Float] + [0]]

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 11,
                                          .hopSize: 11,
                                          .startFromZero: true,
                                          .validFrameThresholdRatio: 0.9], input: 1..<66),
                   expected20)

    let expected21: [[Float]] = [1..<12, 12..<23, 23..<34,
                                 34..<45, 45..<56, [56, 57, 58, 0, 0, 0, 0, 0, 0, 0, 0]]

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 11,
                                          .hopSize: 11,
                                          .startFromZero: true,
                                          .validFrameThresholdRatio: 0.2], input: 1..<59),
                   expected21)

    /*
     Test dropping last frame when not starting from zero and provided an even frame size.
     */

    let expected22: [[Float]] = [[0, 0, 0, 0, 0, 1, 2, 3, 4, 5], 6..<16,
                                 16..<26, 26..<36, 36..<46, 46..<56]

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 10,
                                          .hopSize: 10,
                                          .startFromZero: false,
                                          .validFrameThresholdRatio: 0.5], input: 1..<60),
                   expected22)

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 10,
                                          .hopSize: 10,
                                          .startFromZero: false,
                                          .validFrameThresholdRatio: 0.2], input: 1..<57),
                   expected22)

    /*
     Test not dropping last frame when not starting from zero and provided an even frame size.
     */

    let expected23: [[Float]] = [[0, 0, 0, 0, 0, 1, 2, 3, 4, 5], 6..<16, 16..<26,
                                 26..<36, 36..<46, 46..<56, [56, 57, 58, 59, 60, 0, 0, 0, 0, 0]]

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 10,
                                          .hopSize: 10,
                                          .startFromZero: false,
                                          .validFrameThresholdRatio: 0.5], input: 1..<61),
                   expected23)

    let expected24: [[Float]] = [[0, 0, 0, 0, 0, 1, 2, 3, 4, 5], 6..<16, 16..<26,
                                 26..<36, 36..<46, 46..<56, [56, 57, 0, 0, 0, 0, 0, 0, 0, 0]]

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 10,
                                          .hopSize: 10,
                                          .startFromZero: false,
                                          .validFrameThresholdRatio: 0.2], input: 1..<58),
                   expected24)

    /*
     Test dropping last frame when not starting from zero and provided an odd frame size.
     */

    let expected25: [[Float]] = [[0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5], 6..<17,
                                 17..<28, 28..<39, 39..<50]

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 11,
                                          .hopSize: 11,
                                          .startFromZero: false,
                                          .validFrameThresholdRatio: 0.5], input: 1..<55),
                   expected25)

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 11,
                                          .hopSize: 11,
                                          .startFromZero: false,
                                          .validFrameThresholdRatio: 0.2], input: 1..<51),
                   expected25)

    /*
     Test not dropping last frame when not starting from zero and provided an odd frame size.
     */

    let expected26: [[Float]] = [[0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5], 6..<17, 17..<28,
                                 28..<39, 39..<50, [50, 51, 52, 53, 54, 55, 0, 0, 0, 0, 0]]

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 11,
                                          .hopSize: 11,
                                          .startFromZero: false,
                                          .validFrameThresholdRatio: 0.5], input: 1..<56),
                   expected26)

    let expected27: [[Float]] = [[0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5], 6..<17, 17..<28,
                                 28..<39, 39..<50, [50, 51, 52, 0, 0, 0, 0, 0, 0, 0, 0]]

    XCTAssertEqual(cutFrames(parameters: [.frameSize: 11,
                                          .hopSize: 11,
                                          .startFromZero: false,
                                          .validFrameThresholdRatio: 0.2], input: 1..<53),
                   expected27)

    /// Helper that loads an audio file, cuts it using the specified parameters and returns
    /// the total number of frames cut.
    ///
    /// - Parameters:
    ///   - url: The URL for the audio file to cut.
    ///   - parameters: The parameters to use when cutting the audio file.
    /// - Returns: The total number of frames cut.
    func cutAudioFile(url: URL, parameters: [Streaming.FrameCutter.Parameter:Parameter]) -> Int {

      let vectorInput = VectorInput<Float>(monoBufferData(url: url))
      let frameCutter = FrameCutterSAlgorithm(parameters)
      let vectorOutput = VectorOutput<[Float]>()

      vectorInput[output: .data] >> frameCutter[input: .signal]
      frameCutter[output: .frame] >> vectorOutput[input: .data]

      let network = Network(generator: vectorInput)
      network.run()

      return vectorOutput.vector.count

    }

    /*
     Test short audio files with a normal hop size.
     */

    XCTAssertEqual(cutAudioFile(url: bundleURL(name: "1024_samples", ext: "wav"),
                                parameters: [.frameSize: 512,
                                             .hopSize: 256,
                                             .startFromZero: true]),
                   3)

    XCTAssertEqual(cutAudioFile(url: bundleURL(name: "1989_samples", ext: "wav"),
                                parameters: [.frameSize: 512,
                                             .hopSize: 256,
                                             .startFromZero: true]),
                   7)

    XCTAssertEqual(cutAudioFile(url: bundleURL(name: "1024_samples", ext: "wav"),
                                parameters: [.frameSize: 512,
                                             .hopSize: 256,
                                             .startFromZero: false]),
                   5)

    XCTAssertEqual(cutAudioFile(url: bundleURL(name: "1989_samples", ext: "wav"),
                                parameters: [.frameSize: 512,
                                             .hopSize: 256,
                                             .startFromZero: false]),
                   9)

    /*
     Test short audio files with a hop size larger than the frame size.
     */

    XCTAssertEqual(cutAudioFile(url: bundleURL(name: "1024_samples", ext: "wav"),
                                parameters: [.frameSize: 256,
                                             .hopSize: 512,
                                             .startFromZero: true]),
                   2)

    XCTAssertEqual(cutAudioFile(url: bundleURL(name: "1989_samples", ext: "wav"),
                                parameters: [.frameSize: 256,
                                             .hopSize: 512,
                                             .startFromZero: true]),
                   4)

    XCTAssertEqual(cutAudioFile(url: bundleURL(name: "1024_samples", ext: "wav"),
                                parameters: [.frameSize: 256,
                                             .hopSize: 512,
                                             .startFromZero: false]),
                   3)

    XCTAssertEqual(cutAudioFile(url: bundleURL(name: "1989_samples", ext: "wav"),
                                parameters: [.frameSize: 256,
                                             .hopSize: 512,
                                             .startFromZero: false]),
                   5)

    /*
     Test short audio files with a hop size that passes the end of the stream.
     */

    XCTAssertEqual(cutAudioFile(url: bundleURL(name: "1024_samples", ext: "wav"),
                                parameters: [.frameSize: 512,
                                             .hopSize: 8192,
                                             .startFromZero: true]),
                   1)

    XCTAssertEqual(cutAudioFile(url: bundleURL(name: "1989_samples", ext: "wav"),
                                parameters: [.frameSize: 512,
                                             .hopSize: 8192,
                                             .startFromZero: true]),
                   1)

    XCTAssertEqual(cutAudioFile(url: bundleURL(name: "1024_samples", ext: "wav"),
                                parameters: [.frameSize: 512,
                                             .hopSize: 8192,
                                             .startFromZero: false]),
                   1)

    XCTAssertEqual(cutAudioFile(url: bundleURL(name: "1989_samples", ext: "wav"),
                                parameters: [.frameSize: 512,
                                             .hopSize: 8192,
                                             .startFromZero: false]),
                   1)

    /// Helper for determining whether a frame is composed of nothing but silence.
    ///
    /// - Parameter frame: The frame to assess.
    /// - Returns: `true` if all values in `frame` are ≤ the silence threshold and `false`
    ///            otherwise.
    func isSilent(frame: [Float]) -> Bool {

      var max: Float = 0
      vDSP_maxv(frame, 1, &max, vDSP_Length(frame.count))

      return max <= 1e-9

    }

    /// Helper that computes the total energy for a given frame.
    ///
    /// - Parameter frames: The frame for which energy shall be computed.
    /// - Returns: The computed energy for `frame`.
    func energy(frame: [Float]) -> Float {

      let count = vDSP_Length(frame.count)

      var frameSquared: [Float] = [0.0] * frame.count
      vDSP_vsq(frame, 1, &frameSquared, 1, count)

      var sum: Float = 0
      vDSP_sve(frameSquared, 1, &sum, count)

      return sum

    }

    /*
     Test replacing silent frames with noise.
     */

    let vectorInput1 = VectorInput<Float>([0.0] * 3072)

    let frameCutter1 = FrameCutterSAlgorithm([
      .frameSize: 1024,
      .hopSize: 512,
      .startFromZero: true,
      .silentFrames: "noise"
      ])

    let vectorOutput1 = VectorOutput<[Float]>()

    vectorInput1[output: .data] >> frameCutter1[input: .signal]
    frameCutter1[output: .frame] >> vectorOutput1[input: .data]

    let network1 = Network(generator: vectorInput1)
    network1.run()

    let frames1 = vectorOutput1.vector

    XCTAssertEqual(frames1.count, 5)

    for frame in frames1 {
      XCTAssert(isSilent(frame: frame))
      XCTAssertGreaterThan(energy(frame: frame), 0)
    }

    /*
     Test keeping silent frames.
     */

    let vectorInput2 = VectorInput<Float>([0.0] * 3072)

    let frameCutter2 = FrameCutterSAlgorithm([
      .frameSize: 1024,
      .hopSize: 512,
      .startFromZero: true,
      .silentFrames: "keep"
      ])

    let vectorOutput2 = VectorOutput<[Float]>()

    vectorInput2[output: .data] >> frameCutter2[input: .signal]
    frameCutter2[output: .frame] >> vectorOutput2[input: .data]

    let network2 = Network(generator: vectorInput2)
    network2.run()

    let frames2 = vectorOutput2.vector

    XCTAssertEqual(frames2.count, 5)

    for frame in frames2 {
      XCTAssert(isSilent(frame: frame))
      XCTAssertEqual(energy(frame: frame), 0)
    }

    /*
     Test dropping silent frames.
     */

    let vectorInput3 = VectorInput<Float>([0.0] * 3072)

    let frameCutter3 = FrameCutterSAlgorithm([
      .frameSize: 1024,
      .hopSize: 512,
      .startFromZero: true,
      .silentFrames: "drop"
      ])

    let vectorOutput3 = VectorOutput<[Float]>()

    vectorInput3[output: .data] >> frameCutter3[input: .signal]
    frameCutter3[output: .frame] >> vectorOutput3[input: .data]

    let network3 = Network(generator: vectorInput3)
    network3.run()

    XCTAssertEqual(vectorOutput3.vector.count, 0)

  }
  
  /// Tests the functionality of the ConstantQ algorithm. Values taken from `test_constantq.py`.
  func testConstantQ() {

    /*
     Test for regression.
     */

    let constantQ = ConstantQAlgorithm()
    constantQ[complexRealVecInput: .frame] = loadComplexVector(name: "constantq_input")
    constantQ.compute()

    let actual = constantQ[complexRealVecOutput: .constantq]
    let expected = loadComplexVector(name: "constantq_expected")

    XCTAssertDifferenceMeanLessThanOrEqual(actual, expected, 1.131e-4)
    XCTAssertPercentDeviationLessThanOrEqual(actual, expected, 3e-3)
    
  }

  /// Tests the functionality of the PeakDetection algorithm. Values taken from
  /// `test_peakdetection.py`.
  func testPeakDetection() {

    /*
     Test with a peak at the beginning of the input.
     */

    let peakDetection1 = PeakDetectionAlgorithm([
      .range: 3, .maxPosition: 3, .minPosition: 0, .orderBy: "amplitude"
      ])

    peakDetection1[realVecInput: .array] = [1, 0, 0, 0]
    peakDetection1.compute()

    XCTAssertEqual(peakDetection1[realVecOutput: .positions], [0])
    XCTAssertEqual(peakDetection1[realVecOutput: .amplitudes], [1])


    /*
     Test with a peak at the min position.
     */

    let peakDetection2 = PeakDetectionAlgorithm([
      .range: 6, .maxPosition: 6, .minPosition: 3, .orderBy: "amplitude"
      ])

    peakDetection2[realVecInput: .array] = [0, 0, 0, 1, 0, 0, 0]
    peakDetection2.compute()

    XCTAssertEqual(peakDetection2[realVecOutput: .positions], [3])
    XCTAssertEqual(peakDetection2[realVecOutput: .amplitudes], [1])

    /*
     Test with a peak at zero.
     */

    let peakDetection3 = PeakDetectionAlgorithm([
      .range: 4, .maxPosition: 4, .orderBy: "amplitude"
      ])

    peakDetection3[realVecInput: .array] = [1, 0, 0, 0, 0]
    peakDetection3.compute()

    XCTAssertEqual(peakDetection3[realVecOutput: .positions], [0])
    XCTAssertEqual(peakDetection3[realVecOutput: .amplitudes], [1])

    /*
     Test with a peak at one.
     */

    let peakDetection4 = PeakDetectionAlgorithm([
      .range: 4, .maxPosition: 4, .orderBy: "amplitude"
      ])

    peakDetection4[realVecInput: .array] = [0, 1, 0, 0, 0]
    peakDetection4.compute()

    XCTAssertEqual(peakDetection4[realVecOutput: .positions], [1])
    XCTAssertEqual(peakDetection4[realVecOutput: .amplitudes], [1])

    /*
     Test with a peak at two.
     */

    let peakDetection5 = PeakDetectionAlgorithm([
      .range: 4, .maxPosition: 4, .orderBy: "amplitude"
      ])

    peakDetection5[realVecInput: .array] = [0, 0, 1, 0, 0]
    peakDetection5.compute()

    XCTAssertEqual(peakDetection5[realVecOutput: .positions], [2])
    XCTAssertEqual(peakDetection5[realVecOutput: .amplitudes], [1])

    /*
     Test with a peak at three.
     */

    let peakDetection6 = PeakDetectionAlgorithm([
      .range: 4, .maxPosition: 4, .orderBy: "amplitude"
      ])

    peakDetection6[realVecInput: .array] = [0, 0, 0, 1, 0]
    peakDetection6.compute()

    XCTAssertEqual(peakDetection6[realVecOutput: .positions], [3])
    XCTAssertEqual(peakDetection6[realVecOutput: .amplitudes], [1])

    /*
     Test with a peak at four.
     */

    let peakDetection7 = PeakDetectionAlgorithm([
      .range: 4, .maxPosition: 4, .orderBy: "amplitude"
      ])

    peakDetection7[realVecInput: .array] = [0, 0, 0, 0, 1]
    peakDetection7.compute()

    XCTAssertEqual(peakDetection7[realVecOutput: .positions], [4])
    XCTAssertEqual(peakDetection7[realVecOutput: .amplitudes], [1])

    /*
     Test with a peak just before the end.
     */

    let peakDetection8 = PeakDetectionAlgorithm([
      .range: 4, .maxPosition: 4, .orderBy: "amplitude"
      ])

    peakDetection8[realVecInput: .array] = [0, 0, 0, 1, 0]
    peakDetection8.compute()

    XCTAssertEqual(peakDetection8[realVecOutput: .positions], [3])
    XCTAssertEqual(peakDetection8[realVecOutput: .amplitudes], [1])

    /*
     Test with a peak at max position.
     */

    let peakDetection9 = PeakDetectionAlgorithm([
      .range: 6, .maxPosition: 3, .orderBy: "amplitude"
      ])

    peakDetection9[realVecInput: .array] = [0, 0, 0, 1, 0, 0, 0]
    peakDetection9.compute()

    XCTAssertEqual(peakDetection9[realVecOutput: .positions], [3])
    XCTAssertEqual(peakDetection9[realVecOutput: .amplitudes], [1])

    /*
     Test with a peak at the very end.
     */

    let peakDetection10 = PeakDetectionAlgorithm([
      .range: 6, .maxPosition: 6, .orderBy: "amplitude"
      ])

    peakDetection10[realVecInput: .array] = [0, 0, 0, 0, 0, 0, 1]
    peakDetection10.compute()

    XCTAssertEqual(peakDetection10[realVecOutput: .positions], [6])
    XCTAssertEqual(peakDetection10[realVecOutput: .amplitudes], [1])

    /*
     Test with a max position larger than the size of the input.
     */

    let peakDetection11 = PeakDetectionAlgorithm([
      .range: 6, .maxPosition: 30, .orderBy: "amplitude"
      ])

    peakDetection11[realVecInput: .array] = [0, 0, 0, 1, 0, 0, 0]
    peakDetection11.compute()

    XCTAssertEqual(peakDetection11[realVecOutput: .positions], [3])
    XCTAssertEqual(peakDetection11[realVecOutput: .amplitudes], [1])

    /*
     Test for regression with a single peak..
     */

    let peakDetection12 = PeakDetectionAlgorithm([
      .range: 1023, .maxPosition: 1024, .minPosition: 0, .orderBy: "amplitude"
      ])

    peakDetection12[realVecInput: .array] = [0, 0, 0, 1] + [0.0] * 1020 as [Float]
    peakDetection12.compute()

    XCTAssertEqual(peakDetection12[realVecOutput: .positions], [3])
    XCTAssertEqual(peakDetection12[realVecOutput: .amplitudes], [1])

    /*
     Test for regression with two peaks ordered by amplitude.
     */

    let peakDetection13 = PeakDetectionAlgorithm([
      .range: 1023, .maxPosition: 1024, .minPosition: 0, .orderBy: "amplitude"
      ])

    peakDetection13[realVecInput: .array] = [0, 0, 0, 1] + [0.0] * 508 as [Float]
                                          + [3] + [0.0] * 511 as [Float]
    peakDetection13.compute()

    XCTAssertEqual(peakDetection13[realVecOutput: .positions], [512, 3])
    XCTAssertEqual(peakDetection13[realVecOutput: .amplitudes], [3, 1])

    /*
     Test for regression with two peaks ordered by position.
     */

    let peakDetection14 = PeakDetectionAlgorithm([
      .range: 1023, .maxPosition: 1024, .minPosition: 0, .orderBy: "position"
      ])

    peakDetection14[realVecInput: .array] = [0, 0, 0, 1] + [0.0] * 508 as [Float]
                                          + [3] + [0.0] * 511 as [Float]
    peakDetection14.compute()

    XCTAssertEqual(peakDetection14[realVecOutput: .positions], [3, 512])
    XCTAssertEqual(peakDetection14[realVecOutput: .amplitudes], [1, 3])

    /*
     Test a plateau with interpolation.
     */

    let peakDetection15 = PeakDetectionAlgorithm([
      .range: 1023, .maxPosition: 1024, .minPosition: 0, .orderBy: "amplitude", .interpolate: true
      ])

    peakDetection15[realVecInput: .array] = [0, 0, 0, 1, 1, 1, 1] + [0.0] * 1017 as [Float]
    peakDetection15.compute()

    XCTAssertEqual(peakDetection15[realVecOutput: .positions], [4.5])
    XCTAssertEqual(peakDetection15[realVecOutput: .amplitudes], [1])

    /*
     Test a plateau without interpolation.
     */

    let peakDetection16 = PeakDetectionAlgorithm([
      .range: 1023, .maxPosition: 1024, .minPosition: 0, .orderBy: "amplitude", .interpolate: false
      ])

    peakDetection16[realVecInput: .array] = [0, 0, 0, 1, 1, 1, 1] + [0.0] * 1017 as [Float]
    peakDetection16.compute()

    XCTAssertEqual(peakDetection16[realVecOutput: .positions], [3])
    XCTAssertEqual(peakDetection16[realVecOutput: .amplitudes], [1])

    /*
     Test with staircase-shaped input.
     */

    let peakDetection17 = PeakDetectionAlgorithm([
      .range: 1023, .maxPosition: 1024, .minPosition: 0, .orderBy: "amplitude", .interpolate: false
      ])

    peakDetection17[realVecInput: .array] = [0, 0, 0]
                                          + [1.0] * 4 as [Float]
                                          + [2.0] * 7 as [Float]
                                          + [3.0] * 6 as [Float]
                                          + [0.0] * 1004 as [Float]
    peakDetection17.compute()

    XCTAssertEqual(peakDetection17[realVecOutput: .positions], [14])
    XCTAssertEqual(peakDetection17[realVecOutput: .amplitudes], [3])

    /*
     Test without a peak in the input.
     */

    let peakDetection18 = PeakDetectionAlgorithm()

    peakDetection18[realVecInput: .array] = [0.0] * 1024
    peakDetection18.compute()

    XCTAssert(peakDetection18[realVecOutput: .positions].isEmpty)
    XCTAssert(peakDetection18[realVecOutput: .amplitudes].isEmpty)

  }

  /// Tests the functionality of the AutoCorrelation algorithm. Values taken from
  /// `test_autocorrelation.py`.
  func testAutoCorrelation() {

    /*
     Test for regression.
     */

    let autoCorrelation1 = AutoCorrelationAlgorithm()
    autoCorrelation1[realVecInput: .array] = loadVector(name: "autocorrelation_input_pow2")
    autoCorrelation1.compute()

    XCTAssertEqual(autoCorrelation1[realVecOutput: .autoCorrelation],
                   loadVector(name: "autocorrelation_output"),
                   accuracy: 1e-4)

    /*
    Test with non power of 2.
     */

    let autoCorrelation2 = AutoCorrelationAlgorithm()
    autoCorrelation2[realVecInput: .array] =
      Array(loadVector(name: "autocorrelation_octave_input")[..<234])
    autoCorrelation2.compute()

    XCTAssertEqual(autoCorrelation2[realVecOutput: .autoCorrelation],
                   loadVector(name: "autocorrelation_output_nonpow2"),
                   accuracy: 1e-4)


    /*
     Test with octave.
     */

    let autoCorrelation3 = AutoCorrelationAlgorithm()
    autoCorrelation3[realVecInput: .array] = loadVector(name: "autocorrelation_octave_input")
    autoCorrelation3.compute()

    XCTAssertEqual(autoCorrelation3[realVecOutput: .autoCorrelation],
                   loadVector(name: "autocorrelation_octave_output"),
                   accuracy: 1e-4)

    /*
     Test with all-zero input.
     */

    let autoCorrelation4 = AutoCorrelationAlgorithm()
    autoCorrelation4[realVecInput: .array] = [0.0] * 1024
    autoCorrelation4.compute()

    XCTAssertEqual(autoCorrelation4[realVecOutput: .autoCorrelation], [0.0] * 1024)

    /*
     Test with empty input.
     */

    let autoCorrelation5 = AutoCorrelationAlgorithm()
    autoCorrelation5[realVecInput: .array] = []
    autoCorrelation5.compute()

    XCTAssert(autoCorrelation5[realVecOutput: .autoCorrelation].isEmpty)

    /*
     Test with a single value.
     */

    let autoCorrelation6 = AutoCorrelationAlgorithm()
    autoCorrelation6[realVecInput: .array] = [0.2]
    autoCorrelation6.compute()

    XCTAssertEqual(autoCorrelation6[realVecOutput: .autoCorrelation], [0.04], accuracy: 1e-7)

  }

}
