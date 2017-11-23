//
//  SpectralAlgorithmTests.swift
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

class SpectralAlgorithmTests: XCTestCase {

  /// Tests the frequency bands algorithm. Values taken from 'test_frequencybands.py'.
  func testFrequencyBands() {

    let audioSignal = monoBufferData(url: bundleURL(name: "sin440_sweep_0db", ext: "wav"))

    let vectorInput1 = VectorInput<Float>(audioSignal)
    let frameCutter = StreamingAlgorithm<Streaming.FrameCutter>([.frameSize: 2048, .hopSize: 512])
    let windowing = StreamingAlgorithm<Streaming.Windowing>([.type: "hamming"])
    let spectrum = StreamingAlgorithm<Streaming.Spectrum>()
    let frequencyBands = StreamingAlgorithm<Streaming.FrequencyBands>([.sampleRate: 44100])
    let vectorOutput = VectorOutput<[Float]>()

    vectorInput1[output: .data] >> frameCutter[input: .signal]
    frameCutter[output: .frame] >> windowing[input: .frame]
    windowing[output: .frame] >> spectrum[input: .frame]
    spectrum[output: .spectrum] >> frequencyBands[input: .spectrum]
    frequencyBands[output: .bands] >> vectorOutput[input: .data]

    let network1 = Network(generator: vectorInput1)
    network1.run()

    XCTAssertNotNaNOrInf(vectorOutput.vector)

    vectorInput1[output: .data] >! frameCutter[input: .signal]
    frameCutter[output: .frame] >! windowing[input: .frame]
    windowing[output: .frame] >! spectrum[input: .frame]
    spectrum[output: .spectrum] >! frequencyBands[input: .spectrum]

    let vectorInput2 = VectorInput<[Float]>([[1.0] * 1024])
    vectorInput2[output: .data] >> frequencyBands[input: .spectrum]

    let binFrequency: Float = 22050/1023
    let bands: [Float] = (0..<4).map { 8 * Float($0) * binFrequency }

    frequencyBands[realVecParameter: .frequencyBands] = bands

    network1.clear()

    let network2 = Network(generator: vectorInput2)
    network2.run()

    XCTAssertEqual(vectorOutput.vector.last ?? [], [8.0, 8.0, 8.0])

  }

  /// Tests the functionality of the `HPCP` algorithm. Values taken from 'test_hpcp.py'.
  func testHPCP() {

    /*
     Test whether a real audio signal of one pure tone gets read as a single semitone activation,
     and gets read into the right pcp bin.
     */

    let audioSignal1 = monoBufferData(url: bundleURL(name: "sin440_0db", ext: "wav"))

    let vectorInput1 = VectorInput<[Float]>([audioSignal1])

    let spectrum1 = StreamingAlgorithm<Streaming.Spectrum>()

    let spectralPeaks1 = StreamingAlgorithm<Streaming.SpectralPeaks>([
      .sampleRate: 44100,
      .maxPeaks: 1,
      .maxFrequency: 22050,
      .minFrequency: 0,
      .magnitudeThreshold: 0,
      .orderBy: "magnitude"
      ])

    let hpcp1 = StreamingAlgorithm<Streaming.HPCP>()

    let vectorOutput1 = VectorOutput<[Float]>()

    vectorInput1[output: .data] >> spectrum1[input: .frame]
    spectrum1[output: .spectrum] >> spectralPeaks1[input: .spectrum]
    spectralPeaks1[output: .frequencies] >> hpcp1[input: .frequencies]
    spectralPeaks1[output: .magnitudes] >> hpcp1[input: .magnitudes]
    hpcp1[output: .hpcp] >> vectorOutput1[input: .data]

    let network1 = Network(generator: vectorInput1)
    network1.run()

    XCTAssertEqual(vectorOutput1.vector[0],
                   [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0])

    /*
     Test whether a spectral peak output of 12 consecutive semitones yields a HPCP of all 1's
     for octaves 1 through 8.
     */

    for octave in 1...8 {

      let tonic: Float = 55 * pow(2, Float(octave - 1))

      let hpcp = StandardAlgorithm<Standard.HPCP>([.maxFrequency: 14000])
      hpcp[realVecInput: .frequencies] = (0..<12).map { tonic * exp2(Float($0)/12) }
      hpcp[realVecInput: .magnitudes] = [1.0] * 12
      hpcp.compute()

      XCTAssertEqual(hpcp[realVecOutput: .hpcp], [1.0] * 12)

    }

    /*
      Test low and high frequency cutoff parameters.
     */

    let hpcp2 = StandardAlgorithm<Standard.HPCP>([.minFrequency: 100, .maxFrequency: 1000])
    hpcp2[realVecInput: .frequencies] = [99, 1001]
    hpcp2[realVecInput: .magnitudes] = [1, 1]
    hpcp2.compute()
    XCTAssertEqual(hpcp2[realVecOutput: .hpcp], [0.0] * 12)

    /*
      Test regression for the 'harmonics' parameter.
     */

    let hpcp3 = StandardAlgorithm<Standard.HPCP>([
      .minFrequency: 50, .maxFrequency: 500, .bandPreset: false, .harmonics: 3
      ])

    hpcp3[realVecInput: .frequencies] = [100, 200, 300, 400]
    hpcp3[realVecInput: .magnitudes]  = [1, 1, 1, 1]
    hpcp3.compute()
    XCTAssertEqual(hpcp3[realVecOutput: .hpcp],
                   [0.0, 0.0, 0.0, 0.1340538263, 0.0, 0.2476127148, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0])


    /*
      Test with white noise.
     */

    let spectrumSize = 262144
    let binResolution: Float = 20050 / Float(spectrumSize)

    let hpcp4 = StandardAlgorithm<Standard.HPCP>([
      .minFrequency: 440,
      .maxFrequency: 880,
      .bandPreset: false,
      .weightType: "none",
      .normalized: "none"
      ])

    hpcp4[realVecInput: .frequencies] = (1...spectrumSize).map { Float($0) * binResolution }
    hpcp4[realVecInput: .magnitudes] = [1.0] * spectrumSize
    hpcp4.compute()

    var weights = (0..<13).map { exp2(Float($0) / 12) }
    weights[0] = weights[0] * 0.5 + weights[12] * 0.5
    weights = Array(weights.dropLast())

    var hpcp4Output = zip(hpcp4[realVecOutput: .hpcp], weights).map(/)

    if let maxElement = hpcp4Output.max(), maxElement != 0 {
      for index in hpcp4Output.indices { hpcp4Output[index] /= maxElement }
    }

    XCTAssertEqual(hpcp4Output, [1.0] * 12, accuracy: 1e-2)

    /*
     Test algorithm on a real data source.
     */

    let audioSignal2 = monoBufferData(url: bundleURL(name: "musicbox", ext: "wav"))

    let vectorInput2 = VectorInput<Float>(audioSignal2)

    let frameCutter = StreamingAlgorithm<Streaming.FrameCutter>([.frameSize: 512, .hopSize: 512])

    let windowing = StreamingAlgorithm<Streaming.Windowing>([.type: "blackmanharris62"])

    let spectrum2 = StreamingAlgorithm<Streaming.Spectrum>([.size: 512])

    let spectralPeaks2 = StreamingAlgorithm<Streaming.SpectralPeaks>([
      .sampleRate: 44100,
      .maxFrequency: 22050,
      .minFrequency: 0,
      .orderBy: "magnitude"
      ])

    let hpcp5 = StreamingAlgorithm<Streaming.HPCP>([
      .minFrequency: 50,
      .maxFrequency: 500,
      .bandPreset: false,
      .harmonics: 3
      ])

    let vectorOutput2 = VectorOutput<[Float]>()

    vectorInput2[output: .data] >> frameCutter[input: .signal]
    frameCutter[output: .frame] >> windowing[input: .frame]
    windowing[output: .frame] >>  spectrum2[input: .frame]
    spectrum2[output: .spectrum] >> spectralPeaks2[input: .spectrum]
    spectralPeaks2[output: .frequencies] >> hpcp5[input: .frequencies]
    spectralPeaks2[output: .magnitudes] >> hpcp5[input: .magnitudes]
    hpcp5[output: .hpcp] >> vectorOutput2[input: .data]

    let network2 = Network(generator: vectorInput2)
    network2.run()

    XCTAssertNotNaNOrInf(vectorOutput2.vector)

  }

  /// Tests the functionality of the `TuningFrequency` algorithm. Values taken from
  /// 'test_tuningfrequency.py`.
  func testTuningFrequency() {

    /*
     Test algorithm using a sinusoid.
     Note: Passing would require broadening the accuracy value from 0.5 (used in python test)
           to 0.757.
     */

    let audioSignal = monoBufferData(url: bundleURL(name: "sin440_0db", ext: "wav"))

    let vectorInput = VectorInput<Float>(audioSignal)

    let frameCutter = StreamingAlgorithm<Streaming.FrameCutter>([.frameSize: 2048, .hopSize: 2048])

    let windowing = StreamingAlgorithm<Streaming.Windowing>([.type: "hann"])

    let spectrum = StreamingAlgorithm<Streaming.Spectrum>()

    let spectralPeaks = StreamingAlgorithm<Streaming.SpectralPeaks>([
      .sampleRate: 44100,
      .maxPeaks: 1,
      .maxFrequency: 10000,
      .minFrequency: 0,
      .magnitudeThreshold: 0,
      .orderBy: "magnitude"
      ])

    let tuningFrequency1 = StreamingAlgorithm<Streaming.TuningFrequency>([.resolution: 1])

    let pool = Pool()

    vectorInput[output: .data] >> frameCutter[input: .signal]
    frameCutter[output: .frame] >> windowing[input: .frame]
    windowing[output: .frame] >> spectrum[input: .frame]
    spectrum[output: .spectrum] >> spectralPeaks[input: .spectrum]
    spectralPeaks[output: .frequencies] >> tuningFrequency1[input: .frequencies]
    spectralPeaks[output: .magnitudes] >> tuningFrequency1[input: .magnitudes]
    tuningFrequency1[output: .tuningCents] >> pool[input: "tuningCents"]
    tuningFrequency1[output: .tuningFrequency] >> pool[input: "tuningFrequency"]

    let network = Network(generator: vectorInput)
    network.run()

    XCTAssertAverageEqual(pool[realVec: "tuningCents"], 0.0, accuracy: 4.0)
    XCTAssertAverageEqual(pool[realVec: "tuningFrequency"], Float(440), deviation: 0.5)

    /*
      Test that empty input produces the expected values.
     */

    let tuningFrequency2 = StandardAlgorithm<Standard.TuningFrequency>()
    tuningFrequency2[realVecInput: .frequencies] = []
    tuningFrequency2[realVecInput: .magnitudes] = []
    tuningFrequency2.compute()

    XCTAssertEqual(tuningFrequency2[realOutput: .tuningCents], 0.0)
    XCTAssertEqual(tuningFrequency2[realOutput: .tuningFrequency], 440.0)

    /*
     Test that an input of zero produces the expected values.
     */

    let tuningFrequency3 = StandardAlgorithm<Standard.TuningFrequency>()
    tuningFrequency3[realVecInput: .frequencies] = [0]
    tuningFrequency3[realVecInput: .magnitudes] = [0]
    tuningFrequency3.compute()

    XCTAssertEqual(tuningFrequency3[realOutput: .tuningCents], 0.0)
    XCTAssertEqual(tuningFrequency3[realOutput: .tuningFrequency], 440.0)

  }

  /// Tests the functionality of the `SpectralPeaks` algorithm. Values taken from
  /// `test_spectralpeaks.py`.
  func testSpectralPeaks() {

    /*
     Regression test for various peak shapes.
     */

    let spectralPeaks1 = StandardAlgorithm<Standard.SpectralPeaks>([
      .sampleRate: 198,
      .maxPeaks: 100,
      .maxFrequency: 99,
      .minFrequency: 0,
      .magnitudeThreshold: 1e-6,
      .orderBy: "frequency"
      ])

    spectralPeaks1[realVecInput: .spectrum] = loadVector(name: "spectralpeaks_spectrum")
    spectralPeaks1.compute()

    XCTAssertEqual(spectralPeaks1[realVecOutput: .frequencies],
                   loadVector(name: "spectralpeaks_expectedfrequencies"),
                   deviation: 1e-5)

    XCTAssertEqual(spectralPeaks1[realVecOutput: .magnitudes],
                   loadVector(name: "spectralpeaks_expectedmagnitudes"),
                   accuracy: 1e-5)

    /*
     Test with a sinusoid.
     */

    let audioSignal = monoBufferData(url: bundleURL(name: "sin5000", ext: "wav"))
    let vectorInput = VectorInput<Float>(audioSignal)
    let frameCutter = StreamingAlgorithm<Streaming.FrameCutter>([.frameSize: 2048, .hopSize: 2048])
    let windowing = StreamingAlgorithm<Streaming.Windowing>([.type: "blackmanharris62"])
    let spectrum2 = StreamingAlgorithm<Streaming.Spectrum>()

    let spectralPeaks2 = StreamingAlgorithm<Streaming.SpectralPeaks>([
      .sampleRate: 44100,
      .maxPeaks: 1,
      .maxFrequency: 10000,
      .minFrequency: 0,
      .orderBy: "magnitude"
      ])

    let vectorOutput = VectorOutput<[Float]>()

    vectorInput[output: .data] >> frameCutter[input: .signal]
    frameCutter[output: .frame] >> windowing[input: .frame]
    windowing[output: .frame] >> spectrum2[input: .frame]
    spectrum2[output: .spectrum] >> spectralPeaks2[input: .spectrum]
    spectralPeaks2[output: .frequencies] >> vectorOutput[input: .data]
    spectralPeaks2[output: .magnitudes]>>|

    let network = Network(generator: vectorInput)
    network.run()

    XCTAssertEqual(vectorOutput.vector,
                   loadVectorVector(name: "spectralpeaks_sinusoidfrequencies"),
                   deviation: 1e-3)


    /*
     Test that all-zero input leads to empty output arrays.
     */

    let spectralPeaks3 = StandardAlgorithm<Standard.SpectralPeaks>()
    spectralPeaks3[realVecInput: .spectrum] = [0.0] * 1024
    spectralPeaks3.compute()

    XCTAssert(spectralPeaks3[realVecOutput: .frequencies].isEmpty)
    XCTAssert(spectralPeaks3[realVecOutput: .magnitudes].isEmpty)

  }

  /// Tests the functionality of the `SpectrumToCent` algorithm. Values taken from
  /// 'test_spectrumtocent.py`.
  func testSpectrumToCent() {

    /*
     Tests that the algorithm behaves the same as directly calling `TrianglularBands` with known
     bands.
     */

    let audioSignal = monoBufferData(url: bundleURL(name: "sin440_sweep_0db", ext: "wav"))

    let frameSize = 2048
    let hopSize = 512

    let signalSlice = Array(audioSignal[(frameSize * 10)..<(frameSize * 11 + hopSize * 3)])

    let vectorInput = VectorInput<Float>(signalSlice)

    let frameCutter = StreamingAlgorithm<Streaming.FrameCutter>([
      .frameSize: Parameter(value: .integer(Int32(frameSize))),
      .hopSize: Parameter(value: .integer(Int32(hopSize)))
      ])

    let spectrum = StreamingAlgorithm<Streaming.Spectrum>()

    let fftSize = Int(exp2(Float(16)))
    let zeroPadding = Int32(fftSize - frameSize)
    let spectrumSize = Int32(fftSize / 2 + 1)

    let windowing = StreamingAlgorithm<Streaming.Windowing>([
      .type: "hamming",
      .zeroPadding: Parameter(value: .integer(zeroPadding))
      ])

    let triangularBands = StreamingAlgorithm<Streaming.TriangularBands>([
      .inputSize: Parameter(value: .integer(spectrumSize)),
      .frequencyBands: Parameter(value: .realVec(loadVector(name: "frequencyBands"))),
      .log: false,
      .sampleRate: 44100
      ])

    let spectrumToCent = StreamingAlgorithm<Streaming.SpectrumToCent>([
      .inputSize: Parameter(value: .integer(spectrumSize)),
      .minimumFrequency: 164.814,
      .bands: 720,
      .log: false,
      .sampleRate: 44100
      ])

    let vectorOutputT = VectorOutput<[Float]>()
    let vectorOutputC = VectorOutput<[Float]>()

    vectorInput[output: .data] >> frameCutter[input: .signal]
    frameCutter[output: .frame] >> windowing[input: .frame]
    windowing[output: .frame] >> spectrum[input: .frame]
    spectrum[output: .spectrum] >> triangularBands[input: .spectrum]
    spectrum[output: .spectrum] >> spectrumToCent[input: .spectrum]
    triangularBands[output: .bands] >> vectorOutputT[input: .data]
    spectrumToCent[output: .bands] >> vectorOutputC[input: .data]
    spectrumToCent[output: .frequencies]>>|

    let network = Network(generator: vectorInput)
    network.run()

    let bandsT = vectorOutputT.vector
    let bandsC = vectorOutputC.vector

    XCTAssertNotNaNOrInf(bandsC)
    XCTAssertGreaterThanOrEqual(bandsC, 0.0)
    XCTAssertEqual(bandsC, bandsT, accuracy: 1e-4)

  }

  /// Tests the functionality of the `SpectralWhitening` algorithm. Values taken from
  /// `test_spectralwhitening.py`.
  func testSpectralWhitening() {

    /*
     Test the algorithm with a sinusoid.
     */

    let audioSignal = monoBufferData(url: bundleURL(name: "sin5000", ext: "wav"))

    let vectorInput = VectorInput<Float>(audioSignal)
    let frameCutter = StreamingAlgorithm<Streaming.FrameCutter>([.frameSize: 512, .hopSize: 512])
    let windowing = StreamingAlgorithm<Streaming.Windowing>([.type: "blackmanharris62"])
    let spectrum = StreamingAlgorithm<Streaming.Spectrum>([.size: 512])

    let spectralPeaks = StreamingAlgorithm<Streaming.SpectralPeaks>([
      .sampleRate: 44100,
      .maxPeaks: 3,
      .maxFrequency: 22050,
      .minFrequency: 0,
      .magnitudeThreshold: 0,
      .orderBy: "magnitude"
      ])

    let spectralWhitening1 = StreamingAlgorithm<Streaming.SpectralWhitening>([
      .maxFrequency: 22050,
      .sampleRate: 44100
      ])

    let vectorOutput = VectorOutput<[Float]>()

    vectorInput[output: .data] >> frameCutter[input: .signal]
    frameCutter[output: .frame] >> windowing[input: .frame]
    windowing[output: .frame] >> spectrum[input: .frame]
    spectrum[output: .spectrum] >> spectralPeaks[input: .spectrum]
    spectralPeaks[output: .frequencies] >> spectralWhitening1[input: .frequencies]
    spectralPeaks[output: .magnitudes] >> spectralWhitening1[input: .magnitudes]
    spectrum[output: .spectrum] >> spectralWhitening1[input: .spectrum]
    spectralWhitening1[output: .magnitudes] >> vectorOutput[input: .data]

    let network = Network(generator: vectorInput)
    network.run()

    var magnitudeAverages: [Float] = [0, 0, 0]
    let frames = vectorOutput.vector

    for frame in frames {
      magnitudeAverages[0] += frame[0]
      magnitudeAverages[1] += frame[1]
      magnitudeAverages[2] += frame[2]
    }

    magnitudeAverages[0] /= Float(frames.count)
    magnitudeAverages[1] /= Float(frames.count)
    magnitudeAverages[2] /= Float(frames.count)

    XCTAssertEqual(magnitudeAverages,
                   [0.05626755335908027, 0.0030654285443056555, 0.0041451468459836284],
                   accuracy: 1e-5)

    /*
     Test with input consisting of all zeros.
     */

    let spectralWhitening2 = StandardAlgorithm<Standard.SpectralWhitening>()
    spectralWhitening2[realVecInput: .frequencies] = [0.0] * 3
    spectralWhitening2[realVecInput: .magnitudes] = [0.0] * 3
    spectralWhitening2[realVecInput: .spectrum] = [0.0] * 100
    spectralWhitening2.compute()

    XCTAssertEqual(spectralWhitening2[realVecOutput: .magnitudes], [1.0] * 3)

    /*
     Test with a single value.
     */

    let spectralWhitening3 = StandardAlgorithm<Standard.SpectralWhitening>()
    spectralWhitening3[realVecInput: .frequencies] = [30]
    spectralWhitening3[realVecInput: .magnitudes] = [10]
    spectralWhitening3[realVecInput: .spectrum] = [10]
    spectralWhitening3.compute()

    XCTAssertEqual(spectralWhitening3[realVecOutput: .magnitudes], [0.9828788638])


    /*
      Test that frequencies above 'maxFrequency' are ignored.
     */
    let spectralWhitening4 = StandardAlgorithm<Standard.SpectralWhitening>([.maxFrequency: 100])
    spectralWhitening4[realVecInput: .frequencies] = [101, 102]
    spectralWhitening4[realVecInput: .magnitudes] = [1, 1]
    spectralWhitening4[realVecInput: .spectrum] = [1.0] * 100
    spectralWhitening4.compute()

    XCTAssertEqual(spectralWhitening4[realVecOutput: .magnitudes], [1.0, 1.0])

    /*
     Test boundary case.
     */

    let bound: Float = 100.0 * 1.2 - 100.00001

    let spectralWhitening5 = StandardAlgorithm<Standard.SpectralWhitening>([.maxFrequency: 100])
    spectralWhitening5[realVecInput: .frequencies] = [bound, bound + 1]
    spectralWhitening5[realVecInput: .magnitudes] = [1, 1]
    spectralWhitening5[realVecInput: .spectrum] = (0..<100).map(Float.init)
    spectralWhitening5.compute()

    XCTAssertEqual(spectralWhitening5[realVecOutput: .magnitudes], [0.9885531068, 1.0])

  }

  /// Tests the functionality of the TriangularBands algorithm. Values taken from
  /// `test_triangularbands.py`.
  func testTriangularBands() {
    //TODO: Implement the  function
    XCTFail("\(#function) not yet implemented.")

    /*
    def testRegression(self):
        # Simple regression test, comparing normal behaviour
        audio = MonoLoader(filename = join(testdata.audio_dir, 'generated/synthesised/sin440_sweep_0db.wav'),
                           sampleRate = 44100)()

        fft = Spectrum()
        window = Windowing(type = 'hamming')
        fbands = TriangularBands(sampleRate = 44100)

        for frame in FrameGenerator(audio, frameSize = 2048, hopSize = 512):
            bands = fbands(fft(window(frame)))

            self.assert_(not any(numpy.isnan(bands)))
            self.assert_(not any(numpy.isinf(bands)))
            self.assert_(all(bands >= 0.0))

        # input is a flat spectrum:
        input = [1]*1024
        sr = 44100.
        binfreq = 0.5*sr/(len(input)-1)
        fbands = [8*x*binfreq for x in range(6)]
        # expected energies in each band are 1 due to normalization
        expected = [1, 1, 1, 1]
        output = TriangularBands(frequencyBands=fbands, log=False)(input)
        self.assertEqualVector(output, expected)
        # expected output using unit spectrum is that power bands matches magnitude bands.
        output = TriangularBands(frequencyBands=fbands, log=False, type = 'power')(input)
        self.assertEqualVector(output, expected)
     */

  }

}
