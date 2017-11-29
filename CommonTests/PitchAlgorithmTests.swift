//
//  PitchAlgorithmTests.swift
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

class PitchAlgorithmTests: XCTestCase {

  /// Tests the functionality of the MultiPitchKlapuri algorithm.
  func testMultiPitchKlapuri() {

    /*
     Test against output from the algorithm run in python.
     */

    let alg = MultiPitchKlapuriAlgorithm()
    alg[realVecInput: .signal] = loadVector(name: "multipitchklapuri_input")
    alg.compute()

    XCTAssertEqual(alg[realVecVecOutput: .pitch],
                   loadVectorVector(name: "multipitchklapuri_expected"),
                   accuracy: 1e-7)

  }

  /// Tests the functionality of the MultiPitchMelodia algorithm.
  func testMultiPitchMelodia() {

    /*
     Test against output from the algorithm run in python.
     */

    let alg = MultiPitchMelodiaAlgorithm()
    alg[realVecInput: .signal] = loadVector(name: "multipitchmelodia_input")
    alg.compute()

    XCTAssertEqual(alg[realVecVecOutput: .pitch],
                   loadVectorVector(name: "multipitchmelodia_expected"),
                   accuracy: 1e-7)

  }

  /// Tests the functionality of the PitchSalienceFunction algorithm.
  func testPitchSalienceFunction() {

    /*
     Test against output from the algorithm run in python.
     */

    let frequencies = loadVectorVector(name: "pitchsaliencefunction_frequenciesinput")
    let magnitudes = loadVectorVector(name: "pitchsaliencefunction_magnitudesinput")
    let alg = PitchSalienceFunctionAlgorithm()

    var salienceFunctionFrames: [[Float]] = []

    for (frequenciesFrame, magnitudesFrame) in zip(frequencies, magnitudes) {

      alg[realVecInput: .frequencies] = frequenciesFrame
      alg[realVecInput: .magnitudes] = magnitudesFrame
      alg.compute()

      salienceFunctionFrames.append(alg[realVecOutput: .salienceFunction])

    }

    XCTAssertEqual(salienceFunctionFrames,
                   loadVectorVector(name: "pitchsaliencefunction_expected"),
                   accuracy: 1e-7)

  }

  /// Tests the functionality of the PitchSalienceFunctionPeaks algorithm.
  func testPitchSalienceFunctionPeaks() {

    /*
     Test against output from the algorithm run in python.
     */

    let frames = loadVectorVector(name: "pitchsaliencefunctionpeaks_input")
    let alg = PitchSalienceFunctionPeaksAlgorithm()


    var binFrames: [[Float]] = []
    var valueFrames: [[Float]] = []

    for frame in frames {

      alg[realVecInput: .salienceFunction] = frame
      alg.compute()

      binFrames.append(alg[realVecOutput: .salienceBins])
      valueFrames.append(alg[realVecOutput: .salienceValues])

    }

    XCTAssertEqual(binFrames,
                   loadVectorVector(name: "pitchsaliencefunctionpeaks_expectedbins"),
                   accuracy: 1e-7)

    XCTAssertEqual(valueFrames,
                   loadVectorVector(name: "pitchsaliencefunctionpeaks_expectedvalues"),
                   accuracy: 1e-7)

  }

  /// Tests the functionality of the PitchContours algorithm.
  func testPitchContours() {

    /*
     Test against output from the algorithm run in python.
     */

    let alg = PitchContoursAlgorithm()
    alg[realVecVecInput: .peakBins] = loadVectorVector(name: "pitchcontours_inputbins")
    alg[realVecVecInput: .peakSaliences] = loadVectorVector(name: "pitchcontours_inputsaliences")
    alg.compute()

    XCTAssertEqual(alg[realVecVecOutput: .contoursBins],
                   loadVectorVector(name: "pitchcontours_expectedbins"),
                   accuracy: 1e-7)

    XCTAssertEqual(alg[realVecVecOutput: .contoursSaliences],
                   loadVectorVector(name: "pitchcontours_expectedsaliences"),
                   accuracy: 1e-7)

    XCTAssertEqual(alg[realVecOutput: .contoursStartTimes],
                   loadVector(name: "pitchcontours_expectedstarttimes"),
                   accuracy: 1e-7)

    XCTAssertEqual(alg[realOutput: .duration],
                   loadValue(name: "pitchcontours_expectedduration"),
                   accuracy: 1e-7)

  }

  /// Tests the functionality of the PitchContoursMultiMelody algorithm.
  func testPitchContoursMultiMelody() {

    /*
     Test against output from the algorithm run in python.
     */

    let alg = PitchContoursMultiMelodyAlgorithm()
    alg[realVecVecInput: .contoursBins] =
      loadVectorVector(name: "pitchcontoursmultimelody_inputbins")
    alg[realVecVecInput: .contoursSaliences] =
      loadVectorVector(name: "pitchcontoursmultimelody_inputsaliences")
    alg[realVecInput: .contoursStartTimes] =
      loadVector(name: "pitchcontoursmultimelody_inputstarttimes")
    alg[realInput: .duration] = loadValue(name: "pitchcontoursmultimelody_inputduration")
    alg.compute()

    XCTAssertEqual(alg[realVecVecOutput: .pitch],
                   loadVectorVector(name: "pitchcontoursmultimelody_expected"),
                   accuracy: 1e-7)

  }

  /// Tests the functionality of the PredominantPitchMelodia algorithm.
  func testPredominantPitchMelodia() {

    /*
     Test against output from the algorithm run in python.
     */

    let alg = PredominantPitchMelodiaAlgorithm()
    alg[realVecInput: .signal] = loadVector(name: "predominantpitchmelodia_input")
    alg.compute()

    XCTAssertEqual(alg[realVecOutput: .pitch],
                   loadVector(name: "predominantpitchmelodia_expectedpitches"),
                   accuracy: 1e-7)

    XCTAssertEqual(alg[realVecOutput: .pitchConfidence],
                   loadVector(name: "predominantpitchmelodia_expectedconfidences"),
                   accuracy: 1e-7)

  }

  /// Tests the functionality of the PitchFilter algorithm.
  func testPitchFilter() {

    /*
     Test against output from the algorithm run in python.
     */

    let alg = PitchFilterAlgorithm()
    alg[realVecInput: .pitch] = loadVector(name: "pitchfilter_inputpitch")
    alg[realVecInput: .pitchConfidence] = loadVector(name: "pitchfilter_inputpitchconfidence")
    alg.compute()

    XCTAssertEqual(alg[realVecOutput: .pitchFiltered],
                   loadVector(name: "pitchfilter_expected"),
                   accuracy: 1e-7)

  }
  
}
