//
//  Streaming.swift
//  Essentia
//
//  Created by Jason Cardwell on 10/26/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
import Foundation

/// A protocol inheriting from `AlgorithmSpecification` specification types that describe an
/// algorithm operating in 'streaming' mode.
public protocol StreamingSpecification: AlgorithmSpecification {

  static func downCast(wrapper: StreamingAlgorithmWrapper) -> StreamingAlgorithm<Self>

}

/*
 Algorithms missing because retrieving their info throws an exception:
 - BarkExtractor
 - FileOutput
 - LoudnessEBR128Filter
 - RealAccumulator
 - VectorRealAccumulator
 */

/// An enumeration serving as both a namespace and a mode of operation for algorithm specifications.
public enum Streaming: AlgorithmMode {

  /// An enumeration of identifiers for all supported streaming algorithms.
  public enum AlgorithmID: String {

    /// Rhythm
    case BeatTrackerDegara, BeatTrackerMultiFeature, Beatogram, BeatsLoudness, BpmHistogram,
         BpmHistogramDescriptors, BpmRubato, Danceability, HarmonicBpm, LoopBpmConfidence,
         LoopBpmEstimator, Meter, NoveltyCurve, OnsetDetection, OnsetDetectionGlobal, OnsetRate,
         Onsets, PercivalBpmEstimator, PercivalEnhanceHarmonics, PercivalEvaluatePulseTrains,
         RhythmDescriptors, RhythmExtractor, RhythmExtractor2013, RhythmTransform,
         SingleBeatLoudness, SuperFluxExtractor, SuperFluxNovelty, SuperFluxPeaks, TempoScaleBands,
         TempoTap, TempoTapDegara, TempoTapMaxAgreement, TempoTapTicks

    /// Pitch
    case MultiPitchMelodia, PitchContours, PitchContoursMelody, PitchContoursMonoMelody,
         PitchContoursMultiMelody, PitchFilter, PitchMelodia, PitchSalienceFunction,
         PitchSalienceFunctionPeaks, PitchYin, PitchYinFFT, PredominantPitchMelodia, Vibrato

    /// Synthesis
    case HarmonicMask, HarmonicModelAnal, HprModelAnal, HpsModelAnal, ResampleFFT, SineModelAnal,
         SineModelSynth, SineSubtraction, SprModelAnal, SprModelSynth, SpsModelAnal, SpsModelSynth,
         StochasticModelAnal, StochasticModelSynth

    /// IO
    case AudioOnsetsMarker, VectorInput, VectorOutput

    /// Duration_Silence
    case Duration, EffectiveDuration, FadeDetection, SilenceRate, StartStopSilence

    /// Loudness_Dynamics
    case DynamicComplexity, Larm, Leq, LevelExtractor, Loudness, LoudnessEBUR128, LoudnessVickers,
         ReplayGain

    /// Filters
    case AllPass, BandPass, BandReject, DCRemoval, EqualLoudness, HighPass, IIR, LowPass, MaxFilter,
         MovingAverage

    /// Standard
    case AutoCorrelation, BPF, BinaryOperator, BinaryOperatorStream, Clipper, ConstantQ,
         CrossCorrelation, CubicSpline, DCT, Derivative, FFT, FFTC, FrameCutter, FrameToReal, IDCT,
         IFFT, IFFTC, MonoMixer, Multiplexer, NoiseAdder, OverlapAdd, PeakDetection, Scale, Slicer,
         Spline, StereoDemuxer, StereoMuxer, StereoTrimmer, Trimmer, UnaryOperator,
         UnaryOperatorStream, WarpedAutoCorrelation, Windowing, ZeroCrossingRate

    /// Spectral
    case BFCC, BarkBands, ERBBands, EnergyBand, EnergyBandRatio, FlatnessDB, Flux, FrequencyBands,
         GFCC, HFC, LPC, MFCC, MaxMagFreq, MelBands, Panning, PowerSpectrum, RollOff,
         SpectralCentroidTime, SpectralComplexity, SpectralContrast, SpectralPeaks,
         SpectralWhitening, Spectrum, SpectrumToCent, StrongPeak, TriangularBands,
         TriangularBarkBands

    /// Extractors
    case LowLevelSpectralEqloudExtractor, LowLevelSpectralExtractor

    /// Envelope_SFX
    case AfterMaxToBeforeMaxEnergyRatio, DerivativeSFX, Envelope, FlatnessSFX, LogAttackTime,
         MaxToTotal, MinToTotal, StrongDecay, TCToTotal

    /// Math
    case CartesianToPolar, Magnitude, PolarToCartesian

    /// Statistics
    case CentralMoments, Centroid, Crest, Decrease, DistributionShape, Energy, Entropy, Flatness,
         GeometricMean, InstantPower, Mean, Median, PowerMean, RMS, RawMoments, SingleGaussian,
         Variance

    /// Tonal
    case ChordsDescriptors, ChordsDetection, Chromagram, Dissonance, HPCP, HarmonicPeaks,
         HighResolutionFeatures, Inharmonicity, Key, KeyExtractor, OddToEvenHarmonicEnergyRatio,
         PitchSalience, SpectrumCQ, TonalExtractor, Tristimulus, TuningFrequency,
         TuningFrequencyExtractor

    /// Segmentation
    case SBic

    /// The set of all enumeration cases.
    public static let allIDs: Set<AlgorithmID> = [
       .BeatTrackerDegara, .BeatTrackerMultiFeature, .Beatogram, .BeatsLoudness, .BpmHistogram,
       .BpmHistogramDescriptors, .BpmRubato, .Danceability, .HarmonicBpm, .LoopBpmConfidence,
       .LoopBpmEstimator, .Meter, .NoveltyCurve, .OnsetDetection, .OnsetDetectionGlobal,
       .OnsetRate, .Onsets, .PercivalBpmEstimator, .PercivalEnhanceHarmonics,
       .PercivalEvaluatePulseTrains, .RhythmDescriptors, .RhythmExtractor, .RhythmExtractor2013,
       .RhythmTransform, .SingleBeatLoudness, .SuperFluxExtractor, .SuperFluxNovelty,
       .SuperFluxPeaks, .TempoScaleBands, .TempoTap, .TempoTapDegara, .TempoTapMaxAgreement,
       .TempoTapTicks, .MultiPitchMelodia, .PitchContours, .PitchContoursMelody,
       .PitchContoursMonoMelody, .PitchContoursMultiMelody, .PitchFilter, .PitchMelodia,
       .PitchSalienceFunction, .PitchSalienceFunctionPeaks, .PitchYin, .PitchYinFFT,
       .PredominantPitchMelodia, .Vibrato, .HarmonicMask, .HarmonicModelAnal, .HprModelAnal,
       .HpsModelAnal, .ResampleFFT, .SineModelAnal, .SineModelSynth, .SineSubtraction,
       .SprModelAnal, .SprModelSynth, .SpsModelAnal, .SpsModelSynth, .StochasticModelAnal,
       .StochasticModelSynth, .AudioOnsetsMarker, .VectorInput, .VectorOutput, .Duration,
       .EffectiveDuration, .FadeDetection, .SilenceRate, .StartStopSilence, .DynamicComplexity,
       .Larm, .Leq, .LevelExtractor, .Loudness, .LoudnessEBUR128, .LoudnessVickers, .ReplayGain,
       .AllPass, .BandPass, .BandReject, .DCRemoval, .EqualLoudness, .HighPass, .IIR, .LowPass,
       .MaxFilter, .MovingAverage, .AutoCorrelation, .BPF, .BinaryOperator, .BinaryOperatorStream,
       .Clipper, .ConstantQ, .CrossCorrelation, .CubicSpline, .DCT, .Derivative, .FFT, .FFTC,
       .FrameCutter, .FrameToReal, .IDCT, .IFFT, .IFFTC, .MonoMixer, .Multiplexer, .NoiseAdder,
       .OverlapAdd, .PeakDetection, .Scale, .Slicer, .Spline, .StereoDemuxer, .StereoMuxer,
       .StereoTrimmer, .Trimmer, .UnaryOperator, .UnaryOperatorStream, .WarpedAutoCorrelation,
       .Windowing, .ZeroCrossingRate, .BFCC, .BarkBands, .ERBBands, .EnergyBand, .EnergyBandRatio,
       .FlatnessDB, .Flux, .FrequencyBands, .GFCC, .HFC, .LPC, .MFCC, .MaxMagFreq, .MelBands,
       .Panning, .PowerSpectrum, .RollOff, .SpectralCentroidTime, .SpectralComplexity,
       .SpectralContrast, .SpectralPeaks, .SpectralWhitening, .Spectrum, .SpectrumToCent,
       .StrongPeak, .TriangularBands, .TriangularBarkBands, .LowLevelSpectralEqloudExtractor,
       .LowLevelSpectralExtractor, .AfterMaxToBeforeMaxEnergyRatio, .DerivativeSFX, .Envelope,
       .FlatnessSFX, .LogAttackTime, .MaxToTotal, .MinToTotal, .StrongDecay, .TCToTotal,
       .CartesianToPolar, .Magnitude, .PolarToCartesian, .CentralMoments, .Centroid, .Crest,
       .Decrease, .DistributionShape, .Energy, .Entropy, .Flatness, .GeometricMean, .InstantPower,
       .Mean, .Median, .PowerMean, .RMS, .RawMoments, .SingleGaussian, .Variance,
       .ChordsDescriptors, .ChordsDetection, .Chromagram, .Dissonance, .HPCP, .HarmonicPeaks,
       .HighResolutionFeatures, .Inharmonicity, .Key, .KeyExtractor, .OddToEvenHarmonicEnergyRatio,
       .PitchSalience, .SpectrumCQ, .TonalExtractor, .Tristimulus, .TuningFrequency,
       .TuningFrequencyExtractor, .SBic
    ]

    /// Function for retrieving the specification corresponding to the identifier.
    ///
    /// - Returns: The corresponding specification.
    public func spec<Spec:StreamingSpecification>() -> Spec.Type {
      switch self {
        case .BeatTrackerDegara: return Rhythm.BeatTrackerDegara.self as! Spec.Type
        case .BeatTrackerMultiFeature: return Rhythm.BeatTrackerMultiFeature.self as! Spec.Type
        case .Beatogram: return Rhythm.Beatogram.self as! Spec.Type
        case .BeatsLoudness: return Rhythm.BeatsLoudness.self as! Spec.Type
        case .BpmHistogram: return Rhythm.BpmHistogram.self as! Spec.Type
        case .BpmHistogramDescriptors: return Rhythm.BpmHistogramDescriptors.self as! Spec.Type
        case .BpmRubato: return Rhythm.BpmRubato.self as! Spec.Type
        case .Danceability: return Rhythm.Danceability.self as! Spec.Type
        case .HarmonicBpm: return Rhythm.HarmonicBpm.self as! Spec.Type
        case .LoopBpmConfidence: return Rhythm.LoopBpmConfidence.self as! Spec.Type
        case .LoopBpmEstimator: return Rhythm.LoopBpmEstimator.self as! Spec.Type
        case .Meter: return Rhythm.Meter.self as! Spec.Type
        case .NoveltyCurve: return Rhythm.NoveltyCurve.self as! Spec.Type
        case .OnsetDetection: return Rhythm.OnsetDetection.self as! Spec.Type
        case .OnsetDetectionGlobal: return Rhythm.OnsetDetectionGlobal.self as! Spec.Type
        case .OnsetRate: return Rhythm.OnsetRate.self as! Spec.Type
        case .Onsets: return Rhythm.Onsets.self as! Spec.Type
        case .PercivalBpmEstimator: return Rhythm.PercivalBpmEstimator.self as! Spec.Type
        case .PercivalEnhanceHarmonics: return Rhythm.PercivalEnhanceHarmonics.self as! Spec.Type
        case .PercivalEvaluatePulseTrains: return Rhythm.PercivalEvaluatePulseTrains.self as! Spec.Type
        case .RhythmDescriptors: return Rhythm.RhythmDescriptors.self as! Spec.Type
        case .RhythmExtractor: return Rhythm.RhythmExtractor.self as! Spec.Type
        case .RhythmExtractor2013: return Rhythm.RhythmExtractor2013.self as! Spec.Type
        case .RhythmTransform: return Rhythm.RhythmTransform.self as! Spec.Type
        case .SingleBeatLoudness: return Rhythm.SingleBeatLoudness.self as! Spec.Type
        case .SuperFluxExtractor: return Rhythm.SuperFluxExtractor.self as! Spec.Type
        case .SuperFluxNovelty: return Rhythm.SuperFluxNovelty.self as! Spec.Type
        case .SuperFluxPeaks: return Rhythm.SuperFluxPeaks.self as! Spec.Type
        case .TempoScaleBands: return Rhythm.TempoScaleBands.self as! Spec.Type
        case .TempoTap: return Rhythm.TempoTap.self as! Spec.Type
        case .TempoTapDegara: return Rhythm.TempoTapDegara.self as! Spec.Type
        case .TempoTapMaxAgreement: return Rhythm.TempoTapMaxAgreement.self as! Spec.Type
        case .TempoTapTicks: return Rhythm.TempoTapTicks.self as! Spec.Type
        case .MultiPitchMelodia: return Pitch.MultiPitchMelodia.self as! Spec.Type
        case .PitchContours: return Pitch.PitchContours.self as! Spec.Type
        case .PitchContoursMelody: return Pitch.PitchContoursMelody.self as! Spec.Type
        case .PitchContoursMonoMelody: return Pitch.PitchContoursMonoMelody.self as! Spec.Type
        case .PitchContoursMultiMelody: return Pitch.PitchContoursMultiMelody.self as! Spec.Type
        case .PitchFilter: return Pitch.PitchFilter.self as! Spec.Type
        case .PitchMelodia: return Pitch.PitchMelodia.self as! Spec.Type
        case .PitchSalienceFunction: return Pitch.PitchSalienceFunction.self as! Spec.Type
        case .PitchSalienceFunctionPeaks: return Pitch.PitchSalienceFunctionPeaks.self as! Spec.Type
        case .PitchYin: return Pitch.PitchYin.self as! Spec.Type
        case .PitchYinFFT: return Pitch.PitchYinFFT.self as! Spec.Type
        case .PredominantPitchMelodia: return Pitch.PredominantPitchMelodia.self as! Spec.Type
        case .Vibrato: return Pitch.Vibrato.self as! Spec.Type
        case .HarmonicMask: return Synthesis.HarmonicMask.self as! Spec.Type
        case .HarmonicModelAnal: return Synthesis.HarmonicModelAnal.self as! Spec.Type
        case .HprModelAnal: return Synthesis.HprModelAnal.self as! Spec.Type
        case .HpsModelAnal: return Synthesis.HpsModelAnal.self as! Spec.Type
        case .ResampleFFT: return Synthesis.ResampleFFT.self as! Spec.Type
        case .SineModelAnal: return Synthesis.SineModelAnal.self as! Spec.Type
        case .SineModelSynth: return Synthesis.SineModelSynth.self as! Spec.Type
        case .SineSubtraction: return Synthesis.SineSubtraction.self as! Spec.Type
        case .SprModelAnal: return Synthesis.SprModelAnal.self as! Spec.Type
        case .SprModelSynth: return Synthesis.SprModelSynth.self as! Spec.Type
        case .SpsModelAnal: return Synthesis.SpsModelAnal.self as! Spec.Type
        case .SpsModelSynth: return Synthesis.SpsModelSynth.self as! Spec.Type
        case .StochasticModelAnal: return Synthesis.StochasticModelAnal.self as! Spec.Type
        case .StochasticModelSynth: return Synthesis.StochasticModelSynth.self as! Spec.Type
        case .AudioOnsetsMarker: return IO.AudioOnsetsMarker.self as! Spec.Type
        case .VectorInput: return IO.VectorInput.self as! Spec.Type
        case .VectorOutput: return IO.VectorOutput.self as! Spec.Type
        case .Duration: return Duration_Silence.Duration.self as! Spec.Type
        case .EffectiveDuration: return Duration_Silence.EffectiveDuration.self as! Spec.Type
        case .FadeDetection: return Duration_Silence.FadeDetection.self as! Spec.Type
        case .SilenceRate: return Duration_Silence.SilenceRate.self as! Spec.Type
        case .StartStopSilence: return Duration_Silence.StartStopSilence.self as! Spec.Type
        case .DynamicComplexity: return Loudness_Dynamics.DynamicComplexity.self as! Spec.Type
        case .Larm: return Loudness_Dynamics.Larm.self as! Spec.Type
        case .Leq: return Loudness_Dynamics.Leq.self as! Spec.Type
        case .LevelExtractor: return Loudness_Dynamics.LevelExtractor.self as! Spec.Type
        case .Loudness: return Loudness_Dynamics.Loudness.self as! Spec.Type
        case .LoudnessEBUR128: return Loudness_Dynamics.LoudnessEBUR128.self as! Spec.Type
        case .LoudnessVickers: return Loudness_Dynamics.LoudnessVickers.self as! Spec.Type
        case .ReplayGain: return Loudness_Dynamics.ReplayGain.self as! Spec.Type
        case .AllPass: return Filters.AllPass.self as! Spec.Type
        case .BandPass: return Filters.BandPass.self as! Spec.Type
        case .BandReject: return Filters.BandReject.self as! Spec.Type
        case .DCRemoval: return Filters.DCRemoval.self as! Spec.Type
        case .EqualLoudness: return Filters.EqualLoudness.self as! Spec.Type
        case .HighPass: return Filters.HighPass.self as! Spec.Type
        case .IIR: return Filters.IIR.self as! Spec.Type
        case .LowPass: return Filters.LowPass.self as! Spec.Type
        case .MaxFilter: return Filters.MaxFilter.self as! Spec.Type
        case .MovingAverage: return Filters.MovingAverage.self as! Spec.Type
        case .AutoCorrelation: return Standard.AutoCorrelation.self as! Spec.Type
        case .BPF: return Standard.BPF.self as! Spec.Type
        case .BinaryOperator: return Standard.BinaryOperator.self as! Spec.Type
        case .BinaryOperatorStream: return Standard.BinaryOperatorStream.self as! Spec.Type
        case .Clipper: return Standard.Clipper.self as! Spec.Type
        case .ConstantQ: return Standard.ConstantQ.self as! Spec.Type
        case .CrossCorrelation: return Standard.CrossCorrelation.self as! Spec.Type
        case .CubicSpline: return Standard.CubicSpline.self as! Spec.Type
        case .DCT: return Standard.DCT.self as! Spec.Type
        case .Derivative: return Standard.Derivative.self as! Spec.Type
        case .FFT: return Standard.FFT.self as! Spec.Type
        case .FFTC: return Standard.FFTC.self as! Spec.Type
        case .FrameCutter: return Standard.FrameCutter.self as! Spec.Type
        case .FrameToReal: return Standard.FrameToReal.self as! Spec.Type
        case .IDCT: return Standard.IDCT.self as! Spec.Type
        case .IFFT: return Standard.IFFT.self as! Spec.Type
        case .IFFTC: return Standard.IFFTC.self as! Spec.Type
        case .MonoMixer: return Standard.MonoMixer.self as! Spec.Type
        case .Multiplexer: return Standard.Multiplexer.self as! Spec.Type
        case .NoiseAdder: return Standard.NoiseAdder.self as! Spec.Type
        case .OverlapAdd: return Standard.OverlapAdd.self as! Spec.Type
        case .PeakDetection: return Standard.PeakDetection.self as! Spec.Type
        case .Scale: return Standard.Scale.self as! Spec.Type
        case .Slicer: return Standard.Slicer.self as! Spec.Type
        case .Spline: return Standard.Spline.self as! Spec.Type
        case .StereoDemuxer: return Standard.StereoDemuxer.self as! Spec.Type
        case .StereoMuxer: return Standard.StereoMuxer.self as! Spec.Type
        case .StereoTrimmer: return Standard.StereoTrimmer.self as! Spec.Type
        case .Trimmer: return Standard.Trimmer.self as! Spec.Type
        case .UnaryOperator: return Standard.UnaryOperator.self as! Spec.Type
        case .UnaryOperatorStream: return Standard.UnaryOperatorStream.self as! Spec.Type
        case .WarpedAutoCorrelation: return Standard.WarpedAutoCorrelation.self as! Spec.Type
        case .Windowing: return Standard.Windowing.self as! Spec.Type
        case .ZeroCrossingRate: return Standard.ZeroCrossingRate.self as! Spec.Type
        case .BFCC: return Spectral.BFCC.self as! Spec.Type
        case .BarkBands: return Spectral.BarkBands.self as! Spec.Type
        case .ERBBands: return Spectral.ERBBands.self as! Spec.Type
        case .EnergyBand: return Spectral.EnergyBand.self as! Spec.Type
        case .EnergyBandRatio: return Spectral.EnergyBandRatio.self as! Spec.Type
        case .FlatnessDB: return Spectral.FlatnessDB.self as! Spec.Type
        case .Flux: return Spectral.Flux.self as! Spec.Type
        case .FrequencyBands: return Spectral.FrequencyBands.self as! Spec.Type
        case .GFCC: return Spectral.GFCC.self as! Spec.Type
        case .HFC: return Spectral.HFC.self as! Spec.Type
        case .LPC: return Spectral.LPC.self as! Spec.Type
        case .MFCC: return Spectral.MFCC.self as! Spec.Type
        case .MaxMagFreq: return Spectral.MaxMagFreq.self as! Spec.Type
        case .MelBands: return Spectral.MelBands.self as! Spec.Type
        case .Panning: return Spectral.Panning.self as! Spec.Type
        case .PowerSpectrum: return Spectral.PowerSpectrum.self as! Spec.Type
        case .RollOff: return Spectral.RollOff.self as! Spec.Type
        case .SpectralCentroidTime: return Spectral.SpectralCentroidTime.self as! Spec.Type
        case .SpectralComplexity: return Spectral.SpectralComplexity.self as! Spec.Type
        case .SpectralContrast: return Spectral.SpectralContrast.self as! Spec.Type
        case .SpectralPeaks: return Spectral.SpectralPeaks.self as! Spec.Type
        case .SpectralWhitening: return Spectral.SpectralWhitening.self as! Spec.Type
        case .Spectrum: return Spectral.Spectrum.self as! Spec.Type
        case .SpectrumToCent: return Spectral.SpectrumToCent.self as! Spec.Type
        case .StrongPeak: return Spectral.StrongPeak.self as! Spec.Type
        case .TriangularBands: return Spectral.TriangularBands.self as! Spec.Type
        case .TriangularBarkBands: return Spectral.TriangularBarkBands.self as! Spec.Type
        case .LowLevelSpectralEqloudExtractor: return Extractors.LowLevelSpectralEqloudExtractor.self as! Spec.Type
        case .LowLevelSpectralExtractor: return Extractors.LowLevelSpectralExtractor.self as! Spec.Type
        case .AfterMaxToBeforeMaxEnergyRatio: return Envelope_SFX.AfterMaxToBeforeMaxEnergyRatio.self as! Spec.Type
        case .DerivativeSFX: return Envelope_SFX.DerivativeSFX.self as! Spec.Type
        case .Envelope: return Envelope_SFX.Envelope.self as! Spec.Type
        case .FlatnessSFX: return Envelope_SFX.FlatnessSFX.self as! Spec.Type
        case .LogAttackTime: return Envelope_SFX.LogAttackTime.self as! Spec.Type
        case .MaxToTotal: return Envelope_SFX.MaxToTotal.self as! Spec.Type
        case .MinToTotal: return Envelope_SFX.MinToTotal.self as! Spec.Type
        case .StrongDecay: return Envelope_SFX.StrongDecay.self as! Spec.Type
        case .TCToTotal: return Envelope_SFX.TCToTotal.self as! Spec.Type
        case .CartesianToPolar: return Math.CartesianToPolar.self as! Spec.Type
        case .Magnitude: return Math.Magnitude.self as! Spec.Type
        case .PolarToCartesian: return Math.PolarToCartesian.self as! Spec.Type
        case .CentralMoments: return Statistics.CentralMoments.self as! Spec.Type
        case .Centroid: return Statistics.Centroid.self as! Spec.Type
        case .Crest: return Statistics.Crest.self as! Spec.Type
        case .Decrease: return Statistics.Decrease.self as! Spec.Type
        case .DistributionShape: return Statistics.DistributionShape.self as! Spec.Type
        case .Energy: return Statistics.Energy.self as! Spec.Type
        case .Entropy: return Statistics.Entropy.self as! Spec.Type
        case .Flatness: return Statistics.Flatness.self as! Spec.Type
        case .GeometricMean: return Statistics.GeometricMean.self as! Spec.Type
        case .InstantPower: return Statistics.InstantPower.self as! Spec.Type
        case .Mean: return Statistics.Mean.self as! Spec.Type
        case .Median: return Statistics.Median.self as! Spec.Type
        case .PowerMean: return Statistics.PowerMean.self as! Spec.Type
        case .RMS: return Statistics.RMS.self as! Spec.Type
        case .RawMoments: return Statistics.RawMoments.self as! Spec.Type
        case .SingleGaussian: return Statistics.SingleGaussian.self as! Spec.Type
        case .Variance: return Statistics.Variance.self as! Spec.Type
        case .ChordsDescriptors: return Tonal.ChordsDescriptors.self as! Spec.Type
        case .ChordsDetection: return Tonal.ChordsDetection.self as! Spec.Type
        case .Chromagram: return Tonal.Chromagram.self as! Spec.Type
        case .Dissonance: return Tonal.Dissonance.self as! Spec.Type
        case .HPCP: return Tonal.HPCP.self as! Spec.Type
        case .HarmonicPeaks: return Tonal.HarmonicPeaks.self as! Spec.Type
        case .HighResolutionFeatures: return Tonal.HighResolutionFeatures.self as! Spec.Type
        case .Inharmonicity: return Tonal.Inharmonicity.self as! Spec.Type
        case .Key: return Tonal.Key.self as! Spec.Type
        case .KeyExtractor: return Tonal.KeyExtractor.self as! Spec.Type
        case .OddToEvenHarmonicEnergyRatio: return Tonal.OddToEvenHarmonicEnergyRatio.self as! Spec.Type
        case .PitchSalience: return Tonal.PitchSalience.self as! Spec.Type
        case .SpectrumCQ: return Tonal.SpectrumCQ.self as! Spec.Type
        case .TonalExtractor: return Tonal.TonalExtractor.self as! Spec.Type
        case .Tristimulus: return Tonal.Tristimulus.self as! Spec.Type
        case .TuningFrequency: return Tonal.TuningFrequency.self as! Spec.Type
        case .TuningFrequencyExtractor: return Tonal.TuningFrequencyExtractor.self as! Spec.Type
        case .SBic: return Segmentation.SBic.self as! Spec.Type
      }
    }

  }

  /// A typealias for `Rhythm.BeatTrackerDegara` so that it can be used without knowing the category.
  public typealias BeatTrackerDegara = Rhythm.BeatTrackerDegara

  /// A typealias for `Rhythm.BeatTrackerMultiFeature` so that it can be used without knowing the category.
  public typealias BeatTrackerMultiFeature = Rhythm.BeatTrackerMultiFeature

  /// A typealias for `Rhythm.Beatogram` so that it can be used without knowing the category.
  public typealias Beatogram = Rhythm.Beatogram

  /// A typealias for `Rhythm.BeatsLoudness` so that it can be used without knowing the category.
  public typealias BeatsLoudness = Rhythm.BeatsLoudness

  /// A typealias for `Rhythm.BpmHistogram` so that it can be used without knowing the category.
  public typealias BpmHistogram = Rhythm.BpmHistogram

  /// A typealias for `Rhythm.BpmHistogramDescriptors` so that it can be used without knowing the category.
  public typealias BpmHistogramDescriptors = Rhythm.BpmHistogramDescriptors

  /// A typealias for `Rhythm.BpmRubato` so that it can be used without knowing the category.
  public typealias BpmRubato = Rhythm.BpmRubato

  /// A typealias for `Rhythm.Danceability` so that it can be used without knowing the category.
  public typealias Danceability = Rhythm.Danceability

  /// A typealias for `Rhythm.HarmonicBpm` so that it can be used without knowing the category.
  public typealias HarmonicBpm = Rhythm.HarmonicBpm

  /// A typealias for `Rhythm.LoopBpmConfidence` so that it can be used without knowing the category.
  public typealias LoopBpmConfidence = Rhythm.LoopBpmConfidence

  /// A typealias for `Rhythm.LoopBpmEstimator` so that it can be used without knowing the category.
  public typealias LoopBpmEstimator = Rhythm.LoopBpmEstimator

  /// A typealias for `Rhythm.Meter` so that it can be used without knowing the category.
  public typealias Meter = Rhythm.Meter

  /// A typealias for `Rhythm.NoveltyCurve` so that it can be used without knowing the category.
  public typealias NoveltyCurve = Rhythm.NoveltyCurve

  /// A typealias for `Rhythm.OnsetDetection` so that it can be used without knowing the category.
  public typealias OnsetDetection = Rhythm.OnsetDetection

  /// A typealias for `Rhythm.OnsetDetectionGlobal` so that it can be used without knowing the category.
  public typealias OnsetDetectionGlobal = Rhythm.OnsetDetectionGlobal

  /// A typealias for `Rhythm.OnsetRate` so that it can be used without knowing the category.
  public typealias OnsetRate = Rhythm.OnsetRate

  /// A typealias for `Rhythm.Onsets` so that it can be used without knowing the category.
  public typealias Onsets = Rhythm.Onsets

  /// A typealias for `Rhythm.PercivalBpmEstimator` so that it can be used without knowing the category.
  public typealias PercivalBpmEstimator = Rhythm.PercivalBpmEstimator

  /// A typealias for `Rhythm.PercivalEnhanceHarmonics` so that it can be used without knowing the category.
  public typealias PercivalEnhanceHarmonics = Rhythm.PercivalEnhanceHarmonics

  /// A typealias for `Rhythm.PercivalEvaluatePulseTrains` so that it can be used without knowing the category.
  public typealias PercivalEvaluatePulseTrains = Rhythm.PercivalEvaluatePulseTrains

  /// A typealias for `Rhythm.RhythmDescriptors` so that it can be used without knowing the category.
  public typealias RhythmDescriptors = Rhythm.RhythmDescriptors

  /// A typealias for `Rhythm.RhythmExtractor` so that it can be used without knowing the category.
  public typealias RhythmExtractor = Rhythm.RhythmExtractor

  /// A typealias for `Rhythm.RhythmExtractor2013` so that it can be used without knowing the category.
  public typealias RhythmExtractor2013 = Rhythm.RhythmExtractor2013

  /// A typealias for `Rhythm.RhythmTransform` so that it can be used without knowing the category.
  public typealias RhythmTransform = Rhythm.RhythmTransform

  /// A typealias for `Rhythm.SingleBeatLoudness` so that it can be used without knowing the category.
  public typealias SingleBeatLoudness = Rhythm.SingleBeatLoudness

  /// A typealias for `Rhythm.SuperFluxExtractor` so that it can be used without knowing the category.
  public typealias SuperFluxExtractor = Rhythm.SuperFluxExtractor

  /// A typealias for `Rhythm.SuperFluxNovelty` so that it can be used without knowing the category.
  public typealias SuperFluxNovelty = Rhythm.SuperFluxNovelty

  /// A typealias for `Rhythm.SuperFluxPeaks` so that it can be used without knowing the category.
  public typealias SuperFluxPeaks = Rhythm.SuperFluxPeaks

  /// A typealias for `Rhythm.TempoScaleBands` so that it can be used without knowing the category.
  public typealias TempoScaleBands = Rhythm.TempoScaleBands

  /// A typealias for `Rhythm.TempoTap` so that it can be used without knowing the category.
  public typealias TempoTap = Rhythm.TempoTap

  /// A typealias for `Rhythm.TempoTapDegara` so that it can be used without knowing the category.
  public typealias TempoTapDegara = Rhythm.TempoTapDegara

  /// A typealias for `Rhythm.TempoTapMaxAgreement` so that it can be used without knowing the category.
  public typealias TempoTapMaxAgreement = Rhythm.TempoTapMaxAgreement

  /// A typealias for `Rhythm.TempoTapTicks` so that it can be used without knowing the category.
  public typealias TempoTapTicks = Rhythm.TempoTapTicks

  /// A typealias for `Pitch.MultiPitchMelodia` so that it can be used without knowing the category.
  public typealias MultiPitchMelodia = Pitch.MultiPitchMelodia

  /// A typealias for `Pitch.PitchContours` so that it can be used without knowing the category.
  public typealias PitchContours = Pitch.PitchContours

  /// A typealias for `Pitch.PitchContoursMelody` so that it can be used without knowing the category.
  public typealias PitchContoursMelody = Pitch.PitchContoursMelody

  /// A typealias for `Pitch.PitchContoursMonoMelody` so that it can be used without knowing the category.
  public typealias PitchContoursMonoMelody = Pitch.PitchContoursMonoMelody

  /// A typealias for `Pitch.PitchContoursMultiMelody` so that it can be used without knowing the category.
  public typealias PitchContoursMultiMelody = Pitch.PitchContoursMultiMelody

  /// A typealias for `Pitch.PitchFilter` so that it can be used without knowing the category.
  public typealias PitchFilter = Pitch.PitchFilter

  /// A typealias for `Pitch.PitchMelodia` so that it can be used without knowing the category.
  public typealias PitchMelodia = Pitch.PitchMelodia

  /// A typealias for `Pitch.PitchSalienceFunction` so that it can be used without knowing the category.
  public typealias PitchSalienceFunction = Pitch.PitchSalienceFunction

  /// A typealias for `Pitch.PitchSalienceFunctionPeaks` so that it can be used without knowing the category.
  public typealias PitchSalienceFunctionPeaks = Pitch.PitchSalienceFunctionPeaks

  /// A typealias for `Pitch.PitchYin` so that it can be used without knowing the category.
  public typealias PitchYin = Pitch.PitchYin

  /// A typealias for `Pitch.PitchYinFFT` so that it can be used without knowing the category.
  public typealias PitchYinFFT = Pitch.PitchYinFFT

  /// A typealias for `Pitch.PredominantPitchMelodia` so that it can be used without knowing the category.
  public typealias PredominantPitchMelodia = Pitch.PredominantPitchMelodia

  /// A typealias for `Pitch.Vibrato` so that it can be used without knowing the category.
  public typealias Vibrato = Pitch.Vibrato

  /// A typealias for `Synthesis.HarmonicMask` so that it can be used without knowing the category.
  public typealias HarmonicMask = Synthesis.HarmonicMask

  /// A typealias for `Synthesis.HarmonicModelAnal` so that it can be used without knowing the category.
  public typealias HarmonicModelAnal = Synthesis.HarmonicModelAnal

  /// A typealias for `Synthesis.HprModelAnal` so that it can be used without knowing the category.
  public typealias HprModelAnal = Synthesis.HprModelAnal

  /// A typealias for `Synthesis.HpsModelAnal` so that it can be used without knowing the category.
  public typealias HpsModelAnal = Synthesis.HpsModelAnal

  /// A typealias for `Synthesis.ResampleFFT` so that it can be used without knowing the category.
  public typealias ResampleFFT = Synthesis.ResampleFFT

  /// A typealias for `Synthesis.SineModelAnal` so that it can be used without knowing the category.
  public typealias SineModelAnal = Synthesis.SineModelAnal

  /// A typealias for `Synthesis.SineModelSynth` so that it can be used without knowing the category.
  public typealias SineModelSynth = Synthesis.SineModelSynth

  /// A typealias for `Synthesis.SineSubtraction` so that it can be used without knowing the category.
  public typealias SineSubtraction = Synthesis.SineSubtraction

  /// A typealias for `Synthesis.SprModelAnal` so that it can be used without knowing the category.
  public typealias SprModelAnal = Synthesis.SprModelAnal

  /// A typealias for `Synthesis.SprModelSynth` so that it can be used without knowing the category.
  public typealias SprModelSynth = Synthesis.SprModelSynth

  /// A typealias for `Synthesis.SpsModelAnal` so that it can be used without knowing the category.
  public typealias SpsModelAnal = Synthesis.SpsModelAnal

  /// A typealias for `Synthesis.SpsModelSynth` so that it can be used without knowing the category.
  public typealias SpsModelSynth = Synthesis.SpsModelSynth

  /// A typealias for `Synthesis.StochasticModelAnal` so that it can be used without knowing the category.
  public typealias StochasticModelAnal = Synthesis.StochasticModelAnal

  /// A typealias for `Synthesis.StochasticModelSynth` so that it can be used without knowing the category.
  public typealias StochasticModelSynth = Synthesis.StochasticModelSynth

  /// A typealias for `IO.AudioOnsetsMarker` so that it can be used without knowing the category.
  public typealias AudioOnsetsMarker = IO.AudioOnsetsMarker

  /// A typealias for `IO.VectorInput` so that it can be used without knowing the category.
  public typealias VectorInput = IO.VectorInput

  /// A typealias for `IO.VectorOutput` so that it can be used without knowing the category.
  public typealias VectorOutput = IO.VectorOutput

  /// A typealias for `Duration_Silence.Duration` so that it can be used without knowing the category.
  public typealias Duration = Duration_Silence.Duration

  /// A typealias for `Duration_Silence.EffectiveDuration` so that it can be used without knowing the category.
  public typealias EffectiveDuration = Duration_Silence.EffectiveDuration

  /// A typealias for `Duration_Silence.FadeDetection` so that it can be used without knowing the category.
  public typealias FadeDetection = Duration_Silence.FadeDetection

  /// A typealias for `Duration_Silence.SilenceRate` so that it can be used without knowing the category.
  public typealias SilenceRate = Duration_Silence.SilenceRate

  /// A typealias for `Duration_Silence.StartStopSilence` so that it can be used without knowing the category.
  public typealias StartStopSilence = Duration_Silence.StartStopSilence

  /// A typealias for `Loudness_Dynamics.DynamicComplexity` so that it can be used without knowing the category.
  public typealias DynamicComplexity = Loudness_Dynamics.DynamicComplexity

  /// A typealias for `Loudness_Dynamics.Larm` so that it can be used without knowing the category.
  public typealias Larm = Loudness_Dynamics.Larm

  /// A typealias for `Loudness_Dynamics.Leq` so that it can be used without knowing the category.
  public typealias Leq = Loudness_Dynamics.Leq

  /// A typealias for `Loudness_Dynamics.LevelExtractor` so that it can be used without knowing the category.
  public typealias LevelExtractor = Loudness_Dynamics.LevelExtractor

  /// A typealias for `Loudness_Dynamics.Loudness` so that it can be used without knowing the category.
  public typealias Loudness = Loudness_Dynamics.Loudness

  /// A typealias for `Loudness_Dynamics.LoudnessEBUR128` so that it can be used without knowing the category.
  public typealias LoudnessEBUR128 = Loudness_Dynamics.LoudnessEBUR128

  /// A typealias for `Loudness_Dynamics.LoudnessVickers` so that it can be used without knowing the category.
  public typealias LoudnessVickers = Loudness_Dynamics.LoudnessVickers

  /// A typealias for `Loudness_Dynamics.ReplayGain` so that it can be used without knowing the category.
  public typealias ReplayGain = Loudness_Dynamics.ReplayGain

  /// A typealias for `Filters.AllPass` so that it can be used without knowing the category.
  public typealias AllPass = Filters.AllPass

  /// A typealias for `Filters.BandPass` so that it can be used without knowing the category.
  public typealias BandPass = Filters.BandPass

  /// A typealias for `Filters.BandReject` so that it can be used without knowing the category.
  public typealias BandReject = Filters.BandReject

  /// A typealias for `Filters.DCRemoval` so that it can be used without knowing the category.
  public typealias DCRemoval = Filters.DCRemoval

  /// A typealias for `Filters.EqualLoudness` so that it can be used without knowing the category.
  public typealias EqualLoudness = Filters.EqualLoudness

  /// A typealias for `Filters.HighPass` so that it can be used without knowing the category.
  public typealias HighPass = Filters.HighPass

  /// A typealias for `Filters.IIR` so that it can be used without knowing the category.
  public typealias IIR = Filters.IIR

  /// A typealias for `Filters.LowPass` so that it can be used without knowing the category.
  public typealias LowPass = Filters.LowPass

  /// A typealias for `Filters.MaxFilter` so that it can be used without knowing the category.
  public typealias MaxFilter = Filters.MaxFilter

  /// A typealias for `Filters.MovingAverage` so that it can be used without knowing the category.
  public typealias MovingAverage = Filters.MovingAverage

  /// A typealias for `Standard.AutoCorrelation` so that it can be used without knowing the category.
  public typealias AutoCorrelation = Standard.AutoCorrelation

  /// A typealias for `Standard.BPF` so that it can be used without knowing the category.
  public typealias BPF = Standard.BPF

  /// A typealias for `Standard.BinaryOperator` so that it can be used without knowing the category.
  public typealias BinaryOperator = Standard.BinaryOperator

  /// A typealias for `Standard.BinaryOperatorStream` so that it can be used without knowing the category.
  public typealias BinaryOperatorStream = Standard.BinaryOperatorStream

  /// A typealias for `Standard.Clipper` so that it can be used without knowing the category.
  public typealias Clipper = Standard.Clipper

  /// A typealias for `Standard.ConstantQ` so that it can be used without knowing the category.
  public typealias ConstantQ = Standard.ConstantQ

  /// A typealias for `Standard.CrossCorrelation` so that it can be used without knowing the category.
  public typealias CrossCorrelation = Standard.CrossCorrelation

  /// A typealias for `Standard.CubicSpline` so that it can be used without knowing the category.
  public typealias CubicSpline = Standard.CubicSpline

  /// A typealias for `Standard.DCT` so that it can be used without knowing the category.
  public typealias DCT = Standard.DCT

  /// A typealias for `Standard.Derivative` so that it can be used without knowing the category.
  public typealias Derivative = Standard.Derivative

  /// A typealias for `Standard.FFT` so that it can be used without knowing the category.
  public typealias FFT = Standard.FFT

  /// A typealias for `Standard.FFTC` so that it can be used without knowing the category.
  public typealias FFTC = Standard.FFTC

  /// A typealias for `Standard.FrameCutter` so that it can be used without knowing the category.
  public typealias FrameCutter = Standard.FrameCutter

  /// A typealias for `Standard.FrameToReal` so that it can be used without knowing the category.
  public typealias FrameToReal = Standard.FrameToReal

  /// A typealias for `Standard.IDCT` so that it can be used without knowing the category.
  public typealias IDCT = Standard.IDCT

  /// A typealias for `Standard.IFFT` so that it can be used without knowing the category.
  public typealias IFFT = Standard.IFFT

  /// A typealias for `Standard.IFFTC` so that it can be used without knowing the category.
  public typealias IFFTC = Standard.IFFTC

  /// A typealias for `Standard.MonoMixer` so that it can be used without knowing the category.
  public typealias MonoMixer = Standard.MonoMixer

  /// A typealias for `Standard.Multiplexer` so that it can be used without knowing the category.
  public typealias Multiplexer = Standard.Multiplexer

  /// A typealias for `Standard.NoiseAdder` so that it can be used without knowing the category.
  public typealias NoiseAdder = Standard.NoiseAdder

  /// A typealias for `Standard.OverlapAdd` so that it can be used without knowing the category.
  public typealias OverlapAdd = Standard.OverlapAdd

  /// A typealias for `Standard.PeakDetection` so that it can be used without knowing the category.
  public typealias PeakDetection = Standard.PeakDetection

  /// A typealias for `Standard.Scale` so that it can be used without knowing the category.
  public typealias Scale = Standard.Scale

  /// A typealias for `Standard.Slicer` so that it can be used without knowing the category.
  public typealias Slicer = Standard.Slicer

  /// A typealias for `Standard.Spline` so that it can be used without knowing the category.
  public typealias Spline = Standard.Spline

  /// A typealias for `Standard.StereoDemuxer` so that it can be used without knowing the category.
  public typealias StereoDemuxer = Standard.StereoDemuxer

  /// A typealias for `Standard.StereoMuxer` so that it can be used without knowing the category.
  public typealias StereoMuxer = Standard.StereoMuxer

  /// A typealias for `Standard.StereoTrimmer` so that it can be used without knowing the category.
  public typealias StereoTrimmer = Standard.StereoTrimmer

  /// A typealias for `Standard.Trimmer` so that it can be used without knowing the category.
  public typealias Trimmer = Standard.Trimmer

  /// A typealias for `Standard.UnaryOperator` so that it can be used without knowing the category.
  public typealias UnaryOperator = Standard.UnaryOperator

  /// A typealias for `Standard.UnaryOperatorStream` so that it can be used without knowing the category.
  public typealias UnaryOperatorStream = Standard.UnaryOperatorStream

  /// A typealias for `Standard.WarpedAutoCorrelation` so that it can be used without knowing the category.
  public typealias WarpedAutoCorrelation = Standard.WarpedAutoCorrelation

  /// A typealias for `Standard.Windowing` so that it can be used without knowing the category.
  public typealias Windowing = Standard.Windowing

  /// A typealias for `Standard.ZeroCrossingRate` so that it can be used without knowing the category.
  public typealias ZeroCrossingRate = Standard.ZeroCrossingRate

  /// A typealias for `Spectral.BFCC` so that it can be used without knowing the category.
  public typealias BFCC = Spectral.BFCC

  /// A typealias for `Spectral.BarkBands` so that it can be used without knowing the category.
  public typealias BarkBands = Spectral.BarkBands

  /// A typealias for `Spectral.ERBBands` so that it can be used without knowing the category.
  public typealias ERBBands = Spectral.ERBBands

  /// A typealias for `Spectral.EnergyBand` so that it can be used without knowing the category.
  public typealias EnergyBand = Spectral.EnergyBand

  /// A typealias for `Spectral.EnergyBandRatio` so that it can be used without knowing the category.
  public typealias EnergyBandRatio = Spectral.EnergyBandRatio

  /// A typealias for `Spectral.FlatnessDB` so that it can be used without knowing the category.
  public typealias FlatnessDB = Spectral.FlatnessDB

  /// A typealias for `Spectral.Flux` so that it can be used without knowing the category.
  public typealias Flux = Spectral.Flux

  /// A typealias for `Spectral.FrequencyBands` so that it can be used without knowing the category.
  public typealias FrequencyBands = Spectral.FrequencyBands

  /// A typealias for `Spectral.GFCC` so that it can be used without knowing the category.
  public typealias GFCC = Spectral.GFCC

  /// A typealias for `Spectral.HFC` so that it can be used without knowing the category.
  public typealias HFC = Spectral.HFC

  /// A typealias for `Spectral.LPC` so that it can be used without knowing the category.
  public typealias LPC = Spectral.LPC

  /// A typealias for `Spectral.MFCC` so that it can be used without knowing the category.
  public typealias MFCC = Spectral.MFCC

  /// A typealias for `Spectral.MaxMagFreq` so that it can be used without knowing the category.
  public typealias MaxMagFreq = Spectral.MaxMagFreq

  /// A typealias for `Spectral.MelBands` so that it can be used without knowing the category.
  public typealias MelBands = Spectral.MelBands

  /// A typealias for `Spectral.Panning` so that it can be used without knowing the category.
  public typealias Panning = Spectral.Panning

  /// A typealias for `Spectral.PowerSpectrum` so that it can be used without knowing the category.
  public typealias PowerSpectrum = Spectral.PowerSpectrum

  /// A typealias for `Spectral.RollOff` so that it can be used without knowing the category.
  public typealias RollOff = Spectral.RollOff

  /// A typealias for `Spectral.SpectralCentroidTime` so that it can be used without knowing the category.
  public typealias SpectralCentroidTime = Spectral.SpectralCentroidTime

  /// A typealias for `Spectral.SpectralComplexity` so that it can be used without knowing the category.
  public typealias SpectralComplexity = Spectral.SpectralComplexity

  /// A typealias for `Spectral.SpectralContrast` so that it can be used without knowing the category.
  public typealias SpectralContrast = Spectral.SpectralContrast

  /// A typealias for `Spectral.SpectralPeaks` so that it can be used without knowing the category.
  public typealias SpectralPeaks = Spectral.SpectralPeaks

  /// A typealias for `Spectral.SpectralWhitening` so that it can be used without knowing the category.
  public typealias SpectralWhitening = Spectral.SpectralWhitening

  /// A typealias for `Spectral.Spectrum` so that it can be used without knowing the category.
  public typealias Spectrum = Spectral.Spectrum

  /// A typealias for `Spectral.SpectrumToCent` so that it can be used without knowing the category.
  public typealias SpectrumToCent = Spectral.SpectrumToCent

  /// A typealias for `Spectral.StrongPeak` so that it can be used without knowing the category.
  public typealias StrongPeak = Spectral.StrongPeak

  /// A typealias for `Spectral.TriangularBands` so that it can be used without knowing the category.
  public typealias TriangularBands = Spectral.TriangularBands

  /// A typealias for `Spectral.TriangularBarkBands` so that it can be used without knowing the category.
  public typealias TriangularBarkBands = Spectral.TriangularBarkBands

  /// A typealias for `Extractors.LowLevelSpectralEqloudExtractor` so that it can be used without knowing the category.
  public typealias LowLevelSpectralEqloudExtractor = Extractors.LowLevelSpectralEqloudExtractor

  /// A typealias for `Extractors.LowLevelSpectralExtractor` so that it can be used without knowing the category.
  public typealias LowLevelSpectralExtractor = Extractors.LowLevelSpectralExtractor

  /// A typealias for `Envelope_SFX.AfterMaxToBeforeMaxEnergyRatio` so that it can be used without knowing the category.
  public typealias AfterMaxToBeforeMaxEnergyRatio = Envelope_SFX.AfterMaxToBeforeMaxEnergyRatio

  /// A typealias for `Envelope_SFX.DerivativeSFX` so that it can be used without knowing the category.
  public typealias DerivativeSFX = Envelope_SFX.DerivativeSFX

  /// A typealias for `Envelope_SFX.Envelope` so that it can be used without knowing the category.
  public typealias Envelope = Envelope_SFX.Envelope

  /// A typealias for `Envelope_SFX.FlatnessSFX` so that it can be used without knowing the category.
  public typealias FlatnessSFX = Envelope_SFX.FlatnessSFX

  /// A typealias for `Envelope_SFX.LogAttackTime` so that it can be used without knowing the category.
  public typealias LogAttackTime = Envelope_SFX.LogAttackTime

  /// A typealias for `Envelope_SFX.MaxToTotal` so that it can be used without knowing the category.
  public typealias MaxToTotal = Envelope_SFX.MaxToTotal

  /// A typealias for `Envelope_SFX.MinToTotal` so that it can be used without knowing the category.
  public typealias MinToTotal = Envelope_SFX.MinToTotal

  /// A typealias for `Envelope_SFX.StrongDecay` so that it can be used without knowing the category.
  public typealias StrongDecay = Envelope_SFX.StrongDecay

  /// A typealias for `Envelope_SFX.TCToTotal` so that it can be used without knowing the category.
  public typealias TCToTotal = Envelope_SFX.TCToTotal

  /// A typealias for `Math.CartesianToPolar` so that it can be used without knowing the category.
  public typealias CartesianToPolar = Math.CartesianToPolar

  /// A typealias for `Math.Magnitude` so that it can be used without knowing the category.
  public typealias Magnitude = Math.Magnitude

  /// A typealias for `Math.PolarToCartesian` so that it can be used without knowing the category.
  public typealias PolarToCartesian = Math.PolarToCartesian

  /// A typealias for `Statistics.CentralMoments` so that it can be used without knowing the category.
  public typealias CentralMoments = Statistics.CentralMoments

  /// A typealias for `Statistics.Centroid` so that it can be used without knowing the category.
  public typealias Centroid = Statistics.Centroid

  /// A typealias for `Statistics.Crest` so that it can be used without knowing the category.
  public typealias Crest = Statistics.Crest

  /// A typealias for `Statistics.Decrease` so that it can be used without knowing the category.
  public typealias Decrease = Statistics.Decrease

  /// A typealias for `Statistics.DistributionShape` so that it can be used without knowing the category.
  public typealias DistributionShape = Statistics.DistributionShape

  /// A typealias for `Statistics.Energy` so that it can be used without knowing the category.
  public typealias Energy = Statistics.Energy

  /// A typealias for `Statistics.Entropy` so that it can be used without knowing the category.
  public typealias Entropy = Statistics.Entropy

  /// A typealias for `Statistics.Flatness` so that it can be used without knowing the category.
  public typealias Flatness = Statistics.Flatness

  /// A typealias for `Statistics.GeometricMean` so that it can be used without knowing the category.
  public typealias GeometricMean = Statistics.GeometricMean

  /// A typealias for `Statistics.InstantPower` so that it can be used without knowing the category.
  public typealias InstantPower = Statistics.InstantPower

  /// A typealias for `Statistics.Mean` so that it can be used without knowing the category.
  public typealias Mean = Statistics.Mean

  /// A typealias for `Statistics.Median` so that it can be used without knowing the category.
  public typealias Median = Statistics.Median

  /// A typealias for `Statistics.PowerMean` so that it can be used without knowing the category.
  public typealias PowerMean = Statistics.PowerMean

  /// A typealias for `Statistics.RMS` so that it can be used without knowing the category.
  public typealias RMS = Statistics.RMS

  /// A typealias for `Statistics.RawMoments` so that it can be used without knowing the category.
  public typealias RawMoments = Statistics.RawMoments

  /// A typealias for `Statistics.SingleGaussian` so that it can be used without knowing the category.
  public typealias SingleGaussian = Statistics.SingleGaussian

  /// A typealias for `Statistics.Variance` so that it can be used without knowing the category.
  public typealias Variance = Statistics.Variance

  /// A typealias for `Tonal.ChordsDescriptors` so that it can be used without knowing the category.
  public typealias ChordsDescriptors = Tonal.ChordsDescriptors

  /// A typealias for `Tonal.ChordsDetection` so that it can be used without knowing the category.
  public typealias ChordsDetection = Tonal.ChordsDetection

  /// A typealias for `Tonal.Chromagram` so that it can be used without knowing the category.
  public typealias Chromagram = Tonal.Chromagram

  /// A typealias for `Tonal.Dissonance` so that it can be used without knowing the category.
  public typealias Dissonance = Tonal.Dissonance

  /// A typealias for `Tonal.HPCP` so that it can be used without knowing the category.
  public typealias HPCP = Tonal.HPCP

  /// A typealias for `Tonal.HarmonicPeaks` so that it can be used without knowing the category.
  public typealias HarmonicPeaks = Tonal.HarmonicPeaks

  /// A typealias for `Tonal.HighResolutionFeatures` so that it can be used without knowing the category.
  public typealias HighResolutionFeatures = Tonal.HighResolutionFeatures

  /// A typealias for `Tonal.Inharmonicity` so that it can be used without knowing the category.
  public typealias Inharmonicity = Tonal.Inharmonicity

  /// A typealias for `Tonal.Key` so that it can be used without knowing the category.
  public typealias Key = Tonal.Key

  /// A typealias for `Tonal.KeyExtractor` so that it can be used without knowing the category.
  public typealias KeyExtractor = Tonal.KeyExtractor

  /// A typealias for `Tonal.OddToEvenHarmonicEnergyRatio` so that it can be used without knowing the category.
  public typealias OddToEvenHarmonicEnergyRatio = Tonal.OddToEvenHarmonicEnergyRatio

  /// A typealias for `Tonal.PitchSalience` so that it can be used without knowing the category.
  public typealias PitchSalience = Tonal.PitchSalience

  /// A typealias for `Tonal.SpectrumCQ` so that it can be used without knowing the category.
  public typealias SpectrumCQ = Tonal.SpectrumCQ

  /// A typealias for `Tonal.TonalExtractor` so that it can be used without knowing the category.
  public typealias TonalExtractor = Tonal.TonalExtractor

  /// A typealias for `Tonal.Tristimulus` so that it can be used without knowing the category.
  public typealias Tristimulus = Tonal.Tristimulus

  /// A typealias for `Tonal.TuningFrequency` so that it can be used without knowing the category.
  public typealias TuningFrequency = Tonal.TuningFrequency

  /// A typealias for `Tonal.TuningFrequencyExtractor` so that it can be used without knowing the category.
  public typealias TuningFrequencyExtractor = Tonal.TuningFrequencyExtractor

  /// A typealias for `Segmentation.SBic` so that it can be used without knowing the category.
  public typealias SBic = Segmentation.SBic

}
