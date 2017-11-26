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
    let spectrum1 = SpectrumSAlgorithm()
    let pitchSalience1 = PitchSalienceSAlgorithm()
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
    let frameCutter2 = FrameCutterSAlgorithm()
    let windowing2 = WindowingSAlgorithm()
    let spectrum2 = SpectrumSAlgorithm()
    let pitchSalience2 = PitchSalienceSAlgorithm([
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
    let frameCutter3 = FrameCutterSAlgorithm()
    let windowing3 = WindowingSAlgorithm()
    let spectrum3 = SpectrumSAlgorithm()
    let pitchSalience3 = PitchSalienceSAlgorithm([
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
    let frameCutter4 = FrameCutterSAlgorithm()
    let windowing4 = WindowingSAlgorithm()
    let spectrum4 = SpectrumSAlgorithm()
    let pitchSalience4 = PitchSalienceSAlgorithm([
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
    let frameCutter5 = FrameCutterSAlgorithm()
    let windowing5 = WindowingSAlgorithm()
    let spectrum5 = SpectrumSAlgorithm()
    let pitchSalience5 = PitchSalienceSAlgorithm([
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
    let frameCutter6 = FrameCutterSAlgorithm()
    let windowing6 = WindowingSAlgorithm()
    let spectrum6 = SpectrumSAlgorithm()
    let pitchSalience6 = PitchSalienceSAlgorithm([
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

    let pitchSalience7 = PitchSalienceAlgorithm([
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

    let pitchSalience8 = PitchSalienceAlgorithm([
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

    let pitchSalience9 = PitchSalienceAlgorithm([
      .lowBoundary: 40,
      .highBoundary: 40
      ])

    pitchSalience9[realVecInput: .spectrum] = [4, 0, 0, 0, 0, 0, 0, 0, 0, 0] as [Float] * 2205
    pitchSalience9.compute()

    XCTAssertGreaterThan(pitchSalience9[realOutput: .pitchSalience], 0.9)

    /*
     Test off-peak boundaries.
     */

    let pitchSalience10 = PitchSalienceAlgorithm([
      .lowBoundary: 41,
      .highBoundary: 41
      ])

    pitchSalience10[realVecInput: .spectrum] = [4, 0, 0, 0, 0, 0, 0, 0, 0, 0] as [Float] * 2205
    pitchSalience10.compute()

    XCTAssertLessThan(pitchSalience10[realOutput: .pitchSalience], 0.1)

    /*
     Test with silence.
     */

    let pitchSalience11 = PitchSalienceAlgorithm()

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

    let harmonicPeaks1 = HarmonicPeaksAlgorithm([.maxHarmonics: 10])
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

    let harmonicPeaks2 = HarmonicPeaksAlgorithm([.maxHarmonics: 3])
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

    let harmonicPeaks3 = HarmonicPeaksAlgorithm([.maxHarmonics: 3])
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

    let harmonicPeaks4 = HarmonicPeaksAlgorithm([.maxHarmonics: 1])
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

    let harmonicPeaks5 = HarmonicPeaksAlgorithm()
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

    let highResolutionFeatures1 = HighResolutionFeaturesAlgorithm()
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
    let highResolutionFeatures2 = HighResolutionFeaturesSAlgorithm()
    let pool = Pool()

    vectorInput[output: .data] >> highResolutionFeatures2[input: .hpcp]
    highResolutionFeatures2[output: .equalTemperedDeviation] >> pool[singleInput: "deviation"]
    highResolutionFeatures2[output: .nonTemperedEnergyRatio] >> pool[singleInput: "energyRatio"]
    highResolutionFeatures2[output: .nonTemperedPeaksEnergyRatio] >> pool[singleInput: "peaksRatio"]

    let network = Network(generator: vectorInput)
    network.run()

    XCTAssertEqual(pool[real: "deviation"], 0.25)
    XCTAssertEqual(pool[real: "energyRatio"], 0.5)
    XCTAssertEqual(pool[real: "peaksRatio"], 0.5)

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

      let frameCutter = FrameCutterSAlgorithm([
        .frameSize: 1024, .hopSize: 1024
        ])

      let pitchYin = PitchYinSAlgorithm([
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

    let pitchYin1 = PitchYinAlgorithm()
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

    let lowPass = LowPassAlgorithm()
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
    let pitchYin2 = PitchYinSAlgorithm([.frameSize: 1024, .sampleRate: 44100])
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

      let frameCutter = FrameCutterSAlgorithm([
        .frameSize: 1024, .hopSize: 1024
        ])

      let windowing = WindowingSAlgorithm([.type: "hann"])

      let spectrum = SpectrumSAlgorithm()

      let pitchYinFFT = PitchYinFFTSAlgorithm([
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

    let pitchYinFFT1 = PitchYinFFTAlgorithm()
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

    let lowPass = LowPassAlgorithm()
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

    let frameCutter = FrameCutterSAlgorithm([
      .frameSize: 1024, .hopSize: 512
      ])

    let windowing = WindowingSAlgorithm([.type: "hann"])

    let spectrum = SpectrumSAlgorithm()

    let pitchYinFFT2 = PitchYinFFTSAlgorithm([
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

    let chordDictionary: [String: [Float]] = [
      "A":  [1, 0, 0, 0, 0.5, 0, 0, 0.3, 0, 0, 0, 0],
      "A#": [0, 1, 0, 0, 0, 0.5, 0, 0, 0.3, 0, 0, 0],
      "B":  [0, 0, 1, 0, 0, 0, 0.5, 0, 0, 0.3, 0, 0],
      "C":  [0, 0, 0, 1, 0, 0, 0, 0.5, 0, 0, 0.3, 0],
      "C#": [0, 0, 0, 0, 1, 0, 0, 0, 0.5, 0, 0, 0.3],
      "D":  [0.3, 0, 0, 0, 0, 1, 0, 0, 0, 0.5, 0, 0],
      "D#": [0, 0.3, 0, 0, 0, 0, 1, 0, 0, 0, 0.5, 0],
      "E":  [0, 0, 0.3, 0, 0, 0, 0, 1, 0, 0, 0, 0.5],
      "F":  [0.5, 0, 0, 0.3, 0, 0, 0, 0, 1, 0, 0, 0],
      "F#": [0, 0.5, 0, 0, 0.3, 0, 0, 0, 0, 1, 0, 0],
      "G":  [0, 0, 0.5, 0, 0, 0.3, 0, 0, 0, 0, 1, 0],
      "G#": [0, 0, 0, 0.5, 0, 0, 0.3, 0, 0, 0, 0, 1],

      "Am":  [1, 0, 0, 0.5, 0, 0, 0, 0.3, 0, 0, 0, 0],
      "A#m": [0, 1, 0, 0, 0.5, 0, 0, 0, 0.3, 0, 0, 0],
      "Bm":  [0, 0, 1, 0, 0, 0.5, 0, 0, 0, 0.3, 0, 0],
      "Cm":  [0, 0, 0, 1, 0, 0, 0.5, 0, 0, 0, 0.3, 0],
      "C#m": [0, 0, 0, 0, 1, 0, 0, 0.5, 0, 0, 0, 0.3],
      "Dm":  [0.3, 0, 0, 0, 0, 1, 0, 0, 0.5, 0, 0, 0],
      "D#m": [0, 0.3, 0, 0, 0, 0, 1, 0, 0, 0.5, 0, 0],
      "Em":  [0, 0, 0.3, 0, 0, 0, 0, 1, 0, 0, 0.5, 0],
      "Fm":  [0, 0, 0, 0.3, 0, 0, 0, 0, 1, 0, 0, 0.5],
      "F#m": [0.5, 0, 0, 0, 0.3, 0, 0, 0, 0, 1, 0, 0],
      "Gm":  [0, 0.5, 0, 0, 0, 0.3, 0, 0, 0, 0, 1, 0],
      "G#m": [0, 0, 0.5, 0, 0, 0, 0.3, 0, 0, 0, 0, 1]
    ]

    /// Helper for mapping a list of chord labels to chroma vector representations.
    ///
    /// - Parameter labels: The chord labels.
    /// - Returns: `labels` mapped to the vectors in `chordDictionary`.
    func progressionVectors(for labels: [String]) -> [[Float]] {
      return labels.flatMap({chordDictionary[$0]})
    }

    /// Helper for running the algorithm and performing assertions on the result.
    ///
    /// - Parameters:
    ///   - progression: The chord labels describing the progression.
    ///   - streaming: Whether to use streaming mode.
    ///   - file: The file in which failure occurred. Defaults to the file name of the test
    ///           case in which this function was called.
    ///   - line: The line number on which failure occurred. Defaults to the line number on
    ///           which this function was called.
    func test(progression: [String],
              streaming: Bool = true,
              file: StaticString = #file,
              line: UInt = #line)
    {
      let nChords = progression.count
      let chordsProgressionReal = progressionVectors(for: progression)
      let dur = Float(nChords)
      let sampleRate: Float = 44100
      let hopSize: Float = 2048
      let frameRate = sampleRate / hopSize
      let nFrames = Int(dur * frameRate - 1)
      var nextChange = frameRate

      var pcp: [[Float]] = [[0.0] * 12] * nFrames
      var expectedChords: [String] = []
      var j = 0
      for i in 0..<nFrames {
        if i == Int(nextChange) {
          j += 1
          nextChange += frameRate
        }
        expectedChords.append(progression[j % nChords])
        pcp[i] = chordsProgressionReal[j % nChords]
      }

      let pool = Pool()

      switch streaming {

      case true:

        let vectorInput = VectorInput<[Float]>(pcp)
        let chordsDetection = ChordsDetectionSAlgorithm([.windowSize: 2, .hopSize: 2048])

        vectorInput[output: .data] >> chordsDetection[input: .pcp]
        chordsDetection[output: .chords] >> pool[input: "chords.progression"]
        chordsDetection[output: .strength] >> pool[input: "chords.strength"]

        let network = Network(generator: vectorInput)
        network.run()

      case false:

        let chordsDetection = ChordsDetectionAlgorithm([.windowSize: 2, .hopSize: 2048])
        chordsDetection[realVecVecInput: .pcp] = pcp
        chordsDetection.compute()

        let chords = chordsDetection[stringVecOutput: .chords]
        let strengths = chordsDetection[realVecOutput: .strength]

        guard chords.count == strengths.count else {
          XCTFail("Lengths of algorithm outputs are not equal.", file: file, line: line)
          return
        }

        for index in 0..<chords.count {
          pool.add(.string(chords[index]), for: "chords.progression")
          pool.add(.real(strengths[index]), for: "chords.strength")
        }

      }

      var failureCount = 0

      for (index, (chordLabel, strength)) in zip(pool[stringVec: "chords.progression"],
                                                 pool[realVec: "chords.strength"]).enumerated()
      {

        if chordLabel != expectedChords[index] { failureCount += 1 }

        XCTAssertNotNaNOrInf(strength, file: file, line: line)
        XCTAssertGreaterThan(strength, 0, file: file, line: line)

      }

      XCTAssertLessThanOrEqual(failureCount, nChords)

    }

    /*
     Test with a major progression in streaming mode.
     */

    test(progression: ["A", "A#", "B", "C", "C#", "D",
                       "D#", "E", "F", "F#", "G", "G#"])

    /*
     Test with a minor progression in streaming mode.
     */

    test(progression: ["Am", "A#m", "Bm", "Cm", "C#m", "Dm",
                       "D#m", "Em", "Fm", "F#m", "Gm", "G#m"])

    /*
     Test with a major progression in standard mode.
     */

    test(progression: ["A", "A#", "B", "C", "C#", "D",
                       "D#", "E", "F", "F#", "G", "G#"], streaming: false)

    /*
     Test with a minor progression in standard mode.
     */

    test(progression: ["Am", "A#m", "Bm", "Cm", "C#m", "Dm",
                       "D#m", "Em", "Fm", "F#m", "Gm", "G#m"], streaming: false)

    /*
     Test with a pitch class profile of all zeros.
     */

    let vectorInput1 = VectorInput<[Float]>([[0.0] * 12] * 10)
    let chordsDetection1 = ChordsDetectionSAlgorithm([.windowSize: 2, .hopSize: 2048])
    let pool1 = Pool()

    vectorInput1[output: .data] >> chordsDetection1[input: .pcp]
    chordsDetection1[output: .chords] >> pool1[input: "chords.progression"]
    chordsDetection1[output: .strength] >> pool1[input: "chords.strength"]

    let network1 = Network(generator: vectorInput1)
    network1.run()

    XCTAssertEqual(pool1[stringVec: "chords.progression"], ["A"] * 10)
    XCTAssertEqual(pool1[realVec: "chords.strength"], [-1.0] * 10)

    /*
     Test that the correct number of chords are returned.
     */

    let vectorInput2 = VectorInput<Float>(monoBufferData(url: bundleURL(name: "musicbox",
                                                                        ext: "wav")))
    let dcRemoval = DCRemovalSAlgorithm()
    let equalLoudness = EqualLoudnessSAlgorithm()
    let frameCutter = FrameCutterSAlgorithm([
      .frameSize: 2048, .hopSize: 1024, .silentFrames: "noise"
      ])
    let windowing = WindowingSAlgorithm([.size: 2048])
    let spectrum = SpectrumSAlgorithm()
    let spectralPeaks = SpectralPeaksSAlgorithm()
    let spectralWhitening = SpectralWhiteningSAlgorithm()
    let hpcp = HPCPSAlgorithm()
    let chordsDetection2 = ChordsDetectionSAlgorithm([.hopSize: 1024])
    let pool2 = Pool()

    vectorInput2[output: .data] >> dcRemoval[input: .signal]
    dcRemoval[output: .signal] >> equalLoudness[input: .signal]
    equalLoudness[output: .signal] >> frameCutter[input: .signal]
    frameCutter[output: .frame] >> windowing[input: .frame]
    windowing[output: .frame] >> spectrum[input: .frame]
    spectrum[output: .spectrum] >> spectralPeaks[input: .spectrum]
    spectrum[output: .spectrum] >> spectralWhitening[input: .spectrum]
    spectralPeaks[output: .frequencies] >> spectralWhitening[input: .frequencies]
    spectralPeaks[output: .magnitudes] >> spectralWhitening[input: .magnitudes]
    spectralWhitening[output: .magnitudes] >> hpcp[input: .magnitudes]
    spectralPeaks[output: .frequencies] >> hpcp[input: .frequencies]
    hpcp[output: .hpcp] >> chordsDetection2[input: .pcp]
    chordsDetection2[output: .chords] >> pool2[input: "chords"]
    chordsDetection2[output: .strength]>>|
    hpcp[output: .hpcp] >> pool2[input: "hpcp"]

    let network2 = Network(generator: vectorInput2)
    network2.run()

    XCTAssertEqual(pool2[stringVec: "chords"].count, pool2[realVecVec: "hpcp"].count)

  }

  /// Tests the functionality of the Key algorithm. Values taken from `test_key.py`.
  func testKey() {

    /// A typealias to make the declarations of the helper functions that follow slightly less
    /// obnoxious.
    typealias AlgorithmResult = (key: String,
                                 scale: String,
                                 strength: Float,
                                 firstToSecondRelativeStrength: Float)

    /// Helper that runs the `Key` algorithm with the specified parameters.
    ///
    /// - Parameters:
    ///   - usePolyphony: The value for `Key.Parameter.usePolophony`.
    ///   - useThreeChords: The value for `Key.Parameter.useThreeChords`.
    ///   - numHarmonics: The value for `Key.Parameter.numHarmonics`.
    ///   - slope: The value for `Key.Parameter.slope`.
    ///   - profileType: The value for `Key.Parameter.profileType`.
    ///   - pcpSize: The value for `Key.Parameter.pcpSize`.
    /// - Returns: The key, scale, strength, and firstToSecondRelativeStrength values computed
    ///            by the key algorithm for 'mozart_c_major_30sec.wav' using the specified
    ///            parameter values.
    func runAlgorithm(usePolyphony: Bool = true,
                      useThreeChords: Bool = true,
                      numHarmonics: Int = 4,
                      slope: Float = 0.6,
                      profileType: String = "temperley",
                      pcpSize: Int = 36) -> AlgorithmResult
    {

      let signal = monoBufferData(url: bundleURL(name: "mozart_c_major_30sec", ext: "wav"))

      let frameCutter = FrameCutterAlgorithm([.frameSize: 4096, .hopSize: 512])
      frameCutter[realVecInput: .signal] = signal
      let windowing = WindowingAlgorithm([.type: "blackmanharris62"])
      let spectrum = SpectrumAlgorithm([.size: 4096])
      let spectralPeaks = SpectralPeaksAlgorithm([
        .sampleRate: 44100, .maxFrequency: 22050, .minFrequency: 0, .orderBy: "magnitude"
        ])
      let hpcp = HPCPAlgorithm([
        .size: Parameter(value: .integer(Int32(pcpSize))),
        .harmonics: Parameter(value: .integer(Int32(numHarmonics - 1))),
        .windowSize: 0.5
        ])


      frameCutter.compute()
      var frame = frameCutter[realVecOutput: .frame]
      var sums: [Float] = [0.0] * pcpSize
      var count: Float = 0

      while frame.count > 0 {

        windowing[realVecInput: .frame] = frame
        windowing.compute()

        spectrum[realVecInput: .frame] = windowing[realVecOutput: .frame]
        spectrum.compute()

        spectralPeaks[realVecInput: .spectrum] = spectrum[realVecOutput: .spectrum]
        spectralPeaks.compute()

        hpcp[realVecInput: .frequencies] = spectralPeaks[realVecOutput: .frequencies]
        hpcp[realVecInput: .magnitudes] = spectralPeaks[realVecOutput: .magnitudes]
        hpcp.compute()

        for (index, value) in hpcp[realVecOutput: .hpcp].enumerated() {
          sums[index] += value
        }

        count += 1

        frameCutter.compute()
        frame = frameCutter[realVecOutput: .frame]

      }

      var avgs: [Float] = [0.0] * sums.count
      vDSP_vsdiv(sums, 1, &count, &avgs, 1, vDSP_Length(sums.count))

      let key = KeyAlgorithm([
        .usePolyphony: Parameter(value: .boolean(usePolyphony)),
        .useThreeChords: Parameter(value: .boolean(useThreeChords)),
        .numHarmonics: Parameter(value: .integer(Int32(numHarmonics))),
        .slope: Parameter(value: .real(slope)),
        .profileType: Parameter(value: .string(profileType)),
        .pcpSize: Parameter(value: .integer(Int32(pcpSize)))
        ])

      key[realVecInput: .pcp] = avgs
      key.compute()

      return (key: key[stringOutput: .key],
              scale: key[stringOutput: .scale],
              strength: key[realOutput: .strength],
              firstToSecondRelativeStrength: key[realOutput: .firstToSecondRelativeStrength])

    }

    /// Performs various assertions on output from the key algorithm.
    ///
    /// - Parameters:
    ///   - result: The key algorithm output values to validate.
    ///   - file: The file in which failure occurred. Defaults to the file name of the test case
    ///           in which this function was called.
    ///   - line: The line number on which failure occurred. Defaults to the line number on which
    ///           this function was called.
    func validateResult(_ result: AlgorithmResult, file: StaticString = #file, line: UInt = #line) {

      let keys: Set<String> = ["A","A#","B","C","C#","D","D#","E","F","F#","G","G#"]
      let scales: Set<String> = ["major", "minor"]

      XCTAssert(keys.contains(result.key), file: file, line: line)
      XCTAssert(scales.contains(result.scale), file: file, line: line)
      XCTAssertNotNaNOrInf(result.strength)
      XCTAssertNotNaNOrInf(result.firstToSecondRelativeStrength)

    }

    /*
     Test for regression.
     */

    let (key, scale, strength, firstToSecondRelativeStrength) = runAlgorithm()

    XCTAssertEqual(key, "C")
    XCTAssertEqual(scale, "major")
    XCTAssertEqual(strength, 0.760322451591, accuracy: 1e-6)
    XCTAssertEqual(firstToSecondRelativeStrength, 0.607807099819, accuracy: 1e-6)

    /*
     Test with `usePolophony` set to `false`.
     */

    validateResult(runAlgorithm(usePolyphony: false))

    /*
     Test with `useThreeChords` set to `false`.
     */

    validateResult(runAlgorithm(useThreeChords: false))

    /*
     Test using various profile types.
     */

    validateResult(runAlgorithm(profileType: "diatonic"))
    validateResult(runAlgorithm(profileType: "krumhansl"))
    validateResult(runAlgorithm(profileType: "weichai"))
    validateResult(runAlgorithm(profileType: "tonictriad"))
    validateResult(runAlgorithm(profileType: "temperley2005"))
    validateResult(runAlgorithm(profileType: "thpcp"))
    
    /*
     Test with `numHarmonics` set to `1`.
     */

    validateResult(runAlgorithm(numHarmonics: 1))

  }

  /// Tests the functionality of the Tristimulus algorithm. Values taken from
  /// `test_tristimulus.py`.
  func testTristimulus() {

    /*
     Test with all-zero magnitudes.
     */

    let tristimulus1 = TristimulusAlgorithm()
    tristimulus1[realVecInput: .magnitudes] = [0, 0, 0, 0, 0]
    tristimulus1[realVecInput: .frequencies] = [23, 500, 3200, 9000, 10000]
    tristimulus1.compute()

    XCTAssertEqual(tristimulus1[realVecOutput: .tristimulus], [0, 0, 0])

    /*
     Test with 3 frequencies.
     */

    let tristimulus2 = TristimulusAlgorithm()
    tristimulus2[realVecInput: .magnitudes] = [1, 2, 3]
    tristimulus2[realVecInput: .frequencies] = [100, 200, 300]
    tristimulus2.compute()

    XCTAssertEqual(tristimulus2[realVecOutput: .tristimulus], [Float(1) / 6, 0, 0])

    /*
     Test with 4 frequencies.
     */

    let tristimulus3 = TristimulusAlgorithm()
    tristimulus3[realVecInput: .magnitudes] = [1, 2, 3, 4]
    tristimulus3[realVecInput: .frequencies] = [100, 435, 6547, 24324]
    tristimulus3.compute()

    XCTAssertEqual(tristimulus3[realVecOutput: .tristimulus], [0.1, 0.9, 0])

    /*
     Test with 5 frequencies.
     */

    let tristimulus4 = TristimulusAlgorithm()
    tristimulus4[realVecInput: .magnitudes] = [1, 2, 3, 4, 5]
    tristimulus4[realVecInput: .frequencies] = [100, 324, 5678, 5899, 60000]
    tristimulus4.compute()

    XCTAssertEqual(tristimulus4[realVecOutput: .tristimulus], [Float(1) / 15, 0.6, Float(1) / 3])

    /*
     Test with empty input.
     */

    let tristimulus5 = TristimulusAlgorithm()
    tristimulus5[realVecInput: .magnitudes] = []
    tristimulus5[realVecInput: .frequencies] = []
    tristimulus5.compute()

    XCTAssertEqual(tristimulus5[realVecOutput: .tristimulus], [0, 0, 0])

  }

  /// Tests the functionality of the SpectrumCQ algorithm.
  func testSpectrumCQ() {
    //TODO: Implement the  function
    XCTFail("\(#function) not yet implemented.")
  }

  /// Tests the functionality of the Chromagram algorithm. Values taken from `test_chromagram.py`.
  func testChromagram() {
    //TODO: Implement the  function
    XCTFail("\(#function) not yet implemented.")

    /*
    def testRandom(self):
        # input is [1, 0, 0, ...] which corresponds to an ConstantQ of constant magnitude 1
        with open(os.path.join(script_dir,'constantq/CQinput.txt'), 'r') as f:
        	#read_data = f.read()
        	data = np.array([], dtype='complex64')
        	line = f.readline()
        	while line != '':
        		re = float(line.split('\t')[0])
        		im = float(line.split('\t')[1])
        		data = np.append(data, re + im * 1j)
        		line = f.readline()



        QMChroma_out = [float(line.rstrip('\n')) for line in open(os.path.join(script_dir,'constantq/QMChroma_out.txt'))]



        Chroma_data = Chromagram()(cvec(data))

        DifferMean = QMChroma_out-Chroma_data  # difference mean
        DifferMean = sum(abs(DifferMean))/len(DifferMean)# difference mean

        DiverPer = abs(sum(((QMChroma_out-Chroma_data)/QMChroma_out)*100)/len(QMChroma_out) )#divergence mean percentage

        """
        print 'Divergence mean percentage is : '+str(DiverPer)[:5]+'%'
        print 'Difference Mean is : '+str(DifferMean)
        """
     */

  }

}
