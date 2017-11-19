//
//  main.swift
//  PitchAnalysis
//
//  Created by Jason Cardwell on 11/17/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
import Foundation
import Essentia
import Docopt

infix operator >>
infix operator >|
postfix operator >>|
postfix operator >>>

let labels = [
  "Monophonic Pitch Estimation (Yin FFT)",
  "Monophonic Pitch Estimation (Melodia)",
  "Monophonic Note Transcription",
  "Multi-Pitch Estimation (Klapuri)",
  "Multi-Pitch Estimation (Melodia)",
  "Predominant-Pitch Estimation (Melodia)"
]

let usage = """
Pitch Analysis.

Usage: pitchanalysis <algorithm> <input> [--output <output>]
       pitchanalysis -h | --help

Arguments:
  <algorithm>  The index of the algorithm with which to analyze <input>. The available algorithms
               are as follows:
                0: \(labels[0])
                1: \(labels[1])
                2: \(labels[2])
                3: \(labels[3])
                4: \(labels[4])
                5: \(labels[5])
  <input>      The path to the audio file to analyze.
  <output>     Optional output file.

Options:
  -h, --help  Show this help message and exit.
"""

let arguments = Docopt.parse(usage, argv: Array(CommandLine.arguments.dropFirst()), help: true)

guard let algorithmString = arguments["<algorithm>"] as? String else {
  print(usage)
  exit(EXIT_FAILURE)
}

let selectedAlgorithm: Int

switch algorithmString {
  case "0": selectedAlgorithm = 0
  case "1": selectedAlgorithm = 1
  case "2": selectedAlgorithm = 2
  case "3": selectedAlgorithm = 3
  case "4": selectedAlgorithm = 4
  case "5": selectedAlgorithm = 5
  default:
    print(usage)
    exit(EXIT_FAILURE)
}

guard let filePath = arguments["<input>"] as? String else {
  print(usage)
  exit(EXIT_FAILURE)
}

let url = URL(fileURLWithPath: filePath)

let signal: [Float]

do {
  guard try url.checkResourceIsReachable() else {
    print("Failed to locate file '\(url.lastPathComponent)'")
    exit(EXIT_FAILURE)
  }
  signal = try monoBufferData(url: url)
} catch {
  print("Failed to locate file '\(url.lastPathComponent)'")
  exit(EXIT_FAILURE)
}


print("\(labels[selectedAlgorithm]) analysis of file '\(url.lastPathComponent)':")

let frameSize = 2048
let hopSize = 128
let sampleRate: Float = 44100
let timeIncrement = Float(hopSize) / sampleRate
let columnWidth = 18

func print(_ pitches: [[Float]]) {

  let columnWidths = printBoxTop(labels: ["Time (s)", "Pitch (Hz)"], minColumnWidth: columnWidth)

  for index in pitches.indices {

    let time = Float(index) * timeIncrement

    for pitch in pitches[index] {
      printBoxRow(values: [time, pitch], columnWidths: columnWidths)
    }

  }

  printBoxBottom(columnWidths: columnWidths)

}

func print(_ trios: Zip3Sequence<[Float], [Float], [Float]>) {

  let columnWidths = printBoxTop(labels: ["Onset (s)", "Duration (s)", "MIDI Pitch"],
                                 minColumnWidth: columnWidth)

  for (onset, duration, midiPitch) in trios {

    printBoxRow(values: [onset, duration, midiPitch], columnWidths: columnWidths)

  }

  printBoxBottom(columnWidths: columnWidths)

}

func print(_ enumeratedTuples: EnumeratedSequence<Zip2Sequence<[Float], [Float]>>) {

  let columnWidths = printBoxTop(labels: ["Time (s)", "Pitch (Hz)", "Confidence"],
                                 minColumnWidth: columnWidth)

  for (index, (pitch, pitchConfidence)) in enumeratedTuples {

    let time = Float(index) * timeIncrement

    printBoxRow(values: [time, pitch, pitchConfidence], columnWidths: columnWidths)

  }

  printBoxBottom(columnWidths: columnWidths)

}

switch selectedAlgorithm {

case 0:

  let vectorInput = VectorInput<Float>(signal)

  let frameCutter = StreamingAlgorithm<Streaming.FrameCutter>([
    .frameSize: 2048,
    .hopSize: 128,
    .startFromZero: false
    ])

  let windowing = StreamingAlgorithm<Streaming.Windowing>([.type: "hann", .zeroPadding: 0])

  let spectrum = StreamingAlgorithm<Streaming.Spectrum>([.size: 2048])

  let pitchDetect = StreamingAlgorithm<Streaming.PitchYinFFT>([
    .frameSize: 2048,
    .sampleRate: 44100
    ])

  let pool = Pool()

  vectorInput[output: .data] >> frameCutter[input: .signal]
  frameCutter[output: .frame] >> windowing[input: .frame]
  windowing[output: .frame] >> spectrum[input: .frame]
  spectrum[output: .spectrum] >> pitchDetect[input: .spectrum]
  pitchDetect[output: .pitch] >> pool[input: "pitch"]
  pitchDetect[output: .pitchConfidence] >> pool[input: "pitchConfidence"]

  let network = Network(generator: vectorInput)
  network.run()

  print(zip(pool[realVec: "pitch"], pool[realVec: "pitchConfidence"]).enumerated())

case 1:

  let pitchDetect = StandardAlgorithm<Standard.PitchMelodia>([
    .sampleRate: 44100,
    .hopSize: 128,
    .frameSize: 2048
    ])

  pitchDetect[realVecInput: .signal] = signal

  pitchDetect.compute()

  print(zip(pitchDetect[realVecOutput: .pitch],
            pitchDetect[realVecOutput: .pitchConfidence]).enumerated())

case 2:


  let pitchDetect = StandardAlgorithm<Standard.PitchMelodia>([
    .sampleRate: 44100,
    .hopSize: 128,
    .frameSize: 2048
    ])

  let noteSeg = StandardAlgorithm<Standard.PitchContourSegmentation>([
    .sampleRate: 44100,
    .hopSize: 128
    ])

  pitchDetect[realVecInput: .signal] = signal
  pitchDetect[output: .pitch] >> noteSeg[input: .pitch]
  noteSeg[realVecInput: .signal] = signal

  pitchDetect.compute()
  noteSeg.compute()

  print(zip(noteSeg[realVecOutput: .onset],
            noteSeg[realVecOutput: .duration],
            noteSeg[realVecOutput: .MIDIpitch]))

case 3:

  let multiPitch = StandardAlgorithm<Standard.MultiPitchKlapuri>([.sampleRate: 44100])
  multiPitch[realVecInput: .signal] = signal
  multiPitch.compute()

  print(multiPitch[realVecVecOutput: .pitch])

case 4:

  let equalLoudness = StandardAlgorithm<Standard.EqualLoudness>([.sampleRate: 44100])

  let multiPitch = StandardAlgorithm<Standard.MultiPitchMelodia>([
    .sampleRate: 44100,
    .frameSize: 2048,
    .hopSize: 128
    ])

  equalLoudness[realVecInput: .signal] = signal
  equalLoudness[output: .signal] >> multiPitch[input: .signal]

  equalLoudness.compute()
  multiPitch.compute()

  print(multiPitch[realVecVecOutput: .pitch])

case 5:

  let vectorInput = VectorInput<Float>(signal)
  let pitchDetect = StreamingAlgorithm<Streaming.PredominantPitchMelodia>([
    .sampleRate: 44100,
    .hopSize: 128,
    .frameSize: 2048
    ])
  let pool = Pool()

  vectorInput[output: .data] >> pitchDetect[input: .signal]
  pitchDetect[output: .pitch] >> pool[singleInput: "pitch"]
  pitchDetect[output: .pitchConfidence] >> pool[singleInput: "pitchConfidence"]

  let network = Network(generator: vectorInput)
  network.run()

  print(zip(pool[singleRealVec: "pitch"], pool[singleRealVec: "pitchConfidence"]).enumerated())

default:
  fatalError("The impossible happened!")

}

