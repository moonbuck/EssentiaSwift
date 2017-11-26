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

class EssentiaTests: XCTestCase {

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

    appendAlgorithmAliases(namesByCategory: namesByCategory,
                           mode: mode,
                           target: &declarationOutput)

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

    appendAlgorithmAliases(namesByCategory: namesByCategory,
                           mode: mode,
                           target: &declarationOutput)

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

    let clipper = ClipperAlgorithm()

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

    let frequencyBands = FrequencyBandsAlgorithm()

    XCTAssertEqual(frequencyBands[realParameter: .sampleRate], 44100)
    frequencyBands[realParameter: .sampleRate] = 22050
    XCTAssertEqual(frequencyBands[realParameter: .sampleRate], 22050)

    XCTAssertEqual(frequencyBands[realVecParameter: .frequencyBands][..<5], [0, 50, 100, 150, 200])
    frequencyBands[realVecParameter: .frequencyBands] = [200, 300, 400]
    XCTAssertEqual(frequencyBands[realVecParameter: .frequencyBands], [200, 300, 400])

    let peakDetection = PeakDetectionAlgorithm()

    XCTAssertEqual(peakDetection[booleanParameter: .interpolate], true)
    peakDetection[booleanParameter: .interpolate] = false
    XCTAssertEqual(peakDetection[booleanParameter: .interpolate], false)

    XCTAssertEqual(peakDetection[integerParameter: .maxPeaks], 100)
    peakDetection[integerParameter: .maxPeaks] = 99
    XCTAssertEqual(peakDetection[integerParameter: .maxPeaks], 99)

    XCTAssertEqual(peakDetection[stringParameter: .orderBy], "position")
    peakDetection[stringParameter: .orderBy] = "amplitude"
    XCTAssertEqual(peakDetection[stringParameter: .orderBy], "amplitude")



    let poolAggregator = PoolAggregatorAlgorithm()

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

    let clipper = ClipperAlgorithm([.min: 0.0, .max: 2.0])

    XCTAssertEqual(clipper[realParameter: .min],  0)
    XCTAssertEqual(clipper[realParameter: .max], 2)

  }

  /// Tests the `Pool` type via the standard algorithm `Extractor`.
  func testPool() {

    /*
     Test output from an actual algorithm.
     */

    let extractor = ExtractorAlgorithm()

    let url = bundleURL(name: "C4-E♭4-G4_Boesendorfer_Grand_Piano-Trimmed", ext: "aif")
    let chordSignal = monoBufferData(url: url)

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


    /*
     Test `Pool.add(:for:)` and `Pool.set(:for:)` with all the supported types.
     */

    let pool1 = Pool()

    let reals: [Float] = [1.0, 2.0, 3.0]

    for real in reals {
      pool1.add(.real(real), for: "real")
    }

    XCTAssertEqual(pool1[realVec: "real"], reals)

    let realVecs: [[Float]] = [[1.1, 1.2, 1.3], [2.1, 2.2, 2.3], [3.1, 3.2, 3.3]]

    for realVec in realVecs {
      pool1.add(.realVec(realVec), for: "realVector")
    }

    XCTAssertEqual(pool1[realVecVec: "realVector"], realVecs, accuracy: Float(0.1))

    let strings = ["1", "2", "3"]

    for string in strings {
      pool1.add(.string(string), for: "string")
    }

    XCTAssertEqual(pool1[stringVec: "string"], strings)

    let stringVecs = [["11", "12", "13"], ["21", "22", "23"], ["31", "32", "33"]]

    for stringVec in stringVecs {
      pool1.add(.stringVec(stringVec), for: "stringVector")
    }

    XCTAssertEqual(pool1[stringVecVec: "stringVector"], stringVecs)

    let stereoSamples = [StereoSample(left: 1.1, right: 1.2), StereoSample(left: 2.1, right: 2.2)]

    for stereoSample in stereoSamples {
      pool1.add(.stereoSample(stereoSample), for: "stereoSample")
    }

    XCTAssertEqual(pool1[stereoSampleVec: "stereoSample"], stereoSamples)

    let realMatrices: [[[Float]]] = [
      [[11.1, 11.2, 11.3], [12.1, 12.2, 12.3]],
      [[21.1, 21.2, 21.3], [22.1, 22.2, 22.3]],
      [[31.1, 31.2, 31.3], [32.1, 32.2, 32.3]]
    ]

    for realMatrix in realMatrices {
      pool1.add(.realVecVec(realMatrix), for: "realMatrix")
    }

    XCTAssertEqual(pool1[realMatrixVec: "realMatrix"], realMatrices, accuracy: Float(0.1))

    for (index, real) in reals.enumerated() {
      pool1.set(.real(real), for: "singleReal\(index)")
    }

    for (index, real) in reals.enumerated() {
      XCTAssertEqual(pool1[real: "singleReal\(index)"], real)
    }

    for (index, realVec) in realVecs.enumerated() {
      pool1.set(.realVec(realVec), for: "singleRealVector\(index)")
    }

    for (index, realVec) in realVecs.enumerated() {
      XCTAssertEqual(pool1[realVec: "singleRealVector\(index)"], realVec)
    }

    for (index, string) in strings.enumerated() {
      pool1.set(.string(string), for: "singleString\(index)")
    }

    for (index, string) in strings.enumerated() {
      XCTAssertEqual(pool1[string: "singleString\(index)"], string)
    }

    for (index, stringVec) in stringVecs.enumerated() {
      pool1.set(.stringVec(stringVec), for: "singleStringVector\(index)")
    }

    for (index, stringVec) in stringVecs.enumerated() {
      XCTAssertEqual(pool1[stringVec: "singleStringVector\(index)"], stringVec)
    }

    XCTAssertEqual(pool1.jsonRepresentation,
                   try! String(contentsOf: bundleURL(name: "pool", ext: "json")))

    /*
     Test initializing via a dictionary literal.
     */

    let pool2: Pool = [
      "real": [1, 2, 3],
      "realVector": [[1.1, 1.2, 1.3], [2.1, 2.2, 2.3], [3.1, 3.2, 3.3]],
      "string": ["1", "2", "3"],
      "stringVector": [["11", "12", "13"], ["21", "22", "23"], ["31", "32", "33"]],
      "stereoSample": [StereoSample(left: 1.1, right: 1.2), StereoSample(left: 2.1, right: 2.2)],
      "realMatrix": [
        [[11.1, 11.2, 11.3], [12.1, 12.2, 12.3]],
        [[21.1, 21.2, 21.3], [22.1, 22.2, 22.3]],
        [[31.1, 31.2, 31.3], [32.1, 32.2, 32.3]]
      ]
    ]

    XCTAssertEqual(pool2[realVec: "real"], [1, 2, 3])

    XCTAssertEqual(pool2[realVecVec: "realVector"], [[1.1, 1.2, 1.3],
                                                     [2.1, 2.2, 2.3],
                                                     [3.1, 3.2, 3.3]])

    XCTAssertEqual(pool2[stringVec: "string"], ["1", "2", "3"])

    XCTAssertEqual(pool2[stringVecVec: "stringVector"], [["11", "12", "13"],
                                                         ["21", "22", "23"],
                                                         ["31", "32", "33"]])

    XCTAssertEqual(pool2[stereoSampleVec: "stereoSample"], [StereoSample(left: 1.1, right: 1.2),
                                                            StereoSample(left: 2.1, right: 2.2)])
    
    XCTAssertEqual(pool2[realMatrixVec: "realMatrix"], [[[11.1, 11.2, 11.3], [12.1, 12.2, 12.3]],
                                                        [[21.1, 21.2, 21.3], [22.1, 22.2, 22.3]],
                                                        [[31.1, 31.2, 31.3], [32.1, 32.2, 32.3]]])

    /*
     Test the collection interface for the pool.
     */

    let expected = pool2.descriptorNames.map({pool2[descriptor: $0]})

    XCTAssertEqual(pool2.count, expected.count)

    for (index, value) in pool2.enumerated() {
      XCTAssertEqual(value, expected[index])
    }

  }

  /// Tests that creating a `Network` instance of streaming algorithms behaves as expected.
  func testNetwork() {

    let url = bundleURL(name: "C4-E♭4-G4_Boesendorfer_Grand_Piano-Trimmed", ext: "aif")
    let chordSignal = monoBufferData(url: url)

    let signalInput = VectorInput<Float>(chordSignal)


    let frameCutter = FrameCutterSAlgorithm()
    frameCutter[integerParameter: .frameSize] = 1024
    frameCutter[integerParameter: .hopSize] = 256
    frameCutter[booleanParameter: .startFromZero] = false

    let windowing = WindowingSAlgorithm([.type: "hann"])

    let fft = FFTSAlgorithm([.size: 1024])

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

}


