//
//  TonalAlgorithmTests.swift
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

class TonalAlgorithmTests: XCTestCase {

  /// Tests the functionality of the `PitchSalienceFunction` algorithm. Values taken from
  /// `test_pitchsalience.py`.
  func testPitchSalience() {

    /*
     Test with white noise.
     */

    let whiteNoise = loadVector(name: "pitchsalience_whitenoise1")

    let vectorInput1 = VectorInput<[Float]>([whiteNoise])
    let spectrum1 = StreamingAlgorithm<Streaming.Spectrum>()
    let pitchSalience1 = StreamingAlgorithm<Streaming.PitchSalience>()
    let vectorOutput1 = VectorOutput<Float>()

    vectorInput1[output: .data] >> spectrum1[input: .frame]
    spectrum1[output: .spectrum] >> pitchSalience1[input: .spectrum]
    pitchSalience1[output: .pitchSalience] >> vectorOutput1[input: .data]

    let network1 = Network(generator: vectorInput1)
    network1.run()

    XCTAssertLessThan(vectorOutput1.vector[0], 0.2)

    /*
     Test with various real signals.
     */

    let vectorInput2 = VectorInput<Float>(loadVector(name: "pitchsalience_puretone"))
    let frameCutter2 = StreamingAlgorithm<Streaming.FrameCutter>()
    let windowing2 = StreamingAlgorithm<Streaming.Windowing>()
    let spectrum2 = StreamingAlgorithm<Streaming.Spectrum>()
    let pitchSalience2 = StreamingAlgorithm<Streaming.PitchSalience>([
      .sampleRate: 8000,
      .lowBoundary: 100,
      .highBoundary: 3999
      ])

    let pool = Pool()

    vectorInput2[output: .data] >> frameCutter2[input: .signal]
    frameCutter2[output: .frame] >> windowing2[input: .frame]
    windowing2[output: .frame] >> spectrum2[input: .frame]
    spectrum2[output: .spectrum] >> pitchSalience2[input: .spectrum]
    pitchSalience2[output: .pitchSalience] >> pool[input: "pureTone"]

    let network2 = Network(generator: vectorInput2)
    network2.run()

    let pureToneValues = pool[realVec: "pureTone"]

    XCTAssertEqual(pureToneValues, loadVector(name: "puretone_saliencevalues"), accuracy: 1e-5)

    let vectorInput3 = VectorInput<Float>(loadVector(name: "pitchsalience_sinesweep"))
    let frameCutter3 = StreamingAlgorithm<Streaming.FrameCutter>()
    let windowing3 = StreamingAlgorithm<Streaming.Windowing>()
    let spectrum3 = StreamingAlgorithm<Streaming.Spectrum>()
    let pitchSalience3 = StreamingAlgorithm<Streaming.PitchSalience>([
      .sampleRate: 8000,
      .lowBoundary: 100,
      .highBoundary: 3999
      ])

    vectorInput3[output: .data] >> frameCutter3[input: .signal]
    frameCutter3[output: .frame] >> windowing3[input: .frame]
    windowing3[output: .frame] >> spectrum3[input: .frame]
    spectrum3[output: .spectrum] >> pitchSalience3[input: .spectrum]
    pitchSalience3[output: .pitchSalience] >> pool[input: "sineSweep"]

    let network3 = Network(generator: vectorInput3)
    network3.run()

    let sineSweepValues = pool[realVec: "sineSweep"]

    XCTAssertEqual(sineSweepValues, loadVector(name: "sinesweep_saliencevalues"), accuracy: 1e-5)

    let vectorInput4 = VectorInput<Float>(loadVector(name: "pitchsalience_whitenoise2"))
    let frameCutter4 = StreamingAlgorithm<Streaming.FrameCutter>()
    let windowing4 = StreamingAlgorithm<Streaming.Windowing>()
    let spectrum4 = StreamingAlgorithm<Streaming.Spectrum>()
    let pitchSalience4 = StreamingAlgorithm<Streaming.PitchSalience>([
      .sampleRate: 8000,
      .lowBoundary: 100,
      .highBoundary: 3999
      ])

    vectorInput4[output: .data] >> frameCutter4[input: .signal]
    frameCutter4[output: .frame] >> windowing4[input: .frame]
    windowing4[output: .frame] >> spectrum4[input: .frame]
    spectrum4[output: .spectrum] >> pitchSalience4[input: .spectrum]
    pitchSalience4[output: .pitchSalience] >> pool[input: "whiteNoise"]

    let network4 = Network(generator: vectorInput4)
    network4.run()

    let whiteNoiseValues = pool[realVec: "whiteNoise"]

    XCTAssertEqual(whiteNoiseValues, loadVector(name: "whitenoise_saliencevalues"), accuracy: 1e-5)

    let vectorInput5 = VectorInput<Float>(loadVector(name: "pitchsalience_squarewave"))
    let frameCutter5 = StreamingAlgorithm<Streaming.FrameCutter>()
    let windowing5 = StreamingAlgorithm<Streaming.Windowing>()
    let spectrum5 = StreamingAlgorithm<Streaming.Spectrum>()
    let pitchSalience5 = StreamingAlgorithm<Streaming.PitchSalience>([
      .sampleRate: 8000,
      .lowBoundary: 100,
      .highBoundary: 3999
      ])


    vectorInput5[output: .data] >> frameCutter5[input: .signal]
    frameCutter5[output: .frame] >> windowing5[input: .frame]
    windowing5[output: .frame] >> spectrum5[input: .frame]
    spectrum5[output: .spectrum] >> pitchSalience5[input: .spectrum]
    pitchSalience5[output: .pitchSalience] >> pool[input: "squareWave"]

    let network5 = Network(generator: vectorInput5)
    network5.run()

    let squareWaveValues = pool[realVec: "squareWave"]

    XCTAssertEqual(squareWaveValues, loadVector(name: "squarewave_saliencevalues"), accuracy: 1e-5)

    let vectorInput6 = VectorInput<Float>(loadVector(name: "pitchsalience_varyingsquarewave"))
    let frameCutter6 = StreamingAlgorithm<Streaming.FrameCutter>()
    let windowing6 = StreamingAlgorithm<Streaming.Windowing>()
    let spectrum6 = StreamingAlgorithm<Streaming.Spectrum>()
    let pitchSalience6 = StreamingAlgorithm<Streaming.PitchSalience>([
      .sampleRate: 8000,
      .lowBoundary: 100,
      .highBoundary: 3999
      ])

    vectorInput6[output: .data] >> frameCutter6[input: .signal]
    frameCutter6[output: .frame] >> windowing6[input: .frame]
    windowing6[output: .frame] >> spectrum6[input: .frame]
    spectrum6[output: .spectrum] >> pitchSalience6[input: .spectrum]
    pitchSalience6[output: .pitchSalience] >> pool[input: "varyingSquareWave"]

    let network6 = Network(generator: vectorInput6)
    network6.run()

    let vSquareWaveValues = pool[realVec: "varyingSquareWave"]

    XCTAssertEqual(vSquareWaveValues, loadVector(name: "varyingsquarewave_saliencevalues"), accuracy: 1e-5)

    // 0.0346908001554
    var pureToneMean: Float = 0
    vDSP_meanv(pureToneValues, 1, &pureToneMean, vDSP_Length(pureToneValues.count))

    // 0.179461378385
    var whiteNoiseMean: Float = 0
    vDSP_meanv(whiteNoiseValues, 1, &whiteNoiseMean, vDSP_Length(whiteNoiseValues.count))

    // 0.044844484395
    var sineSweepMean: Float = 0
    vDSP_meanv(sineSweepValues, 1, &sineSweepMean, vDSP_Length(sineSweepValues.count))

    // 0.38006446642
    var squareWaveMean: Float = 0
    vDSP_meanv(squareWaveValues, 1, &squareWaveMean, vDSP_Length(squareWaveValues.count))

    // 0.349530152342
    var vSquareWaveMean: Float = 0
    vDSP_meanv(vSquareWaveValues, 1, &vSquareWaveMean, vDSP_Length(vSquareWaveValues.count))

    XCTAssertLessThan(pureToneMean, sineSweepMean,
                      "Pure tone mean is not less than sine sweep mean.")

    XCTAssertLessThan(sineSweepMean, whiteNoiseMean,
                      "Sine sweep mean is not less than white noise mean.")

    XCTAssertLessThan(whiteNoiseMean, vSquareWaveMean,
                      "White noise mean is not less than varying square wave mean.")

    XCTAssertLessThan(vSquareWaveMean, squareWaveMean,
                      "Varying square wave mean is not less than square wave mean.")


    /*
     Test with harmonic input.
     */

    let pitchSalience7 = StandardAlgorithm<Standard.PitchSalience>([
      .sampleRate: 38,
      .lowBoundary: 1.9,
      .highBoundary: 17.1
      ])

    pitchSalience7[realVecInput: .spectrum] = [0.0, 1.0] * 9 + [0.0]
    pitchSalience7.compute()

    XCTAssertEqual(pitchSalience7[realOutput: .pitchSalience], 0.88888888, accuracy: 1e-6)

    /*
     Test with a full spectrum.
     */

    let pitchSalience8 = StandardAlgorithm<Standard.PitchSalience>([
      .sampleRate: 18,
      .lowBoundary: 1,
      .highBoundary: 8
      ])

    pitchSalience8[realVecInput: .spectrum] = [4, 5, 7, 2, 1, 4, 5, 6, 10]
    pitchSalience8.compute()

    XCTAssertEqual(pitchSalience8[realOutput: .pitchSalience], 0.68014699220657349, accuracy: 1e-7)

    /*
     Test on-peak boundries.
     */

    let pitchSalience9 = StandardAlgorithm<Standard.PitchSalience>([
      .lowBoundary: 40,
      .highBoundary: 40
      ])

    pitchSalience9[realVecInput: .spectrum] = [4, 0, 0, 0, 0, 0, 0, 0, 0, 0] as [Float] * 2205
    pitchSalience9.compute()

    XCTAssertGreaterThan(pitchSalience9[realOutput: .pitchSalience], 0.9)

    /*
     Test off-peak boundaries.
     */

    let pitchSalience10 = StandardAlgorithm<Standard.PitchSalience>([
      .lowBoundary: 41,
      .highBoundary: 41
      ])

    pitchSalience10[realVecInput: .spectrum] = [4, 0, 0, 0, 0, 0, 0, 0, 0, 0] as [Float] * 2205
    pitchSalience10.compute()

    XCTAssertLessThan(pitchSalience10[realOutput: .pitchSalience], 0.1)

    /*
     Test with silence.
     */

    let pitchSalience11 = StandardAlgorithm<Standard.PitchSalience>()

    pitchSalience11[realVecInput: .spectrum] = [0.0] * 1024
    pitchSalience11.compute()

    XCTAssertEqual(pitchSalience11[realOutput: .pitchSalience], 0.0)
  }

  /// Tests the functionality of the `HarmonicPeaks` algorithm. Values taken from
  /// `test_harmonicpeaks.py`.
  func testHarmonicPeaks() {

    /*
     Simple regression test.
     */

    let harmonicPeaks1 = StandardAlgorithm<Standard.HarmonicPeaks>([.maxHarmonics: 10])
    harmonicPeaks1[realVecInput: .frequencies] =
      [0.5, 0.75, 1, 2, 3.5, 4, 4.09, 4.9, 6.25].map(110, *)
    harmonicPeaks1[realVecInput: .magnitudes] = [1.0] * 9
    harmonicPeaks1[realInput: .pitch] = 110
    harmonicPeaks1.compute()

    XCTAssertEqual(harmonicPeaks1[realVecOutput: .harmonicFrequencies],
                   [1, 2, 3, 4, 4.9, 6, 7, 8, 9, 10].map(110, *),
                   accuracy: 1e-7)

    XCTAssertEqual(harmonicPeaks1[realVecOutput: .harmonicMagnitudes],
                   [1, 1, 0, 1, 1, 0, 0, 0, 0, 0])

    /*
     Test that when two peaks are equidistant to an ideal harmonic the peak with the greater
     amplitude is selected.
     */

    let harmonicPeaks2 = StandardAlgorithm<Standard.HarmonicPeaks>([.maxHarmonics: 3])
    harmonicPeaks2[realVecInput: .frequencies] = [1, 2.9, 3.1].map(110, *)
    harmonicPeaks2[realVecInput: .magnitudes] = [1, 1, 0.5]
    harmonicPeaks2[realInput: .pitch] = 110
    harmonicPeaks2.compute()

    XCTAssertEqual(harmonicPeaks2[realVecOutput: .harmonicFrequencies],
                   [1, 2, 2.9].map(110, *),
                   accuracy: 1e-7)

    XCTAssertEqual(harmonicPeaks2[realVecOutput: .harmonicMagnitudes], [1, 0, 1])

    /*
     Test with F0 missing.
     */

    let harmonicPeaks3 = StandardAlgorithm<Standard.HarmonicPeaks>([.maxHarmonics: 3])
    harmonicPeaks3[realVecInput: .frequencies] = [2.9, 3.1].map(110, *)
    harmonicPeaks3[realVecInput: .magnitudes] = [1, 0.5]
    harmonicPeaks3[realInput: .pitch] = 110
    harmonicPeaks3.compute()

    XCTAssertEqual(harmonicPeaks3[realVecOutput: .harmonicFrequencies], [110, 220, 319],
                   accuracy: 1e-7)

    XCTAssertEqual(harmonicPeaks3[realVecOutput: .harmonicMagnitudes], [0, 0, 1])

    /*
     Test with only one peak.
     */

    let harmonicPeaks4 = StandardAlgorithm<Standard.HarmonicPeaks>([.maxHarmonics: 1])
    harmonicPeaks4[realVecInput: .frequencies] = [110]
    harmonicPeaks4[realVecInput: .magnitudes] = [1]
    harmonicPeaks4[realInput: .pitch] = 110
    harmonicPeaks4.compute()

    XCTAssertEqual(harmonicPeaks4[realVecOutput: .harmonicFrequencies], [110],
                   accuracy: 1e-7)

    XCTAssertEqual(harmonicPeaks4[realVecOutput: .harmonicMagnitudes], [1])

    /*
     Test with DC.
     */

    let harmonicPeaks5 = StandardAlgorithm<Standard.HarmonicPeaks>()
    harmonicPeaks5[realVecInput: .frequencies] = [0, 110, 220]
    harmonicPeaks5[realVecInput: .magnitudes] = [1, 0, 0]
    harmonicPeaks5[realInput: .pitch] = 0
    harmonicPeaks5.compute()

    XCTAssert(harmonicPeaks5[realVecOutput: .harmonicFrequencies].isEmpty)
    XCTAssert(harmonicPeaks5[realVecOutput: .harmonicMagnitudes].isEmpty)

  }

  /// Tests the functionality of the `HighResolutionFeatures` algorithm. Values taken from
  /// `test_hfc.py`.
  func testHighResolutionFeatures() {

    /*
     Test with all-zero input.
     */

    let highResolutionFeatures1 = StandardAlgorithm<Standard.HighResolutionFeatures>()
    highResolutionFeatures1[realVecInput: .hpcp] = [0.0] * 120
    highResolutionFeatures1.compute()

    XCTAssertEqual(highResolutionFeatures1[realOutput: .equalTemperedDeviation], 0)
    XCTAssertEqual(highResolutionFeatures1[realOutput: .nonTemperedEnergyRatio], 0)
    XCTAssertEqual(highResolutionFeatures1[realOutput: .nonTemperedPeaksEnergyRatio], 0)

    /*
     Test perfectly tempered.
     */

    highResolutionFeatures1[realVecInput: .hpcp] = [1, 0, 0, 0, 0, 0, 0, 0, 0, 0] as [Float]  * 12
    highResolutionFeatures1.compute()

    XCTAssertEqual(highResolutionFeatures1[realOutput: .equalTemperedDeviation], 0)
    XCTAssertEqual(highResolutionFeatures1[realOutput: .nonTemperedEnergyRatio], 0)
    XCTAssertEqual(highResolutionFeatures1[realOutput: .nonTemperedPeaksEnergyRatio], 0)

    /*
     Test max deviation.
     */

    highResolutionFeatures1[realVecInput: .hpcp] = [1, 0, 0, 0, 0] as [Float] * 24
    highResolutionFeatures1.compute()

    XCTAssertEqual(highResolutionFeatures1[realOutput: .equalTemperedDeviation], 0.25)
    XCTAssertEqual(highResolutionFeatures1[realOutput: .nonTemperedEnergyRatio], 0.5)
    XCTAssertEqual(highResolutionFeatures1[realOutput: .nonTemperedPeaksEnergyRatio], 0.5)

    /*
     Test streaming max deviation.
     */

    let vectorInput = VectorInput<[Float]>([[1, 0, 0, 0, 0] as [Float] * 24])
    let highResolutionFeatures2 = StreamingAlgorithm<Streaming.HighResolutionFeatures>()
    let pool = Pool()

    vectorInput[output: .data] >> highResolutionFeatures2[input: .hpcp]
    highResolutionFeatures2[output: .equalTemperedDeviation] >> pool[singleInput: "deviation"]
    highResolutionFeatures2[output: .nonTemperedEnergyRatio] >> pool[singleInput: "energyRatio"]
    highResolutionFeatures2[output: .nonTemperedPeaksEnergyRatio] >> pool[singleInput: "peaksRatio"]

    let network = Network(generator: vectorInput)
    network.run()

    XCTAssertEqual(pool[singleReal: "deviation"], 0.25)
    XCTAssertEqual(pool[singleReal: "energyRatio"], 0.5)
    XCTAssertEqual(pool[singleReal: "peaksRatio"], 0.5)

  }

 /// Tests the functionality of the PitchYin algorithm. Values taken from `test_pitchyin.py`.
  func testPitchYin() {

    /// A simple helper for running the algorithm and testing its output.
    ///
    /// - Parameters:
    ///   - signal: The signal to feed into the algorithm.
    ///   - frequency: The frequency present in `signal`.
    ///   - deviation: Max allowable deviation values for pitch and pitch confidence.
    ///                Default is `(pitch: 0, confidence: 0.1)`
    ///   - file: The file to use in assertion statements. Default is `#file`.
    ///   - line: The line to use in assertion statements. Default is `#line`.
    func runtTest(signal: [Float],
                  frequency: Float,
                  precision: (pitch: Float, confidence: Float) = (1, 0.1),
                  file: StaticString = #file,
                  line: UInt = #line)
    {

      let vectorInput = VectorInput<Float>(signal)

      let frameCutter = StreamingAlgorithm<Streaming.FrameCutter>([
        .frameSize: 1024, .hopSize: 1024
        ])

      let pitchYin = StreamingAlgorithm<Streaming.PitchYin>([
        .frameSize: 1024, .sampleRate: 44100
        ])

      let pool = Pool()

      vectorInput[output: .data] >> frameCutter[input: .signal]
      frameCutter[output: .frame] >> pitchYin[input: .signal]
      pitchYin[output: .pitch] >> pool[input: "pitch"]
      pitchYin[output: .pitchConfidence] >> pool[input: "confidence"]

      let network = Network(generator: vectorInput)
      network.run()

      XCTAssertAverageEqual(pool[realVec: "pitch"], frequency,
                            deviation: precision.pitch, file: file, line: line)
      XCTAssertAverageEqual(pool[realVec: "confidence"], 1,
                            deviation: precision.confidence, file: file, line: line)

    }

    /*
     Test with all-zero input.
     */

    let pitchYin1 = StandardAlgorithm<Standard.PitchYin>()
    pitchYin1[realVecInput: .signal] = [0.0] * 2048
    pitchYin1.compute()

    XCTAssertEqual(pitchYin1[realOutput: .pitch], 0)
    XCTAssertEqual(pitchYin1[realOutput: .pitchConfidence], 0)

    /*
     Test with a 440Hz sine wave.
     */

    let signal1: [Float] = (0..<44100).map({ (index: Int) -> Float in
      sinf((2 * Float.pi * 440 * Float(index)) / 44100)
    })

    runtTest(signal: signal1, frequency: 440)

    /*
     Test with a 660Hz band-limited square wave.
     */

    let signal2: [Float] = (0..<44100).map { [w = 2 * Float.pi * 660] (i: Int) -> Float in
      var sample: Float = 0
      for h in 0..<10 {
        sample += 0.5 / (2 * Float(h) + 1) * sinf((2 * Float(h) + 1) * Float(i) * w / 44100)
      }
      return sample
    }

    runtTest(signal: signal2, frequency: 660)


    /*
     Test with a 660Hz band-limited saw wave.
     */

    let signal3: [Float] = (0..<44100).map { [w = 2 * Float.pi * 660] (i: Int) -> Float in
      guard i > 0 else { return 0 }
      var sample: Float = 0
      for h in 1..<11 {
        sample += 1 / Float(h) * sinf(Float(h) * Float(i) * w / 44100)
      }
      return sample
    }

    runtTest(signal: signal3, frequency: 660, precision: (1.1, 0.1))

    /*
     Test with a masked 440Hz band-limited saw wave.
     */

    var signal4: [Float] = [0.0] * 44100
    let w = 2 * Float.pi * 440

    let subw = 2 * Float.pi * 340

    for i in 1..<44100 {
      signal4[i] += Float(4 * (drand48() - 0.5)) // White noise.
      (1..<10).forEach({signal4[i] += 1 / Float($0) * sinf(Float(i) * Float($0) * w / 44100)})
    }

    let lowPass = StandardAlgorithm<Standard.LowPass>()
    lowPass[realVecInput: .signal] = signal4
    lowPass.compute()
    signal4 = lowPass[realVecOutput: .signal]

    var five: Float = 5
    vDSP_vsmul(signal4, 1, &five, &signal4, 1, 44100)

    for i in 1..<44100 {
      (1..<10).forEach({signal4[i] += 0.1 / Float($0) * sinf(Float(i) * Float($0) * w / 44100)})
      signal4[i] += 0.5 * sinf(Float(i) * subw / 44100)
    }

    var max: Float = 0; vDSP_maxv(signal4, 1, &max, 44100); max += 1
    vDSP_vsdiv(signal4, 1, &max, &signal4, 1, 44100)

    runtTest(signal: signal4, frequency: 440, precision: (1.5, 0.3))

    /*
     Test with a real case.
     Note: The python test for this actually fails. The test performed here checks that the
           algorithm output matches the output when run using python.
     */

    let vectorInput = VectorInput<[Float]>(loadVectorVector(name: "pitchyin_mozartframes"))
    let pitchYin2 = StreamingAlgorithm<Streaming.PitchYin>([.frameSize: 1024, .sampleRate: 44100])
    let pool = Pool()

    vectorInput[output: .data] >> pitchYin2[input: .signal]
    pitchYin2[output: .pitch] >> pool[input: "pitch"]
    pitchYin2[output: .pitchConfidence] >> pool[input: "confidence"]

    let network = Network(generator: vectorInput)
    network.run()

    XCTAssertEqual(pool[realVec: "pitch"], loadVector(name: "pitchyin_expectedpitch"),
                   deviation: 1e-4)

    XCTAssertEqual(pool[realVec: "confidence"], loadVector(name: "pitchyin_expectedconfidence"),
                   deviation: 5e-5)

  }

  /// Tests functionality of the PitchYinFFT algorithm. Values taken from `test_pitchyinfft.py`.
  func testPitchYinFFT() {

    /// A simple helper for running the algorithm and testing its output.
    ///
    /// - Parameters:
    ///   - signal: The signal to feed into the algorithm.
    ///   - frequency: The frequency present in `signal`.
    ///   - deviation: Max allowable deviation values for pitch and pitch confidence.
    ///                Default is `(pitch: 0, confidence: 0.1)`
    ///   - file: The file to use in assertion statements. Default is `#file`.
    ///   - line: The line to use in assertion statements. Default is `#line`.
    func runtTest(signal: [Float],
                  frequency: Float,
                  precision: (pitch: Float, confidence: Float) = (1, 0.1),
                  file: StaticString = #file,
                  line: UInt = #line)
    {

      let vectorInput = VectorInput<Float>(signal)

      let frameCutter = StreamingAlgorithm<Streaming.FrameCutter>([
        .frameSize: 1024, .hopSize: 1024
        ])

      let windowing = StreamingAlgorithm<Streaming.Windowing>([.type: "hann"])

      let spectrum = StreamingAlgorithm<Streaming.Spectrum>()

      let pitchYinFFT = StreamingAlgorithm<Streaming.PitchYinFFT>([
        .frameSize: 1024, .sampleRate: 44100
        ])

      let pool = Pool()

      vectorInput[output: .data] >> frameCutter[input: .signal]
      frameCutter[output: .frame] >> windowing[input: .frame]
      windowing[output: .frame] >> spectrum[input: .frame]
      spectrum[output: .spectrum] >> pitchYinFFT[input: .spectrum]
      pitchYinFFT[output: .pitch] >> pool[input: "pitch"]
      pitchYinFFT[output: .pitchConfidence] >> pool[input: "confidence"]

      let network = Network(generator: vectorInput)
      network.run()

      XCTAssertAverageEqual(pool[realVec: "pitch"], frequency,
                            deviation: precision.pitch, file: file, line: line)
      XCTAssertAverageEqual(pool[realVec: "confidence"], 1,
                            deviation: precision.confidence, file: file, line: line)

    }

    /*
     Test with all-zero input.
     */

    let pitchYinFFT1 = StandardAlgorithm<Standard.PitchYinFFT>()
    pitchYinFFT1[realVecInput: .spectrum] = [0.0] * 1024
    pitchYinFFT1.compute()

    XCTAssertEqual(pitchYinFFT1[realOutput: .pitch], 0)
    XCTAssertEqual(pitchYinFFT1[realOutput: .pitchConfidence], 0)

    /*
     Test with a 440Hz sine wave.
     */

    let signal1: [Float] = (0..<44100).map({ (index: Int) -> Float in
      sinf((2 * Float.pi * 440 * Float(index)) / 44100)
    })

    runtTest(signal: signal1, frequency: 440)

    /*
     Test with a 660Hz band-limited square wave.
     */

    let signal2: [Float] = (0..<44100).map { [w = 2 * Float.pi * 660] (i: Int) -> Float in
      var sample: Float = 0
      for h in 0..<10 {
        sample += 0.5 / (2 * Float(h) + 1) * sinf((2 * Float(h) + 1) * Float(i) * w / 44100)
      }
      return sample
    }

    runtTest(signal: signal2, frequency: 660)

    /*
     Test with a 660Hz band-limited saw wave.
     */

    let signal3: [Float] = (0..<44100).map { [w = 2 * Float.pi * 660] (i: Int) -> Float in
      guard i > 0 else { return 0 }
      var sample: Float = 0
      for h in 1..<11 {
        sample += 1 / Float(h) * sinf(Float(h) * Float(i) * w / 44100)
      }
      return sample
    }

    runtTest(signal: signal3, frequency: 660, precision: (1.1, 0.1))

    /*
     Test with a masked 440Hz band-limited saw wave.
     */

    var signal4: [Float] = [0.0] * 44100
    let w = 2 * Float.pi * 440

    let subw = 2 * Float.pi * 340

    for i in 1..<44100 {
      signal4[i] += Float(4 * (drand48() - 0.5)) // White noise.
      (1..<10).forEach({signal4[i] += 1 / Float($0) * sinf(Float(i) * Float($0) * w / 44100)})
    }

    let lowPass = StandardAlgorithm<Standard.LowPass>()
    lowPass[realVecInput: .signal] = signal4
    lowPass.compute()
    signal4 = lowPass[realVecOutput: .signal]

    var five: Float = 5
    vDSP_vsmul(signal4, 1, &five, &signal4, 1, 44100)

    for i in 1..<44100 {
      (1..<10).forEach({signal4[i] += 0.1 / Float($0) * sinf(Float(i) * Float($0) * w / 44100)})
      signal4[i] += 0.5 * sinf(Float(i) * subw / 44100)
    }

    var max: Float = 0; vDSP_maxv(signal4, 1, &max, 44100); max += 1
    vDSP_vsdiv(signal4, 1, &max, &signal4, 1, 44100)

    runtTest(signal: signal4, frequency: 440, precision: (1.5, 0.3))

    /*
     Test with a real case.
     Note: The python test for this actually fails. The test performed here checks that the
           algorithm output matches the output when run using python.
     TODO: The failures may be due to the algorithm receiving non-zero values for what should
           be a first frame filled with zeros. The python `FrameGenerator` yields a first
           frame of zeros but `FrameCutter` seems not to do the same given the same signal.
     */

    let vectorInput = VectorInput<Float>(loadVector(name: "mozart_c_major_30sec_samples"))

    let frameCutter = StreamingAlgorithm<Streaming.FrameCutter>([
      .frameSize: 1024, .hopSize: 512
      ])

    let windowing = StreamingAlgorithm<Streaming.Windowing>([.type: "hann"])

    let spectrum = StreamingAlgorithm<Streaming.Spectrum>()

    let pitchYinFFT2 = StreamingAlgorithm<Streaming.PitchYinFFT>([
      .frameSize: 1024, .sampleRate: 44100
      ])

    let pool = Pool()

    vectorInput[output: .data] >> frameCutter[input: .signal]
    frameCutter[output: .frame] >> windowing[input: .frame]
    windowing[output: .frame] >> spectrum[input: .frame]
    spectrum[output: .spectrum] >> pitchYinFFT2[input: .spectrum]
    pitchYinFFT2[output: .pitch] >> pool[input: "pitch"]
    pitchYinFFT2[output: .pitchConfidence] >> pool[input: "confidence"]

    let network = Network(generator: vectorInput)
    network.run()

    XCTAssertEqual(pool[realVec: "pitch"],
                   loadVector(name: "pitchyinfft_expectedpitch"),
                   deviation: 1e-4)

    XCTAssertEqual(pool[realVec: "confidence"],
                   loadVector(name: "pitchyinfft_expectedconfidence"),
                   deviation: 5e-5)

  }

  /// Tests the functionality of the ChordsDetection algorithm. Values taken from
  /// `test_chordsdetection_streaming.py`.
  func testChordsDetection() {
    //TODO: Implement the  function
    XCTFail("\(#function) not yet implemented.")
  }

  func testKey() {
    //TODO: Implement the  function
    XCTFail("\(#function) not yet implemented.")
  }

  func testKeyExtractor() {
    //TODO: Implement the  function
    XCTFail("\(#function) not yet implemented.")
  }

  func testTonalExtractor() {
    //TODO: Implement the  function
    XCTFail("\(#function) not yet implemented.")
  }

  /// Tests the functionality of the Tristimulus algorithm. Values taken from
  /// `test_tristimulus.py`.
  func testTristimulus() {
    //TODO: Implement the  function
    XCTFail("\(#function) not yet implemented.")
  }

  func testSpectrumCQ() {
    //TODO: Implement the  function
    XCTFail("\(#function) not yet implemented.")
  }

}
