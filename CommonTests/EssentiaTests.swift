//
//  EssentiaTests.swift
//  EssentiaTests
//
//  Created by Jason Cardwell on 9/26/17.
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

// Change the type assumed for float literals.
typealias FloatLiteralType = Float

/// Simple helper for retrieving the URL for a bundled file.
///
/// - Parameters:
///   - name: The file's name.
///   - ext: The file's extension.
/// - Returns: The URL for the bundled file `name`.`ext`.
func bundleURL(name: String, ext: String) -> URL {
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
func monoBuffer(url: URL) -> AVAudioPCMBuffer {
  guard let buffer = (try? AVAudioPCMBuffer(contentsOf: url))?.mono else {
    fatalError("Failed to create audio buffer using `url`.")
  }
  return buffer
}

/// Simple helper that extracts the underlying data from a buffer filled with the
/// contents of the specified audio file.
///
/// - Parameters:
///   - url: The URL for the audio file with which to fill the buffer.
///   - forceEvenCount: Flag indicating whether the returned array should have an even count.
/// - Returns: An array with the signal from `url`.
func monoBufferData(url: URL, forceEvenCount: Bool = true) -> [Float] {
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
func loadVector(name: String) -> [Float] {
  let url = bundleURL(name: name, ext: "txt")
  guard let text = try? String(contentsOf: url) else {
    fatalError("Failed to load text from file: '\(name).txt'.")
  }
  return (text.split(separator: "\n") as [NSString]).map(\.floatValue)
}

class EssentiaTests: XCTestCase {

  /// The audio signal used as input when testing various algorithms.
  let chordSignal: [Float] =
    monoBufferData(url: bundleURL(name: "C4-E♭4-G4_Boesendorfer_Grand_Piano-Trimmed", ext: "aif"))

  /// Tests that log event automation is properly received and stored.
  func testLogScheduling() {

    XCTAssert(Log.schedule.isEmpty)

    let events: [Log.Event] = [
      Log.Event(start: 0, stop: CInt.max, modules: .algorithm),
      Log.Event(start: 500, stop: CInt.max, modules: [.network, .memory]),
      Log.Event(start: 782, stop: 782, modules: .scheduler)
    ]

    Log.scheduleDebug(events: events)
    XCTAssertEqual(Log.schedule, events)

    Log.scheduleDebug(events: [])
    XCTAssert(Log.schedule.isEmpty)

  }

  /// A test simply for generating a rich text document containing descriptions of all
  /// registered algorithms.
  func testDumpRegisteredStandardAlgorithms() {

    // Get the list of available standard algorithms.
    let expected = Set(AlgorithmFactoryWrapper.standardRegisteredNames)

    // Get the algorithm info corresponding to each name.
    let infos = expected.flatMap(AlgorithmFactoryWrapper.standardInfo(forName:))

    // Map the infos into a list of names.
    let actual = Set(infos.map(\.algorithmName))

    // Create a set of names appearing in `actual` but that are not found in `infos`.
    let missing = expected.subtracting(actual)

    // Assert all expected names have a corresponding info.
    XCTAssert(missing.isEmpty, "missing algorithms: \(missing.joined(separator: ", "))")

    // Generate RTF document text describing the retrieved algorithms.
    let rtfData = generateAlgorithmRTFDocument(with: infos,
                                               title: "Essentia Standard Algorithms")

    // Attach the RTF document to the test.
    add(XCTAttachment(data: rtfData, uniformTypeIdentifier: "public.rtf", lifetime: .keepAlways))

  }

  /// A test simply for generating a rich text document containing descriptions of all
  /// registered algorithms.
  func testDumpRegisteredStreamingAlgorithms() {

    // Get the list of available streaming algorithms.
    let expected = Set(AlgorithmFactoryWrapper.streamingRegisteredNames)

    // Get the algorithm info corresponding to each name.
    let infos = expected.flatMap(AlgorithmFactoryWrapper.streamingInfo(forName:))

    // Map the infos into a list of names.
    let actual = Set(infos.map(\.algorithmName))

    // Create a set of names for algorithms known to be broken and expected missing.
    let broken: Set<String> = [
      "BarkExtractor",
      "FileOutput",
      "LoudnessEBUR128Filter",
      "RealAccumulator",
      "VectorRealAccumulator"
    ]

    // Create a set of names appearing in `actual` but that are not found in `infos` and are not
    // known to be broken.
    let missing = expected.subtracting(actual).subtracting(broken)

    // Assert all expected names not known to be broken have a corresponding info.
    XCTAssert(missing.isEmpty, "missing algorithms: \(missing.joined(separator: ", "))")

    // Generate RTF document text describing the retrieved algorithms.
    let rtfData = generateAlgorithmRTFDocument(with: infos,
                                               title: "Essentia Streaming Algorithms")

    // Attach the RTF document to the test.
    add(XCTAttachment(data: rtfData, uniformTypeIdentifier: "public.rtf", lifetime: .keepAlways))

  }

  /// A test that generates swift code for the standard algorithm specifications.
  func testGenerateStandardAlgorithmSpecifications() {

    var declarationOutput = ""

    let infoKeys = AlgorithmFactoryWrapper.standardRegisteredNames
    let infos = infoKeys.flatMap(AlgorithmFactoryWrapper.standardInfo(forName:))

    let infosByCategory = Dictionary(grouping: infos, by: \.algorithmCategory)
    let namesByCategory = infosByCategory.mapValues({$0.map(\.algorithmName)})

    let mode = "Standard"

    beginAlgorithmMode(name: mode, isExtension: false, target: &declarationOutput)
    appendAlgorithmID(namesByCategory: namesByCategory, mode: mode, target: &declarationOutput)
    appendSpecificationTypealiases(namesByCategory: namesByCategory, target: &declarationOutput)
    endAlgorithmMode(target: &declarationOutput)

    guard let declarationData = declarationOutput.data(using: .utf8) else {
      XCTFail("Failed to get the declaration output string as raw data.")
      return
    }

    add(XCTAttachment(data: declarationData,
                      uniformTypeIdentifier: "public.text",
                      lifetime: .keepAlways))


    var extensionOutput = ""

    beginAlgorithmMode(name: mode, isExtension: true, target: &extensionOutput)

    for (categoryName, infos) in infosByCategory {

      beginAlgorithmCategory(name: categoryName, target: &extensionOutput)

      for info in infos {

        appendSpecification(createAlgorithm: info.createAlgorithm,
                            categoryName: categoryName,
                            target: &extensionOutput)

      }

      endAlgorithmCategory(target: &extensionOutput)

    }

    endAlgorithmMode(target: &extensionOutput)

    guard let extensionData = extensionOutput.data(using: .utf8) else {
      XCTFail("Failed to get the extension output string as raw data.")
      return
    }

    add(XCTAttachment(data: extensionData,
                      uniformTypeIdentifier: "public.text",
                      lifetime: .keepAlways))

  }

  /// A test that generates swift code for the streaming algorithm specifications.
  func testGenerateStreamingAlgorithmSpecifications() {

    var declarationOutput = ""

    let infoKeys = AlgorithmFactoryWrapper.streamingRegisteredNames
    let infos = infoKeys.flatMap(AlgorithmFactoryWrapper.streamingInfo(forName:))

    let infosByCategory = Dictionary(grouping: infos, by: \.algorithmCategory)

    var namesByCategory = infosByCategory.mapValues({$0.map(\.algorithmName)})
    namesByCategory["Input/output"]?.append(contentsOf: ["VectorInput", "VectorOutput"])

    let mode = "Streaming"


    beginAlgorithmMode(name: mode, isExtension: false, target: &declarationOutput)
    appendAlgorithmID(namesByCategory: namesByCategory, mode: mode, target: &declarationOutput)
    appendSpecificationTypealiases(namesByCategory: namesByCategory, target: &declarationOutput)
    endAlgorithmMode(target: &declarationOutput)

    guard let declarationData = declarationOutput.data(using: .utf8) else {
      XCTFail("Failed to get the declaration output string as raw data.")
      return
    }

    add(XCTAttachment(data: declarationData,
                      uniformTypeIdentifier: "public.text",
                      lifetime: .keepAlways))


    var extensionOutput = ""

    beginAlgorithmMode(name: mode, isExtension: true, target: &extensionOutput)

    for (categoryName, infos) in infosByCategory {

      beginAlgorithmCategory(name: categoryName, target: &extensionOutput)

      for info in infos {

        appendSpecification(createAlgorithm: info.createAlgorithm,
                            categoryName: categoryName,
                            target: &extensionOutput)

      }

      if categoryName == "Input/output" {

        let tripleQuote = "\"\"\""
        let indent = String(repeating: " ", count: 10)

        var vectorInputDescription = "\(tripleQuote)\n"
        vectorInputDescription += "\(indent)The VectorInput algorithm serves as a network's root "
        vectorInputDescription += "by allowing a vector to be connected directly to the \\\n"
        vectorInputDescription += "\(indent)algorithm. This vector of data is then streamed "
        vectorInputDescription += "through the algorithm as output.\n\(indent)\(tripleQuote)"

        appendSpecification(createAlgorithm: { VectorInputWrapper(realVec: []) },
                            categoryName: categoryName,
                            description: vectorInputDescription,
                            target: &extensionOutput)

        var vectorOutputDescription = "\(tripleQuote)\n"
        vectorOutputDescription += "\(indent)The VectorOutput algorithm serves as a network's final "
        vectorOutputDescription += "destination receiving data over a single input and \\\n"
        vectorOutputDescription += "\(indent)making that data available directly from the algorithm."
        vectorOutputDescription += "\n\(indent)\(tripleQuote)"

        appendSpecification(createAlgorithm: { VectorOutputWrapper(for: .realVec) },
                            categoryName: categoryName,
                            description: vectorOutputDescription,
                            target: &extensionOutput)

      }

      endAlgorithmCategory(target: &extensionOutput)

    }

    endAlgorithmMode(target: &extensionOutput)

    guard let extensionData = extensionOutput.data(using: .utf8) else {
      XCTFail("Failed to get the extension output string as raw data.")
      return
    }

    add(XCTAttachment(data: extensionData,
                      uniformTypeIdentifier: "public.text",
                      lifetime: .keepAlways))

  }

  /// Tests that algorithm inputs can be set, that algorithms can be computed, and then results
  /// retrieved via the algorithm outputs.
  ///
  ///  IO types with test coverage:
  /// ````
  /// Type                 Input    Output
  /// ────────────────────────────────────
  /// Real                  ✕         ✓
  /// String                ✕         ✕
  /// Int                   ✕         ✕
  /// Pool                  ✕         ✕
  /// RealMatrix            ✕         ✕
  /// ComplexRealVec        ✕         ✕
  /// RealVec               ✓         ✓
  /// StringVec             ✕         ✕
  /// StereoSampleVec       ✕         ✕
  /// RealVecVec            ✕         ✕
  /// ````
  func testAlgorithmIO() {

    let clipper = StandardAlgorithm<Standard.Clipper>()

    clipper[realParameter: .min] = 0
    clipper[realParameter: .max] = 2

    XCTAssertEqual(clipper[realParameter: .min], 0)

    XCTAssertEqual(clipper[realParameter: .max], 2)

    clipper[realVecInput: .signal] = [-0.34, -22.1, 1.0, 16.24, 22.22]

    clipper.compute()

    XCTAssertEqual(clipper[realVecOutput: .signal], [0, 0, 1, 2, 2] as [Float])

  }

  /// Tests that algorithm parameters can be set.
  ///
  ///  Parameter types actually used and covered by test:
  ///  - Real
  ///  - Int
  ///  - String
  ///  - RealVec
  ///  - Bool
  ///  - StringVec
  ///  - StringVecMap
  ///
  ///  FrequencyBands: sampleRate(Real), frequencyBands(RealVec)
  ///  PeakDetection: interpolate(Bool), range(Real), maxPeaks(Int), orderBy(String)
  ///  PoolAggregator: defaultStats(StringVec), exceptions(StringVecMap)
  func testAlgorithmParameters() {

    let frequencyBands = StandardAlgorithm<Standard.FrequencyBands>()

    XCTAssertEqual(frequencyBands[realParameter: .sampleRate], 44100)
    frequencyBands[realParameter: .sampleRate] = 22050
    XCTAssertEqual(frequencyBands[realParameter: .sampleRate], 22050)

    XCTAssertEqual(frequencyBands[realVecParameter: .frequencyBands][..<5], [0, 50, 100, 150, 200])
    frequencyBands[realVecParameter: .frequencyBands] = [200, 300, 400]
    XCTAssertEqual(frequencyBands[realVecParameter: .frequencyBands], [200, 300, 400])

    let peakDetection = StandardAlgorithm<Standard.PeakDetection>()

    XCTAssertEqual(peakDetection[booleanParameter: .interpolate], true)
    peakDetection[booleanParameter: .interpolate] = false
    XCTAssertEqual(peakDetection[booleanParameter: .interpolate], false)

    XCTAssertEqual(peakDetection[integerParameter: .maxPeaks], 100)
    peakDetection[integerParameter: .maxPeaks] = 99
    XCTAssertEqual(peakDetection[integerParameter: .maxPeaks], 99)

    XCTAssertEqual(peakDetection[stringParameter: .orderBy], "position")
    peakDetection[stringParameter: .orderBy] = "amplitude"
    XCTAssertEqual(peakDetection[stringParameter: .orderBy], "amplitude")



    let poolAggregator = StandardAlgorithm<Standard.PoolAggregator>()

    XCTAssertEqual(poolAggregator[stringVecParameter: .defaultStats],
                   ["mean", "stdev", "min", "max", "median"])
    poolAggregator[stringVecParameter: .defaultStats] = ["kurt", "skew"]
    XCTAssertEqual(poolAggregator[stringVecParameter: .defaultStats], ["kurt", "skew"])

    XCTAssertEqual(poolAggregator[stringVecMapParameter: .exceptions].count, 0)
    poolAggregator[stringVecMapParameter: .exceptions] = ["lowlevel.bpm" : ["min", "max"]]
    XCTAssertEqual(poolAggregator[stringVecMapParameter: .exceptions].count, 1)
    XCTAssertEqual(poolAggregator[stringVecMapParameter: .exceptions]["lowlevel.bpm"] ?? [],
                   ["min", "max"])

  }

  /// Tests that algorithms created with calls that include parameter values are properly configured.
  func testAlgorithmCreationWithParameterValues() {

    let clipper = StandardAlgorithm<Standard.Clipper>([.min: 0.0, .max: 2.0])

    XCTAssertEqual(clipper[realParameter: .min],  0)
    XCTAssertEqual(clipper[realParameter: .max], 2)

  }

  /// Tests the `Pool` type via the standard algorithm `Extractor`.
  func testPool() {

    let extractor = StandardAlgorithm<Standard.Extractor>()

    extractor[realVecInput: .audio] = chordSignal

    extractor.compute()

    let extractorPool = extractor[poolOutput: .pool]

    XCTAssertEqual(extractorPool.realPool.count, 39)
    XCTAssertEqual(extractorPool.realVecPool.count, 8)
    XCTAssertEqual(extractorPool.stringPool.count, 1)
    XCTAssertEqual(extractorPool.stringVecPool.count, 0)
    XCTAssertEqual(extractorPool.realMatrixPool.count, 0)
    XCTAssertEqual(extractorPool.stereoSamplePool.count, 0)
    XCTAssertEqual(extractorPool.realSinglePool.count, 15)
    XCTAssertEqual(extractorPool.stringSinglePool.count, 4)
    XCTAssertEqual(extractorPool.realVecSinglePool.count, 6)
    XCTAssertEqual(extractorPool.stringVecSinglePool.count, 0)

    let pool = Pool()

    /*
     add: Float, [Float], String, [String], StereoSample, [[Float]]
     set: Float, [Float], String, [String]
     */

    let reals: [Float] = [1.0, 2.0, 3.0]

    for real in reals {
      pool[real: "real"] = real
    }

    XCTAssertEqual(pool[realVec: "real"], reals)

    let realVecs: [[Float]] = [[1.1, 1.2, 1.3], [2.1, 2.2, 2.3], [3.1, 3.2, 3.3]]

    for realVec in realVecs {
      pool[realVec: "realVector"] = realVec
    }

    XCTAssertEqual(pool[realVecVec: "realVector"], realVecs, accuracy: Float(0.1))

    let strings = ["1", "2", "3"]

    for string in strings {
      pool[string: "string"] = string
    }

    XCTAssertEqual(pool[stringVec: "string"], strings)

    let stringVecs = [["11", "12", "13"], ["21", "22", "23"], ["31", "32", "33"]]

    for stringVec in stringVecs {
      pool[stringVec: "stringVector"] = stringVec
    }

    XCTAssertEqual(pool[stringVecVec: "stringVector"], stringVecs)

    let stereoSamples = [StereoSample(left: 1.1, right: 1.2), StereoSample(left: 2.1, right: 2.2)]

    for stereoSample in stereoSamples {
      pool[stereoSample: "stereoSample"] = stereoSample
    }

    XCTAssertEqual(pool[stereoSampleVec: "stereoSample"], stereoSamples)

    let realMatrices: [[[Float]]] = [
      [[11.1, 11.2, 11.3], [12.1, 12.2, 12.3]],
      [[21.1, 21.2, 21.3], [22.1, 22.2, 22.3]],
      [[31.1, 31.2, 31.3], [32.1, 32.2, 32.3]]
    ]

    for realMatrix in realMatrices {
      pool[realVecVec: "realMatrix"] = realMatrix
    }

    XCTAssertEqual(pool[realMatrixVec: "realMatrix"], realMatrices, accuracy: Float(0.1))

    for (index, real) in reals.enumerated() {
      pool[singleReal: "singleReal\(index)"] = real
    }

    for (index, real) in reals.enumerated() {
      XCTAssertEqual(pool[singleReal: "singleReal\(index)"], real)
    }

    for (index, realVec) in realVecs.enumerated() {
      pool[singleRealVec: "singleRealVector\(index)"] = realVec
    }

    for (index, realVec) in realVecs.enumerated() {
      XCTAssertEqual(pool[singleRealVec: "singleRealVector\(index)"], realVec)
    }

    for (index, string) in strings.enumerated() {
      pool[singleString: "singleString\(index)"] = string
    }

    for (index, string) in strings.enumerated() {
      XCTAssertEqual(pool[singleString: "singleString\(index)"], string)
    }

    for (index, stringVec) in stringVecs.enumerated() {
      pool[singleStringVec: "singleStringVector\(index)"] = stringVec
    }

    for (index, stringVec) in stringVecs.enumerated() {
      XCTAssertEqual(pool[singleStringVec: "singleStringVector\(index)"], stringVec)
    }

    XCTAssertEqual(pool.jsonRepresentation, """
                    {
                      "singleString0" : "1",
                      "stringVector" : [
                        [
                          "11",
                          "12",
                          "13"
                        ],
                        [
                          "21",
                          "22",
                          "23"
                        ],
                        [
                          "31",
                          "32",
                          "33"
                        ]
                      ],
                      "singleStringVector2" : [
                        "31",
                        "32",
                        "33"
                      ],
                      "singleRealVector0" : [
                        1.1000000238418579,
                        1.2000000476837158,
                        1.2999999523162842
                      ],
                      "real" : [
                        1,
                        2,
                        3
                      ],
                      "singleString1" : "2",
                      "string" : [
                        "1",
                        "2",
                        "3"
                      ],
                      "singleReal0" : 1,
                      "stereoSample" : [
                        {
                          "right" : 1.2000000476837158,
                          "left" : 1.1000000238418579
                        },
                        {
                          "right" : 2.2000000476837158,
                          "left" : 2.0999999046325684
                        }
                      ],
                      "singleString2" : "3",
                      "singleReal1" : 2,
                      "singleReal2" : 3,
                      "singleStringVector0" : [
                        "11",
                        "12",
                        "13"
                      ],
                      "singleRealVector2" : [
                        3.0999999046325684,
                        3.2000000476837158,
                        3.2999999523162842
                      ],
                      "singleStringVector1" : [
                        "21",
                        "22",
                        "23"
                      ],
                      "realMatrix" : [
                        [
                          [
                            11.100000381469727,
                            11.199999809265137,
                            11.300000190734863
                          ],
                          [
                            12.100000381469727,
                            12.199999809265137,
                            12.300000190734863
                          ]
                        ],
                        [
                          [
                            21.100000381469727,
                            21.200000762939453,
                            21.299999237060547
                          ],
                          [
                            22.100000381469727,
                            22.200000762939453,
                            22.299999237060547
                          ]
                        ],
                        [
                          [
                            31.100000381469727,
                            31.200000762939453,
                            31.299999237060547
                          ],
                          [
                            32.099998474121094,
                            32.200000762939453,
                            32.299999237060547
                          ]
                        ]
                      ],
                      "realVector" : [
                        [
                          1.1000000238418579,
                          1.2000000476837158,
                          1.2999999523162842
                        ],
                        [
                          2.0999999046325684,
                          2.2000000476837158,
                          2.2999999523162842
                        ],
                        [
                          3.0999999046325684,
                          3.2000000476837158,
                          3.2999999523162842
                        ]
                      ],
                      "singleRealVector1" : [
                        2.0999999046325684,
                        2.2000000476837158,
                        2.2999999523162842
                      ]
                    }
                    """)

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

  /// Tests the STFT/FFT functionality.
  func testFFT() {

    let frameCutter = StandardAlgorithm<Standard.FrameCutter>()
    frameCutter[integerParameter: .frameSize] = 1024
    frameCutter[integerParameter: .hopSize] = 256
    frameCutter[booleanParameter: .startFromZero] = false

    let windowing = StandardAlgorithm<Standard.Windowing>([.type: "hann"])

    let fft = StandardAlgorithm<Standard.FFT>([.size: 1024])

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
    XCTAssertEqual(complexRealVectorInput.vector, complexRealVector)
    let complexRealVectorʹ: [DSPComplex] = [DSPComplex(real: 4, imag: 0),
                                            DSPComplex(real: 5, imag: 0),
                                            DSPComplex(real: 6, imag: 0)]
    complexRealVectorInput.vector = complexRealVectorʹ
    XCTAssertEqual(complexRealVectorInput.vector, complexRealVectorʹ)

  }

  /// Tests that creating a `Network` instance of streaming algorithms behaves as expected.
  func testNetwork() {

    let signalInput = VectorInput<Float>(chordSignal)


    let frameCutter = StreamingAlgorithm<Streaming.FrameCutter>()
    frameCutter[integerParameter: .frameSize] = 1024
    frameCutter[integerParameter: .hopSize] = 256
    frameCutter[booleanParameter: .startFromZero] = false

    let windowing = StreamingAlgorithm<Streaming.Windowing>([.type: "hann"])

    let fft = StreamingAlgorithm<Streaming.FFT>([.size: 1024])

    let output = VectorOutput<[DSPComplex]>()

    signalInput[output: .data] >> frameCutter[input: .signal]
    frameCutter[output: .frame] >> windowing[input: .frame]
    windowing[output: .frame] >> fft[input: .frame]
    fft[output: .fft] >> output[input: .data]

    let network = Network(generator: signalInput)
    network.update()

    let executionOrder = network.linearExecutionOrder

    XCTAssertEqual(executionOrder.count, 5)

    guard executionOrder.count == 5 else { return }

    XCTAssertEqual(executionOrder[0].name, "VectorInput")
    XCTAssertEqual(executionOrder[1].name, "FrameCutter")
    XCTAssertEqual(executionOrder[2].name, "Windowing")
    XCTAssertEqual(executionOrder[3].name, "FFT")
    XCTAssertEqual(executionOrder[4].name, "VectorOutput")

  }

  /// Tests the STFT/FFT functionality in streaming mode.
  func testStreamingFFT() {

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
    XCTAssertAverageEqual(pool[realVec: "tuningFrequency"], Float(440), accuracy: 0.5)

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
     Note: Passing would require broadening the accuracy value for the assertion on the
           frequencies from 1e-5 (used in python) to 1e-4.
     */

    var spectrum1: [Float] = [0.0] * 100
    spectrum1[0..<3] = [0.5, 0.4, 0.3]
    spectrum1[10..<13] = [0.5, 0.6, 0.5]
    spectrum1[20..<25] = [0.8, 0.95, 0.95, 0.95, 0.8]
    spectrum1[30..<35] = [0.5, 0.6, 0.6, 0.6, 0.7]
    spectrum1[40..<44] = [0.5, 0.6, 0.6, 0.7]
    spectrum1[50..<55] = [0.7, 0.6, 0.6, 0.6, 0.5]
    spectrum1[60..<65] = [0.7, 0.6, 0.6, 0.6, 0.7]
    spectrum1[70..<75] = [0.7, 0.5, 0.7, 0.5, 0.7]
    spectrum1[97...  ] = [0.3, 0.4, 0.5]

    let expected: [(frequency: Float, magnitude: Float)] = [
      (0, 0.5),
      (11, 0.6),
      (22, 0.95),
      (33.625, 0.75625),
      (42.625, 0.75625),
      (50.375, 0.75625),
      (60.375, 0.75625),
      (63.625, 0.75625),
      (70.2778, 0.734722),
      (72, 0.7),
      (73.7222, 0.734722),
      (99, 0.5)
    ]

    let spectralPeaks1 = StandardAlgorithm<Standard.SpectralPeaks>([
      .sampleRate: 198,
      .maxPeaks: 100,
      .maxFrequency: 99,
      .minFrequency: 0,
      .magnitudeThreshold: 0.000001,
      .orderBy: "frequency"
      ])

    spectralPeaks1[realVecInput: .spectrum] = spectrum1
    spectralPeaks1.compute()

    let actual: [(frequency: Float, magnitude: Float)] =
      Array(zip(spectralPeaks1[realVecOutput: .frequencies],
                spectralPeaks1[realVecOutput: .magnitudes]))

    for (actual, expected) in zip(actual, expected) {
      XCTAssertEqual(actual.frequency, expected.frequency, accuracy: 1e-5)
      XCTAssertEqual(actual.magnitude, expected.magnitude, accuracy: 1e-5)
    }

    /*
     Test with a sinusoid.
     Note: Passing would require broadening the accuracy value from 1e-3 (used in python) to 0.89.
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

    XCTAssertAverageEqual(Array(vectorOutput.vector.joined()), 5000, accuracy: 1e-3)

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
     Note: Passing would require broadening the accuracy value from 1e-5 (used in python)
           to 0.00265293219 for third magnitude average.
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

  /// Tests the functionality of the `DCRemoval` algorithm. Values taken from `test_dcremoval.py`.
  func testDCRemoval() {

    /*
     Test that filtering one by one is the same as all at once.
     */

    let signal1: [Float] = [1, 2, 3, 4, 5, 6, 7]

    let dcRemoval1 = StandardAlgorithm<Standard.DCRemoval>()
    dcRemoval1[realVecInput: .signal] = signal1
    dcRemoval1.compute()

    let expected = dcRemoval1[realVecOutput: .signal]

    dcRemoval1.reset()

    var output: [Float] = []

    for sample in signal1 {

      dcRemoval1[realVecInput: .signal] = [sample]
      dcRemoval1.compute()

      output.append(contentsOf: dcRemoval1[realVecOutput: .signal])

    }

    XCTAssertEqual(output, expected)

    /*
     Test with all-zero input.
     */

    let dcRemoval2 = StandardAlgorithm<Standard.DCRemoval>()
    dcRemoval2[realVecInput: .signal] = [0.0] * 20
    dcRemoval2.compute()

    XCTAssertEqual(dcRemoval2[realVecOutput: .signal], [0.0] * 20)

    /*
     Test with constant input.
     */

    let dcRemoval3 = StandardAlgorithm<Standard.DCRemoval>()
    dcRemoval3[realVecInput: .signal] = [1.0] * 20000
    dcRemoval3.compute()

    XCTAssertEqual(Array(dcRemoval3[realVecOutput: .signal].dropFirst(1000)), [0.0] * 19000,
                   accuracy: 3.3e-3)

    /*
     Test with a real signal modified with an artificial DC offset.
     */

    let signal2 = monoBufferData(url: bundleURL(name: "sin_30_seconds", ext: "wav"))

    let dcRemoval4 = StandardAlgorithm<Standard.DCRemoval>()
    dcRemoval4[realVecInput: .signal] = signal2.map({$0 + 0.2})
    dcRemoval4.compute()

    XCTAssertAverageEqual(Array(dcRemoval4[realVecOutput: .signal].dropFirst(2500)), 0.0,
                          accuracy: 1e-6)

  }

  /// Tests the functionality of the `EqualLoudness` algorithm. Values taken from
  /// `test_equalloudness.py`.
  func testEqualLoudness() {

    /*
     Test that filtering one by one is the same as all at once.
     */

    let signal1: [Float] = [1, 2, 3, 4, 5, 6, 7]

    let equalLoudness1 = StandardAlgorithm<Standard.EqualLoudness>()
    equalLoudness1[realVecInput: .signal] = signal1
    equalLoudness1.compute()

    let expected1 = equalLoudness1[realVecOutput: .signal]

    equalLoudness1.reset()

    var output1: [Float] = []

    for sample in signal1 {

      equalLoudness1[realVecInput: .signal] = [sample]
      equalLoudness1.compute()

      output1.append(contentsOf: equalLoudness1[realVecOutput: .signal])

    }

    XCTAssertEqual(output1, expected1)

    /*
     Test with all-zero input.
     */

    let equalLoudness2 = StandardAlgorithm<Standard.EqualLoudness>()
    equalLoudness2[realVecInput: .signal] = [0.0] * 20
    equalLoudness2.compute()

    XCTAssertEqual(equalLoudness2[realVecOutput: .signal], [0.0] * 20)

    /*
     Test with two real signals, the second being the expected result of filtering the first.
     */

    let signal2 = monoBufferData(url: bundleURL(name: "sin_30_seconds", ext: "wav"))
    let expected2 = monoBufferData(url: bundleURL(name: "sin_30_seconds_eqloud", ext: "wav"))

    let equalLoudness3 = StandardAlgorithm<Standard.EqualLoudness>()
    equalLoudness3[realVecInput: .signal] = Array(signal2[...100000])
    equalLoudness3.compute()

    XCTAssertEqual(equalLoudness3[realVecOutput: .signal], Array(expected2[...100000]),
                   accuracy: 1e-4)

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

  /// Tests the functionality of the `PitchSalienceFunction` algorithm. Values taken from
  /// `test_pitchsalience.py`.
  func testPitchSalienceFunction() {

    /*
     Test with white noise.
     */

    let whiteNoise = loadVector(name: "pitchSalience")

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
     Note: Not sure why the varying square wave salience is off.
     */

    let pureTone = (0..<8000).map {(i: Int) -> Float in sinf(2 * Float.pi * 440 * Float(i) / 8000)}

    let vectorInput2 = VectorInput<Float>(pureTone)
    let frameCutter = StreamingAlgorithm<Streaming.FrameCutter>()
    let windowing = StreamingAlgorithm<Streaming.Windowing>()
    let spectrum2 = StreamingAlgorithm<Streaming.Spectrum>()
    let pitchSalience2 = StreamingAlgorithm<Streaming.PitchSalience>([
      .sampleRate: 8000,
      .lowBoundary: 100,
      .highBoundary: 3999
      ])

    let pool = Pool()

    vectorInput2[output: .data] >> frameCutter[input: .signal]
    frameCutter[output: .frame] >> windowing[input: .frame]
    windowing[output: .frame] >> spectrum2[input: .frame]
    spectrum2[output: .spectrum] >> pitchSalience2[input: .spectrum]
    pitchSalience2[output: .pitchSalience] >> pool[input: "pureTone"]

    let network2 = Network(generator: vectorInput2)
    network2.run()

    let sineSweep = (0..<8000).map {
      (i:Int) -> Float in
        let y = Float(i) / 8000
        let x = 20 + 440 * y
        return sinf(2 * Float.pi * x * y)
    }

    vectorInput2.vector = sineSweep
    vectorInput2.reset()

    pitchSalience2[output: .pitchSalience] >! pool[input: "pureTone"]
    pitchSalience2[output: .pitchSalience] >> pool[input: "sineSweep"]

    network2.update()
    network2.run()

    vectorInput2.vector = whiteNoise
    vectorInput2.reset()

    pitchSalience2[output: .pitchSalience] >! pool[input: "sineSweep"]
    pitchSalience2[output: .pitchSalience] >> pool[input: "whiteNoise"]

    network2.update()
    network2.run()

    let squareWave = loadVector(name: "squareWave")

    vectorInput2.vector = squareWave
    vectorInput2.reset()

    pitchSalience2[output: .pitchSalience] >! pool[input: "whiteNoise"]
    pitchSalience2[output: .pitchSalience] >> pool[input: "squareWave"]

    network2.update()
    network2.run()

    let vSquareWave = loadVector(name: "varyingSquareWave")

    vectorInput2.vector = vSquareWave
    vectorInput2.reset()

    pitchSalience2[output: .pitchSalience] >! pool[input: "squareWave"]
    pitchSalience2[output: .pitchSalience] >> pool[input: "varyingSquareWave"]

    network2.update()
    network2.run()

    let pureToneValues = pool[realVec: "pureTone"]
    let whiteNoiseValues = pool[realVec: "whiteNoise"]
    let sineSweepValues = pool[realVec: "sineSweep"]
    let squareWaveValues = pool[realVec: "squareWave"]
    let vSquareWaveValues = pool[realVec: "varyingSquareWave"]

    var pureToneMean: Float = 0
    vDSP_meanv(pureToneValues, 1, &pureToneMean, vDSP_Length(pureToneValues.count))

    var whiteNoiseMean: Float = 0
    vDSP_meanv(whiteNoiseValues, 1, &whiteNoiseMean, vDSP_Length(whiteNoiseValues.count))

    var sineSweepMean: Float = 0
    vDSP_meanv(sineSweepValues, 1, &sineSweepMean, vDSP_Length(sineSweepValues.count))

    var squareWaveMean: Float = 0
    vDSP_meanv(squareWaveValues, 1, &squareWaveMean, vDSP_Length(squareWaveValues.count))

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

    let pitchSalience3 = StandardAlgorithm<Standard.PitchSalience>([
      .sampleRate: 38,
      .lowBoundary: 1.9,
      .highBoundary: 17.1
      ])

    pitchSalience3[realVecInput: .spectrum] = [0.0, 1.0] * 9 + [0.0]
    pitchSalience3.compute()

    XCTAssertEqual(pitchSalience3[realOutput: .pitchSalience], 0.88888888, accuracy: 1e-6)

    /*
     Test with a full spectrum.
     */

    let pitchSalience4 = StandardAlgorithm<Standard.PitchSalience>([
      .sampleRate: 18,
      .lowBoundary: 1,
      .highBoundary: 8
      ])

    pitchSalience4[realVecInput: .spectrum] = [4, 5, 7, 2, 1, 4, 5, 6, 10]
    pitchSalience4.compute()

    XCTAssertEqual(pitchSalience4[realOutput: .pitchSalience], 0.68014699220657349, accuracy: 1e-7)

    /*
     Test on-peak boundries.
     */

    let pitchSalience5 = StandardAlgorithm<Standard.PitchSalience>([
      .lowBoundary: 40,
      .highBoundary: 40
      ])

    pitchSalience5[realVecInput: .spectrum] = [4, 0, 0, 0, 0, 0, 0, 0, 0, 0] as [Float] * 2205
    pitchSalience5.compute()

    XCTAssertGreaterThan(pitchSalience5[realOutput: .pitchSalience], 0.9)

    /*
     Test off-peak boundaries.
     */

    let pitchSalience6 = StandardAlgorithm<Standard.PitchSalience>([
      .lowBoundary: 41,
      .highBoundary: 41
      ])

    pitchSalience6[realVecInput: .spectrum] = [4, 0, 0, 0, 0, 0, 0, 0, 0, 0] as [Float] * 2205
    pitchSalience6.compute()

    XCTAssertLessThan(pitchSalience6[realOutput: .pitchSalience], 0.1)

    /*
     Test with silence.
     */

    let pitchSalience7 = StandardAlgorithm<Standard.PitchSalience>()

    pitchSalience7[realVecInput: .spectrum] = [0.0] * 1024
    pitchSalience7.compute()

    XCTAssertEqual(pitchSalience7[realOutput: .pitchSalience], 0.0)


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

    var expected = loadVector(name: "hamming")
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

    expected = loadVector(name: "hann")
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

    expected = loadVector(name: "triangular")
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

    expected = loadVector(name: "blackmanharris62")
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

    expected = loadVector(name: "blackmanharris70")
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

    expected = loadVector(name: "blackmanharris74")
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

    expected = loadVector(name: "blackmanharris92")
    normalize(&expected)

    XCTAssertEqual(windowing11[realVecOutput: .frame], expected, accuracy: 1e-3)

  }

/*
   Possible test subjects:
     MultiPitchKlapuri
     MultiPitchMelodia
     PitchContourSegmentation
     PitchContours
     PitchContoursMelody
     PitchContoursMultiMelody
     PitchFilter
     PitchMelodia
     PitchSalienceFunctionPeaks
     AutoCorrelation
     FFTC
     OverlapAdd
     PeakDetection
     WarpedAutoCorrelation
     PCA
     Extractor
     LowLevelSpectralEqloudExtractor
     LowLevelSpectralExtractor
     SpectrumCQ
     TuningFrequencyExtractor
 */


}

