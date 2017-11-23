//
//  StreamingSpecifications.swift
//  Essentia
//
//  Created by Jason Cardwell on 11/2/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
import Foundation

extension Streaming {

  /// An enumeration serving as both a namespace and a category for algorithm specifications.
  public enum Rhythm: AlgorithmCategory {

    /// The name of the category as it appears in info structs.
    public static var name: String { return "Rhythm" }

    /// The specification for the streaming `BeatTrackerDegara` algorithm.
    public struct BeatTrackerDegara: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<BeatTrackerDegara> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<BeatTrackerDegara>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "BeatTrackerDegara" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `BeatTrackerMultiFeature` algorithm.
    public struct BeatTrackerMultiFeature: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<BeatTrackerMultiFeature> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<BeatTrackerMultiFeature>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "BeatTrackerMultiFeature" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `Beatogram` algorithm.
    public struct Beatogram: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<Beatogram> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<Beatogram>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Beatogram" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `BeatsLoudness` algorithm.
    public struct BeatsLoudness: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<BeatsLoudness> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<BeatsLoudness>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "BeatsLoudness" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `BpmHistogram` algorithm.
    public struct BpmHistogram: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<BpmHistogram> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<BpmHistogram>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "BpmHistogram" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `BpmHistogramDescriptors` algorithm.
    public struct BpmHistogramDescriptors: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<BpmHistogramDescriptors> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<BpmHistogramDescriptors>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "BpmHistogramDescriptors" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `BpmRubato` algorithm.
    public struct BpmRubato: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<BpmRubato> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<BpmRubato>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "BpmRubato" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `Danceability` algorithm.
    public struct Danceability: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<Danceability> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<Danceability>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Danceability" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `HarmonicBpm` algorithm.
    public struct HarmonicBpm: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<HarmonicBpm> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<HarmonicBpm>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "HarmonicBpm" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `LoopBpmConfidence` algorithm.
    public struct LoopBpmConfidence: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<LoopBpmConfidence> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<LoopBpmConfidence>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "LoopBpmConfidence" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `LoopBpmEstimator` algorithm.
    public struct LoopBpmEstimator: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<LoopBpmEstimator> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<LoopBpmEstimator>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "LoopBpmEstimator" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `Meter` algorithm.
    public struct Meter: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<Meter> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<Meter>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Meter" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `NoveltyCurve` algorithm.
    public struct NoveltyCurve: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<NoveltyCurve> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<NoveltyCurve>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "NoveltyCurve" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `OnsetDetection` algorithm.
    public struct OnsetDetection: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<OnsetDetection> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<OnsetDetection>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "OnsetDetection" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `OnsetDetectionGlobal` algorithm.
    public struct OnsetDetectionGlobal: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<OnsetDetectionGlobal> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<OnsetDetectionGlobal>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "OnsetDetectionGlobal" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `OnsetRate` algorithm.
    public struct OnsetRate: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<OnsetRate> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<OnsetRate>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "OnsetRate" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

        case onsetRate
        case onsetTimes

        public static var allKeys: Set<Output> {
          return [
             .onsetRate,
             .onsetTimes
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

    /// The specification for the streaming `Onsets` algorithm.
    public struct Onsets: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<Onsets> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<Onsets>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Onsets" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `PercivalBpmEstimator` algorithm.
    public struct PercivalBpmEstimator: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<PercivalBpmEstimator> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<PercivalBpmEstimator>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "PercivalBpmEstimator" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `PercivalEnhanceHarmonics` algorithm.
    public struct PercivalEnhanceHarmonics: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<PercivalEnhanceHarmonics> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<PercivalEnhanceHarmonics>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "PercivalEnhanceHarmonics" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `PercivalEvaluatePulseTrains` algorithm.
    public struct PercivalEvaluatePulseTrains: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<PercivalEvaluatePulseTrains> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<PercivalEvaluatePulseTrains>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "PercivalEvaluatePulseTrains" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `RhythmDescriptors` algorithm.
    public struct RhythmDescriptors: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<RhythmDescriptors> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<RhythmDescriptors>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "RhythmDescriptors" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `RhythmExtractor` algorithm.
    public struct RhythmExtractor: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<RhythmExtractor> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<RhythmExtractor>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "RhythmExtractor" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `RhythmExtractor2013` algorithm.
    public struct RhythmExtractor2013: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<RhythmExtractor2013> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<RhythmExtractor2013>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "RhythmExtractor2013" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `RhythmTransform` algorithm.
    public struct RhythmTransform: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<RhythmTransform> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<RhythmTransform>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "RhythmTransform" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `SingleBeatLoudness` algorithm.
    public struct SingleBeatLoudness: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<SingleBeatLoudness> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<SingleBeatLoudness>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "SingleBeatLoudness" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `SuperFluxExtractor` algorithm.
    public struct SuperFluxExtractor: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<SuperFluxExtractor> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<SuperFluxExtractor>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "SuperFluxExtractor" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `SuperFluxNovelty` algorithm.
    public struct SuperFluxNovelty: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<SuperFluxNovelty> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<SuperFluxNovelty>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "SuperFluxNovelty" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `SuperFluxPeaks` algorithm.
    public struct SuperFluxPeaks: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<SuperFluxPeaks> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<SuperFluxPeaks>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "SuperFluxPeaks" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `TempoScaleBands` algorithm.
    public struct TempoScaleBands: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<TempoScaleBands> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<TempoScaleBands>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "TempoScaleBands" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `TempoTap` algorithm.
    public struct TempoTap: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<TempoTap> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<TempoTap>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "TempoTap" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `TempoTapDegara` algorithm.
    public struct TempoTapDegara: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<TempoTapDegara> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<TempoTapDegara>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "TempoTapDegara" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `TempoTapMaxAgreement` algorithm.
    public struct TempoTapMaxAgreement: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<TempoTapMaxAgreement> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<TempoTapMaxAgreement>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "TempoTapMaxAgreement" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `TempoTapTicks` algorithm.
    public struct TempoTapTicks: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<TempoTapTicks> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<TempoTapTicks>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "TempoTapTicks" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Rhythm.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `MultiPitchMelodia` algorithm.
    public struct MultiPitchMelodia: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<MultiPitchMelodia> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<MultiPitchMelodia>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "MultiPitchMelodia" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Pitch.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `PitchContours` algorithm.
    public struct PitchContours: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<PitchContours> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<PitchContours>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "PitchContours" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Pitch.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `PitchContoursMelody` algorithm.
    public struct PitchContoursMelody: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<PitchContoursMelody> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<PitchContoursMelody>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "PitchContoursMelody" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Pitch.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `PitchContoursMonoMelody` algorithm.
    public struct PitchContoursMonoMelody: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<PitchContoursMonoMelody> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<PitchContoursMonoMelody>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "PitchContoursMonoMelody" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Pitch.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `PitchContoursMultiMelody` algorithm.
    public struct PitchContoursMultiMelody: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<PitchContoursMultiMelody> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<PitchContoursMultiMelody>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "PitchContoursMultiMelody" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Pitch.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `PitchFilter` algorithm.
    public struct PitchFilter: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<PitchFilter> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<PitchFilter>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "PitchFilter" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Pitch.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `PitchMelodia` algorithm.
    public struct PitchMelodia: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<PitchMelodia> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<PitchMelodia>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "PitchMelodia" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Pitch.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `PitchSalienceFunction` algorithm.
    public struct PitchSalienceFunction: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<PitchSalienceFunction> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<PitchSalienceFunction>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "PitchSalienceFunction" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Pitch.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `PitchSalienceFunctionPeaks` algorithm.
    public struct PitchSalienceFunctionPeaks: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<PitchSalienceFunctionPeaks> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<PitchSalienceFunctionPeaks>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "PitchSalienceFunctionPeaks" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Pitch.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `PitchYin` algorithm.
    public struct PitchYin: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<PitchYin> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<PitchYin>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "PitchYin" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Pitch.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `PitchYinFFT` algorithm.
    public struct PitchYinFFT: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<PitchYinFFT> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<PitchYinFFT>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "PitchYinFFT" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Pitch.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `PredominantPitchMelodia` algorithm.
    public struct PredominantPitchMelodia: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<PredominantPitchMelodia> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<PredominantPitchMelodia>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "PredominantPitchMelodia" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Pitch.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `Vibrato` algorithm.
    public struct Vibrato: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<Vibrato> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<Vibrato>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Vibrato" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Pitch.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `HarmonicMask` algorithm.
    public struct HarmonicMask: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<HarmonicMask> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<HarmonicMask>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "HarmonicMask" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Synthesis.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `HarmonicModelAnal` algorithm.
    public struct HarmonicModelAnal: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<HarmonicModelAnal> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<HarmonicModelAnal>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "HarmonicModelAnal" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Synthesis.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `HprModelAnal` algorithm.
    public struct HprModelAnal: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<HprModelAnal> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<HprModelAnal>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "HprModelAnal" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Synthesis.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `HpsModelAnal` algorithm.
    public struct HpsModelAnal: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<HpsModelAnal> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<HpsModelAnal>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "HpsModelAnal" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Synthesis.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `ResampleFFT` algorithm.
    public struct ResampleFFT: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<ResampleFFT> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<ResampleFFT>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "ResampleFFT" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Synthesis.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `SineModelAnal` algorithm.
    public struct SineModelAnal: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<SineModelAnal> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<SineModelAnal>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "SineModelAnal" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Synthesis.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `SineModelSynth` algorithm.
    public struct SineModelSynth: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<SineModelSynth> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<SineModelSynth>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "SineModelSynth" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Synthesis.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `SineSubtraction` algorithm.
    public struct SineSubtraction: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<SineSubtraction> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<SineSubtraction>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "SineSubtraction" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Synthesis.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `SprModelAnal` algorithm.
    public struct SprModelAnal: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<SprModelAnal> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<SprModelAnal>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "SprModelAnal" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Synthesis.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `SprModelSynth` algorithm.
    public struct SprModelSynth: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<SprModelSynth> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<SprModelSynth>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "SprModelSynth" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Synthesis.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `SpsModelAnal` algorithm.
    public struct SpsModelAnal: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<SpsModelAnal> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<SpsModelAnal>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "SpsModelAnal" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Synthesis.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `SpsModelSynth` algorithm.
    public struct SpsModelSynth: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<SpsModelSynth> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<SpsModelSynth>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "SpsModelSynth" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Synthesis.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `StochasticModelAnal` algorithm.
    public struct StochasticModelAnal: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<StochasticModelAnal> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<StochasticModelAnal>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "StochasticModelAnal" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Synthesis.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `StochasticModelSynth` algorithm.
    public struct StochasticModelSynth: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<StochasticModelSynth> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<StochasticModelSynth>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "StochasticModelSynth" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Synthesis.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `AudioOnsetsMarker` algorithm.
    public struct AudioOnsetsMarker: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<AudioOnsetsMarker> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<AudioOnsetsMarker>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "AudioOnsetsMarker" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return IO.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `VectorInput` algorithm.
    public struct VectorInput: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<VectorInput> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<VectorInput>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "VectorInput" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return IO.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return """
          The VectorInput algorithm serves as a network's root by allowing a vector to be connected directly to the \
          algorithm. This vector of data is then streamed through the algorithm as output.
          """
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

      /// An enumeration with the sole case of `none` specifying that the algorithm has no parameters.
      public enum Parameter: String, KeyEnumeration {

        case none

        public static var allKeys: Set<Parameter> {
          return []
        }

      }

    }

    /// The specification for the streaming `VectorOutput` algorithm.
    public struct VectorOutput: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<VectorOutput> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<VectorOutput>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "VectorOutput" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return IO.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return """
          The VectorOutput algorithm serves as a network's final destination receiving data over a single input and \
          making that data available directly from the algorithm.
          """
      }

      /// An enumeration of the valid input names for the algorithm.
      public enum Input: String, KeyEnumeration {

        case data

        public static var allKeys: Set<Input> {
          return [
             .data
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
  public enum Duration_Silence: AlgorithmCategory {

    /// The name of the category as it appears in info structs.
    public static var name: String { return "Duration/silence" }

    /// The specification for the streaming `Duration` algorithm.
    public struct Duration: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<Duration> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<Duration>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Duration" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Duration_Silence.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `EffectiveDuration` algorithm.
    public struct EffectiveDuration: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<EffectiveDuration> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<EffectiveDuration>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "EffectiveDuration" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Duration_Silence.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `FadeDetection` algorithm.
    public struct FadeDetection: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<FadeDetection> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<FadeDetection>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "FadeDetection" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Duration_Silence.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `SilenceRate` algorithm.
    public struct SilenceRate: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<SilenceRate> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<SilenceRate>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "SilenceRate" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Duration_Silence.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `StartStopSilence` algorithm.
    public struct StartStopSilence: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<StartStopSilence> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<StartStopSilence>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "StartStopSilence" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Duration_Silence.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `DynamicComplexity` algorithm.
    public struct DynamicComplexity: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<DynamicComplexity> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<DynamicComplexity>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "DynamicComplexity" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Loudness_Dynamics.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `Larm` algorithm.
    public struct Larm: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<Larm> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<Larm>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Larm" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Loudness_Dynamics.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `Leq` algorithm.
    public struct Leq: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<Leq> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<Leq>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Leq" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Loudness_Dynamics.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `LevelExtractor` algorithm.
    public struct LevelExtractor: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<LevelExtractor> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<LevelExtractor>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "LevelExtractor" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Loudness_Dynamics.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `Loudness` algorithm.
    public struct Loudness: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<Loudness> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<Loudness>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Loudness" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Loudness_Dynamics.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `LoudnessEBUR128` algorithm.
    public struct LoudnessEBUR128: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<LoudnessEBUR128> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<LoudnessEBUR128>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "LoudnessEBUR128" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Loudness_Dynamics.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `LoudnessVickers` algorithm.
    public struct LoudnessVickers: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<LoudnessVickers> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<LoudnessVickers>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "LoudnessVickers" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Loudness_Dynamics.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `ReplayGain` algorithm.
    public struct ReplayGain: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<ReplayGain> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<ReplayGain>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "ReplayGain" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Loudness_Dynamics.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

        case applyEqloud
        case sampleRate

        public static var allKeys: Set<Parameter> {
          return [
             .applyEqloud,
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

    /// The specification for the streaming `AllPass` algorithm.
    public struct AllPass: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<AllPass> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<AllPass>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "AllPass" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Filters.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `BandPass` algorithm.
    public struct BandPass: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<BandPass> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<BandPass>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "BandPass" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Filters.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `BandReject` algorithm.
    public struct BandReject: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<BandReject> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<BandReject>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "BandReject" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Filters.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `DCRemoval` algorithm.
    public struct DCRemoval: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<DCRemoval> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<DCRemoval>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "DCRemoval" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Filters.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `EqualLoudness` algorithm.
    public struct EqualLoudness: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<EqualLoudness> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<EqualLoudness>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "EqualLoudness" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Filters.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `HighPass` algorithm.
    public struct HighPass: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<HighPass> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<HighPass>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "HighPass" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Filters.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `IIR` algorithm.
    public struct IIR: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<IIR> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<IIR>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "IIR" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Filters.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `LowPass` algorithm.
    public struct LowPass: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<LowPass> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<LowPass>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "LowPass" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Filters.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `MaxFilter` algorithm.
    public struct MaxFilter: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<MaxFilter> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<MaxFilter>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "MaxFilter" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Filters.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `MovingAverage` algorithm.
    public struct MovingAverage: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<MovingAverage> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<MovingAverage>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "MovingAverage" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Filters.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `AutoCorrelation` algorithm.
    public struct AutoCorrelation: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<AutoCorrelation> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<AutoCorrelation>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "AutoCorrelation" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `BPF` algorithm.
    public struct BPF: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<BPF> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<BPF>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "BPF" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `BinaryOperator` algorithm.
    public struct BinaryOperator: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<BinaryOperator> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<BinaryOperator>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "BinaryOperator" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `BinaryOperatorStream` algorithm.
    public struct BinaryOperatorStream: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<BinaryOperatorStream> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<BinaryOperatorStream>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "BinaryOperatorStream" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `Clipper` algorithm.
    public struct Clipper: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<Clipper> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<Clipper>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Clipper" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `ConstantQ` algorithm.
    public struct ConstantQ: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<ConstantQ> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<ConstantQ>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "ConstantQ" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `CrossCorrelation` algorithm.
    public struct CrossCorrelation: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<CrossCorrelation> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<CrossCorrelation>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "CrossCorrelation" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `CubicSpline` algorithm.
    public struct CubicSpline: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<CubicSpline> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<CubicSpline>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "CubicSpline" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `DCT` algorithm.
    public struct DCT: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<DCT> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<DCT>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "DCT" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `Derivative` algorithm.
    public struct Derivative: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<Derivative> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<Derivative>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Derivative" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `FFT` algorithm.
    public struct FFT: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<FFT> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<FFT>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "FFT" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `FFTC` algorithm.
    public struct FFTC: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<FFTC> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<FFTC>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "FFTC" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `FrameCutter` algorithm.
    public struct FrameCutter: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<FrameCutter> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<FrameCutter>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "FrameCutter" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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
        case silentFrames
        case startFromZero
        case validFrameThresholdRatio

        public static var allKeys: Set<Parameter> {
          return [
             .frameSize,
             .hopSize,
             .lastFrameToEndOfFile,
             .silentFrames,
             .startFromZero,
             .validFrameThresholdRatio
          ]
        }

      }

    }

    /// The specification for the streaming `FrameToReal` algorithm.
    public struct FrameToReal: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<FrameToReal> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<FrameToReal>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "FrameToReal" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `IDCT` algorithm.
    public struct IDCT: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<IDCT> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<IDCT>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "IDCT" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `IFFT` algorithm.
    public struct IFFT: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<IFFT> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<IFFT>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "IFFT" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `IFFTC` algorithm.
    public struct IFFTC: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<IFFTC> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<IFFTC>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "IFFTC" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `MonoMixer` algorithm.
    public struct MonoMixer: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<MonoMixer> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<MonoMixer>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "MonoMixer" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `Multiplexer` algorithm.
    public struct Multiplexer: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<Multiplexer> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<Multiplexer>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Multiplexer" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `NoiseAdder` algorithm.
    public struct NoiseAdder: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<NoiseAdder> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<NoiseAdder>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "NoiseAdder" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `OverlapAdd` algorithm.
    public struct OverlapAdd: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<OverlapAdd> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<OverlapAdd>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "OverlapAdd" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `PeakDetection` algorithm.
    public struct PeakDetection: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<PeakDetection> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<PeakDetection>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "PeakDetection" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `Scale` algorithm.
    public struct Scale: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<Scale> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<Scale>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Scale" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `Slicer` algorithm.
    public struct Slicer: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<Slicer> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<Slicer>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Slicer" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `Spline` algorithm.
    public struct Spline: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<Spline> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<Spline>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Spline" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `StereoDemuxer` algorithm.
    public struct StereoDemuxer: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<StereoDemuxer> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<StereoDemuxer>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "StereoDemuxer" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `StereoMuxer` algorithm.
    public struct StereoMuxer: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<StereoMuxer> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<StereoMuxer>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "StereoMuxer" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `StereoTrimmer` algorithm.
    public struct StereoTrimmer: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<StereoTrimmer> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<StereoTrimmer>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "StereoTrimmer" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

        case endTime
        case sampleRate
        case startTime

        public static var allKeys: Set<Parameter> {
          return [
             .endTime,
             .sampleRate,
             .startTime
          ]
        }

      }

    }

    /// The specification for the streaming `Trimmer` algorithm.
    public struct Trimmer: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<Trimmer> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<Trimmer>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Trimmer" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

        case endTime
        case sampleRate
        case startTime

        public static var allKeys: Set<Parameter> {
          return [
             .endTime,
             .sampleRate,
             .startTime
          ]
        }

      }

    }

    /// The specification for the streaming `UnaryOperator` algorithm.
    public struct UnaryOperator: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<UnaryOperator> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<UnaryOperator>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "UnaryOperator" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `UnaryOperatorStream` algorithm.
    public struct UnaryOperatorStream: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<UnaryOperatorStream> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<UnaryOperatorStream>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "UnaryOperatorStream" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `WarpedAutoCorrelation` algorithm.
    public struct WarpedAutoCorrelation: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<WarpedAutoCorrelation> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<WarpedAutoCorrelation>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "WarpedAutoCorrelation" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `Windowing` algorithm.
    public struct Windowing: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<Windowing> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<Windowing>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Windowing" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `ZeroCrossingRate` algorithm.
    public struct ZeroCrossingRate: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<ZeroCrossingRate> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<ZeroCrossingRate>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "ZeroCrossingRate" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Standard.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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
  public enum Spectral: AlgorithmCategory {

    /// The name of the category as it appears in info structs.
    public static var name: String { return "Spectral" }

    /// The specification for the streaming `BFCC` algorithm.
    public struct BFCC: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<BFCC> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<BFCC>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "BFCC" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Spectral.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `BarkBands` algorithm.
    public struct BarkBands: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<BarkBands> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<BarkBands>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "BarkBands" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Spectral.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `ERBBands` algorithm.
    public struct ERBBands: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<ERBBands> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<ERBBands>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "ERBBands" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Spectral.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `EnergyBand` algorithm.
    public struct EnergyBand: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<EnergyBand> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<EnergyBand>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "EnergyBand" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Spectral.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `EnergyBandRatio` algorithm.
    public struct EnergyBandRatio: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<EnergyBandRatio> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<EnergyBandRatio>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "EnergyBandRatio" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Spectral.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `FlatnessDB` algorithm.
    public struct FlatnessDB: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<FlatnessDB> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<FlatnessDB>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "FlatnessDB" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Spectral.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `Flux` algorithm.
    public struct Flux: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<Flux> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<Flux>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Flux" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Spectral.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `FrequencyBands` algorithm.
    public struct FrequencyBands: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<FrequencyBands> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<FrequencyBands>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "FrequencyBands" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Spectral.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `GFCC` algorithm.
    public struct GFCC: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<GFCC> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<GFCC>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "GFCC" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Spectral.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `HFC` algorithm.
    public struct HFC: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<HFC> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<HFC>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "HFC" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Spectral.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `LPC` algorithm.
    public struct LPC: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<LPC> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<LPC>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "LPC" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Spectral.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `MFCC` algorithm.
    public struct MFCC: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<MFCC> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<MFCC>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "MFCC" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Spectral.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `MaxMagFreq` algorithm.
    public struct MaxMagFreq: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<MaxMagFreq> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<MaxMagFreq>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "MaxMagFreq" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Spectral.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `MelBands` algorithm.
    public struct MelBands: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<MelBands> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<MelBands>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "MelBands" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Spectral.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `Panning` algorithm.
    public struct Panning: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<Panning> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<Panning>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Panning" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Spectral.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `PowerSpectrum` algorithm.
    public struct PowerSpectrum: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<PowerSpectrum> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<PowerSpectrum>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "PowerSpectrum" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Spectral.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `RollOff` algorithm.
    public struct RollOff: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<RollOff> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<RollOff>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "RollOff" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Spectral.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `SpectralCentroidTime` algorithm.
    public struct SpectralCentroidTime: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<SpectralCentroidTime> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<SpectralCentroidTime>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "SpectralCentroidTime" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Spectral.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `SpectralComplexity` algorithm.
    public struct SpectralComplexity: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<SpectralComplexity> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<SpectralComplexity>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "SpectralComplexity" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Spectral.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `SpectralContrast` algorithm.
    public struct SpectralContrast: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<SpectralContrast> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<SpectralContrast>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "SpectralContrast" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Spectral.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `SpectralPeaks` algorithm.
    public struct SpectralPeaks: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<SpectralPeaks> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<SpectralPeaks>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "SpectralPeaks" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Spectral.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `SpectralWhitening` algorithm.
    public struct SpectralWhitening: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<SpectralWhitening> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<SpectralWhitening>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "SpectralWhitening" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Spectral.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `Spectrum` algorithm.
    public struct Spectrum: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<Spectrum> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<Spectrum>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Spectrum" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Spectral.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `SpectrumToCent` algorithm.
    public struct SpectrumToCent: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<SpectrumToCent> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<SpectrumToCent>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "SpectrumToCent" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Spectral.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `StrongPeak` algorithm.
    public struct StrongPeak: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<StrongPeak> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<StrongPeak>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "StrongPeak" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Spectral.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `TriangularBands` algorithm.
    public struct TriangularBands: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<TriangularBands> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<TriangularBands>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "TriangularBands" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Spectral.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `TriangularBarkBands` algorithm.
    public struct TriangularBarkBands: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<TriangularBarkBands> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<TriangularBarkBands>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "TriangularBarkBands" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Spectral.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `LowLevelSpectralEqloudExtractor` algorithm.
    public struct LowLevelSpectralEqloudExtractor: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<LowLevelSpectralEqloudExtractor> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<LowLevelSpectralEqloudExtractor>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "LowLevelSpectralEqloudExtractor" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Extractors.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `LowLevelSpectralExtractor` algorithm.
    public struct LowLevelSpectralExtractor: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<LowLevelSpectralExtractor> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<LowLevelSpectralExtractor>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "LowLevelSpectralExtractor" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Extractors.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `AfterMaxToBeforeMaxEnergyRatio` algorithm.
    public struct AfterMaxToBeforeMaxEnergyRatio: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<AfterMaxToBeforeMaxEnergyRatio> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<AfterMaxToBeforeMaxEnergyRatio>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "AfterMaxToBeforeMaxEnergyRatio" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Envelope_SFX.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `DerivativeSFX` algorithm.
    public struct DerivativeSFX: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<DerivativeSFX> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<DerivativeSFX>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "DerivativeSFX" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Envelope_SFX.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `Envelope` algorithm.
    public struct Envelope: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<Envelope> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<Envelope>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Envelope" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Envelope_SFX.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `FlatnessSFX` algorithm.
    public struct FlatnessSFX: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<FlatnessSFX> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<FlatnessSFX>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "FlatnessSFX" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Envelope_SFX.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `LogAttackTime` algorithm.
    public struct LogAttackTime: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<LogAttackTime> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<LogAttackTime>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "LogAttackTime" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Envelope_SFX.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `MaxToTotal` algorithm.
    public struct MaxToTotal: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<MaxToTotal> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<MaxToTotal>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "MaxToTotal" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Envelope_SFX.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `MinToTotal` algorithm.
    public struct MinToTotal: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<MinToTotal> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<MinToTotal>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "MinToTotal" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Envelope_SFX.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `StrongDecay` algorithm.
    public struct StrongDecay: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<StrongDecay> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<StrongDecay>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "StrongDecay" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Envelope_SFX.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `TCToTotal` algorithm.
    public struct TCToTotal: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<TCToTotal> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<TCToTotal>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "TCToTotal" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Envelope_SFX.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `CartesianToPolar` algorithm.
    public struct CartesianToPolar: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<CartesianToPolar> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<CartesianToPolar>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "CartesianToPolar" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Math.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `Magnitude` algorithm.
    public struct Magnitude: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<Magnitude> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<Magnitude>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Magnitude" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Math.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `PolarToCartesian` algorithm.
    public struct PolarToCartesian: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<PolarToCartesian> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<PolarToCartesian>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "PolarToCartesian" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Math.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `CentralMoments` algorithm.
    public struct CentralMoments: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<CentralMoments> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<CentralMoments>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "CentralMoments" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Statistics.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `Centroid` algorithm.
    public struct Centroid: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<Centroid> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<Centroid>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Centroid" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Statistics.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `Crest` algorithm.
    public struct Crest: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<Crest> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<Crest>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Crest" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Statistics.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `Decrease` algorithm.
    public struct Decrease: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<Decrease> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<Decrease>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Decrease" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Statistics.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `DistributionShape` algorithm.
    public struct DistributionShape: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<DistributionShape> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<DistributionShape>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "DistributionShape" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Statistics.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `Energy` algorithm.
    public struct Energy: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<Energy> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<Energy>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Energy" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Statistics.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `Entropy` algorithm.
    public struct Entropy: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<Entropy> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<Entropy>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Entropy" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Statistics.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `Flatness` algorithm.
    public struct Flatness: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<Flatness> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<Flatness>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Flatness" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Statistics.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `GeometricMean` algorithm.
    public struct GeometricMean: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<GeometricMean> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<GeometricMean>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "GeometricMean" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Statistics.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `InstantPower` algorithm.
    public struct InstantPower: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<InstantPower> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<InstantPower>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "InstantPower" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Statistics.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `Mean` algorithm.
    public struct Mean: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<Mean> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<Mean>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Mean" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Statistics.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `Median` algorithm.
    public struct Median: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<Median> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<Median>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Median" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Statistics.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `PowerMean` algorithm.
    public struct PowerMean: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<PowerMean> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<PowerMean>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "PowerMean" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Statistics.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `RMS` algorithm.
    public struct RMS: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<RMS> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<RMS>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "RMS" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Statistics.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `RawMoments` algorithm.
    public struct RawMoments: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<RawMoments> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<RawMoments>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "RawMoments" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Statistics.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `SingleGaussian` algorithm.
    public struct SingleGaussian: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<SingleGaussian> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<SingleGaussian>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "SingleGaussian" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Statistics.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `Variance` algorithm.
    public struct Variance: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<Variance> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<Variance>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Variance" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Statistics.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `ChordsDescriptors` algorithm.
    public struct ChordsDescriptors: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<ChordsDescriptors> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<ChordsDescriptors>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "ChordsDescriptors" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Tonal.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `ChordsDetection` algorithm.
    public struct ChordsDetection: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<ChordsDetection> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<ChordsDetection>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "ChordsDetection" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Tonal.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `Chromagram` algorithm.
    public struct Chromagram: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<Chromagram> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<Chromagram>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Chromagram" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Tonal.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

        case chromagram

        public static var allKeys: Set<Output> {
          return [
             .chromagram
          ]
        }

      }

      /// An enumeration of the valid parameter names for the algorithm.
      public enum Parameter: String, KeyEnumeration {

        case binsPerOctave
        case maxFrequency
        case minFrequency
        case normalizeType
        case sampleRate
        case threshold

        public static var allKeys: Set<Parameter> {
          return [
             .binsPerOctave,
             .maxFrequency,
             .minFrequency,
             .normalizeType,
             .sampleRate,
             .threshold
          ]
        }

      }

    }

    /// The specification for the streaming `Dissonance` algorithm.
    public struct Dissonance: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<Dissonance> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<Dissonance>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Dissonance" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Tonal.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `HPCP` algorithm.
    public struct HPCP: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<HPCP> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<HPCP>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "HPCP" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Tonal.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `HarmonicPeaks` algorithm.
    public struct HarmonicPeaks: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<HarmonicPeaks> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<HarmonicPeaks>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "HarmonicPeaks" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Tonal.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `HighResolutionFeatures` algorithm.
    public struct HighResolutionFeatures: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<HighResolutionFeatures> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<HighResolutionFeatures>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "HighResolutionFeatures" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Tonal.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `Inharmonicity` algorithm.
    public struct Inharmonicity: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<Inharmonicity> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<Inharmonicity>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Inharmonicity" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Tonal.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `Key` algorithm.
    public struct Key: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<Key> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<Key>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Key" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Tonal.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `KeyExtractor` algorithm.
    public struct KeyExtractor: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<KeyExtractor> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<KeyExtractor>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "KeyExtractor" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Tonal.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `OddToEvenHarmonicEnergyRatio` algorithm.
    public struct OddToEvenHarmonicEnergyRatio: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<OddToEvenHarmonicEnergyRatio> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<OddToEvenHarmonicEnergyRatio>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "OddToEvenHarmonicEnergyRatio" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Tonal.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `PitchSalience` algorithm.
    public struct PitchSalience: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<PitchSalience> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<PitchSalience>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "PitchSalience" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Tonal.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `SpectrumCQ` algorithm.
    public struct SpectrumCQ: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<SpectrumCQ> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<SpectrumCQ>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "SpectrumCQ" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Tonal.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `TonalExtractor` algorithm.
    public struct TonalExtractor: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<TonalExtractor> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<TonalExtractor>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "TonalExtractor" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Tonal.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `Tristimulus` algorithm.
    public struct Tristimulus: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<Tristimulus> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<Tristimulus>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "Tristimulus" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Tonal.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `TuningFrequency` algorithm.
    public struct TuningFrequency: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<TuningFrequency> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<TuningFrequency>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "TuningFrequency" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Tonal.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `TuningFrequencyExtractor` algorithm.
    public struct TuningFrequencyExtractor: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<TuningFrequencyExtractor> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<TuningFrequencyExtractor>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "TuningFrequencyExtractor" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Tonal.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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

    /// The specification for the streaming `SBic` algorithm.
    public struct SBic: StreamingSpecification {

      public static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<SBic> {
        guard wrapper.name == name else {
          fatalError("Invalid cast from \(wrapper.name) to \(name).")
        }
        return StreamingAlgorithm<SBic>(wrapper: wrapper)
      }

      /// The algorithm's name. This is equal to `info.algorithmName`.
      public static var name: String { return "SBic" }

      /// The algorithm's operating mode.
      public static var mode: AlgorithmMode.Type { return Essentia.Streaming.self }

      /// The algorithm's category.
      public static var category: AlgorithmCategory.Type { return Segmentation.self }

      /// The algorithm's description. This is equal to `info.algorithmDescription`.
      public static var description: String {
        return AlgorithmFactoryWrapper.streamingInfo(forName: name)?.algorithmDescription ?? ""
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
