//
//  IOValue.swift
//  Essentia
//
//  Created by Jason Cardwell on 10/24/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
import Foundation
import struct Accelerate.DSPComplex

extension IODataType: CustomStringConvertible {

  /// A string containing the capitalized name of the enumeration case.
  public var description: String {

    switch self {
      case .real:              return "Real"
      case .string:            return "String"
      case .int:               return "Int"
      case .complexReal:       return "ComplexReal"
      case .stereoSample:      return "StereoSample"
      case .pool:              return "Pool"
      case .realMatrix:        return "RealMatrix"
      case .complexRealVec:    return "ComplexRealVec"
      case .realVec:           return "RealVec"
      case .stringVec:         return "StringVec"
      case .stereoSampleVec:   return "StereoSampleVec"
      case .realVecVec:        return "RealVecVec"
      case .complexRealVecVec: return "ComplexRealVecVec"
    @unknown default:
      return "Undefined"
    }

  }

  /// Boolean indicating whether the data type constitutes some form of vector.
  public var isVector: Bool {
    switch self {
      case .complexRealVec, .realVec, .stringVec,
           .stereoSampleVec, .realVecVec, .complexRealVecVec: return true
      default:                                                return false
    }
  }

}

/// An enumeration for values held by instances of `Input` and `Output`.
///
/// - none: Used to express a `nil` value.
/// - real: A real value.
/// - string: A string value.
/// - integer: An integer value.
/// - complexReal: A complex real value.
/// - stereoSample: A stereo sample value.
/// - pool: A pool value.
/// - realMatrix: A real matrix value.
/// - complexRealVec: A complex real vector value.
/// - realVec: A real vector value.
/// - stringVec: A string vector value.
/// - stereoSampleVec: A stereo sample vector value.
/// - realVecVec: A real vector vector value.
/// - complexRealVecVec: A complex real vector vector value.
public enum IOValue {

  case none
  case real (Float)
  case string (String)
  case integer (Int32)
  case complexReal (DSPComplex)
  case stereoSample (StereoSample)
  case pool (Pool)
  case realMatrix ([[Float]])
  case complexRealVec ([DSPComplex])
  case realVec ([Float])
  case stringVec ([String])
  case stereoSampleVec ([StereoSample])
  case realVecVec ([[Float]])
  case complexRealVecVec ([[DSPComplex]])

  public init(data: Any, dataType: IODataType) {

    switch dataType {

      case .real:
        guard let realData = data as? Float else { self = .none; return }
        self = .real(realData)

      case .string:
        guard let stringData = data as? String else { self = .none; return }
        self = .string(stringData)

      case .int:
        guard let intData = data as? CInt else { self = .none; return }
        self = .integer(intData)

      case .complexReal:
        guard let complexRealData = data as? NSValue else { self = .none; return }
        self = .complexReal(complexRealData.complexValue)

      case .stereoSample:
        guard let stereoSampleData = data as? NSValue else { self = .none; return }
        self = .stereoSample(stereoSampleData.stereoSampleValue)

      case .pool:
        guard let poolData = data as? PoolWrapper else { self = .none; return }
        self = .pool(Pool(wrapper: poolData))

      case .realMatrix:
        guard let realMatrixData = data as? [[Float]] else { self = .none; return }
        self = .realMatrix(realMatrixData)

      case .complexRealVec:
        guard let complexRealVecData = data as? [NSValue] else { self = .none; return }
        let convertedData = complexRealVecData.map({$0.complexValue})
        self = .complexRealVec(convertedData)

      case .realVec:
        guard let realVecData = data as? [Float] else { self = .none; return }
        self = .realVec(realVecData)

      case .stringVec:
        guard let stringVecData = data as? [String] else { self = .none; return }
        self = .stringVec(stringVecData)

      case .stereoSampleVec:
        guard let stereoSampleData = data as? [NSValue] else { self = .none; return }
        let convertedData = stereoSampleData.map({$0.stereoSampleValue})
        self = .stereoSampleVec(convertedData)

      case .realVecVec:
        guard let realVecVecData = data as? [[Float]] else { self = .none; return }
        self = .realVecVec(realVecVecData)

      case .complexRealVecVec:
        guard let complexRealVecVecData = data as? [[NSValue]] else { self = .none; return }
        let convertedData = complexRealVecVecData.map({$0.map({$0.complexValue})})
        self = .complexRealVecVec(convertedData)

    @unknown default:
      self = .none
    }

  }

}

