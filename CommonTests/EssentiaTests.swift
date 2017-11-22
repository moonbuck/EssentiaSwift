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

/// Range creation operator support for creating an array of float values. The two
/// bounds are first converted into integers and these integers are used to create and
/// map a countable range.
///
/// - Parameters:
///   - lhs: The lower bound for the half open range.
///   - rhs: The upper bound for the half open range.
/// - Returns: The array of floating point values.
func ..<<F:BinaryFloatingPoint>(lhs: F, rhs: F) -> [F] {
  return (Int(lhs)..<Int(rhs)).map(F.init)
}

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
  guard let buffer = (try? AVAudioPCMBuffer(contentsOf: url)) else {
    fatalError("Failed to create audio buffer using `url`.")
  }
  return buffer.downmixed()
}

/// Simple helper that extracts the underlying data from a buffer filled with the
/// contents of the specified audio file.
///
/// - Parameters:
///   - url: The URL for the audio file with which to fill the buffer.
///   - forceEvenCount: Flag indicating whether the returned array should have an even count.
/// - Returns: An array with the signal from `url`.
func monoBufferData(url: URL, forceEvenCount: Bool = false) -> [Float] {
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

/// Simple helper that loads values from a text file into a two dimensional array of float values.
/// Inner arrays are delimited by consecutive newline characters.
///
/// - Parameters:
///   - name: The name of the bundled file.
/// - Returns: A two dimensional array of the float values parsed from the file.
func loadVectorVector(name: String) -> [[Float]] {
  let url = bundleURL(name: name, ext: "txt")
  guard let text = try? String(contentsOf: url) else {
    fatalError("Failed to load text from file: '\(name).txt'.")
  }

  return (text as NSString).components(separatedBy: "\n\n")
          .map({($0.split(separator: "\n") as [NSString]).map(\.floatValue)})
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

    XCTAssertEqual(pool.jsonRepresentation,
                   try! String(contentsOf: bundleURL(name: "pool", ext: "json")))

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
    XCTAssertEqual(complexRealVectorInput.vector, complexRealVector, accuracy: 0)
    let complexRealVectorʹ: [DSPComplex] = [DSPComplex(real: 4, imag: 0),
                                            DSPComplex(real: 5, imag: 0),
                                            DSPComplex(real: 6, imag: 0)]
    complexRealVectorInput.vector = complexRealVectorʹ
    XCTAssertEqual(complexRealVectorInput.vector, complexRealVectorʹ, accuracy: 0)

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

  func testPitchSalienceFunction() {
    //TODO: Implement the  function
    XCTFail("\(#function) not yet implemented.")
  }

  func testPitchSalienceFunctionPeaks() {
    //TODO: Implement the  function
    XCTFail("\(#function) not yet implemented.")
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

  func testMultiPitchKlapuri() {
    //TODO: Implement the  function
    XCTFail("\(#function) not yet implemented.")
  }

  func testMultiPitchMelodia() {
    //TODO: Implement the  function
    XCTFail("\(#function) not yet implemented.")
  }

  func testPitchContours() {
    //TODO: Implement the  function
    XCTFail("\(#function) not yet implemented.")
  }

  func testPitchContoursMultiMelody() {
    //TODO: Implement the  function
    XCTFail("\(#function) not yet implemented.")
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

  func testPredominantPitchMelodia() {
    //TODO: Implement the  function
    XCTFail("\(#function) not yet implemented.")
  }

  func testPitchFilter() {
    //TODO: Implement the  function
    XCTFail("\(#function) not yet implemented.")
  }

  func testConstantQ() {
    //TODO: Implement the  function
    XCTFail("\(#function) not yet implemented.")
  }

  /// Tests the functionality of the ChordsDetection algorithm. Values taken from
  /// `test_chordsdetection_streaming.py`.
  func testChordsDetection() {
    //TODO: Implement the  function
    XCTFail("\(#function) not yet implemented.")
  }

  func testExtractor() {
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

  func testSpectrumCQ() {
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

}


