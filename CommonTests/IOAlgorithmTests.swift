//
//  IOAlgorithmTests.swift
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

class IOAlgorithmTests: XCTestCase {

  /// Tests creation and modification of `VectorInput` instances.
  func testVectorInput() {

    let realVector: [Float] = [1, 2, 3]
    let realVectorInput = VectorInput<Float>(realVector)
    XCTAssertEqual(realVectorInput.vector, realVector)
    let realVectorʹ: [Float] = [4, 5, 6]
    realVectorInput.vector = realVectorʹ
    XCTAssertEqual(realVectorInput.vector, realVectorʹ)

    let realVecVector: [[Float]] = [[1, 2, 3], [4, 5, 6]]
    let realVecVectorInput = VectorInput<[Float]>(realVecVector)
    XCTAssertEqual(realVecVectorInput.vector, realVecVector)
    let realVecVectorʹ: [[Float]] = [[7, 8, 9], [10, 11, 12]]
    realVecVectorInput.vector = realVecVectorʹ
    XCTAssertEqual(realVecVectorInput.vector, realVecVectorʹ)

    let stringVector: [String] = ["1", "2", "3"]
    let stringVectorInput = VectorInput<String>(stringVector)
    XCTAssertEqual(stringVectorInput.vector, stringVector)
    let stringVectorʹ: [String] = ["4", "5", "6"]
    stringVectorInput.vector = stringVectorʹ
    XCTAssertEqual(stringVectorInput.vector, stringVectorʹ)

    let stereoSampleVector: [StereoSample] = [StereoSample(left: 1, right: 1),
                                              StereoSample(left: 2, right: 2),
                                              StereoSample(left: 3, right: 3)]
    let stereoSampleVectorInput = VectorInput<StereoSample>(stereoSampleVector)
    XCTAssertEqual(stereoSampleVectorInput.vector, stereoSampleVector)
    let stereoSampleVectorʹ: [StereoSample] = [StereoSample(left: 4, right: 4),
                                               StereoSample(left: 5, right: 5),
                                               StereoSample(left: 6, right: 6)]
    stereoSampleVectorInput.vector = stereoSampleVectorʹ
    XCTAssertEqual(stereoSampleVectorInput.vector, stereoSampleVectorʹ)

    let realMatrixVector: [[[Float]]] = [[[11.1, 11.2, 11.3], [12.1, 12.2, 12.3]],
                                         [[21.1, 21.2, 21.3], [22.1, 22.2, 22.3]],
                                         [[31.1, 31.2, 31.3], [32.1, 32.2, 32.3]]]
    let realMatrixVectorInput = VectorInput<[[Float]]>(realMatrixVector)
    XCTAssertEqual(realMatrixVectorInput.vector, realMatrixVector)
    let realMatrixVectorʹ: [[[Float]]] = [[[41.1, 41.2, 41.3], [42.1, 42.2, 42.3]],
                                          [[51.1, 51.2, 51.3], [52.1, 52.2, 52.3]],
                                          [[61.1, 61.2, 61.3], [62.1, 62.2, 62.3]]]
    realMatrixVectorInput.vector = realMatrixVectorʹ
    XCTAssertEqual(realMatrixVectorInput.vector, realMatrixVectorʹ)

    let complexRealVector: [DSPComplex] = [DSPComplex(real: 1, imag: 0),
                                           DSPComplex(real: 2, imag: 0),
                                           DSPComplex(real: 3, imag: 0)]
    let complexRealVectorInput = VectorInput<DSPComplex>(complexRealVector)
    XCTAssertEqual(complexRealVectorInput.vector, complexRealVector, accuracy: 0)
    let complexRealVectorʹ: [DSPComplex] = [DSPComplex(real: 4, imag: 0),
                                            DSPComplex(real: 5, imag: 0),
                                            DSPComplex(real: 6, imag: 0)]
    complexRealVectorInput.vector = complexRealVectorʹ
    XCTAssertEqual(complexRealVectorInput.vector, complexRealVectorʹ, accuracy: 0)

  }

  /// Tests the functionality of the bridged `Pool` as data for inputs and outputs.
  func testStandardPoolIO() {

    let inputPool = Pool()

    ([23.4, 44.2, 0.233, 994.35, 23.6] as [Float]).forEach {
      inputPool.add(.real($0), for: "testData1")
    }

    ([[45.33, 78.21, 993.24, 43.2, 9.234],
     [24.43, 1.235, 4.53, 33.2, 76.0],
     [24.344, 824.2, 0.54, 22.34, 55.43]] as [[Float]]).forEach {
      inputPool.add(.realVec($0), for: "testData2")
    }

    let aggregator = StandardAlgorithm<Standard.PoolAggregator>()
    aggregator[stringVecParameter: .defaultStats] = ["mean", "var", "min", "max"]

    aggregator[poolInput: .input] = inputPool

    aggregator.compute()

    let outputPool = aggregator[poolOutput: .output]

    XCTAssertEqual(outputPool[singleReal: "testData1.mean"], 217.156586, accuracy: 0.1)
    XCTAssertEqual(outputPool[singleReal: "testData1.var"], 151201.016, accuracy: 0.1)
    XCTAssertEqual(outputPool[singleReal: "testData1.max"], 994.35, accuracy: 0.1)
    XCTAssertEqual(outputPool[singleReal: "testData1.min"], 0.233, accuracy: 0.1)

  }

  /// Tests the functionality of the bridged `Pool` as a sink for source data.
  func testStreamingPoolIO() {

    let realValues: [Float] = [23.4, 44.2, 0.233, 994.35, 23.6]
    let realVecValues: [[Float]] = [[45.33, 78.21, 993.24, 43.2, 9.234],
                                       [24.43, 1.235, 4.53, 33.2, 76.0],
                                       [24.344, 824.2, 0.54, 22.34, 55.43]]

    let realValueInput = VectorInput<Float>(realValues)
    let realVecValueInput = VectorInput<[Float]>(realVecValues)

    let pool = Pool()

    realValueInput[output: .data] >> pool[input: "realValues"]

    realVecValueInput[output: .data] >> pool[input: "realVecValues"]

    let realNetwork = Network(generator: realValueInput)
    realNetwork.run()

    let realVecNetwork = Network(generator: realVecValueInput)
    realVecNetwork.run()

    XCTAssertEqual(pool[realVec: "realValues"], realValues)
    XCTAssertEqual(pool[realVecVec: "realVecValues"], realVecValues)


  }

  /// Tests that audio signals passed to algorithms are handled in a way that is compatible
  /// with the unavailable `MonoLoader` algorithm. Values taken from `test_monoloader.py`.
  func testAudioLoading() {

    /// Helper for rounding a value. Implementation is a port of the same helper function in
    /// test_monoloader.py.
    ///
    /// - Parameter value: The value to round.
    /// - Returns: `value` rounded to an integer.
    func rounded(_ value: Float) -> Int { return Int(value >= 0 ? value + 0.5 : value - 0.5) }

    /// Helper for computing the sum of all samples in a signal.
    ///
    /// - Parameter signal: The signal to sum.
    /// - Returns: The sum of all the samples in `signal`.
    func sum(_ signal: [Float]) -> Float {
      var result: Float = 0
      vDSP_sve(signal, 1, &result, vDSP_Length(signal.count))
      return result
    }

    /// Helper for loading audio from a file with the same parameters one would use
    /// with `MonoLoader`.
    ///
    /// - Parameters:
    ///   - url: The url for the file to load.
    ///   - method: The method to use when downmixing the signal.
    ///   - sampleRate: The desired sample rate for the buffer.
    ///   - file: The file in which failure occurred. Defaults to the file name of the test case in
    ///           which this function was called.
    ///   - line: The line number on which failure occurred. Defaults to the line number on which this
    ///           function was called.
    /// - Returns: The signal loaded from `url` at `sampleRate` and downmixed using `method`.
    func loadAudio(url: URL,
                   downMix method: AVAudioPCMBuffer.DownmixMethod,
                   sampleRate: Double,
                   file: StaticString = #file,
                   line: UInt = #line) -> [Float]
    {
      guard let buffer = (try? AVAudioPCMBuffer(contentsOf: url)) else {
        XCTFail("Failed to create audio buffer using `url`.", file: file, line: line)
        return []
      }

      let downmixedBuffer = buffer.downmixed(method: method, sampleRate: sampleRate)

      guard let signal = downmixedBuffer.floatChannelData?.pointee else {
        XCTFail("Failed to get raw signal from buffer`.", file: file, line: line)
        return []
      }

      return Array(UnsafeBufferPointer(start: signal, count: Int(downmixedBuffer.frameLength)))

    }

    /*
     Test with an audio file sampled at 44100Hz.
     */

    let url1 = bundleURL(name: "impulses_1second_44100_st", ext: "wav")
    let left1 = loadAudio(url: url1, downMix: .left, sampleRate: 44100)
    let right1 = loadAudio(url: url1, downMix: .right, sampleRate: 44100)
    let mix1 = loadAudio(url: url1, downMix: .mix, sampleRate: 44100)

    XCTAssertEqual(rounded(sum(left1)), 9)
    XCTAssertEqual(rounded(sum(right1)), 9)
    XCTAssertEqual(rounded(sum(mix1)), 9)

    /*
     Test with an audio file sampled at 22050Hz.
     */

    let url2 = bundleURL(name: "impulses_1second_22050_st", ext: "wav")
    let left2 = loadAudio(url: url2, downMix: .left, sampleRate: 22050)
    let right2 = loadAudio(url: url2, downMix: .right, sampleRate: 22050)
    let mix2 = loadAudio(url: url2, downMix: .mix, sampleRate: 22050)

    XCTAssertEqual(rounded(sum(left2)), 9)
    XCTAssertEqual(rounded(sum(right2)), 9)
    XCTAssertEqual(rounded(sum(mix2)), 9)

    /*
     Test with an audio file sampled at 48000Hz.
     */

    let url3 = bundleURL(name: "impulses_1second_48000_st", ext: "wav")
    let left3 = loadAudio(url: url3, downMix: .left, sampleRate: 48000)
    let right3 = loadAudio(url: url3, downMix: .right, sampleRate: 48000)
    let mix3 = loadAudio(url: url3, downMix: .mix, sampleRate: 48000)

    XCTAssertEqual(rounded(sum(left3)), 9)
    XCTAssertEqual(rounded(sum(right3)), 9)
    XCTAssertEqual(rounded(sum(mix3)), 9)

    /*
     Test with an empty audio file.
     */

    XCTAssert(loadAudio(url: bundleURL(name: "empty", ext: "wav"),
                        downMix: .left, sampleRate: 44100).isEmpty)

    /*
     Test with an audio file containing more impulses in one channel than the other.
     */

    let url4 = bundleURL(name: "impulses_1second_441002", ext: "wav")
    let left4 = loadAudio(url: url4, downMix: .left, sampleRate: 44100)
    let right4 = loadAudio(url: url4, downMix: .right, sampleRate: 44100)
    let mix4 = loadAudio(url: url4, downMix: .mix, sampleRate: 44100)


    XCTAssertEqual(rounded(sum(left4)), 10)
    XCTAssertEqual(rounded(sum(right4)), 9)
    XCTAssertEqual(sum(mix4), 9.5, accuracy: 0.1)

    /*
     Test the sample values for an audio file compared with the same audio file loaded
     via `MonoLoader` in python.
     */
    let url5 = bundleURL(name: "mozart_c_major_30sec", ext: "wav")
    let expectedSamples = loadVector(name: "mozart_c_major_30sec_samples")
    let actualSamples = loadAudio(url:url5, downMix: .mix, sampleRate: 44100)

    XCTAssertEqual(actualSamples, expectedSamples, accuracy: 1e-6)

  }

}
