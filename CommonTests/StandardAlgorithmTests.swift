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

class StandardAlgorithmTests: XCTestCase {

  /// Tests the STFT/FFT functionality.
  func testFFT() {

    let frameCutter = StandardAlgorithm<Standard.FrameCutter>()
    frameCutter[integerParameter: .frameSize] = 1024
    frameCutter[integerParameter: .hopSize] = 256
    frameCutter[booleanParameter: .startFromZero] = false

    let windowing = StandardAlgorithm<Standard.Windowing>([.type: "hann"])

    let fft = StandardAlgorithm<Standard.FFT>([.size: 1024])

    let url = bundleURL(name: "C4-E♭4-G4_Boesendorfer_Grand_Piano-Trimmed", ext: "aif")
    let chordSignal = monoBufferData(url: url)

    frameCutter[realVecInput: .signal] = chordSignal

    frameCutter[output: .frame] >> windowing[input: .frame]
    windowing[output: .frame] >> fft[input: .frame]


    var fftOutputFrames: [[Float]] = []

    repeat {

      frameCutter.compute()

      let frame = frameCutter[realVecOutput: .frame]

      if frame.isEmpty { break }

      windowing.compute()

      fft.compute()

      let complexFrame = fft[complexRealVecOutput: .fft]

      var accelBuffer = DSPSplitComplex(realp: UnsafeMutablePointer<Float>.allocate(capacity: 512),
                                        imagp: UnsafeMutablePointer<Float>.allocate(capacity: 512))

      vDSP_ctoz(complexFrame, 2, &accelBuffer, 1, 512)

      var frameMagnitudes = Array<Float>(repeating: 0, count: 512)

      vDSP_zvmags(&accelBuffer, 1, &frameMagnitudes, 1, 512)

      fftOutputFrames.append(frameMagnitudes)

    } while true

    var text = ""

    for bin in 0 ..< 512 {

      print(fftOutputFrames.map({"\($0[bin])"}).joined(separator: ","), to: &text)

    }

    guard let textData = text.data(using: .utf8) else {
      XCTFail("Failed to get the text as raw data.")
      return
    }

    add(XCTAttachment(data: textData, uniformTypeIdentifier: "public.csv", lifetime: .keepAlways))

  }

  /// Tests the STFT/FFT functionality in streaming mode.
  func testStreamingFFT() {

    let url = bundleURL(name: "C4-E♭4-G4_Boesendorfer_Grand_Piano-Trimmed", ext: "aif")
    let chordSignal = monoBufferData(url: url)
    
    let signalInput = VectorInput<Float>(chordSignal)

    let frameCutter = StreamingAlgorithm<Streaming.FrameCutter>()
    frameCutter[integerParameter: .frameSize] = 1024
    frameCutter[integerParameter: .hopSize] = 256
    frameCutter[booleanParameter: .startFromZero] = false

    let windowing = StreamingAlgorithm<Streaming.Windowing>([.type: "hann"])

    let fft = StreamingAlgorithm<Streaming.FFT>([.size: 1024])

    let fftOutput = VectorOutput<[DSPComplex]>()

    signalInput[output: .data] >> frameCutter[input: .signal]
    frameCutter[output: .frame] >> windowing[input: .frame]
    windowing[output: .frame] >> fft[input: .frame]
    fft[output: .fft] >> fftOutput[input: .data]

    let network = Network(generator: signalInput)
    network.run()

    let complexFrames = fftOutput.vector

    XCTAssert(!complexFrames.isEmpty)

    var accelBuffer = DSPSplitComplex(realp: UnsafeMutablePointer<Float>.allocate(capacity: 512),
                                      imagp: UnsafeMutablePointer<Float>.allocate(capacity: 512))

    var realFrames:[[Float]] = []

    for complexFrame in complexFrames {

      vDSP_ctoz(complexFrame, 2, &accelBuffer, 1, 512)

      var realFrame = Array<Float>(repeating: 0, count: 512)

      vDSP_zvmags(&accelBuffer, 1, &realFrame, 1, 512)

      realFrames.append(realFrame)

    }

    var text = ""

    for bin in 0 ..< 512 {

      print(realFrames.map({"\($0[bin])"}).joined(separator: ","), to: &text)

    }

    guard let textData = text.data(using: .utf8) else {
      XCTFail("Failed to get the text as raw data.")
      return
    }

    add(XCTAttachment(data: textData, uniformTypeIdentifier: "public.csv", lifetime: .keepAlways))

  }

  func testFFTC() {
    //TODO: Implement the  function
    XCTFail("\(#function) not yet implemented.")
  }

  /// Tests the functionality ofthe IFFT algorithm. Values taken from `test_ifft.py`.
  func testIFFT() {
    //TODO: Implement the  function
    XCTFail("\(#function) not yet implemented.")

    /*
    def testDC(self):
        # input is [1, 0, 0, ...] which corresponds to an IFFT of constant magnitude 1
        signalSize = 512
        fftSize = signalSize/2 + 1

        signalDC = zeros(signalSize)
        signalDC[0] = 1.0

        fftInput = [ 1+0j ] * fftSize

        self.assertAlmostEqualVector(signalDC*signalSize, IFFT()(cvec(fftInput)))
     */

    /*
    def testNyquist(self):
        # input is [1, -1, 1, -1, ...] which corresponds to a sine of frequency Fs/2
        signalSize = 1024
        fftSize = signalSize/2 + 1

        signalNyquist = ones(signalSize)
        for i in range(signalSize):
            if i % 2 == 1:
                signalNyquist[i] = -1.0

        fftInput = [ 0+0j ] * fftSize
        fftInput[-1] = (1+0j) * signalSize

        self.assertAlmostEqualVector(IFFT()(cvec(fftInput)), signalNyquist*signalSize)
     */

    /*
    def testZero(self):
        self.assertAlmostEqualVector(zeros(2048), IFFT()(numpy.zeros(1025, dtype='c8')))
     */

    /*
    def testEmpty(self):
        self.assertComputeFails(IFFT(), cvec([]))
     */

    /*
    def testRegression(self):
        signal = numpy.sin(numpy.arange(1024, dtype='f4')/1024. * 441 * 2*math.pi)
        self.assertAlmostEqualVector(signal*len(signal), IFFT()(FFT()(signal)), 1e-2)
     */

  }

  /// Tests the DCT algorithm. Values taken from 'test_dct.py'.
  func testDCT() {

    let input = VectorInput<[Float]>([[0.0, 0.0, 1.0, 0.0, 1.0]])

    let dct = StreamingAlgorithm<Streaming.DCT>([.inputSize: 5,
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

    let envelope1 = StandardAlgorithm<Standard.Envelope>([
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

    let envelope2 = StandardAlgorithm<Standard.Envelope>([
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

    let envelope3 = StandardAlgorithm<Standard.Envelope>([
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

    let spectrum1 = StandardAlgorithm<Standard.Spectrum>()
    spectrum1[realVecInput: .frame] = loadVector(name: "spectrumInput")
    spectrum1.compute()

    XCTAssertEqual(spectrum1[realVecOutput: .spectrum], loadVector(name: "spectrumOutput"),
                   accuracy: 1e-4)


    /*
     Test with a DC signal.
     */

    let spectrum2 = StandardAlgorithm<Standard.Spectrum>()
    spectrum2[realVecInput: .frame] = [1.0] * 512
    spectrum2.compute()

    XCTAssertEqual(spectrum2[realVecOutput: .spectrum], [512.0] + [0.0] * 256)

    /*
      Test nyquist values.
     */

    let spectrum3 = StandardAlgorithm<Standard.Spectrum>()
    spectrum3[realVecInput: .frame] = [-1.0, 1.0] * 256
    spectrum3.compute()

    XCTAssertEqual(spectrum3[realVecOutput: .spectrum], [0.0] * 256 + [512.0])

    /*
     Test with all-zero input.
     */

    let spectrum4 = StandardAlgorithm<Standard.Spectrum>()
    spectrum4[realVecInput: .frame] = [0.0] * 512
    spectrum4.compute()

    XCTAssertEqual(spectrum4[realVecOutput: .spectrum], [0.0] * 257)

    /*
     Test that the size parameter does not cause improperly-sized output.
     */

    let spectrum5 = StandardAlgorithm<Standard.Spectrum>([.size: 514])
    spectrum5[realVecInput: .frame] = [1.0] * 512
    spectrum5.compute()

    XCTAssertEqual(spectrum5[realVecOutput: .spectrum].count, 257)

  }

  /// Tests the functionality of the Windowing algorithm. Values taken from `test_windowing.py`.
  func testWindowing() {

    /*
     Test that the output frame has the expected size.
     */

    let windowing1 = StandardAlgorithm<Standard.Windowing>([
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

    let windowing2 = StandardAlgorithm<Standard.Windowing>([
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

    let windowing3 = StandardAlgorithm<Standard.Windowing>([
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

    let windowing4 = StandardAlgorithm<Standard.Windowing>([
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

    let windowing5 = StandardAlgorithm<Standard.Windowing>([
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

    let windowing6 = StandardAlgorithm<Standard.Windowing>([
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

    let windowing7 = StandardAlgorithm<Standard.Windowing>([
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

    let windowing8 = StandardAlgorithm<Standard.Windowing>([
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

    let windowing9 = StandardAlgorithm<Standard.Windowing>([
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

    let windowing10 = StandardAlgorithm<Standard.Windowing>([
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

    let windowing11 = StandardAlgorithm<Standard.Windowing>([
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

      let frameCutter = StandardAlgorithm<Standard.FrameCutter>(parameters)
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
      let frameCutter = StreamingAlgorithm<Streaming.FrameCutter>(parameters)

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
      let frameCutter = StreamingAlgorithm<Streaming.FrameCutter>(parameters)
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

    let frameCutter1 = StreamingAlgorithm<Streaming.FrameCutter>([
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

    let frameCutter2 = StreamingAlgorithm<Streaming.FrameCutter>([
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

    let frameCutter3 = StreamingAlgorithm<Streaming.FrameCutter>([
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
    //TODO: Implement the  function
    XCTFail("\(#function) not yet implemented.")

    /*
    def testRandom(self):
        # input is [1, 0, 0, ...] which corresponds to an ConstantQ of constant magnitude 1
        with open(os.path.join(script_dir, 'constantq/CQinput.txt'), 'r') as f:
            #read_data = f.read()
            data = np.array([], dtype='complex64')
            line = f.readline()
            while line != '':
                re = float(line.split('\t')[0])
                im = float(line.split('\t')[1])
                data = np.append(data, re + im * 1j)
                line = f.readline()

        with open(os.path.join(script_dir, 'constantq/QMoutput.txt'), 'r') as u:
            QMdata_out = np.array([], dtype='complex64')
            for line in u:
                re = line.split('+')[0]
                re = float(re[1:])
                im = line.split('+')[1]
                im = float(im[:-3])
                QMdata_out = np.append(QMdata_out, re + im * 1j)

        CQdata = ConstantQ()(cvec(data))
        QMdata_out = np.array(QMdata_out, dtype='complex64')

        # difference mean
        DifferMean = QMdata_out-CQdata
        DifferMean = ((sum(abs(DifferMean.real))/len(DifferMean))+(sum(abs(DifferMean.imag))/len(DifferMean)))/2
        # divergence mean percentage
        DiverPerReal = (sum(((QMdata_out.real-CQdata.real)/QMdata_out.real)*100))/len(QMdata_out.real)
        DiverPerImag = (sum(((QMdata_out.imag-CQdata.imag)/QMdata_out.imag)*100))/len(QMdata_out.imag)
        DiverPer = (DiverPerReal + DiverPerImag) / 2

        """
        print 'Divergence mean percentage is : '+str(DiverPer)[:5]+'%'
        print 'Difference Mean is : '+str(DifferMean)[:9]
        """
     */
    
  }

  /// Tests the functionality of the PeakDetection algorithm. Values taken from
  /// `test_peakdetection.py`.
  func testPeakDetection() {
    //TODO: Implement the  function
    XCTFail("\(#function) not yet implemented.")

    /*
    def testPeakAtBegining(self):
        input=[1,0,0,0]
        inputSize = len(input)
        config = { 'range': inputSize -1,  'maxPosition': inputSize-1,  'minPosition': 0,  'orderBy': 'amplitude' }
        pdetect = PeakDetection(**config)
        (posis, vals) = pdetect(input)
        self.assertEqualVector(posis, [0])
        self.assertEqualVector(vals, [1])
     */

    /*
    def testPeakAtMinPosition(self):
        peakPos = 3
        input=[0,0,0,0,0,0,0]
        input[peakPos] = 1
        inputSize = len(input)
        config = { 'range': inputSize -1,  'maxPosition': inputSize-1, 'minPosition': peakPos,  'orderBy': 'amplitude' }
        pdetect = PeakDetection(**config)
        (posis, vals) = pdetect(input)
        self.assertEqualVector(posis, [peakPos])
        self.assertEqualVector(vals, [1])
     */

    /*
    def testPeakZero(self):
        peakPos = 0
        input=[0,0,0,0,0]
        input[peakPos] = 1
        inputSize = len(input)
        config = { 'range': inputSize-1,  'maxPosition': inputSize-1, 'orderBy': 'amplitude' }
        pdetect = PeakDetection(**config)
        (posis, vals) = pdetect(input)
        self.assertEqualVector(posis, [peakPos])
        self.assertEqualVector(vals, [1])
     */

    /*
    def testPeakOne(self):
        peakPos = 1
        input=[0,0,0,0,0]
        input[peakPos] = 1
        inputSize = len(input)
        config = { 'range': inputSize-1,  'maxPosition': inputSize-1, 'orderBy': 'amplitude' }
        pdetect = PeakDetection(**config)
        (posis, vals) = pdetect(input)
        self.assertEqualVector(posis, [peakPos])
        self.assertEqualVector(vals, [1])
     */

    /*
    def testPeakTwo(self):
        peakPos = 2
        input=[0,0,0,0,0]
        input[peakPos] = 1
        inputSize = len(input)
        config = { 'range': inputSize-1,  'maxPosition': inputSize-1, 'orderBy': 'amplitude' }
        pdetect = PeakDetection(**config)
        (posis, vals) = pdetect(input)
        self.assertEqualVector(posis, [peakPos])
        self.assertEqualVector(vals, [1])
     */

    /*
    def testPeakThree(self):
        peakPos = 3
        input=[0,0,0,0,0]
        input[peakPos] = 1
        inputSize = len(input)
        config = { 'range': inputSize-1,  'maxPosition': inputSize-1, 'orderBy': 'amplitude' }
        pdetect = PeakDetection(**config)
        (posis, vals) = pdetect(input)
        self.assertEqualVector(posis, [peakPos])
        self.assertEqualVector(vals, [1])
     */

    /*
    def testPeakFour(self):
        peakPos = 4
        input=[0,0,0,0,0]
        input[peakPos] = 1
        inputSize = len(input)
        config = { 'range': inputSize-1,  'maxPosition': inputSize-1, 'orderBy': 'amplitude' }
        pdetect = PeakDetection(**config)
        (posis, vals) = pdetect(input)
        self.assertEqualVector(posis, [peakPos])
        self.assertEqualVector(vals, [1])
     */

    /*
    def testPeakBeforeEnd(self):
        peakPos = 3
        input=[0,0,0,0,0]
        input[peakPos] = 1
        inputSize = len(input)
        config = { 'range': inputSize-1,  'maxPosition': inputSize-1, 'orderBy': 'amplitude' }
        pdetect = PeakDetection(**config)
        (posis, vals) = pdetect(input)
        self.assertEqualVector(posis, [peakPos])
        self.assertEqualVector(vals, [1])
     */

    /*
    def testPeakAtMaxPosition(self):
        peakPos = 3
        input=[0,0,0,0,0,0,0]
        input[peakPos] = 1
        inputSize = len(input)
        config = { 'range': inputSize -1,  'maxPosition': peakPos, 'orderBy': 'amplitude' }
        pdetect = PeakDetection(**config)
        (posis, vals) = pdetect(input)
        self.assertEqualVector(posis, [peakPos])
        self.assertEqualVector(vals, [1])
     */

    /*
    def testPeakEnd(self):
        input=[0,0,0,0,0,0,0]
        inputSize = len(input)
        peakPos = inputSize-1
        input[peakPos] = 1
        config = { 'range': inputSize -1,  'maxPosition': peakPos, 'orderBy': 'amplitude' }
        pdetect = PeakDetection(**config)
        (posis, vals) = pdetect(input)
        self.assertEqualVector(posis, [peakPos])
        self.assertEqualVector(vals, [1])
     */

    /*
    def testMaxPositionLargerThanSize(self):
        peakPos = 3
        input=[0,0,0,0,0,0,0]
        input[peakPos] = 1
        inputSize = len(input)
        config = { 'range': inputSize -1,  'maxPosition': 10*peakPos, 'orderBy': 'amplitude' }
        pdetect = PeakDetection(**config)
        (posis, vals) = pdetect(input)
        self.assertEqualVector(posis, [peakPos])
        self.assertEqualVector(vals, [1])
     */

    /*
    def testRegression(self):
        inputSize = 1024

        config = { 'range': inputSize -1,  'maxPosition': inputSize,  'minPosition': 0,  'orderBy': 'amplitude' }
        pdetect = PeakDetection(**config)

        pos1 = 3
        val1 = 1.0
        inputOne = [0] * inputSize
        inputOne[pos1] = val1
        (posis, vals) = pdetect(inputOne)
        self.assertEqualVector(posis, [pos1])
        self.assertEqualVector(vals, [val1])

        pos1 = 3
        val1 = 1.0
        pos2 = 512
        val2 = 3.0
        inputTwo = [0] * inputSize
        inputTwo[pos1] = val1
        inputTwo[pos2] = val2
        (posis, vals) = pdetect(inputTwo)
        self.assertEqualVector(posis, [pos2, pos1])
        self.assertEqualVector(vals, [val2, val1])

        config['orderBy'] = 'position'
        pdetect.configure(**config)
        (posis, vals) = pdetect(inputTwo)
        self.assertEqualVector(posis, [pos1, pos2])
        self.assertEqualVector(vals, [val1, val2])
     */

    /*
    def testPlateau(self):
        inputSize = 1024
        pos = range(3, 7)
        val = 1.0
        input = [0] * inputSize
        for i in range(len(pos)):
            input[pos[i]] = val

        # with interpolation:
        config = { 'range': inputSize -1,  'maxPosition': inputSize, 'minPosition': 0,  'orderBy': 'amplitude', 'interpolate' : True }
        pdetect = PeakDetection(**config)
        (posis, vals) = pdetect(input)
        self.assertEqualVector(posis, [0.5*(pos[0]+pos[-1])])
        self.assertEqualVector(vals, [val])

        # no interpolation:
        config = { 'range': inputSize -1,  'maxPosition': inputSize, 'minPosition': 0,  'orderBy': 'amplitude', 'interpolate' : False }
        pdetect = PeakDetection(**config)

        (posis, vals) = pdetect(input)
        self.assertEqualVector(posis, [pos[0]])
        self.assertEqualVector(vals, [val])
     */

    /*
    def testStairCase(self):
        # should find the first postition of the last step
        inputSize = 1024
        pos = [range(3, 7), range(7,14), range(14,20)]
        val = [1.0, 2.0, 3.0]
        input = [0] * inputSize
        for i in range(len(pos)):
            for j in range(len(pos[i])):
                input[pos[i][j]] = val[i]

        # no interpolation:
        config = { 'range': inputSize -1,  'maxPosition': inputSize, 'minPosition': 0,  'orderBy': 'amplitude', 'interpolate' : False }
        pdetect = PeakDetection(**config)
        (posis, vals) = pdetect(input)
        self.assertEqualVector(posis, [pos[-1][0]])
        self.assertEqualVector(vals, [val[-1]])
     */

    /*
    def testZero(self):
        inputSize = 1024
        input = [0] * inputSize
        pdetect = PeakDetection()
        (posis, vals) = pdetect(input)
        self.assert_(len(posis) == 0)
        self.assert_(len(vals) == 0)
     */

    /*
    def testEmpty(self):
        # Feeding an empty array shouldn't crash and throw an exception
        self.assertComputeFails(PeakDetection(),  [])
     */

    /*
    def testOne(self):
        # Feeding an array of size 1 shouldn't crash and throw an exception
        self.assertComputeFails(PeakDetection(), [0])
     */

    /*
    def testInvalidParam(self):
        self.assertConfigureFails(PeakDetection(), {'range': 0})
        self.assertConfigureFails(PeakDetection(), {'maxPeaks': 0})
        self.assertConfigureFails(PeakDetection(), {'maxPosition': 0})
        self.assertConfigureFails(PeakDetection(), {'minPosition': -1})
        PeakDetection(threshold=0)
        self.assertConfigureFails(PeakDetection(), {'minPosition': 1.01,  'maxPosition': 1})
     */

  }

  /// Tests the functionality of the AutoCorrelation algorithm. Values taken from
  /// `test_autocorrelation.py`.
  func testAutoCorrelation() {
    //TODO: Implement the  function
    XCTFail("\(#function) not yet implemented.")

    /*
    def testRegression(self):
        inputv = readVector(join(testdir, 'input_pow2.txt'))
        expected = readVector(join(testdir, 'output.txt'))

        output = AutoCorrelation()(inputv)

        self.assertAlmostEqualVector(expected, output, 1e-4)
     */

    /*
    def testNonPowerOfTwo(self):
        inputv = readVector(join(testdir, 'octave_input.txt'))
        inputv = inputv[:234]
        expected = readVector(join(testdir, 'output_nonpow2.txt'))

        output = AutoCorrelation()(inputv)

        self.assertAlmostEqualVector(expected, output, 1e-4)
     */

    /*
    def testOctave(self):
        inputv = readVector(join(testdir, 'octave_input.txt'))
        expected = readVector(join(testdir, 'octave_output.txt'))

        output = AutoCorrelation()(inputv)

        self.assertEqual(len(expected)/2, len(output))

        self.assertAlmostEqualVector(expected[:len(expected)/2], output, 1e-4)
     */

    /*
    def testZero(self):
        self.assertEqualVector(AutoCorrelation()(zeros(1024)), zeros(1024))
     */

    /*
    def testEmpty(self):
        self.assertEqualVector(AutoCorrelation()([]), [])
     */

    /*
    def testOne(self):
        self.assertAlmostEqualVector(AutoCorrelation()([0.2]), [0.04])
     */

  }

}
