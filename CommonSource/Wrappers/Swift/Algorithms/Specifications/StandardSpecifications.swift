//
//  StandardSpecifications.swift
//  Essentia
//
//  Created by Jason Cardwell on 11/2/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
import Foundation

extension Standard {

  /// An enumeration serving as both a namespace and a category for algorithm specifications.
  public enum Rhythm: AlgorithmCategory {

    /// The name of the category as it appears in info structs.
    public static var name: String { return "Rhythm" }

    /// The specification for the standard `BeatTrackerDegara` algorithm.
    public struct BeatTrackerDegara: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<BeatTrackerDegara> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<BeatTrackerDegara>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "BeatTrackerDegara" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Input> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case ticks

        public static var allKeys: Set<Output> {
          return [
             .ticks
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case maxTempo
        case minTempo

        public static var allKeys: Set<Parameter> {
          return [
             .maxTempo,
             .minTempo
          ]
        }

      }

    }

    /// The specification for the standard `BeatTrackerMultiFeature` algorithm.
    public struct BeatTrackerMultiFeature: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<BeatTrackerMultiFeature> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<BeatTrackerMultiFeature>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "BeatTrackerMultiFeature" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Input> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case confidence
        case ticks

        public static var allKeys: Set<Output> {
          return [
             .confidence,
             .ticks
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case maxTempo
        case minTempo

        public static var allKeys: Set<Parameter> {
          return [
             .maxTempo,
             .minTempo
          ]
        }

      }

    }

    /// The specification for the standard `Beatogram` algorithm.
    public struct Beatogram: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<Beatogram> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<Beatogram>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Beatogram" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case loudness
        case loudnessBandRatio

        public static var allKeys: Set<Input> {
          return [
             .loudness,
             .loudnessBandRatio
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case beatogram

        public static var allKeys: Set<Output> {
          return [
             .beatogram
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case size

        public static var allKeys: Set<Parameter> {
          return [
             .size
          ]
        }

      }

    }

    /// The specification for the standard `BeatsLoudness` algorithm.
    public struct BeatsLoudness: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<BeatsLoudness> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<BeatsLoudness>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "BeatsLoudness" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Input> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case loudness
        case loudnessBandRatio

        public static var allKeys: Set<Output> {
          return [
             .loudness,
             .loudnessBandRatio
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case beatDuration
        case beatWindowDuration
        case beats
        case frequencyBands
        case sampleRate

        public static var allKeys: Set<Parameter> {
          return [
             .beatDuration,
             .beatWindowDuration,
             .beats,
             .frequencyBands,
             .sampleRate
          ]
        }

      }

    }

    /// The specification for the standard `BpmHistogram` algorithm.
    public struct BpmHistogram: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<BpmHistogram> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<BpmHistogram>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "BpmHistogram" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case novelty

        public static var allKeys: Set<Input> {
          return [
             .novelty
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case bpmCandidates
        case bpmMagnitudes
        case ticksMagnitude
        case frameBpms
        case bpm
        case ticks
        case sinusoid
        case tempogram

        public static var allKeys: Set<Output> {
          return [
             .bpmCandidates,
             .bpmMagnitudes,
             .ticksMagnitude,
             .frameBpms,
             .bpm,
             .ticks,
             .sinusoid,
             .tempogram
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case bpm
        case constantTempo
        case frameRate
        case frameSize
        case maxBpm
        case maxPeaks
        case minBpm
        case overlap
        case tempoChange
        case weightByMagnitude
        case windowType
        case zeroPadding

        public static var allKeys: Set<Parameter> {
          return [
             .bpm,
             .constantTempo,
             .frameRate,
             .frameSize,
             .maxBpm,
             .maxPeaks,
             .minBpm,
             .overlap,
             .tempoChange,
             .weightByMagnitude,
             .windowType,
             .zeroPadding
          ]
        }

      }

    }

    /// The specification for the standard `BpmHistogramDescriptors` algorithm.
    public struct BpmHistogramDescriptors: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<BpmHistogramDescriptors> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<BpmHistogramDescriptors>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "BpmHistogramDescriptors" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case bpmIntervals

        public static var allKeys: Set<Input> {
          return [
             .bpmIntervals
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case firstPeakBPM
        case histogram
        case firstPeakSpread
        case secondPeakWeight
        case firstPeakWeight
        case secondPeakBPM
        case secondPeakSpread

        public static var allKeys: Set<Output> {
          return [
             .firstPeakBPM,
             .histogram,
             .firstPeakSpread,
             .secondPeakWeight,
             .firstPeakWeight,
             .secondPeakBPM,
             .secondPeakSpread
          ]
        }

      }

      /// An enumeration with the sole case of `none` specifying that the algorithm has no parameters.
      public enum Parameter: String, KeyEnumeration {

        case none

        public static var allKeys: Set<Parameter> {
          return []
        }

      }

    }

    /// The specification for the standard `BpmRubato` algorithm.
    public struct BpmRubato: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<BpmRubato> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<BpmRubato>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "BpmRubato" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case beats

        public static var allKeys: Set<Input> {
          return [
             .beats
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case rubatoNumber
        case rubatoStop
        case rubatoStart

        public static var allKeys: Set<Output> {
          return [
             .rubatoNumber,
             .rubatoStop,
             .rubatoStart
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case longRegionsPruningTime
        case shortRegionsMergingTime
        case tolerance

        public static var allKeys: Set<Parameter> {
          return [
             .longRegionsPruningTime,
             .shortRegionsMergingTime,
             .tolerance
          ]
        }

      }

    }

    /// The specification for the standard `Danceability` algorithm.
    public struct Danceability: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<Danceability> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<Danceability>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Danceability" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Input> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case dfa
        case danceability

        public static var allKeys: Set<Output> {
          return [
             .dfa,
             .danceability
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case maxTau
        case minTau
        case sampleRate
        case tauMultiplier

        public static var allKeys: Set<Parameter> {
          return [
             .maxTau,
             .minTau,
             .sampleRate,
             .tauMultiplier
          ]
        }

      }

    }

    /// The specification for the standard `HarmonicBpm` algorithm.
    public struct HarmonicBpm: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<HarmonicBpm> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<HarmonicBpm>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "HarmonicBpm" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case bpms

        public static var allKeys: Set<Input> {
          return [
             .bpms
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case harmonicBpms

        public static var allKeys: Set<Output> {
          return [
             .harmonicBpms
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case bpm
        case threshold
        case tolerance

        public static var allKeys: Set<Parameter> {
          return [
             .bpm,
             .threshold,
             .tolerance
          ]
        }

      }

    }

    /// The specification for the standard `LoopBpmConfidence` algorithm.
    public struct LoopBpmConfidence: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<LoopBpmConfidence> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<LoopBpmConfidence>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "LoopBpmConfidence" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case signal
        case bpmEstimate

        public static var allKeys: Set<Input> {
          return [
             .signal,
             .bpmEstimate
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case confidence

        public static var allKeys: Set<Output> {
          return [
             .confidence
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case sampleRate

        public static var allKeys: Set<Parameter> {
          return [
             .sampleRate
          ]
        }

      }

    }

    /// The specification for the standard `LoopBpmEstimator` algorithm.
    public struct LoopBpmEstimator: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<LoopBpmEstimator> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<LoopBpmEstimator>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "LoopBpmEstimator" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Input> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case bpm

        public static var allKeys: Set<Output> {
          return [
             .bpm
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case confidenceThreshold

        public static var allKeys: Set<Parameter> {
          return [
             .confidenceThreshold
          ]
        }

      }

    }

    /// The specification for the standard `Meter` algorithm.
    public struct Meter: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<Meter> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<Meter>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Meter" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case beatogram

        public static var allKeys: Set<Input> {
          return [
             .beatogram
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case meter

        public static var allKeys: Set<Output> {
          return [
             .meter
          ]
        }

      }

      /// An enumeration with the sole case of `none` specifying that the algorithm has no parameters.
      public enum Parameter: String, KeyEnumeration {

        case none

        public static var allKeys: Set<Parameter> {
          return []
        }

      }

    }

    /// The specification for the standard `NoveltyCurve` algorithm.
    public struct NoveltyCurve: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<NoveltyCurve> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<NoveltyCurve>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "NoveltyCurve" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case frequencyBands

        public static var allKeys: Set<Input> {
          return [
             .frequencyBands
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case novelty

        public static var allKeys: Set<Output> {
          return [
             .novelty
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case frameRate
        case normalize
        case weightCurve
        case weightCurveType

        public static var allKeys: Set<Parameter> {
          return [
             .frameRate,
             .normalize,
             .weightCurve,
             .weightCurveType
          ]
        }

      }

    }

    /// The specification for the standard `NoveltyCurveFixedBpmEstimator` algorithm.
    public struct NoveltyCurveFixedBpmEstimator: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<NoveltyCurveFixedBpmEstimator> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<NoveltyCurveFixedBpmEstimator>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "NoveltyCurveFixedBpmEstimator" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case novelty

        public static var allKeys: Set<Input> {
          return [
             .novelty
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case bpms
        case amplitudes

        public static var allKeys: Set<Output> {
          return [
             .bpms,
             .amplitudes
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case hopSize
        case maxBpm
        case minBpm
        case sampleRate
        case tolerance

        public static var allKeys: Set<Parameter> {
          return [
             .hopSize,
             .maxBpm,
             .minBpm,
             .sampleRate,
             .tolerance
          ]
        }

      }

    }

    /// The specification for the standard `OnsetDetection` algorithm.
    public struct OnsetDetection: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<OnsetDetection> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<OnsetDetection>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "OnsetDetection" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case phase
        case spectrum

        public static var allKeys: Set<Input> {
          return [
             .phase,
             .spectrum
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case onsetDetection

        public static var allKeys: Set<Output> {
          return [
             .onsetDetection
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case method
        case sampleRate

        public static var allKeys: Set<Parameter> {
          return [
             .method,
             .sampleRate
          ]
        }

      }

    }

    /// The specification for the standard `OnsetDetectionGlobal` algorithm.
    public struct OnsetDetectionGlobal: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<OnsetDetectionGlobal> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<OnsetDetectionGlobal>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "OnsetDetectionGlobal" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Input> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case onsetDetections

        public static var allKeys: Set<Output> {
          return [
             .onsetDetections
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case frameSize
        case hopSize
        case method
        case sampleRate

        public static var allKeys: Set<Parameter> {
          return [
             .frameSize,
             .hopSize,
             .method,
             .sampleRate
          ]
        }

      }

    }

    /// The specification for the standard `OnsetRate` algorithm.
    public struct OnsetRate: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<OnsetRate> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<OnsetRate>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "OnsetRate" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Input> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case onsets
        case onsetRate

        public static var allKeys: Set<Output> {
          return [
             .onsets,
             .onsetRate
          ]
        }

      }

      /// An enumeration with the sole case of `none` specifying that the algorithm has no parameters.
      public enum Parameter: String, KeyEnumeration {

        case none

        public static var allKeys: Set<Parameter> {
          return []
        }

      }

    }

    /// The specification for the standard `Onsets` algorithm.
    public struct Onsets: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<Onsets> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<Onsets>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Onsets" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case weights
        case detections

        public static var allKeys: Set<Input> {
          return [
             .weights,
             .detections
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case onsets

        public static var allKeys: Set<Output> {
          return [
             .onsets
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case alpha
        case delay
        case frameRate
        case silenceThreshold

        public static var allKeys: Set<Parameter> {
          return [
             .alpha,
             .delay,
             .frameRate,
             .silenceThreshold
          ]
        }

      }

    }

    /// The specification for the standard `PercivalBpmEstimator` algorithm.
    public struct PercivalBpmEstimator: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<PercivalBpmEstimator> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<PercivalBpmEstimator>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "PercivalBpmEstimator" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Input> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case bpm

        public static var allKeys: Set<Output> {
          return [
             .bpm
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case frameSize
        case frameSizeOSS
        case hopSize
        case hopSizeOSS
        case maxBPM
        case minBPM
        case sampleRate

        public static var allKeys: Set<Parameter> {
          return [
             .frameSize,
             .frameSizeOSS,
             .hopSize,
             .hopSizeOSS,
             .maxBPM,
             .minBPM,
             .sampleRate
          ]
        }

      }

    }

    /// The specification for the standard `PercivalEnhanceHarmonics` algorithm.
    public struct PercivalEnhanceHarmonics: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<PercivalEnhanceHarmonics> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<PercivalEnhanceHarmonics>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "PercivalEnhanceHarmonics" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case array

        public static var allKeys: Set<Input> {
          return [
             .array
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case array

        public static var allKeys: Set<Output> {
          return [
             .array
          ]
        }

      }

      /// An enumeration with the sole case of `none` specifying that the algorithm has no parameters.
      public enum Parameter: String, KeyEnumeration {

        case none

        public static var allKeys: Set<Parameter> {
          return []
        }

      }

    }

    /// The specification for the standard `PercivalEvaluatePulseTrains` algorithm.
    public struct PercivalEvaluatePulseTrains: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<PercivalEvaluatePulseTrains> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<PercivalEvaluatePulseTrains>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "PercivalEvaluatePulseTrains" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case oss
        case positions

        public static var allKeys: Set<Input> {
          return [
             .oss,
             .positions
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case lag

        public static var allKeys: Set<Output> {
          return [
             .lag
          ]
        }

      }

      /// An enumeration with the sole case of `none` specifying that the algorithm has no parameters.
      public enum Parameter: String, KeyEnumeration {

        case none

        public static var allKeys: Set<Parameter> {
          return []
        }

      }

    }

    /// The specification for the standard `RhythmDescriptors` algorithm.
    public struct RhythmDescriptors: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<RhythmDescriptors> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<RhythmDescriptors>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "RhythmDescriptors" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Input> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case bpm_estimates
        case second_peak_spread
        case beats_position
        case histogram
        case second_peak_weight
        case bpm_intervals
        case second_peak_bpm
        case first_peak_bpm
        case first_peak_weight
        case bpm
        case confidence
        case first_peak_spread

        public static var allKeys: Set<Output> {
          return [
             .bpm_estimates,
             .second_peak_spread,
             .beats_position,
             .histogram,
             .second_peak_weight,
             .bpm_intervals,
             .second_peak_bpm,
             .first_peak_bpm,
             .first_peak_weight,
             .bpm,
             .confidence,
             .first_peak_spread
          ]
        }

      }

      /// An enumeration with the sole case of `none` specifying that the algorithm has no parameters.
      public enum Parameter: String, KeyEnumeration {

        case none

        public static var allKeys: Set<Parameter> {
          return []
        }

      }

    }

    /// The specification for the standard `RhythmExtractor` algorithm.
    public struct RhythmExtractor: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<RhythmExtractor> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<RhythmExtractor>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "RhythmExtractor" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Input> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case bpm
        case ticks
        case bpmIntervals
        case estimates

        public static var allKeys: Set<Output> {
          return [
             .bpm,
             .ticks,
             .bpmIntervals,
             .estimates
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case frameHop
        case frameSize
        case hopSize
        case lastBeatInterval
        case maxTempo
        case minTempo
        case numberFrames
        case sampleRate
        case tempoHints
        case tolerance
        case useBands
        case useOnset

        public static var allKeys: Set<Parameter> {
          return [
             .frameHop,
             .frameSize,
             .hopSize,
             .lastBeatInterval,
             .maxTempo,
             .minTempo,
             .numberFrames,
             .sampleRate,
             .tempoHints,
             .tolerance,
             .useBands,
             .useOnset
          ]
        }

      }

    }

    /// The specification for the standard `RhythmExtractor2013` algorithm.
    public struct RhythmExtractor2013: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<RhythmExtractor2013> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<RhythmExtractor2013>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "RhythmExtractor2013" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Input> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case bpm
        case ticks
        case bpmIntervals
        case estimates
        case confidence

        public static var allKeys: Set<Output> {
          return [
             .bpm,
             .ticks,
             .bpmIntervals,
             .estimates,
             .confidence
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case maxTempo
        case method
        case minTempo

        public static var allKeys: Set<Parameter> {
          return [
             .maxTempo,
             .method,
             .minTempo
          ]
        }

      }

    }

    /// The specification for the standard `RhythmTransform` algorithm.
    public struct RhythmTransform: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<RhythmTransform> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<RhythmTransform>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "RhythmTransform" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case melBands

        public static var allKeys: Set<Input> {
          return [
             .melBands
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case rhythm

        public static var allKeys: Set<Output> {
          return [
             .rhythm
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case frameSize
        case hopSize

        public static var allKeys: Set<Parameter> {
          return [
             .frameSize,
             .hopSize
          ]
        }

      }

    }

    /// The specification for the standard `SingleBeatLoudness` algorithm.
    public struct SingleBeatLoudness: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<SingleBeatLoudness> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<SingleBeatLoudness>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "SingleBeatLoudness" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case beat

        public static var allKeys: Set<Input> {
          return [
             .beat
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case loudness
        case loudnessBandRatio

        public static var allKeys: Set<Output> {
          return [
             .loudness,
             .loudnessBandRatio
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case beatDuration
        case beatWindowDuration
        case frequencyBands
        case onsetStart
        case sampleRate

        public static var allKeys: Set<Parameter> {
          return [
             .beatDuration,
             .beatWindowDuration,
             .frequencyBands,
             .onsetStart,
             .sampleRate
          ]
        }

      }

    }

    /// The specification for the standard `SuperFluxExtractor` algorithm.
    public struct SuperFluxExtractor: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<SuperFluxExtractor> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<SuperFluxExtractor>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "SuperFluxExtractor" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Input> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case onsets

        public static var allKeys: Set<Output> {
          return [
             .onsets
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case combine
        case frameSize
        case hopSize
        case ratioThreshold
        case sampleRate
        case threshold

        public static var allKeys: Set<Parameter> {
          return [
             .combine,
             .frameSize,
             .hopSize,
             .ratioThreshold,
             .sampleRate,
             .threshold
          ]
        }

      }

    }

    /// The specification for the standard `SuperFluxNovelty` algorithm.
    public struct SuperFluxNovelty: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<SuperFluxNovelty> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<SuperFluxNovelty>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "SuperFluxNovelty" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case bands

        public static var allKeys: Set<Input> {
          return [
             .bands
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case differences

        public static var allKeys: Set<Output> {
          return [
             .differences
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case binWidth
        case frameWidth

        public static var allKeys: Set<Parameter> {
          return [
             .binWidth,
             .frameWidth
          ]
        }

      }

    }

    /// The specification for the standard `SuperFluxPeaks` algorithm.
    public struct SuperFluxPeaks: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<SuperFluxPeaks> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<SuperFluxPeaks>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "SuperFluxPeaks" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case novelty

        public static var allKeys: Set<Input> {
          return [
             .novelty
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case peaks

        public static var allKeys: Set<Output> {
          return [
             .peaks
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case combine
        case frameRate
        case pre_avg
        case pre_max
        case ratioThreshold
        case threshold

        public static var allKeys: Set<Parameter> {
          return [
             .combine,
             .frameRate,
             .pre_avg,
             .pre_max,
             .ratioThreshold,
             .threshold
          ]
        }

      }

    }

    /// The specification for the standard `TempoScaleBands` algorithm.
    public struct TempoScaleBands: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<TempoScaleBands> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<TempoScaleBands>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "TempoScaleBands" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case bands

        public static var allKeys: Set<Input> {
          return [
             .bands
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case scaledBands
        case cumulativeBands

        public static var allKeys: Set<Output> {
          return [
             .scaledBands,
             .cumulativeBands
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case bandsGain
        case frameTime

        public static var allKeys: Set<Parameter> {
          return [
             .bandsGain,
             .frameTime
          ]
        }

      }

    }

    /// The specification for the standard `TempoTap` algorithm.
    public struct TempoTap: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<TempoTap> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<TempoTap>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "TempoTap" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case featuresFrame

        public static var allKeys: Set<Input> {
          return [
             .featuresFrame
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case periods
        case phases

        public static var allKeys: Set<Output> {
          return [
             .periods,
             .phases
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case frameHop
        case frameSize
        case maxTempo
        case minTempo
        case numberFrames
        case sampleRate
        case tempoHints

        public static var allKeys: Set<Parameter> {
          return [
             .frameHop,
             .frameSize,
             .maxTempo,
             .minTempo,
             .numberFrames,
             .sampleRate,
             .tempoHints
          ]
        }

      }

    }

    /// The specification for the standard `TempoTapDegara` algorithm.
    public struct TempoTapDegara: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<TempoTapDegara> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<TempoTapDegara>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "TempoTapDegara" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case onsetDetections

        public static var allKeys: Set<Input> {
          return [
             .onsetDetections
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case ticks

        public static var allKeys: Set<Output> {
          return [
             .ticks
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case maxTempo
        case minTempo
        case resample
        case sampleRateODF

        public static var allKeys: Set<Parameter> {
          return [
             .maxTempo,
             .minTempo,
             .resample,
             .sampleRateODF
          ]
        }

      }

    }

    /// The specification for the standard `TempoTapMaxAgreement` algorithm.
    public struct TempoTapMaxAgreement: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<TempoTapMaxAgreement> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<TempoTapMaxAgreement>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "TempoTapMaxAgreement" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case tickCandidates

        public static var allKeys: Set<Input> {
          return [
             .tickCandidates
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case confidence
        case ticks

        public static var allKeys: Set<Output> {
          return [
             .confidence,
             .ticks
          ]
        }

      }

      /// An enumeration with the sole case of `none` specifying that the algorithm has no parameters.
      public enum Parameter: String, KeyEnumeration {

        case none

        public static var allKeys: Set<Parameter> {
          return []
        }

      }

    }

    /// The specification for the standard `TempoTapTicks` algorithm.
    public struct TempoTapTicks: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<TempoTapTicks> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<TempoTapTicks>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "TempoTapTicks" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case periods
        case phases

        public static var allKeys: Set<Input> {
          return [
             .periods,
             .phases
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case matchingPeriods
        case ticks

        public static var allKeys: Set<Output> {
          return [
             .matchingPeriods,
             .ticks
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case frameHop
        case hopSize
        case sampleRate

        public static var allKeys: Set<Parameter> {
          return [
             .frameHop,
             .hopSize,
             .sampleRate
          ]
        }

      }

    }

  }

  /// An enumeration serving as both a namespace and a category for algorithm specifications.
  public enum Pitch: AlgorithmCategory {

    /// The name of the category as it appears in info structs.
    public static var name: String { return "Pitch" }

    /// The specification for the standard `MultiPitchKlapuri` algorithm.
    public struct MultiPitchKlapuri: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<MultiPitchKlapuri> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<MultiPitchKlapuri>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "MultiPitchKlapuri" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Pitch.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Input> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case pitch

        public static var allKeys: Set<Output> {
          return [
             .pitch
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case binResolution
        case frameSize
        case harmonicWeight
        case hopSize
        case magnitudeCompression
        case magnitudeThreshold
        case maxFrequency
        case minFrequency
        case numberHarmonics
        case referenceFrequency
        case sampleRate

        public static var allKeys: Set<Parameter> {
          return [
             .binResolution,
             .frameSize,
             .harmonicWeight,
             .hopSize,
             .magnitudeCompression,
             .magnitudeThreshold,
             .maxFrequency,
             .minFrequency,
             .numberHarmonics,
             .referenceFrequency,
             .sampleRate
          ]
        }

      }

    }

    /// The specification for the standard `MultiPitchMelodia` algorithm.
    public struct MultiPitchMelodia: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<MultiPitchMelodia> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<MultiPitchMelodia>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "MultiPitchMelodia" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Pitch.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Input> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case pitch

        public static var allKeys: Set<Output> {
          return [
             .pitch
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case binResolution
        case filterIterations
        case frameSize
        case guessUnvoiced
        case harmonicWeight
        case hopSize
        case magnitudeCompression
        case magnitudeThreshold
        case maxFrequency
        case minDuration
        case minFrequency
        case numberHarmonics
        case peakDistributionThreshold
        case peakFrameThreshold
        case pitchContinuity
        case referenceFrequency
        case sampleRate
        case timeContinuity

        public static var allKeys: Set<Parameter> {
          return [
             .binResolution,
             .filterIterations,
             .frameSize,
             .guessUnvoiced,
             .harmonicWeight,
             .hopSize,
             .magnitudeCompression,
             .magnitudeThreshold,
             .maxFrequency,
             .minDuration,
             .minFrequency,
             .numberHarmonics,
             .peakDistributionThreshold,
             .peakFrameThreshold,
             .pitchContinuity,
             .referenceFrequency,
             .sampleRate,
             .timeContinuity
          ]
        }

      }

    }

    /// The specification for the standard `PitchContourSegmentation` algorithm.
    public struct PitchContourSegmentation: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<PitchContourSegmentation> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<PitchContourSegmentation>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "PitchContourSegmentation" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Pitch.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case signal
        case pitch

        public static var allKeys: Set<Input> {
          return [
             .signal,
             .pitch
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case duration
        case MIDIpitch
        case onset

        public static var allKeys: Set<Output> {
          return [
             .duration,
             .MIDIpitch,
             .onset
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case hopSize
        case minDuration
        case pitchDistanceThreshold
        case rmsThreshold
        case sampleRate
        case tuningFrequency

        public static var allKeys: Set<Parameter> {
          return [
             .hopSize,
             .minDuration,
             .pitchDistanceThreshold,
             .rmsThreshold,
             .sampleRate,
             .tuningFrequency
          ]
        }

      }

    }

    /// The specification for the standard `PitchContours` algorithm.
    public struct PitchContours: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<PitchContours> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<PitchContours>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "PitchContours" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Pitch.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case peakBins
        case peakSaliences

        public static var allKeys: Set<Input> {
          return [
             .peakBins,
             .peakSaliences
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case contoursBins
        case contoursStartTimes
        case duration
        case contoursSaliences

        public static var allKeys: Set<Output> {
          return [
             .contoursBins,
             .contoursStartTimes,
             .duration,
             .contoursSaliences
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case binResolution
        case hopSize
        case minDuration
        case peakDistributionThreshold
        case peakFrameThreshold
        case pitchContinuity
        case sampleRate
        case timeContinuity

        public static var allKeys: Set<Parameter> {
          return [
             .binResolution,
             .hopSize,
             .minDuration,
             .peakDistributionThreshold,
             .peakFrameThreshold,
             .pitchContinuity,
             .sampleRate,
             .timeContinuity
          ]
        }

      }

    }

    /// The specification for the standard `PitchContoursMelody` algorithm.
    public struct PitchContoursMelody: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<PitchContoursMelody> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<PitchContoursMelody>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "PitchContoursMelody" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Pitch.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case contoursBins
        case contoursStartTimes
        case duration
        case contoursSaliences

        public static var allKeys: Set<Input> {
          return [
             .contoursBins,
             .contoursStartTimes,
             .duration,
             .contoursSaliences
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case pitchConfidence
        case pitch

        public static var allKeys: Set<Output> {
          return [
             .pitchConfidence,
             .pitch
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case binResolution
        case filterIterations
        case guessUnvoiced
        case hopSize
        case maxFrequency
        case minFrequency
        case referenceFrequency
        case sampleRate
        case voiceVibrato
        case voicingTolerance

        public static var allKeys: Set<Parameter> {
          return [
             .binResolution,
             .filterIterations,
             .guessUnvoiced,
             .hopSize,
             .maxFrequency,
             .minFrequency,
             .referenceFrequency,
             .sampleRate,
             .voiceVibrato,
             .voicingTolerance
          ]
        }

      }

    }

    /// The specification for the standard `PitchContoursMonoMelody` algorithm.
    public struct PitchContoursMonoMelody: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<PitchContoursMonoMelody> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<PitchContoursMonoMelody>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "PitchContoursMonoMelody" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Pitch.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case contoursBins
        case contoursStartTimes
        case duration
        case contoursSaliences

        public static var allKeys: Set<Input> {
          return [
             .contoursBins,
             .contoursStartTimes,
             .duration,
             .contoursSaliences
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case pitchConfidence
        case pitch

        public static var allKeys: Set<Output> {
          return [
             .pitchConfidence,
             .pitch
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case binResolution
        case filterIterations
        case guessUnvoiced
        case hopSize
        case maxFrequency
        case minFrequency
        case referenceFrequency
        case sampleRate

        public static var allKeys: Set<Parameter> {
          return [
             .binResolution,
             .filterIterations,
             .guessUnvoiced,
             .hopSize,
             .maxFrequency,
             .minFrequency,
             .referenceFrequency,
             .sampleRate
          ]
        }

      }

    }

    /// The specification for the standard `PitchContoursMultiMelody` algorithm.
    public struct PitchContoursMultiMelody: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<PitchContoursMultiMelody> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<PitchContoursMultiMelody>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "PitchContoursMultiMelody" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Pitch.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case contoursBins
        case contoursStartTimes
        case duration
        case contoursSaliences

        public static var allKeys: Set<Input> {
          return [
             .contoursBins,
             .contoursStartTimes,
             .duration,
             .contoursSaliences
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case pitch

        public static var allKeys: Set<Output> {
          return [
             .pitch
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case binResolution
        case filterIterations
        case guessUnvoiced
        case hopSize
        case maxFrequency
        case minFrequency
        case referenceFrequency
        case sampleRate

        public static var allKeys: Set<Parameter> {
          return [
             .binResolution,
             .filterIterations,
             .guessUnvoiced,
             .hopSize,
             .maxFrequency,
             .minFrequency,
             .referenceFrequency,
             .sampleRate
          ]
        }

      }

    }

    /// The specification for the standard `PitchFilter` algorithm.
    public struct PitchFilter: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<PitchFilter> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<PitchFilter>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "PitchFilter" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Pitch.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case pitchConfidence
        case pitch

        public static var allKeys: Set<Input> {
          return [
             .pitchConfidence,
             .pitch
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case pitchFiltered

        public static var allKeys: Set<Output> {
          return [
             .pitchFiltered
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case confidenceThreshold
        case minChunkSize
        case useAbsolutePitchConfidence

        public static var allKeys: Set<Parameter> {
          return [
             .confidenceThreshold,
             .minChunkSize,
             .useAbsolutePitchConfidence
          ]
        }

      }

    }

    /// The specification for the standard `PitchMelodia` algorithm.
    public struct PitchMelodia: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<PitchMelodia> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<PitchMelodia>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "PitchMelodia" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Pitch.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Input> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case pitchConfidence
        case pitch

        public static var allKeys: Set<Output> {
          return [
             .pitchConfidence,
             .pitch
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case binResolution
        case filterIterations
        case frameSize
        case guessUnvoiced
        case harmonicWeight
        case hopSize
        case magnitudeCompression
        case magnitudeThreshold
        case maxFrequency
        case minDuration
        case minFrequency
        case numberHarmonics
        case peakDistributionThreshold
        case peakFrameThreshold
        case pitchContinuity
        case referenceFrequency
        case sampleRate
        case timeContinuity

        public static var allKeys: Set<Parameter> {
          return [
             .binResolution,
             .filterIterations,
             .frameSize,
             .guessUnvoiced,
             .harmonicWeight,
             .hopSize,
             .magnitudeCompression,
             .magnitudeThreshold,
             .maxFrequency,
             .minDuration,
             .minFrequency,
             .numberHarmonics,
             .peakDistributionThreshold,
             .peakFrameThreshold,
             .pitchContinuity,
             .referenceFrequency,
             .sampleRate,
             .timeContinuity
          ]
        }

      }

    }

    /// The specification for the standard `PitchSalienceFunction` algorithm.
    public struct PitchSalienceFunction: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<PitchSalienceFunction> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<PitchSalienceFunction>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "PitchSalienceFunction" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Pitch.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case frequencies
        case magnitudes

        public static var allKeys: Set<Input> {
          return [
             .frequencies,
             .magnitudes
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case salienceFunction

        public static var allKeys: Set<Output> {
          return [
             .salienceFunction
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case binResolution
        case harmonicWeight
        case magnitudeCompression
        case magnitudeThreshold
        case numberHarmonics
        case referenceFrequency

        public static var allKeys: Set<Parameter> {
          return [
             .binResolution,
             .harmonicWeight,
             .magnitudeCompression,
             .magnitudeThreshold,
             .numberHarmonics,
             .referenceFrequency
          ]
        }

      }

    }

    /// The specification for the standard `PitchSalienceFunctionPeaks` algorithm.
    public struct PitchSalienceFunctionPeaks: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<PitchSalienceFunctionPeaks> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<PitchSalienceFunctionPeaks>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "PitchSalienceFunctionPeaks" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Pitch.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case salienceFunction

        public static var allKeys: Set<Input> {
          return [
             .salienceFunction
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case salienceBins
        case salienceValues

        public static var allKeys: Set<Output> {
          return [
             .salienceBins,
             .salienceValues
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case binResolution
        case maxFrequency
        case minFrequency
        case referenceFrequency

        public static var allKeys: Set<Parameter> {
          return [
             .binResolution,
             .maxFrequency,
             .minFrequency,
             .referenceFrequency
          ]
        }

      }

    }

    /// The specification for the standard `PitchYin` algorithm.
    public struct PitchYin: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<PitchYin> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<PitchYin>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "PitchYin" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Pitch.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Input> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case pitchConfidence
        case pitch

        public static var allKeys: Set<Output> {
          return [
             .pitchConfidence,
             .pitch
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case frameSize
        case interpolate
        case maxFrequency
        case minFrequency
        case sampleRate
        case tolerance

        public static var allKeys: Set<Parameter> {
          return [
             .frameSize,
             .interpolate,
             .maxFrequency,
             .minFrequency,
             .sampleRate,
             .tolerance
          ]
        }

      }

    }

    /// The specification for the standard `PitchYinFFT` algorithm.
    public struct PitchYinFFT: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<PitchYinFFT> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<PitchYinFFT>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "PitchYinFFT" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Pitch.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case spectrum

        public static var allKeys: Set<Input> {
          return [
             .spectrum
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case pitchConfidence
        case pitch

        public static var allKeys: Set<Output> {
          return [
             .pitchConfidence,
             .pitch
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case frameSize
        case interpolate
        case maxFrequency
        case minFrequency
        case sampleRate

        public static var allKeys: Set<Parameter> {
          return [
             .frameSize,
             .interpolate,
             .maxFrequency,
             .minFrequency,
             .sampleRate
          ]
        }

      }

    }

    /// The specification for the standard `PredominantPitchMelodia` algorithm.
    public struct PredominantPitchMelodia: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<PredominantPitchMelodia> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<PredominantPitchMelodia>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "PredominantPitchMelodia" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Pitch.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Input> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case pitchConfidence
        case pitch

        public static var allKeys: Set<Output> {
          return [
             .pitchConfidence,
             .pitch
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case binResolution
        case filterIterations
        case frameSize
        case guessUnvoiced
        case harmonicWeight
        case hopSize
        case magnitudeCompression
        case magnitudeThreshold
        case maxFrequency
        case minDuration
        case minFrequency
        case numberHarmonics
        case peakDistributionThreshold
        case peakFrameThreshold
        case pitchContinuity
        case referenceFrequency
        case sampleRate
        case timeContinuity
        case voiceVibrato
        case voicingTolerance

        public static var allKeys: Set<Parameter> {
          return [
             .binResolution,
             .filterIterations,
             .frameSize,
             .guessUnvoiced,
             .harmonicWeight,
             .hopSize,
             .magnitudeCompression,
             .magnitudeThreshold,
             .maxFrequency,
             .minDuration,
             .minFrequency,
             .numberHarmonics,
             .peakDistributionThreshold,
             .peakFrameThreshold,
             .pitchContinuity,
             .referenceFrequency,
             .sampleRate,
             .timeContinuity,
             .voiceVibrato,
             .voicingTolerance
          ]
        }

      }

    }

    /// The specification for the standard `Vibrato` algorithm.
    public struct Vibrato: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<Vibrato> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<Vibrato>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Vibrato" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Pitch.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case pitch

        public static var allKeys: Set<Input> {
          return [
             .pitch
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case vibratoExtend
        case vibratoFrequency

        public static var allKeys: Set<Output> {
          return [
             .vibratoExtend,
             .vibratoFrequency
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case maxExtend
        case maxFrequency
        case minExtend
        case minFrequency
        case sampleRate

        public static var allKeys: Set<Parameter> {
          return [
             .maxExtend,
             .maxFrequency,
             .minExtend,
             .minFrequency,
             .sampleRate
          ]
        }

      }

    }

  }

  /// An enumeration serving as both a namespace and a category for algorithm specifications.
  public enum Synthesis: AlgorithmCategory {

    /// The name of the category as it appears in info structs.
    public static var name: String { return "Synthesis" }

    /// The specification for the standard `HarmonicMask` algorithm.
    public struct HarmonicMask: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<HarmonicMask> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<HarmonicMask>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "HarmonicMask" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Synthesis.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case fft
        case pitch

        public static var allKeys: Set<Input> {
          return [
             .fft,
             .pitch
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case fft

        public static var allKeys: Set<Output> {
          return [
             .fft
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case attenuation
        case binWidth
        case sampleRate

        public static var allKeys: Set<Parameter> {
          return [
             .attenuation,
             .binWidth,
             .sampleRate
          ]
        }

      }

    }

    /// The specification for the standard `HarmonicModelAnal` algorithm.
    public struct HarmonicModelAnal: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<HarmonicModelAnal> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<HarmonicModelAnal>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "HarmonicModelAnal" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Synthesis.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case fft
        case pitch

        public static var allKeys: Set<Input> {
          return [
             .fft,
             .pitch
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case frequencies
        case phases
        case magnitudes

        public static var allKeys: Set<Output> {
          return [
             .frequencies,
             .phases,
             .magnitudes
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case freqDevOffset
        case freqDevSlope
        case harmDevSlope
        case hopSize
        case magnitudeThreshold
        case maxFrequency
        case maxPeaks
        case maxnSines
        case minFrequency
        case nHarmonics
        case orderBy
        case sampleRate

        public static var allKeys: Set<Parameter> {
          return [
             .freqDevOffset,
             .freqDevSlope,
             .harmDevSlope,
             .hopSize,
             .magnitudeThreshold,
             .maxFrequency,
             .maxPeaks,
             .maxnSines,
             .minFrequency,
             .nHarmonics,
             .orderBy,
             .sampleRate
          ]
        }

      }

    }

    /// The specification for the standard `HprModelAnal` algorithm.
    public struct HprModelAnal: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<HprModelAnal> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<HprModelAnal>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "HprModelAnal" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Synthesis.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case frame
        case pitch

        public static var allKeys: Set<Input> {
          return [
             .frame,
             .pitch
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case phases
        case magnitudes
        case res
        case frequencies

        public static var allKeys: Set<Output> {
          return [
             .phases,
             .magnitudes,
             .res,
             .frequencies
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case fftSize
        case freqDevOffset
        case freqDevSlope
        case harmDevSlope
        case hopSize
        case magnitudeThreshold
        case maxFrequency
        case maxPeaks
        case maxnSines
        case minFrequency
        case nHarmonics
        case orderBy
        case sampleRate
        case stocf

        public static var allKeys: Set<Parameter> {
          return [
             .fftSize,
             .freqDevOffset,
             .freqDevSlope,
             .harmDevSlope,
             .hopSize,
             .magnitudeThreshold,
             .maxFrequency,
             .maxPeaks,
             .maxnSines,
             .minFrequency,
             .nHarmonics,
             .orderBy,
             .sampleRate,
             .stocf
          ]
        }

      }

    }

    /// The specification for the standard `HpsModelAnal` algorithm.
    public struct HpsModelAnal: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<HpsModelAnal> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<HpsModelAnal>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "HpsModelAnal" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Synthesis.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case frame
        case pitch

        public static var allKeys: Set<Input> {
          return [
             .frame,
             .pitch
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case phases
        case stocenv
        case magnitudes
        case frequencies

        public static var allKeys: Set<Output> {
          return [
             .phases,
             .stocenv,
             .magnitudes,
             .frequencies
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case fftSize
        case freqDevOffset
        case freqDevSlope
        case harmDevSlope
        case hopSize
        case magnitudeThreshold
        case maxFrequency
        case maxPeaks
        case maxnSines
        case minFrequency
        case nHarmonics
        case orderBy
        case sampleRate
        case stocf

        public static var allKeys: Set<Parameter> {
          return [
             .fftSize,
             .freqDevOffset,
             .freqDevSlope,
             .harmDevSlope,
             .hopSize,
             .magnitudeThreshold,
             .maxFrequency,
             .maxPeaks,
             .maxnSines,
             .minFrequency,
             .nHarmonics,
             .orderBy,
             .sampleRate,
             .stocf
          ]
        }

      }

    }

    /// The specification for the standard `ResampleFFT` algorithm.
    public struct ResampleFFT: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<ResampleFFT> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<ResampleFFT>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "ResampleFFT" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Synthesis.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case input

        public static var allKeys: Set<Input> {
          return [
             .input
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case output

        public static var allKeys: Set<Output> {
          return [
             .output
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case inSize
        case outSize

        public static var allKeys: Set<Parameter> {
          return [
             .inSize,
             .outSize
          ]
        }

      }

    }

    /// The specification for the standard `SineModelAnal` algorithm.
    public struct SineModelAnal: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<SineModelAnal> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<SineModelAnal>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "SineModelAnal" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Synthesis.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case fft

        public static var allKeys: Set<Input> {
          return [
             .fft
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case frequencies
        case phases
        case magnitudes

        public static var allKeys: Set<Output> {
          return [
             .frequencies,
             .phases,
             .magnitudes
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case freqDevOffset
        case freqDevSlope
        case magnitudeThreshold
        case maxFrequency
        case maxPeaks
        case maxnSines
        case minFrequency
        case orderBy
        case sampleRate

        public static var allKeys: Set<Parameter> {
          return [
             .freqDevOffset,
             .freqDevSlope,
             .magnitudeThreshold,
             .maxFrequency,
             .maxPeaks,
             .maxnSines,
             .minFrequency,
             .orderBy,
             .sampleRate
          ]
        }

      }

    }

    /// The specification for the standard `SineModelSynth` algorithm.
    public struct SineModelSynth: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<SineModelSynth> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<SineModelSynth>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "SineModelSynth" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Synthesis.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case frequencies
        case phases
        case magnitudes

        public static var allKeys: Set<Input> {
          return [
             .frequencies,
             .phases,
             .magnitudes
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case fft

        public static var allKeys: Set<Output> {
          return [
             .fft
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case fftSize
        case hopSize
        case sampleRate

        public static var allKeys: Set<Parameter> {
          return [
             .fftSize,
             .hopSize,
             .sampleRate
          ]
        }

      }

    }

    /// The specification for the standard `SineSubtraction` algorithm.
    public struct SineSubtraction: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<SineSubtraction> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<SineSubtraction>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "SineSubtraction" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Synthesis.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case phases
        case magnitudes
        case frame
        case frequencies

        public static var allKeys: Set<Input> {
          return [
             .phases,
             .magnitudes,
             .frame,
             .frequencies
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case frame

        public static var allKeys: Set<Output> {
          return [
             .frame
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case fftSize
        case hopSize
        case sampleRate

        public static var allKeys: Set<Parameter> {
          return [
             .fftSize,
             .hopSize,
             .sampleRate
          ]
        }

      }

    }

    /// The specification for the standard `SprModelAnal` algorithm.
    public struct SprModelAnal: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<SprModelAnal> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<SprModelAnal>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "SprModelAnal" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Synthesis.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case frame

        public static var allKeys: Set<Input> {
          return [
             .frame
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case phases
        case magnitudes
        case res
        case frequencies

        public static var allKeys: Set<Output> {
          return [
             .phases,
             .magnitudes,
             .res,
             .frequencies
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case fftSize
        case freqDevOffset
        case freqDevSlope
        case hopSize
        case magnitudeThreshold
        case maxFrequency
        case maxPeaks
        case maxnSines
        case minFrequency
        case orderBy
        case sampleRate

        public static var allKeys: Set<Parameter> {
          return [
             .fftSize,
             .freqDevOffset,
             .freqDevSlope,
             .hopSize,
             .magnitudeThreshold,
             .maxFrequency,
             .maxPeaks,
             .maxnSines,
             .minFrequency,
             .orderBy,
             .sampleRate
          ]
        }

      }

    }

    /// The specification for the standard `SprModelSynth` algorithm.
    public struct SprModelSynth: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<SprModelSynth> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<SprModelSynth>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "SprModelSynth" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Synthesis.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case phases
        case magnitudes
        case res
        case frequencies

        public static var allKeys: Set<Input> {
          return [
             .phases,
             .magnitudes,
             .res,
             .frequencies
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case frame
        case resframe
        case sineframe

        public static var allKeys: Set<Output> {
          return [
             .frame,
             .resframe,
             .sineframe
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case fftSize
        case hopSize
        case sampleRate

        public static var allKeys: Set<Parameter> {
          return [
             .fftSize,
             .hopSize,
             .sampleRate
          ]
        }

      }

    }

    /// The specification for the standard `SpsModelAnal` algorithm.
    public struct SpsModelAnal: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<SpsModelAnal> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<SpsModelAnal>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "SpsModelAnal" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Synthesis.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case frame

        public static var allKeys: Set<Input> {
          return [
             .frame
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case phases
        case stocenv
        case magnitudes
        case frequencies

        public static var allKeys: Set<Output> {
          return [
             .phases,
             .stocenv,
             .magnitudes,
             .frequencies
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case fftSize
        case freqDevOffset
        case freqDevSlope
        case hopSize
        case magnitudeThreshold
        case maxFrequency
        case maxPeaks
        case maxnSines
        case minFrequency
        case orderBy
        case sampleRate
        case stocf

        public static var allKeys: Set<Parameter> {
          return [
             .fftSize,
             .freqDevOffset,
             .freqDevSlope,
             .hopSize,
             .magnitudeThreshold,
             .maxFrequency,
             .maxPeaks,
             .maxnSines,
             .minFrequency,
             .orderBy,
             .sampleRate,
             .stocf
          ]
        }

      }

    }

    /// The specification for the standard `SpsModelSynth` algorithm.
    public struct SpsModelSynth: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<SpsModelSynth> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<SpsModelSynth>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "SpsModelSynth" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Synthesis.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case phases
        case stocenv
        case magnitudes
        case frequencies

        public static var allKeys: Set<Input> {
          return [
             .phases,
             .stocenv,
             .magnitudes,
             .frequencies
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case frame
        case stocframe
        case sineframe

        public static var allKeys: Set<Output> {
          return [
             .frame,
             .stocframe,
             .sineframe
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case fftSize
        case hopSize
        case sampleRate
        case stocf

        public static var allKeys: Set<Parameter> {
          return [
             .fftSize,
             .hopSize,
             .sampleRate,
             .stocf
          ]
        }

      }

    }

    /// The specification for the standard `StochasticModelAnal` algorithm.
    public struct StochasticModelAnal: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<StochasticModelAnal> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<StochasticModelAnal>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "StochasticModelAnal" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Synthesis.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case frame

        public static var allKeys: Set<Input> {
          return [
             .frame
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case stocenv

        public static var allKeys: Set<Output> {
          return [
             .stocenv
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case fftSize
        case hopSize
        case sampleRate
        case stocf

        public static var allKeys: Set<Parameter> {
          return [
             .fftSize,
             .hopSize,
             .sampleRate,
             .stocf
          ]
        }

      }

    }

    /// The specification for the standard `StochasticModelSynth` algorithm.
    public struct StochasticModelSynth: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<StochasticModelSynth> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<StochasticModelSynth>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "StochasticModelSynth" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Synthesis.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case stocenv

        public static var allKeys: Set<Input> {
          return [
             .stocenv
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case frame

        public static var allKeys: Set<Output> {
          return [
             .frame
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case fftSize
        case hopSize
        case sampleRate
        case stocf

        public static var allKeys: Set<Parameter> {
          return [
             .fftSize,
             .hopSize,
             .sampleRate,
             .stocf
          ]
        }

      }

    }

  }

  /// An enumeration serving as both a namespace and a category for algorithm specifications.
  public enum IO: AlgorithmCategory {

    /// The name of the category as it appears in info structs.
    public static var name: String { return "Input/output" }

    /// The specification for the standard `AudioOnsetsMarker` algorithm.
    public struct AudioOnsetsMarker: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<AudioOnsetsMarker> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<AudioOnsetsMarker>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "AudioOnsetsMarker" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return IO.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Input> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Output> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case onsets
        case sampleRate
        case type

        public static var allKeys: Set<Parameter> {
          return [
             .onsets,
             .sampleRate,
             .type
          ]
        }

      }

    }

  }

  /// An enumeration serving as both a namespace and a category for algorithm specifications.
  public enum Duration_Silence: AlgorithmCategory {

    /// The name of the category as it appears in info structs.
    public static var name: String { return "Duration/silence" }

    /// The specification for the standard `Duration` algorithm.
    public struct Duration: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<Duration> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<Duration>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Duration" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Duration_Silence.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Input> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case duration

        public static var allKeys: Set<Output> {
          return [
             .duration
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case sampleRate

        public static var allKeys: Set<Parameter> {
          return [
             .sampleRate
          ]
        }

      }

    }

    /// The specification for the standard `EffectiveDuration` algorithm.
    public struct EffectiveDuration: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<EffectiveDuration> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<EffectiveDuration>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "EffectiveDuration" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Duration_Silence.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Input> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case effectiveDuration

        public static var allKeys: Set<Output> {
          return [
             .effectiveDuration
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case sampleRate
        case thresholdRatio

        public static var allKeys: Set<Parameter> {
          return [
             .sampleRate,
             .thresholdRatio
          ]
        }

      }

    }

    /// The specification for the standard `FadeDetection` algorithm.
    public struct FadeDetection: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<FadeDetection> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<FadeDetection>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "FadeDetection" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Duration_Silence.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case rms

        public static var allKeys: Set<Input> {
          return [
             .rms
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case fadeIn
        case fadeOut

        public static var allKeys: Set<Output> {
          return [
             .fadeIn,
             .fadeOut
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case cutoffHigh
        case cutoffLow
        case frameRate
        case minLength

        public static var allKeys: Set<Parameter> {
          return [
             .cutoffHigh,
             .cutoffLow,
             .frameRate,
             .minLength
          ]
        }

      }

    }

    /// The specification for the standard `SilenceRate` algorithm.
    public struct SilenceRate: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<SilenceRate> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<SilenceRate>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "SilenceRate" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Duration_Silence.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case frame

        public static var allKeys: Set<Input> {
          return [
             .frame
          ]
        }

      }

      /// An enumeration with the sole case of `none` specifying that the algorithm has no outputs.
      public enum Output: String, KeyEnumeration {

        case none

        public static var allKeys: Set<Output> {
          return []
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case thresholds

        public static var allKeys: Set<Parameter> {
          return [
             .thresholds
          ]
        }

      }

    }

    /// The specification for the standard `StartStopSilence` algorithm.
    public struct StartStopSilence: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<StartStopSilence> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<StartStopSilence>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "StartStopSilence" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Duration_Silence.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case frame

        public static var allKeys: Set<Input> {
          return [
             .frame
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case stopFrame
        case startFrame

        public static var allKeys: Set<Output> {
          return [
             .stopFrame,
             .startFrame
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case threshold

        public static var allKeys: Set<Parameter> {
          return [
             .threshold
          ]
        }

      }

    }

  }

  /// An enumeration serving as both a namespace and a category for algorithm specifications.
  public enum Loudness_Dynamics: AlgorithmCategory {

    /// The name of the category as it appears in info structs.
    public static var name: String { return "Loudness/dynamics" }

    /// The specification for the standard `DynamicComplexity` algorithm.
    public struct DynamicComplexity: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<DynamicComplexity> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<DynamicComplexity>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "DynamicComplexity" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Loudness_Dynamics.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Input> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case loudness
        case dynamicComplexity

        public static var allKeys: Set<Output> {
          return [
             .loudness,
             .dynamicComplexity
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case frameSize
        case sampleRate

        public static var allKeys: Set<Parameter> {
          return [
             .frameSize,
             .sampleRate
          ]
        }

      }

    }

    /// The specification for the standard `Intensity` algorithm.
    public struct Intensity: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<Intensity> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<Intensity>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Intensity" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Loudness_Dynamics.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Input> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case intensity

        public static var allKeys: Set<Output> {
          return [
             .intensity
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case sampleRate

        public static var allKeys: Set<Parameter> {
          return [
             .sampleRate
          ]
        }

      }

    }

    /// The specification for the standard `Larm` algorithm.
    public struct Larm: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<Larm> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<Larm>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Larm" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Loudness_Dynamics.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Input> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case larm

        public static var allKeys: Set<Output> {
          return [
             .larm
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case attackTime
        case power
        case releaseTime
        case sampleRate

        public static var allKeys: Set<Parameter> {
          return [
             .attackTime,
             .power,
             .releaseTime,
             .sampleRate
          ]
        }

      }

    }

    /// The specification for the standard `Leq` algorithm.
    public struct Leq: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<Leq> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<Leq>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Leq" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Loudness_Dynamics.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Input> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case leq

        public static var allKeys: Set<Output> {
          return [
             .leq
          ]
        }

      }

      /// An enumeration with the sole case of `none` specifying that the algorithm has no parameters.
      public enum Parameter: String, KeyEnumeration {

        case none

        public static var allKeys: Set<Parameter> {
          return []
        }

      }

    }

    /// The specification for the standard `LevelExtractor` algorithm.
    public struct LevelExtractor: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<LevelExtractor> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<LevelExtractor>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "LevelExtractor" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Loudness_Dynamics.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Input> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case loudness

        public static var allKeys: Set<Output> {
          return [
             .loudness
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case frameSize
        case hopSize

        public static var allKeys: Set<Parameter> {
          return [
             .frameSize,
             .hopSize
          ]
        }

      }

    }

    /// The specification for the standard `Loudness` algorithm.
    public struct Loudness: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<Loudness> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<Loudness>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Loudness" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Loudness_Dynamics.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Input> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case loudness

        public static var allKeys: Set<Output> {
          return [
             .loudness
          ]
        }

      }

      /// An enumeration with the sole case of `none` specifying that the algorithm has no parameters.
      public enum Parameter: String, KeyEnumeration {

        case none

        public static var allKeys: Set<Parameter> {
          return []
        }

      }

    }

    /// The specification for the standard `LoudnessEBUR128` algorithm.
    public struct LoudnessEBUR128: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<LoudnessEBUR128> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<LoudnessEBUR128>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "LoudnessEBUR128" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Loudness_Dynamics.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Input> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case loudnessRange
        case momentaryLoudness
        case integratedLoudness
        case shortTermLoudness

        public static var allKeys: Set<Output> {
          return [
             .loudnessRange,
             .momentaryLoudness,
             .integratedLoudness,
             .shortTermLoudness
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case hopSize
        case sampleRate

        public static var allKeys: Set<Parameter> {
          return [
             .hopSize,
             .sampleRate
          ]
        }

      }

    }

    /// The specification for the standard `LoudnessVickers` algorithm.
    public struct LoudnessVickers: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<LoudnessVickers> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<LoudnessVickers>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "LoudnessVickers" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Loudness_Dynamics.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Input> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case loudness

        public static var allKeys: Set<Output> {
          return [
             .loudness
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case sampleRate

        public static var allKeys: Set<Parameter> {
          return [
             .sampleRate
          ]
        }

      }

    }

    /// The specification for the standard `ReplayGain` algorithm.
    public struct ReplayGain: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<ReplayGain> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<ReplayGain>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "ReplayGain" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Loudness_Dynamics.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Input> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case replayGain

        public static var allKeys: Set<Output> {
          return [
             .replayGain
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case sampleRate

        public static var allKeys: Set<Parameter> {
          return [
             .sampleRate
          ]
        }

      }

    }

  }

  /// An enumeration serving as both a namespace and a category for algorithm specifications.
  public enum Filters: AlgorithmCategory {

    /// The name of the category as it appears in info structs.
    public static var name: String { return "Filters" }

    /// The specification for the standard `AllPass` algorithm.
    public struct AllPass: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<AllPass> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<AllPass>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "AllPass" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Filters.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Input> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Output> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case bandwidth
        case cutoffFrequency
        case order
        case sampleRate

        public static var allKeys: Set<Parameter> {
          return [
             .bandwidth,
             .cutoffFrequency,
             .order,
             .sampleRate
          ]
        }

      }

    }

    /// The specification for the standard `BandPass` algorithm.
    public struct BandPass: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<BandPass> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<BandPass>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "BandPass" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Filters.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Input> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Output> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case bandwidth
        case cutoffFrequency
        case sampleRate

        public static var allKeys: Set<Parameter> {
          return [
             .bandwidth,
             .cutoffFrequency,
             .sampleRate
          ]
        }

      }

    }

    /// The specification for the standard `BandReject` algorithm.
    public struct BandReject: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<BandReject> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<BandReject>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "BandReject" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Filters.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Input> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Output> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case bandwidth
        case cutoffFrequency
        case sampleRate

        public static var allKeys: Set<Parameter> {
          return [
             .bandwidth,
             .cutoffFrequency,
             .sampleRate
          ]
        }

      }

    }

    /// The specification for the standard `DCRemoval` algorithm.
    public struct DCRemoval: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<DCRemoval> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<DCRemoval>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "DCRemoval" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Filters.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Input> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Output> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case cutoffFrequency
        case sampleRate

        public static var allKeys: Set<Parameter> {
          return [
             .cutoffFrequency,
             .sampleRate
          ]
        }

      }

    }

    /// The specification for the standard `EqualLoudness` algorithm.
    public struct EqualLoudness: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<EqualLoudness> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<EqualLoudness>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "EqualLoudness" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Filters.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Input> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Output> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case sampleRate

        public static var allKeys: Set<Parameter> {
          return [
             .sampleRate
          ]
        }

      }

    }

    /// The specification for the standard `HighPass` algorithm.
    public struct HighPass: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<HighPass> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<HighPass>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "HighPass" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Filters.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Input> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Output> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case cutoffFrequency
        case sampleRate

        public static var allKeys: Set<Parameter> {
          return [
             .cutoffFrequency,
             .sampleRate
          ]
        }

      }

    }

    /// The specification for the standard `IIR` algorithm.
    public struct IIR: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<IIR> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<IIR>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "IIR" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Filters.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Input> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Output> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case denominator
        case numerator

        public static var allKeys: Set<Parameter> {
          return [
             .denominator,
             .numerator
          ]
        }

      }

    }

    /// The specification for the standard `LowPass` algorithm.
    public struct LowPass: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<LowPass> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<LowPass>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "LowPass" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Filters.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Input> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Output> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case cutoffFrequency
        case sampleRate

        public static var allKeys: Set<Parameter> {
          return [
             .cutoffFrequency,
             .sampleRate
          ]
        }

      }

    }

    /// The specification for the standard `MaxFilter` algorithm.
    public struct MaxFilter: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<MaxFilter> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<MaxFilter>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "MaxFilter" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Filters.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Input> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Output> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case causal
        case width

        public static var allKeys: Set<Parameter> {
          return [
             .causal,
             .width
          ]
        }

      }

    }

    /// The specification for the standard `MovingAverage` algorithm.
    public struct MovingAverage: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<MovingAverage> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<MovingAverage>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "MovingAverage" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Filters.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Input> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Output> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case size

        public static var allKeys: Set<Parameter> {
          return [
             .size
          ]
        }

      }

    }

  }

  /// An enumeration serving as both a namespace and a category for algorithm specifications.
  public enum Standard: AlgorithmCategory {

    /// The name of the category as it appears in info structs.
    public static var name: String { return "Standard" }

    /// The specification for the standard `AutoCorrelation` algorithm.
    public struct AutoCorrelation: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<AutoCorrelation> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<AutoCorrelation>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "AutoCorrelation" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case array

        public static var allKeys: Set<Input> {
          return [
             .array
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case autoCorrelation

        public static var allKeys: Set<Output> {
          return [
             .autoCorrelation
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case frequencyDomainCompression
        case generalized
        case normalization

        public static var allKeys: Set<Parameter> {
          return [
             .frequencyDomainCompression,
             .generalized,
             .normalization
          ]
        }

      }

    }

    /// The specification for the standard `BPF` algorithm.
    public struct BPF: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<BPF> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<BPF>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "BPF" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case x

        public static var allKeys: Set<Input> {
          return [
             .x
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case y

        public static var allKeys: Set<Output> {
          return [
             .y
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case xPoints
        case yPoints

        public static var allKeys: Set<Parameter> {
          return [
             .xPoints,
             .yPoints
          ]
        }

      }

    }

    /// The specification for the standard `BinaryOperator` algorithm.
    public struct BinaryOperator: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<BinaryOperator> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<BinaryOperator>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "BinaryOperator" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case array1
        case array2

        public static var allKeys: Set<Input> {
          return [
             .array1,
             .array2
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case array

        public static var allKeys: Set<Output> {
          return [
             .array
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case type

        public static var allKeys: Set<Parameter> {
          return [
             .type
          ]
        }

      }

    }

    /// The specification for the standard `BinaryOperatorStream` algorithm.
    public struct BinaryOperatorStream: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<BinaryOperatorStream> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<BinaryOperatorStream>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "BinaryOperatorStream" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case array1
        case array2

        public static var allKeys: Set<Input> {
          return [
             .array1,
             .array2
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case array

        public static var allKeys: Set<Output> {
          return [
             .array
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case type

        public static var allKeys: Set<Parameter> {
          return [
             .type
          ]
        }

      }

    }

    /// The specification for the standard `Clipper` algorithm.
    public struct Clipper: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<Clipper> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<Clipper>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Clipper" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Input> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Output> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case max
        case min

        public static var allKeys: Set<Parameter> {
          return [
             .max,
             .min
          ]
        }

      }

    }

    /// The specification for the standard `ConstantQ` algorithm.
    public struct ConstantQ: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<ConstantQ> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<ConstantQ>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "ConstantQ" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case frame

        public static var allKeys: Set<Input> {
          return [
             .frame
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case constantq

        public static var allKeys: Set<Output> {
          return [
             .constantq
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case binsPerOctave
        case maxFrequency
        case minFrequency
        case sampleRate
        case threshold

        public static var allKeys: Set<Parameter> {
          return [
             .binsPerOctave,
             .maxFrequency,
             .minFrequency,
             .sampleRate,
             .threshold
          ]
        }

      }

    }

    /// The specification for the standard `CrossCorrelation` algorithm.
    public struct CrossCorrelation: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<CrossCorrelation> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<CrossCorrelation>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "CrossCorrelation" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case arrayX
        case arrayY

        public static var allKeys: Set<Input> {
          return [
             .arrayX,
             .arrayY
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case crossCorrelation

        public static var allKeys: Set<Output> {
          return [
             .crossCorrelation
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case maxLag
        case minLag

        public static var allKeys: Set<Parameter> {
          return [
             .maxLag,
             .minLag
          ]
        }

      }

    }

    /// The specification for the standard `CubicSpline` algorithm.
    public struct CubicSpline: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<CubicSpline> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<CubicSpline>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "CubicSpline" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case x

        public static var allKeys: Set<Input> {
          return [
             .x
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case y
        case dy
        case ddy

        public static var allKeys: Set<Output> {
          return [
             .y,
             .dy,
             .ddy
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case leftBoundaryFlag
        case leftBoundaryValue
        case rightBoundaryFlag
        case rightBoundaryValue
        case xPoints
        case yPoints

        public static var allKeys: Set<Parameter> {
          return [
             .leftBoundaryFlag,
             .leftBoundaryValue,
             .rightBoundaryFlag,
             .rightBoundaryValue,
             .xPoints,
             .yPoints
          ]
        }

      }

    }

    /// The specification for the standard `DCT` algorithm.
    public struct DCT: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<DCT> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<DCT>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "DCT" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case array

        public static var allKeys: Set<Input> {
          return [
             .array
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case dct

        public static var allKeys: Set<Output> {
          return [
             .dct
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case dctType
        case inputSize
        case liftering
        case outputSize

        public static var allKeys: Set<Parameter> {
          return [
             .dctType,
             .inputSize,
             .liftering,
             .outputSize
          ]
        }

      }

    }

    /// The specification for the standard `Derivative` algorithm.
    public struct Derivative: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<Derivative> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<Derivative>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Derivative" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Input> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Output> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration with the sole case of `none` specifying that the algorithm has no parameters.
      public enum Parameter: String, KeyEnumeration {

        case none

        public static var allKeys: Set<Parameter> {
          return []
        }

      }

    }

    /// The specification for the standard `FFT` algorithm.
    public struct FFT: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<FFT> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<FFT>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "FFT" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case frame

        public static var allKeys: Set<Input> {
          return [
             .frame
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case fft

        public static var allKeys: Set<Output> {
          return [
             .fft
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case size

        public static var allKeys: Set<Parameter> {
          return [
             .size
          ]
        }

      }

    }

    /// The specification for the standard `FFTC` algorithm.
    public struct FFTC: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<FFTC> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<FFTC>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "FFTC" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case frame

        public static var allKeys: Set<Input> {
          return [
             .frame
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case fft

        public static var allKeys: Set<Output> {
          return [
             .fft
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case size

        public static var allKeys: Set<Parameter> {
          return [
             .size
          ]
        }

      }

    }

    /// The specification for the standard `FrameCutter` algorithm.
    public struct FrameCutter: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<FrameCutter> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<FrameCutter>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "FrameCutter" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Input> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case frame

        public static var allKeys: Set<Output> {
          return [
             .frame
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case frameSize
        case hopSize
        case lastFrameToEndOfFile
        case startFromZero
        case validFrameThresholdRatio

        public static var allKeys: Set<Parameter> {
          return [
             .frameSize,
             .hopSize,
             .lastFrameToEndOfFile,
             .startFromZero,
             .validFrameThresholdRatio
          ]
        }

      }

    }

    /// The specification for the standard `FrameToReal` algorithm.
    public struct FrameToReal: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<FrameToReal> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<FrameToReal>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "FrameToReal" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Input> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Output> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case frameSize
        case hopSize

        public static var allKeys: Set<Parameter> {
          return [
             .frameSize,
             .hopSize
          ]
        }

      }

    }

    /// The specification for the standard `IDCT` algorithm.
    public struct IDCT: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<IDCT> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<IDCT>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "IDCT" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case dct

        public static var allKeys: Set<Input> {
          return [
             .dct
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case idct

        public static var allKeys: Set<Output> {
          return [
             .idct
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case dctType
        case inputSize
        case liftering
        case outputSize

        public static var allKeys: Set<Parameter> {
          return [
             .dctType,
             .inputSize,
             .liftering,
             .outputSize
          ]
        }

      }

    }

    /// The specification for the standard `IFFT` algorithm.
    public struct IFFT: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<IFFT> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<IFFT>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "IFFT" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case fft

        public static var allKeys: Set<Input> {
          return [
             .fft
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case frame

        public static var allKeys: Set<Output> {
          return [
             .frame
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case size

        public static var allKeys: Set<Parameter> {
          return [
             .size
          ]
        }

      }

    }

    /// The specification for the standard `IFFTC` algorithm.
    public struct IFFTC: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<IFFTC> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<IFFTC>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "IFFTC" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case fft

        public static var allKeys: Set<Input> {
          return [
             .fft
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case frame

        public static var allKeys: Set<Output> {
          return [
             .frame
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case size

        public static var allKeys: Set<Parameter> {
          return [
             .size
          ]
        }

      }

    }

    /// The specification for the standard `MonoMixer` algorithm.
    public struct MonoMixer: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<MonoMixer> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<MonoMixer>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "MonoMixer" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case audio
        case numberChannels

        public static var allKeys: Set<Input> {
          return [
             .audio,
             .numberChannels
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case audio

        public static var allKeys: Set<Output> {
          return [
             .audio
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case type

        public static var allKeys: Set<Parameter> {
          return [
             .type
          ]
        }

      }

    }

    /// The specification for the standard `Multiplexer` algorithm.
    public struct Multiplexer: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<Multiplexer> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<Multiplexer>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Multiplexer" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration with the sole case of `none` specifying that the algorithm has no inputs.
      public enum Input: String, KeyEnumeration {

        case none

        public static var allKeys: Set<Input> {
          return []
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case data

        public static var allKeys: Set<Output> {
          return [
             .data
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case numberRealInputs
        case numberVectorRealInputs

        public static var allKeys: Set<Parameter> {
          return [
             .numberRealInputs,
             .numberVectorRealInputs
          ]
        }

      }

    }

    /// The specification for the standard `NoiseAdder` algorithm.
    public struct NoiseAdder: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<NoiseAdder> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<NoiseAdder>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "NoiseAdder" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Input> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Output> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case fixSeed
        case level

        public static var allKeys: Set<Parameter> {
          return [
             .fixSeed,
             .level
          ]
        }

      }

    }

    /// The specification for the standard `OverlapAdd` algorithm.
    public struct OverlapAdd: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<OverlapAdd> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<OverlapAdd>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "OverlapAdd" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Input> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Output> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case frameSize
        case gain
        case hopSize

        public static var allKeys: Set<Parameter> {
          return [
             .frameSize,
             .gain,
             .hopSize
          ]
        }

      }

    }

    /// The specification for the standard `PeakDetection` algorithm.
    public struct PeakDetection: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<PeakDetection> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<PeakDetection>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "PeakDetection" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case array

        public static var allKeys: Set<Input> {
          return [
             .array
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case positions
        case amplitudes

        public static var allKeys: Set<Output> {
          return [
             .positions,
             .amplitudes
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case interpolate
        case maxPeaks
        case maxPosition
        case minPosition
        case orderBy
        case range
        case threshold

        public static var allKeys: Set<Parameter> {
          return [
             .interpolate,
             .maxPeaks,
             .maxPosition,
             .minPosition,
             .orderBy,
             .range,
             .threshold
          ]
        }

      }

    }

    /// The specification for the standard `Scale` algorithm.
    public struct Scale: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<Scale> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<Scale>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Scale" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Input> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Output> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case clipping
        case factor
        case maxAbsValue

        public static var allKeys: Set<Parameter> {
          return [
             .clipping,
             .factor,
             .maxAbsValue
          ]
        }

      }

    }

    /// The specification for the standard `Slicer` algorithm.
    public struct Slicer: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<Slicer> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<Slicer>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Slicer" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case audio

        public static var allKeys: Set<Input> {
          return [
             .audio
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case frame

        public static var allKeys: Set<Output> {
          return [
             .frame
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case endTimes
        case sampleRate
        case startTimes
        case timeUnits

        public static var allKeys: Set<Parameter> {
          return [
             .endTimes,
             .sampleRate,
             .startTimes,
             .timeUnits
          ]
        }

      }

    }

    /// The specification for the standard `Spline` algorithm.
    public struct Spline: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<Spline> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<Spline>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Spline" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case x

        public static var allKeys: Set<Input> {
          return [
             .x
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case y

        public static var allKeys: Set<Output> {
          return [
             .y
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case beta1
        case beta2
        case type
        case xPoints
        case yPoints

        public static var allKeys: Set<Parameter> {
          return [
             .beta1,
             .beta2,
             .type,
             .xPoints,
             .yPoints
          ]
        }

      }

    }

    /// The specification for the standard `StereoDemuxer` algorithm.
    public struct StereoDemuxer: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<StereoDemuxer> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<StereoDemuxer>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "StereoDemuxer" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case audio

        public static var allKeys: Set<Input> {
          return [
             .audio
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case left
        case right

        public static var allKeys: Set<Output> {
          return [
             .left,
             .right
          ]
        }

      }

      /// An enumeration with the sole case of `none` specifying that the algorithm has no parameters.
      public enum Parameter: String, KeyEnumeration {

        case none

        public static var allKeys: Set<Parameter> {
          return []
        }

      }

    }

    /// The specification for the standard `StereoMuxer` algorithm.
    public struct StereoMuxer: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<StereoMuxer> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<StereoMuxer>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "StereoMuxer" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case left
        case right

        public static var allKeys: Set<Input> {
          return [
             .left,
             .right
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case audio

        public static var allKeys: Set<Output> {
          return [
             .audio
          ]
        }

      }

      /// An enumeration with the sole case of `none` specifying that the algorithm has no parameters.
      public enum Parameter: String, KeyEnumeration {

        case none

        public static var allKeys: Set<Parameter> {
          return []
        }

      }

    }

    /// The specification for the standard `StereoTrimmer` algorithm.
    public struct StereoTrimmer: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<StereoTrimmer> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<StereoTrimmer>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "StereoTrimmer" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Input> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Output> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case checkRange
        case endTime
        case sampleRate
        case startTime

        public static var allKeys: Set<Parameter> {
          return [
             .checkRange,
             .endTime,
             .sampleRate,
             .startTime
          ]
        }

      }

    }

    /// The specification for the standard `Trimmer` algorithm.
    public struct Trimmer: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<Trimmer> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<Trimmer>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Trimmer" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Input> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Output> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case checkRange
        case endTime
        case sampleRate
        case startTime

        public static var allKeys: Set<Parameter> {
          return [
             .checkRange,
             .endTime,
             .sampleRate,
             .startTime
          ]
        }

      }

    }

    /// The specification for the standard `UnaryOperator` algorithm.
    public struct UnaryOperator: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<UnaryOperator> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<UnaryOperator>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "UnaryOperator" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case array

        public static var allKeys: Set<Input> {
          return [
             .array
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case array

        public static var allKeys: Set<Output> {
          return [
             .array
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case scale
        case shift
        case type

        public static var allKeys: Set<Parameter> {
          return [
             .scale,
             .shift,
             .type
          ]
        }

      }

    }

    /// The specification for the standard `UnaryOperatorStream` algorithm.
    public struct UnaryOperatorStream: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<UnaryOperatorStream> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<UnaryOperatorStream>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "UnaryOperatorStream" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case array

        public static var allKeys: Set<Input> {
          return [
             .array
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case array

        public static var allKeys: Set<Output> {
          return [
             .array
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case scale
        case shift
        case type

        public static var allKeys: Set<Parameter> {
          return [
             .scale,
             .shift,
             .type
          ]
        }

      }

    }

    /// The specification for the standard `WarpedAutoCorrelation` algorithm.
    public struct WarpedAutoCorrelation: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<WarpedAutoCorrelation> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<WarpedAutoCorrelation>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "WarpedAutoCorrelation" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case array

        public static var allKeys: Set<Input> {
          return [
             .array
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case warpedAutoCorrelation

        public static var allKeys: Set<Output> {
          return [
             .warpedAutoCorrelation
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case maxLag
        case sampleRate

        public static var allKeys: Set<Parameter> {
          return [
             .maxLag,
             .sampleRate
          ]
        }

      }

    }

    /// The specification for the standard `Windowing` algorithm.
    public struct Windowing: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<Windowing> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<Windowing>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Windowing" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case frame

        public static var allKeys: Set<Input> {
          return [
             .frame
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case frame

        public static var allKeys: Set<Output> {
          return [
             .frame
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case normalized
        case size
        case type
        case zeroPadding
        case zeroPhase

        public static var allKeys: Set<Parameter> {
          return [
             .normalized,
             .size,
             .type,
             .zeroPadding,
             .zeroPhase
          ]
        }

      }

    }

    /// The specification for the standard `ZeroCrossingRate` algorithm.
    public struct ZeroCrossingRate: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<ZeroCrossingRate> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<ZeroCrossingRate>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "ZeroCrossingRate" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Input> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case zeroCrossingRate

        public static var allKeys: Set<Output> {
          return [
             .zeroCrossingRate
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case threshold

        public static var allKeys: Set<Parameter> {
          return [
             .threshold
          ]
        }

      }

    }

  }

  /// An enumeration serving as both a namespace and a category for algorithm specifications.
  public enum Transformations: AlgorithmCategory {

    /// The name of the category as it appears in info structs.
    public static var name: String { return "Transformations" }

    /// The specification for the standard `PCA` algorithm.
    public struct PCA: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<PCA> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<PCA>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "PCA" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Transformations.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case poolIn

        public static var allKeys: Set<Input> {
          return [
             .poolIn
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case poolOut

        public static var allKeys: Set<Output> {
          return [
             .poolOut
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case dimensions
        case namespaceIn
        case namespaceOut

        public static var allKeys: Set<Parameter> {
          return [
             .dimensions,
             .namespaceIn,
             .namespaceOut
          ]
        }

      }

    }

  }

  /// An enumeration serving as both a namespace and a category for algorithm specifications.
  public enum Spectral: AlgorithmCategory {

    /// The name of the category as it appears in info structs.
    public static var name: String { return "Spectral" }

    /// The specification for the standard `BFCC` algorithm.
    public struct BFCC: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<BFCC> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<BFCC>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "BFCC" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Spectral.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case spectrum

        public static var allKeys: Set<Input> {
          return [
             .spectrum
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case bfcc
        case bands

        public static var allKeys: Set<Output> {
          return [
             .bfcc,
             .bands
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case dctType
        case highFrequencyBound
        case inputSize
        case liftering
        case logType
        case lowFrequencyBound
        case normalize
        case numberBands
        case numberCoefficients
        case sampleRate
        case type
        case weighting

        public static var allKeys: Set<Parameter> {
          return [
             .dctType,
             .highFrequencyBound,
             .inputSize,
             .liftering,
             .logType,
             .lowFrequencyBound,
             .normalize,
             .numberBands,
             .numberCoefficients,
             .sampleRate,
             .type,
             .weighting
          ]
        }

      }

    }

    /// The specification for the standard `BarkBands` algorithm.
    public struct BarkBands: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<BarkBands> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<BarkBands>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "BarkBands" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Spectral.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case spectrum

        public static var allKeys: Set<Input> {
          return [
             .spectrum
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case bands

        public static var allKeys: Set<Output> {
          return [
             .bands
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case numberBands
        case sampleRate

        public static var allKeys: Set<Parameter> {
          return [
             .numberBands,
             .sampleRate
          ]
        }

      }

    }

    /// The specification for the standard `ERBBands` algorithm.
    public struct ERBBands: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<ERBBands> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<ERBBands>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "ERBBands" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Spectral.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case spectrum

        public static var allKeys: Set<Input> {
          return [
             .spectrum
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case bands

        public static var allKeys: Set<Output> {
          return [
             .bands
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case highFrequencyBound
        case inputSize
        case lowFrequencyBound
        case numberBands
        case sampleRate
        case type
        case width

        public static var allKeys: Set<Parameter> {
          return [
             .highFrequencyBound,
             .inputSize,
             .lowFrequencyBound,
             .numberBands,
             .sampleRate,
             .type,
             .width
          ]
        }

      }

    }

    /// The specification for the standard `EnergyBand` algorithm.
    public struct EnergyBand: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<EnergyBand> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<EnergyBand>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "EnergyBand" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Spectral.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case spectrum

        public static var allKeys: Set<Input> {
          return [
             .spectrum
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case energyBand

        public static var allKeys: Set<Output> {
          return [
             .energyBand
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case sampleRate
        case startCutoffFrequency
        case stopCutoffFrequency

        public static var allKeys: Set<Parameter> {
          return [
             .sampleRate,
             .startCutoffFrequency,
             .stopCutoffFrequency
          ]
        }

      }

    }

    /// The specification for the standard `EnergyBandRatio` algorithm.
    public struct EnergyBandRatio: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<EnergyBandRatio> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<EnergyBandRatio>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "EnergyBandRatio" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Spectral.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case spectrum

        public static var allKeys: Set<Input> {
          return [
             .spectrum
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case energyBandRatio

        public static var allKeys: Set<Output> {
          return [
             .energyBandRatio
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case sampleRate
        case startFrequency
        case stopFrequency

        public static var allKeys: Set<Parameter> {
          return [
             .sampleRate,
             .startFrequency,
             .stopFrequency
          ]
        }

      }

    }

    /// The specification for the standard `FlatnessDB` algorithm.
    public struct FlatnessDB: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<FlatnessDB> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<FlatnessDB>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "FlatnessDB" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Spectral.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case array

        public static var allKeys: Set<Input> {
          return [
             .array
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case flatnessDB

        public static var allKeys: Set<Output> {
          return [
             .flatnessDB
          ]
        }

      }

      /// An enumeration with the sole case of `none` specifying that the algorithm has no parameters.
      public enum Parameter: String, KeyEnumeration {

        case none

        public static var allKeys: Set<Parameter> {
          return []
        }

      }

    }

    /// The specification for the standard `Flux` algorithm.
    public struct Flux: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<Flux> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<Flux>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Flux" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Spectral.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case spectrum

        public static var allKeys: Set<Input> {
          return [
             .spectrum
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case flux

        public static var allKeys: Set<Output> {
          return [
             .flux
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case halfRectify
        case norm

        public static var allKeys: Set<Parameter> {
          return [
             .halfRectify,
             .norm
          ]
        }

      }

    }

    /// The specification for the standard `FrequencyBands` algorithm.
    public struct FrequencyBands: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<FrequencyBands> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<FrequencyBands>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "FrequencyBands" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Spectral.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case spectrum

        public static var allKeys: Set<Input> {
          return [
             .spectrum
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case bands

        public static var allKeys: Set<Output> {
          return [
             .bands
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case frequencyBands
        case sampleRate

        public static var allKeys: Set<Parameter> {
          return [
             .frequencyBands,
             .sampleRate
          ]
        }

      }

    }

    /// The specification for the standard `GFCC` algorithm.
    public struct GFCC: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<GFCC> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<GFCC>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "GFCC" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Spectral.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case spectrum

        public static var allKeys: Set<Input> {
          return [
             .spectrum
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case gfcc
        case bands

        public static var allKeys: Set<Output> {
          return [
             .gfcc,
             .bands
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case dctType
        case highFrequencyBound
        case inputSize
        case logType
        case lowFrequencyBound
        case numberBands
        case numberCoefficients
        case sampleRate
        case type

        public static var allKeys: Set<Parameter> {
          return [
             .dctType,
             .highFrequencyBound,
             .inputSize,
             .logType,
             .lowFrequencyBound,
             .numberBands,
             .numberCoefficients,
             .sampleRate,
             .type
          ]
        }

      }

    }

    /// The specification for the standard `HFC` algorithm.
    public struct HFC: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<HFC> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<HFC>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "HFC" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Spectral.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case spectrum

        public static var allKeys: Set<Input> {
          return [
             .spectrum
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case hfc

        public static var allKeys: Set<Output> {
          return [
             .hfc
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case sampleRate
        case type

        public static var allKeys: Set<Parameter> {
          return [
             .sampleRate,
             .type
          ]
        }

      }

    }

    /// The specification for the standard `LPC` algorithm.
    public struct LPC: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<LPC> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<LPC>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "LPC" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Spectral.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case frame

        public static var allKeys: Set<Input> {
          return [
             .frame
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case lpc
        case reflection

        public static var allKeys: Set<Output> {
          return [
             .lpc,
             .reflection
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case order
        case sampleRate
        case type

        public static var allKeys: Set<Parameter> {
          return [
             .order,
             .sampleRate,
             .type
          ]
        }

      }

    }

    /// The specification for the standard `MFCC` algorithm.
    public struct MFCC: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<MFCC> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<MFCC>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "MFCC" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Spectral.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case spectrum

        public static var allKeys: Set<Input> {
          return [
             .spectrum
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case mfcc
        case bands

        public static var allKeys: Set<Output> {
          return [
             .mfcc,
             .bands
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case dctType
        case highFrequencyBound
        case inputSize
        case liftering
        case logType
        case lowFrequencyBound
        case normalize
        case numberBands
        case numberCoefficients
        case sampleRate
        case type
        case warpingFormula
        case weighting

        public static var allKeys: Set<Parameter> {
          return [
             .dctType,
             .highFrequencyBound,
             .inputSize,
             .liftering,
             .logType,
             .lowFrequencyBound,
             .normalize,
             .numberBands,
             .numberCoefficients,
             .sampleRate,
             .type,
             .warpingFormula,
             .weighting
          ]
        }

      }

    }

    /// The specification for the standard `MaxMagFreq` algorithm.
    public struct MaxMagFreq: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<MaxMagFreq> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<MaxMagFreq>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "MaxMagFreq" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Spectral.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case spectrum

        public static var allKeys: Set<Input> {
          return [
             .spectrum
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case maxMagFreq

        public static var allKeys: Set<Output> {
          return [
             .maxMagFreq
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case sampleRate

        public static var allKeys: Set<Parameter> {
          return [
             .sampleRate
          ]
        }

      }

    }

    /// The specification for the standard `MelBands` algorithm.
    public struct MelBands: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<MelBands> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<MelBands>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "MelBands" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Spectral.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case spectrum

        public static var allKeys: Set<Input> {
          return [
             .spectrum
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case bands

        public static var allKeys: Set<Output> {
          return [
             .bands
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case highFrequencyBound
        case inputSize
        case log
        case lowFrequencyBound
        case normalize
        case numberBands
        case sampleRate
        case type
        case warpingFormula
        case weighting

        public static var allKeys: Set<Parameter> {
          return [
             .highFrequencyBound,
             .inputSize,
             .log,
             .lowFrequencyBound,
             .normalize,
             .numberBands,
             .sampleRate,
             .type,
             .warpingFormula,
             .weighting
          ]
        }

      }

    }

    /// The specification for the standard `Panning` algorithm.
    public struct Panning: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<Panning> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<Panning>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Panning" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Spectral.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case spectrumLeft
        case spectrumRight

        public static var allKeys: Set<Input> {
          return [
             .spectrumLeft,
             .spectrumRight
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case panningCoeffs

        public static var allKeys: Set<Output> {
          return [
             .panningCoeffs
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case averageFrames
        case numBands
        case numCoeffs
        case panningBins
        case sampleRate
        case warpedPanorama

        public static var allKeys: Set<Parameter> {
          return [
             .averageFrames,
             .numBands,
             .numCoeffs,
             .panningBins,
             .sampleRate,
             .warpedPanorama
          ]
        }

      }

    }

    /// The specification for the standard `PowerSpectrum` algorithm.
    public struct PowerSpectrum: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<PowerSpectrum> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<PowerSpectrum>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "PowerSpectrum" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Spectral.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Input> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case powerSpectrum

        public static var allKeys: Set<Output> {
          return [
             .powerSpectrum
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case size

        public static var allKeys: Set<Parameter> {
          return [
             .size
          ]
        }

      }

    }

    /// The specification for the standard `RollOff` algorithm.
    public struct RollOff: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<RollOff> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<RollOff>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "RollOff" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Spectral.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case spectrum

        public static var allKeys: Set<Input> {
          return [
             .spectrum
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case rollOff

        public static var allKeys: Set<Output> {
          return [
             .rollOff
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case cutoff
        case sampleRate

        public static var allKeys: Set<Parameter> {
          return [
             .cutoff,
             .sampleRate
          ]
        }

      }

    }

    /// The specification for the standard `SpectralCentroidTime` algorithm.
    public struct SpectralCentroidTime: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<SpectralCentroidTime> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<SpectralCentroidTime>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "SpectralCentroidTime" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Spectral.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case array

        public static var allKeys: Set<Input> {
          return [
             .array
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case centroid

        public static var allKeys: Set<Output> {
          return [
             .centroid
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case sampleRate

        public static var allKeys: Set<Parameter> {
          return [
             .sampleRate
          ]
        }

      }

    }

    /// The specification for the standard `SpectralComplexity` algorithm.
    public struct SpectralComplexity: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<SpectralComplexity> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<SpectralComplexity>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "SpectralComplexity" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Spectral.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case spectrum

        public static var allKeys: Set<Input> {
          return [
             .spectrum
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case spectralComplexity

        public static var allKeys: Set<Output> {
          return [
             .spectralComplexity
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case magnitudeThreshold
        case sampleRate

        public static var allKeys: Set<Parameter> {
          return [
             .magnitudeThreshold,
             .sampleRate
          ]
        }

      }

    }

    /// The specification for the standard `SpectralContrast` algorithm.
    public struct SpectralContrast: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<SpectralContrast> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<SpectralContrast>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "SpectralContrast" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Spectral.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case spectrum

        public static var allKeys: Set<Input> {
          return [
             .spectrum
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case spectralValley
        case spectralContrast

        public static var allKeys: Set<Output> {
          return [
             .spectralValley,
             .spectralContrast
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case frameSize
        case highFrequencyBound
        case lowFrequencyBound
        case neighbourRatio
        case numberBands
        case sampleRate
        case staticDistribution

        public static var allKeys: Set<Parameter> {
          return [
             .frameSize,
             .highFrequencyBound,
             .lowFrequencyBound,
             .neighbourRatio,
             .numberBands,
             .sampleRate,
             .staticDistribution
          ]
        }

      }

    }

    /// The specification for the standard `SpectralPeaks` algorithm.
    public struct SpectralPeaks: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<SpectralPeaks> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<SpectralPeaks>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "SpectralPeaks" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Spectral.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case spectrum

        public static var allKeys: Set<Input> {
          return [
             .spectrum
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case frequencies
        case magnitudes

        public static var allKeys: Set<Output> {
          return [
             .frequencies,
             .magnitudes
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case magnitudeThreshold
        case maxFrequency
        case maxPeaks
        case minFrequency
        case orderBy
        case sampleRate

        public static var allKeys: Set<Parameter> {
          return [
             .magnitudeThreshold,
             .maxFrequency,
             .maxPeaks,
             .minFrequency,
             .orderBy,
             .sampleRate
          ]
        }

      }

    }

    /// The specification for the standard `SpectralWhitening` algorithm.
    public struct SpectralWhitening: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<SpectralWhitening> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<SpectralWhitening>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "SpectralWhitening" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Spectral.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case frequencies
        case spectrum
        case magnitudes

        public static var allKeys: Set<Input> {
          return [
             .frequencies,
             .spectrum,
             .magnitudes
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case magnitudes

        public static var allKeys: Set<Output> {
          return [
             .magnitudes
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case maxFrequency
        case sampleRate

        public static var allKeys: Set<Parameter> {
          return [
             .maxFrequency,
             .sampleRate
          ]
        }

      }

    }

    /// The specification for the standard `Spectrum` algorithm.
    public struct Spectrum: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<Spectrum> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<Spectrum>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Spectrum" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Spectral.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case frame

        public static var allKeys: Set<Input> {
          return [
             .frame
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case spectrum

        public static var allKeys: Set<Output> {
          return [
             .spectrum
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case size

        public static var allKeys: Set<Parameter> {
          return [
             .size
          ]
        }

      }

    }

    /// The specification for the standard `SpectrumToCent` algorithm.
    public struct SpectrumToCent: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<SpectrumToCent> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<SpectrumToCent>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "SpectrumToCent" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Spectral.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case spectrum

        public static var allKeys: Set<Input> {
          return [
             .spectrum
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case frequencies
        case bands

        public static var allKeys: Set<Output> {
          return [
             .frequencies,
             .bands
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case bands
        case centBinResolution
        case inputSize
        case log
        case minimumFrequency
        case normalize
        case sampleRate
        case type

        public static var allKeys: Set<Parameter> {
          return [
             .bands,
             .centBinResolution,
             .inputSize,
             .log,
             .minimumFrequency,
             .normalize,
             .sampleRate,
             .type
          ]
        }

      }

    }

    /// The specification for the standard `StrongPeak` algorithm.
    public struct StrongPeak: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<StrongPeak> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<StrongPeak>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "StrongPeak" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Spectral.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case spectrum

        public static var allKeys: Set<Input> {
          return [
             .spectrum
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case strongPeak

        public static var allKeys: Set<Output> {
          return [
             .strongPeak
          ]
        }

      }

      /// An enumeration with the sole case of `none` specifying that the algorithm has no parameters.
      public enum Parameter: String, KeyEnumeration {

        case none

        public static var allKeys: Set<Parameter> {
          return []
        }

      }

    }

    /// The specification for the standard `TriangularBands` algorithm.
    public struct TriangularBands: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<TriangularBands> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<TriangularBands>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "TriangularBands" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Spectral.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case spectrum

        public static var allKeys: Set<Input> {
          return [
             .spectrum
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case bands

        public static var allKeys: Set<Output> {
          return [
             .bands
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case frequencyBands
        case inputSize
        case log
        case normalize
        case sampleRate
        case type
        case weighting

        public static var allKeys: Set<Parameter> {
          return [
             .frequencyBands,
             .inputSize,
             .log,
             .normalize,
             .sampleRate,
             .type,
             .weighting
          ]
        }

      }

    }

    /// The specification for the standard `TriangularBarkBands` algorithm.
    public struct TriangularBarkBands: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<TriangularBarkBands> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<TriangularBarkBands>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "TriangularBarkBands" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Spectral.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case spectrum

        public static var allKeys: Set<Input> {
          return [
             .spectrum
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case bands

        public static var allKeys: Set<Output> {
          return [
             .bands
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case highFrequencyBound
        case inputSize
        case log
        case lowFrequencyBound
        case normalize
        case numberBands
        case sampleRate
        case type
        case weighting

        public static var allKeys: Set<Parameter> {
          return [
             .highFrequencyBound,
             .inputSize,
             .log,
             .lowFrequencyBound,
             .normalize,
             .numberBands,
             .sampleRate,
             .type,
             .weighting
          ]
        }

      }

    }

  }

  /// An enumeration serving as both a namespace and a category for algorithm specifications.
  public enum Extractors: AlgorithmCategory {

    /// The name of the category as it appears in info structs.
    public static var name: String { return "Extractors" }

    /// The specification for the standard `Extractor` algorithm.
    public struct Extractor: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<Extractor> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<Extractor>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Extractor" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Extractors.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case audio

        public static var allKeys: Set<Input> {
          return [
             .audio
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case pool

        public static var allKeys: Set<Output> {
          return [
             .pool
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case dynamics
        case dynamicsFrameSize
        case dynamicsHopSize
        case highLevel
        case lowLevel
        case lowLevelFrameSize
        case lowLevelHopSize
        case midLevel
        case namespace
        case relativeIoi
        case rhythm
        case sampleRate
        case tonalFrameSize
        case tonalHopSize
        case tuning

        public static var allKeys: Set<Parameter> {
          return [
             .dynamics,
             .dynamicsFrameSize,
             .dynamicsHopSize,
             .highLevel,
             .lowLevel,
             .lowLevelFrameSize,
             .lowLevelHopSize,
             .midLevel,
             .namespace,
             .relativeIoi,
             .rhythm,
             .sampleRate,
             .tonalFrameSize,
             .tonalHopSize,
             .tuning
          ]
        }

      }

    }

    /// The specification for the standard `LowLevelSpectralEqloudExtractor` algorithm.
    public struct LowLevelSpectralEqloudExtractor: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<LowLevelSpectralEqloudExtractor> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<LowLevelSpectralEqloudExtractor>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "LowLevelSpectralEqloudExtractor" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Extractors.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Input> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case scvalleys
        case spectral_kurtosis
        case spectral_skewness
        case sccoeffs
        case spectral_spread
        case dissonance
        case spectral_centroid

        public static var allKeys: Set<Output> {
          return [
             .scvalleys,
             .spectral_kurtosis,
             .spectral_skewness,
             .sccoeffs,
             .spectral_spread,
             .dissonance,
             .spectral_centroid
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case frameSize
        case hopSize
        case sampleRate

        public static var allKeys: Set<Parameter> {
          return [
             .frameSize,
             .hopSize,
             .sampleRate
          ]
        }

      }

    }

    /// The specification for the standard `LowLevelSpectralExtractor` algorithm.
    public struct LowLevelSpectralExtractor: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<LowLevelSpectralExtractor> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<LowLevelSpectralExtractor>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "LowLevelSpectralExtractor" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Extractors.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Input> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case spectral_energyband_high
        case spectral_energyband_middle_low
        case spectral_complexity
        case hfc
        case spectral_rms
        case zerocrossingrate
        case oddtoevenharmonicenergyratio
        case barkbands
        case tristimulus
        case spectral_rolloff
        case spectral_flatness_db
        case barkbands_kurtosis
        case spectral_crest
        case barkbands_skewness
        case spectral_energyband_low
        case inharmonicity
        case spectral_flux
        case barkbands_spread
        case spectral_decrease
        case pitch_salience
        case mfcc
        case spectral_energyband_middle_high
        case spectral_strongpeak
        case pitch
        case silence_rate_60dB
        case spectral_energy
        case silence_rate_20dB
        case silence_rate_30dB
        case pitch_instantaneous_confidence

        public static var allKeys: Set<Output> {
          return [
             .spectral_energyband_high,
             .spectral_energyband_middle_low,
             .spectral_complexity,
             .hfc,
             .spectral_rms,
             .zerocrossingrate,
             .oddtoevenharmonicenergyratio,
             .barkbands,
             .tristimulus,
             .spectral_rolloff,
             .spectral_flatness_db,
             .barkbands_kurtosis,
             .spectral_crest,
             .barkbands_skewness,
             .spectral_energyband_low,
             .inharmonicity,
             .spectral_flux,
             .barkbands_spread,
             .spectral_decrease,
             .pitch_salience,
             .mfcc,
             .spectral_energyband_middle_high,
             .spectral_strongpeak,
             .pitch,
             .silence_rate_60dB,
             .spectral_energy,
             .silence_rate_20dB,
             .silence_rate_30dB,
             .pitch_instantaneous_confidence
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case frameSize
        case hopSize
        case sampleRate

        public static var allKeys: Set<Parameter> {
          return [
             .frameSize,
             .hopSize,
             .sampleRate
          ]
        }

      }

    }

  }

  /// An enumeration serving as both a namespace and a category for algorithm specifications.
  public enum Envelope_SFX: AlgorithmCategory {

    /// The name of the category as it appears in info structs.
    public static var name: String { return "Envelope/SFX" }

    /// The specification for the standard `AfterMaxToBeforeMaxEnergyRatio` algorithm.
    public struct AfterMaxToBeforeMaxEnergyRatio: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<AfterMaxToBeforeMaxEnergyRatio> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<AfterMaxToBeforeMaxEnergyRatio>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "AfterMaxToBeforeMaxEnergyRatio" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Envelope_SFX.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case pitch

        public static var allKeys: Set<Input> {
          return [
             .pitch
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case afterMaxToBeforeMaxEnergyRatio

        public static var allKeys: Set<Output> {
          return [
             .afterMaxToBeforeMaxEnergyRatio
          ]
        }

      }

      /// An enumeration with the sole case of `none` specifying that the algorithm has no parameters.
      public enum Parameter: String, KeyEnumeration {

        case none

        public static var allKeys: Set<Parameter> {
          return []
        }

      }

    }

    /// The specification for the standard `DerivativeSFX` algorithm.
    public struct DerivativeSFX: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<DerivativeSFX> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<DerivativeSFX>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "DerivativeSFX" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Envelope_SFX.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case envelope

        public static var allKeys: Set<Input> {
          return [
             .envelope
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case derAvAfterMax
        case maxDerBeforeMax

        public static var allKeys: Set<Output> {
          return [
             .derAvAfterMax,
             .maxDerBeforeMax
          ]
        }

      }

      /// An enumeration with the sole case of `none` specifying that the algorithm has no parameters.
      public enum Parameter: String, KeyEnumeration {

        case none

        public static var allKeys: Set<Parameter> {
          return []
        }

      }

    }

    /// The specification for the standard `Envelope` algorithm.
    public struct Envelope: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<Envelope> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<Envelope>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Envelope" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Envelope_SFX.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Input> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Output> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case applyRectification
        case attackTime
        case releaseTime
        case sampleRate

        public static var allKeys: Set<Parameter> {
          return [
             .applyRectification,
             .attackTime,
             .releaseTime,
             .sampleRate
          ]
        }

      }

    }

    /// The specification for the standard `FlatnessSFX` algorithm.
    public struct FlatnessSFX: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<FlatnessSFX> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<FlatnessSFX>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "FlatnessSFX" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Envelope_SFX.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case envelope

        public static var allKeys: Set<Input> {
          return [
             .envelope
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case flatness

        public static var allKeys: Set<Output> {
          return [
             .flatness
          ]
        }

      }

      /// An enumeration with the sole case of `none` specifying that the algorithm has no parameters.
      public enum Parameter: String, KeyEnumeration {

        case none

        public static var allKeys: Set<Parameter> {
          return []
        }

      }

    }

    /// The specification for the standard `LogAttackTime` algorithm.
    public struct LogAttackTime: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<LogAttackTime> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<LogAttackTime>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "LogAttackTime" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Envelope_SFX.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Input> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case logAttackTime
        case attackStop
        case attackStart

        public static var allKeys: Set<Output> {
          return [
             .logAttackTime,
             .attackStop,
             .attackStart
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case sampleRate
        case startAttackThreshold
        case stopAttackThreshold

        public static var allKeys: Set<Parameter> {
          return [
             .sampleRate,
             .startAttackThreshold,
             .stopAttackThreshold
          ]
        }

      }

    }

    /// The specification for the standard `MaxToTotal` algorithm.
    public struct MaxToTotal: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<MaxToTotal> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<MaxToTotal>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "MaxToTotal" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Envelope_SFX.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case envelope

        public static var allKeys: Set<Input> {
          return [
             .envelope
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case maxToTotal

        public static var allKeys: Set<Output> {
          return [
             .maxToTotal
          ]
        }

      }

      /// An enumeration with the sole case of `none` specifying that the algorithm has no parameters.
      public enum Parameter: String, KeyEnumeration {

        case none

        public static var allKeys: Set<Parameter> {
          return []
        }

      }

    }

    /// The specification for the standard `MinToTotal` algorithm.
    public struct MinToTotal: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<MinToTotal> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<MinToTotal>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "MinToTotal" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Envelope_SFX.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case envelope

        public static var allKeys: Set<Input> {
          return [
             .envelope
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case minToTotal

        public static var allKeys: Set<Output> {
          return [
             .minToTotal
          ]
        }

      }

      /// An enumeration with the sole case of `none` specifying that the algorithm has no parameters.
      public enum Parameter: String, KeyEnumeration {

        case none

        public static var allKeys: Set<Parameter> {
          return []
        }

      }

    }

    /// The specification for the standard `StrongDecay` algorithm.
    public struct StrongDecay: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<StrongDecay> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<StrongDecay>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "StrongDecay" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Envelope_SFX.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Input> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case strongDecay

        public static var allKeys: Set<Output> {
          return [
             .strongDecay
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case sampleRate

        public static var allKeys: Set<Parameter> {
          return [
             .sampleRate
          ]
        }

      }

    }

    /// The specification for the standard `TCToTotal` algorithm.
    public struct TCToTotal: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<TCToTotal> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<TCToTotal>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "TCToTotal" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Envelope_SFX.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case envelope

        public static var allKeys: Set<Input> {
          return [
             .envelope
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case TCToTotal

        public static var allKeys: Set<Output> {
          return [
             .TCToTotal
          ]
        }

      }

      /// An enumeration with the sole case of `none` specifying that the algorithm has no parameters.
      public enum Parameter: String, KeyEnumeration {

        case none

        public static var allKeys: Set<Parameter> {
          return []
        }

      }

    }

  }

  /// An enumeration serving as both a namespace and a category for algorithm specifications.
  public enum Math: AlgorithmCategory {

    /// The name of the category as it appears in info structs.
    public static var name: String { return "Math" }

    /// The specification for the standard `CartesianToPolar` algorithm.
    public struct CartesianToPolar: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<CartesianToPolar> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<CartesianToPolar>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "CartesianToPolar" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Math.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case complex

        public static var allKeys: Set<Input> {
          return [
             .complex
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case phase
        case magnitude

        public static var allKeys: Set<Output> {
          return [
             .phase,
             .magnitude
          ]
        }

      }

      /// An enumeration with the sole case of `none` specifying that the algorithm has no parameters.
      public enum Parameter: String, KeyEnumeration {

        case none

        public static var allKeys: Set<Parameter> {
          return []
        }

      }

    }

    /// The specification for the standard `Magnitude` algorithm.
    public struct Magnitude: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<Magnitude> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<Magnitude>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Magnitude" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Math.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case complex

        public static var allKeys: Set<Input> {
          return [
             .complex
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case magnitude

        public static var allKeys: Set<Output> {
          return [
             .magnitude
          ]
        }

      }

      /// An enumeration with the sole case of `none` specifying that the algorithm has no parameters.
      public enum Parameter: String, KeyEnumeration {

        case none

        public static var allKeys: Set<Parameter> {
          return []
        }

      }

    }

    /// The specification for the standard `PolarToCartesian` algorithm.
    public struct PolarToCartesian: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<PolarToCartesian> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<PolarToCartesian>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "PolarToCartesian" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Math.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case phase
        case magnitude

        public static var allKeys: Set<Input> {
          return [
             .phase,
             .magnitude
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case complex

        public static var allKeys: Set<Output> {
          return [
             .complex
          ]
        }

      }

      /// An enumeration with the sole case of `none` specifying that the algorithm has no parameters.
      public enum Parameter: String, KeyEnumeration {

        case none

        public static var allKeys: Set<Parameter> {
          return []
        }

      }

    }

  }

  /// An enumeration serving as both a namespace and a category for algorithm specifications.
  public enum Statistics: AlgorithmCategory {

    /// The name of the category as it appears in info structs.
    public static var name: String { return "Statistics" }

    /// The specification for the standard `CentralMoments` algorithm.
    public struct CentralMoments: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<CentralMoments> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<CentralMoments>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "CentralMoments" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Statistics.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case array

        public static var allKeys: Set<Input> {
          return [
             .array
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case centralMoments

        public static var allKeys: Set<Output> {
          return [
             .centralMoments
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case mode
        case range

        public static var allKeys: Set<Parameter> {
          return [
             .mode,
             .range
          ]
        }

      }

    }

    /// The specification for the standard `Centroid` algorithm.
    public struct Centroid: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<Centroid> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<Centroid>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Centroid" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Statistics.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case array

        public static var allKeys: Set<Input> {
          return [
             .array
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case centroid

        public static var allKeys: Set<Output> {
          return [
             .centroid
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case range

        public static var allKeys: Set<Parameter> {
          return [
             .range
          ]
        }

      }

    }

    /// The specification for the standard `Crest` algorithm.
    public struct Crest: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<Crest> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<Crest>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Crest" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Statistics.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case array

        public static var allKeys: Set<Input> {
          return [
             .array
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case crest

        public static var allKeys: Set<Output> {
          return [
             .crest
          ]
        }

      }

      /// An enumeration with the sole case of `none` specifying that the algorithm has no parameters.
      public enum Parameter: String, KeyEnumeration {

        case none

        public static var allKeys: Set<Parameter> {
          return []
        }

      }

    }

    /// The specification for the standard `Decrease` algorithm.
    public struct Decrease: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<Decrease> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<Decrease>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Decrease" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Statistics.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case array

        public static var allKeys: Set<Input> {
          return [
             .array
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case decrease

        public static var allKeys: Set<Output> {
          return [
             .decrease
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case range

        public static var allKeys: Set<Parameter> {
          return [
             .range
          ]
        }

      }

    }

    /// The specification for the standard `DistributionShape` algorithm.
    public struct DistributionShape: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<DistributionShape> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<DistributionShape>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "DistributionShape" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Statistics.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case centralMoments

        public static var allKeys: Set<Input> {
          return [
             .centralMoments
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case kurtosis
        case spread
        case skewness

        public static var allKeys: Set<Output> {
          return [
             .kurtosis,
             .spread,
             .skewness
          ]
        }

      }

      /// An enumeration with the sole case of `none` specifying that the algorithm has no parameters.
      public enum Parameter: String, KeyEnumeration {

        case none

        public static var allKeys: Set<Parameter> {
          return []
        }

      }

    }

    /// The specification for the standard `Energy` algorithm.
    public struct Energy: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<Energy> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<Energy>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Energy" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Statistics.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case array

        public static var allKeys: Set<Input> {
          return [
             .array
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case energy

        public static var allKeys: Set<Output> {
          return [
             .energy
          ]
        }

      }

      /// An enumeration with the sole case of `none` specifying that the algorithm has no parameters.
      public enum Parameter: String, KeyEnumeration {

        case none

        public static var allKeys: Set<Parameter> {
          return []
        }

      }

    }

    /// The specification for the standard `Entropy` algorithm.
    public struct Entropy: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<Entropy> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<Entropy>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Entropy" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Statistics.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case array

        public static var allKeys: Set<Input> {
          return [
             .array
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case entropy

        public static var allKeys: Set<Output> {
          return [
             .entropy
          ]
        }

      }

      /// An enumeration with the sole case of `none` specifying that the algorithm has no parameters.
      public enum Parameter: String, KeyEnumeration {

        case none

        public static var allKeys: Set<Parameter> {
          return []
        }

      }

    }

    /// The specification for the standard `Flatness` algorithm.
    public struct Flatness: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<Flatness> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<Flatness>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Flatness" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Statistics.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case array

        public static var allKeys: Set<Input> {
          return [
             .array
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case flatness

        public static var allKeys: Set<Output> {
          return [
             .flatness
          ]
        }

      }

      /// An enumeration with the sole case of `none` specifying that the algorithm has no parameters.
      public enum Parameter: String, KeyEnumeration {

        case none

        public static var allKeys: Set<Parameter> {
          return []
        }

      }

    }

    /// The specification for the standard `GeometricMean` algorithm.
    public struct GeometricMean: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<GeometricMean> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<GeometricMean>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "GeometricMean" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Statistics.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case array

        public static var allKeys: Set<Input> {
          return [
             .array
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case geometricMean

        public static var allKeys: Set<Output> {
          return [
             .geometricMean
          ]
        }

      }

      /// An enumeration with the sole case of `none` specifying that the algorithm has no parameters.
      public enum Parameter: String, KeyEnumeration {

        case none

        public static var allKeys: Set<Parameter> {
          return []
        }

      }

    }

    /// The specification for the standard `InstantPower` algorithm.
    public struct InstantPower: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<InstantPower> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<InstantPower>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "InstantPower" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Statistics.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case array

        public static var allKeys: Set<Input> {
          return [
             .array
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case power

        public static var allKeys: Set<Output> {
          return [
             .power
          ]
        }

      }

      /// An enumeration with the sole case of `none` specifying that the algorithm has no parameters.
      public enum Parameter: String, KeyEnumeration {

        case none

        public static var allKeys: Set<Parameter> {
          return []
        }

      }

    }

    /// The specification for the standard `Mean` algorithm.
    public struct Mean: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<Mean> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<Mean>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Mean" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Statistics.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case array

        public static var allKeys: Set<Input> {
          return [
             .array
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case mean

        public static var allKeys: Set<Output> {
          return [
             .mean
          ]
        }

      }

      /// An enumeration with the sole case of `none` specifying that the algorithm has no parameters.
      public enum Parameter: String, KeyEnumeration {

        case none

        public static var allKeys: Set<Parameter> {
          return []
        }

      }

    }

    /// The specification for the standard `Median` algorithm.
    public struct Median: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<Median> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<Median>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Median" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Statistics.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case array

        public static var allKeys: Set<Input> {
          return [
             .array
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case median

        public static var allKeys: Set<Output> {
          return [
             .median
          ]
        }

      }

      /// An enumeration with the sole case of `none` specifying that the algorithm has no parameters.
      public enum Parameter: String, KeyEnumeration {

        case none

        public static var allKeys: Set<Parameter> {
          return []
        }

      }

    }

    /// The specification for the standard `PoolAggregator` algorithm.
    public struct PoolAggregator: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<PoolAggregator> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<PoolAggregator>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "PoolAggregator" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Statistics.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case input

        public static var allKeys: Set<Input> {
          return [
             .input
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case output

        public static var allKeys: Set<Output> {
          return [
             .output
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case defaultStats
        case exceptions

        public static var allKeys: Set<Parameter> {
          return [
             .defaultStats,
             .exceptions
          ]
        }

      }

    }

    /// The specification for the standard `PowerMean` algorithm.
    public struct PowerMean: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<PowerMean> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<PowerMean>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "PowerMean" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Statistics.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case array

        public static var allKeys: Set<Input> {
          return [
             .array
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case powerMean

        public static var allKeys: Set<Output> {
          return [
             .powerMean
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case power

        public static var allKeys: Set<Parameter> {
          return [
             .power
          ]
        }

      }

    }

    /// The specification for the standard `RMS` algorithm.
    public struct RMS: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<RMS> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<RMS>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "RMS" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Statistics.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case array

        public static var allKeys: Set<Input> {
          return [
             .array
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case rms

        public static var allKeys: Set<Output> {
          return [
             .rms
          ]
        }

      }

      /// An enumeration with the sole case of `none` specifying that the algorithm has no parameters.
      public enum Parameter: String, KeyEnumeration {

        case none

        public static var allKeys: Set<Parameter> {
          return []
        }

      }

    }

    /// The specification for the standard `RawMoments` algorithm.
    public struct RawMoments: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<RawMoments> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<RawMoments>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "RawMoments" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Statistics.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case array

        public static var allKeys: Set<Input> {
          return [
             .array
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case rawMoments

        public static var allKeys: Set<Output> {
          return [
             .rawMoments
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case range

        public static var allKeys: Set<Parameter> {
          return [
             .range
          ]
        }

      }

    }

    /// The specification for the standard `SingleGaussian` algorithm.
    public struct SingleGaussian: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<SingleGaussian> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<SingleGaussian>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "SingleGaussian" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Statistics.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case matrix

        public static var allKeys: Set<Input> {
          return [
             .matrix
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case mean
        case covariance
        case inverseCovariance

        public static var allKeys: Set<Output> {
          return [
             .mean,
             .covariance,
             .inverseCovariance
          ]
        }

      }

      /// An enumeration with the sole case of `none` specifying that the algorithm has no parameters.
      public enum Parameter: String, KeyEnumeration {

        case none

        public static var allKeys: Set<Parameter> {
          return []
        }

      }

    }

    /// The specification for the standard `Variance` algorithm.
    public struct Variance: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<Variance> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<Variance>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Variance" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Statistics.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case array

        public static var allKeys: Set<Input> {
          return [
             .array
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case variance

        public static var allKeys: Set<Output> {
          return [
             .variance
          ]
        }

      }

      /// An enumeration with the sole case of `none` specifying that the algorithm has no parameters.
      public enum Parameter: String, KeyEnumeration {

        case none

        public static var allKeys: Set<Parameter> {
          return []
        }

      }

    }

  }

  /// An enumeration serving as both a namespace and a category for algorithm specifications.
  public enum Tonal: AlgorithmCategory {

    /// The name of the category as it appears in info structs.
    public static var name: String { return "Tonal" }

    /// The specification for the standard `ChordsDescriptors` algorithm.
    public struct ChordsDescriptors: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<ChordsDescriptors> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<ChordsDescriptors>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "ChordsDescriptors" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Tonal.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case key
        case chords
        case scale

        public static var allKeys: Set<Input> {
          return [
             .key,
             .chords,
             .scale
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case chordsChangesRate
        case chordsKey
        case chordsScale
        case chordsHistogram
        case chordsNumberRate

        public static var allKeys: Set<Output> {
          return [
             .chordsChangesRate,
             .chordsKey,
             .chordsScale,
             .chordsHistogram,
             .chordsNumberRate
          ]
        }

      }

      /// An enumeration with the sole case of `none` specifying that the algorithm has no parameters.
      public enum Parameter: String, KeyEnumeration {

        case none

        public static var allKeys: Set<Parameter> {
          return []
        }

      }

    }

    /// The specification for the standard `ChordsDetection` algorithm.
    public struct ChordsDetection: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<ChordsDetection> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<ChordsDetection>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "ChordsDetection" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Tonal.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case pcp

        public static var allKeys: Set<Input> {
          return [
             .pcp
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case strength
        case chords

        public static var allKeys: Set<Output> {
          return [
             .strength,
             .chords
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case hopSize
        case sampleRate
        case windowSize

        public static var allKeys: Set<Parameter> {
          return [
             .hopSize,
             .sampleRate,
             .windowSize
          ]
        }

      }

    }

    /// The specification for the standard `ChordsDetectionBeats` algorithm.
    public struct ChordsDetectionBeats: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<ChordsDetectionBeats> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<ChordsDetectionBeats>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "ChordsDetectionBeats" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Tonal.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case pcp
        case ticks

        public static var allKeys: Set<Input> {
          return [
             .pcp,
             .ticks
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case strength
        case chords

        public static var allKeys: Set<Output> {
          return [
             .strength,
             .chords
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case hopSize
        case sampleRate

        public static var allKeys: Set<Parameter> {
          return [
             .hopSize,
             .sampleRate
          ]
        }

      }

    }

    /// The specification for the standard `Dissonance` algorithm.
    public struct Dissonance: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<Dissonance> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<Dissonance>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Dissonance" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Tonal.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case frequencies
        case magnitudes

        public static var allKeys: Set<Input> {
          return [
             .frequencies,
             .magnitudes
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case dissonance

        public static var allKeys: Set<Output> {
          return [
             .dissonance
          ]
        }

      }

      /// An enumeration with the sole case of `none` specifying that the algorithm has no parameters.
      public enum Parameter: String, KeyEnumeration {

        case none

        public static var allKeys: Set<Parameter> {
          return []
        }

      }

    }

    /// The specification for the standard `HPCP` algorithm.
    public struct HPCP: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<HPCP> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<HPCP>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "HPCP" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Tonal.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case frequencies
        case magnitudes

        public static var allKeys: Set<Input> {
          return [
             .frequencies,
             .magnitudes
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case hpcp

        public static var allKeys: Set<Output> {
          return [
             .hpcp
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case bandPreset
        case bandSplitFrequency
        case harmonics
        case maxFrequency
        case maxShifted
        case minFrequency
        case nonLinear
        case normalized
        case referenceFrequency
        case sampleRate
        case size
        case weightType
        case windowSize

        public static var allKeys: Set<Parameter> {
          return [
             .bandPreset,
             .bandSplitFrequency,
             .harmonics,
             .maxFrequency,
             .maxShifted,
             .minFrequency,
             .nonLinear,
             .normalized,
             .referenceFrequency,
             .sampleRate,
             .size,
             .weightType,
             .windowSize
          ]
        }

      }

    }

    /// The specification for the standard `HarmonicPeaks` algorithm.
    public struct HarmonicPeaks: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<HarmonicPeaks> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<HarmonicPeaks>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "HarmonicPeaks" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Tonal.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case frequencies
        case pitch
        case magnitudes

        public static var allKeys: Set<Input> {
          return [
             .frequencies,
             .pitch,
             .magnitudes
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case harmonicFrequencies
        case harmonicMagnitudes

        public static var allKeys: Set<Output> {
          return [
             .harmonicFrequencies,
             .harmonicMagnitudes
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case maxHarmonics
        case tolerance

        public static var allKeys: Set<Parameter> {
          return [
             .maxHarmonics,
             .tolerance
          ]
        }

      }

    }

    /// The specification for the standard `HighResolutionFeatures` algorithm.
    public struct HighResolutionFeatures: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<HighResolutionFeatures> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<HighResolutionFeatures>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "HighResolutionFeatures" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Tonal.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case hpcp

        public static var allKeys: Set<Input> {
          return [
             .hpcp
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case equalTemperedDeviation
        case nonTemperedEnergyRatio
        case nonTemperedPeaksEnergyRatio

        public static var allKeys: Set<Output> {
          return [
             .equalTemperedDeviation,
             .nonTemperedEnergyRatio,
             .nonTemperedPeaksEnergyRatio
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case maxPeaks

        public static var allKeys: Set<Parameter> {
          return [
             .maxPeaks
          ]
        }

      }

    }

    /// The specification for the standard `Inharmonicity` algorithm.
    public struct Inharmonicity: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<Inharmonicity> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<Inharmonicity>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Inharmonicity" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Tonal.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case frequencies
        case magnitudes

        public static var allKeys: Set<Input> {
          return [
             .frequencies,
             .magnitudes
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case inharmonicity

        public static var allKeys: Set<Output> {
          return [
             .inharmonicity
          ]
        }

      }

      /// An enumeration with the sole case of `none` specifying that the algorithm has no parameters.
      public enum Parameter: String, KeyEnumeration {

        case none

        public static var allKeys: Set<Parameter> {
          return []
        }

      }

    }

    /// The specification for the standard `Key` algorithm.
    public struct Key: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<Key> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<Key>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Key" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Tonal.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case pcp

        public static var allKeys: Set<Input> {
          return [
             .pcp
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case firstToSecondRelativeStrength
        case strength
        case key
        case scale

        public static var allKeys: Set<Output> {
          return [
             .firstToSecondRelativeStrength,
             .strength,
             .key,
             .scale
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case numHarmonics
        case pcpSize
        case profileType
        case slope
        case usePolyphony
        case useThreeChords

        public static var allKeys: Set<Parameter> {
          return [
             .numHarmonics,
             .pcpSize,
             .profileType,
             .slope,
             .usePolyphony,
             .useThreeChords
          ]
        }

      }

    }

    /// The specification for the standard `KeyExtractor` algorithm.
    public struct KeyExtractor: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<KeyExtractor> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<KeyExtractor>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "KeyExtractor" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Tonal.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case audio

        public static var allKeys: Set<Input> {
          return [
             .audio
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case strength
        case key
        case scale

        public static var allKeys: Set<Output> {
          return [
             .strength,
             .key,
             .scale
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case frameSize
        case hopSize
        case tuningFrequency

        public static var allKeys: Set<Parameter> {
          return [
             .frameSize,
             .hopSize,
             .tuningFrequency
          ]
        }

      }

    }

    /// The specification for the standard `OddToEvenHarmonicEnergyRatio` algorithm.
    public struct OddToEvenHarmonicEnergyRatio: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<OddToEvenHarmonicEnergyRatio> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<OddToEvenHarmonicEnergyRatio>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "OddToEvenHarmonicEnergyRatio" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Tonal.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case frequencies
        case magnitudes

        public static var allKeys: Set<Input> {
          return [
             .frequencies,
             .magnitudes
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case oddToEvenHarmonicEnergyRatio

        public static var allKeys: Set<Output> {
          return [
             .oddToEvenHarmonicEnergyRatio
          ]
        }

      }

      /// An enumeration with the sole case of `none` specifying that the algorithm has no parameters.
      public enum Parameter: String, KeyEnumeration {

        case none

        public static var allKeys: Set<Parameter> {
          return []
        }

      }

    }

    /// The specification for the standard `PitchSalience` algorithm.
    public struct PitchSalience: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<PitchSalience> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<PitchSalience>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "PitchSalience" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Tonal.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case spectrum

        public static var allKeys: Set<Input> {
          return [
             .spectrum
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case pitchSalience

        public static var allKeys: Set<Output> {
          return [
             .pitchSalience
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case highBoundary
        case lowBoundary
        case sampleRate

        public static var allKeys: Set<Parameter> {
          return [
             .highBoundary,
             .lowBoundary,
             .sampleRate
          ]
        }

      }

    }

    /// The specification for the standard `SpectrumCQ` algorithm.
    public struct SpectrumCQ: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<SpectrumCQ> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<SpectrumCQ>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "SpectrumCQ" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Tonal.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case frame

        public static var allKeys: Set<Input> {
          return [
             .frame
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case spectrumCQ

        public static var allKeys: Set<Output> {
          return [
             .spectrumCQ
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case binsPerOctave
        case maxFrequency
        case minFrequency
        case sampleRate
        case threshold

        public static var allKeys: Set<Parameter> {
          return [
             .binsPerOctave,
             .maxFrequency,
             .minFrequency,
             .sampleRate,
             .threshold
          ]
        }

      }

    }

    /// The specification for the standard `TonalExtractor` algorithm.
    public struct TonalExtractor: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<TonalExtractor> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<TonalExtractor>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "TonalExtractor" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Tonal.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Input> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case chords_strength
        case hpcp
        case key_strength
        case chords_number_rate
        case key_scale
        case chords_changes_rate
        case key_key
        case chords_histogram
        case chords_scale
        case hpcp_highres
        case chords_key
        case chords_progression

        public static var allKeys: Set<Output> {
          return [
             .chords_strength,
             .hpcp,
             .key_strength,
             .chords_number_rate,
             .key_scale,
             .chords_changes_rate,
             .key_key,
             .chords_histogram,
             .chords_scale,
             .hpcp_highres,
             .chords_key,
             .chords_progression
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case frameSize
        case hopSize
        case tuningFrequency

        public static var allKeys: Set<Parameter> {
          return [
             .frameSize,
             .hopSize,
             .tuningFrequency
          ]
        }

      }

    }

    /// The specification for the standard `TonicIndianArtMusic` algorithm.
    public struct TonicIndianArtMusic: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<TonicIndianArtMusic> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<TonicIndianArtMusic>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "TonicIndianArtMusic" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Tonal.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Input> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case tonic

        public static var allKeys: Set<Output> {
          return [
             .tonic
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case binResolution
        case frameSize
        case harmonicWeight
        case hopSize
        case magnitudeCompression
        case magnitudeThreshold
        case maxTonicFrequency
        case minTonicFrequency
        case numberHarmonics
        case numberSaliencePeaks
        case referenceFrequency
        case sampleRate

        public static var allKeys: Set<Parameter> {
          return [
             .binResolution,
             .frameSize,
             .harmonicWeight,
             .hopSize,
             .magnitudeCompression,
             .magnitudeThreshold,
             .maxTonicFrequency,
             .minTonicFrequency,
             .numberHarmonics,
             .numberSaliencePeaks,
             .referenceFrequency,
             .sampleRate
          ]
        }

      }

    }

    /// The specification for the standard `Tristimulus` algorithm.
    public struct Tristimulus: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<Tristimulus> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<Tristimulus>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Tristimulus" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Tonal.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case frequencies
        case magnitudes

        public static var allKeys: Set<Input> {
          return [
             .frequencies,
             .magnitudes
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case tristimulus

        public static var allKeys: Set<Output> {
          return [
             .tristimulus
          ]
        }

      }

      /// An enumeration with the sole case of `none` specifying that the algorithm has no parameters.
      public enum Parameter: String, KeyEnumeration {

        case none

        public static var allKeys: Set<Parameter> {
          return []
        }

      }

    }

    /// The specification for the standard `TuningFrequency` algorithm.
    public struct TuningFrequency: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<TuningFrequency> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<TuningFrequency>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "TuningFrequency" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Tonal.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case frequencies
        case magnitudes

        public static var allKeys: Set<Input> {
          return [
             .frequencies,
             .magnitudes
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case tuningCents
        case tuningFrequency

        public static var allKeys: Set<Output> {
          return [
             .tuningCents,
             .tuningFrequency
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case resolution

        public static var allKeys: Set<Parameter> {
          return [
             .resolution
          ]
        }

      }

    }

    /// The specification for the standard `TuningFrequencyExtractor` algorithm.
    public struct TuningFrequencyExtractor: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<TuningFrequencyExtractor> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<TuningFrequencyExtractor>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "TuningFrequencyExtractor" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Tonal.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case signal

        public static var allKeys: Set<Input> {
          return [
             .signal
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case tuningFrequency

        public static var allKeys: Set<Output> {
          return [
             .tuningFrequency
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case frameSize
        case hopSize

        public static var allKeys: Set<Parameter> {
          return [
             .frameSize,
             .hopSize
          ]
        }

      }

    }

  }

  /// An enumeration serving as both a namespace and a category for algorithm specifications.
  public enum Segmentation: AlgorithmCategory {

    /// The name of the category as it appears in info structs.
    public static var name: String { return "Segmentation" }

    /// The specification for the standard `SBic` algorithm.
    public struct SBic: StandardSpecification {

      public static func downCast(wrapper: StandardAlgorithmWrapper) -> StandardAlgorithm<SBic> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StandardAlgorithm<SBic>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "SBic" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Standard.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Segmentation.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.standardInfo(forName: name)?.algorithmDescription ?? ""
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case features

        public static var allKeys: Set<Input> {
          return [
             .features
          ]
        }

      }

      /// An enumeration of the valid output names for the algorithm.
      public enum Output: String, KeyEnumeration {

        case segmentation

        public static var allKeys: Set<Output> {
          return [
             .segmentation
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case cpw
        case inc1
        case inc2
        case minLength
        case size1
        case size2

        public static var allKeys: Set<Parameter> {
          return [
             .cpw,
             .inc1,
             .inc2,
             .minLength,
             .size1,
             .size2
          ]
        }

      }

    }

  }

}

