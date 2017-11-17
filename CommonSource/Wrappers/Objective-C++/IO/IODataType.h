//
//  IODataType.h
//  Essentia
//
//  Created by Jason Cardwell on 10/23/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
#import <Foundation/Foundation.h>

/**
 Enumeration of supported types for IO data.

 - IODataTypeReal: A real value.
 - IODataTypeString: A string value.
 - IODataTypeInt: An integer value.
 - IODataTypeComplexReal: A complex real value.
 - IODataTypeStereoSample: A stereo sample value.
 - IODataTypePool: A pool value.
 - IODataTypeRealMatrix: A real matrix.
 - IODataTypeComplexRealVec: A vector of complex real numbers
 - IODataTypeRealVec: A vector of real numbers.
 - IODataTypeStringVec: A vector of strings.
 - IODataTypeStereoSampleVec: A vector of stereo samples.
 - IODataTypeRealVecVec: A vector of vectors of real numbers.
 - IODataTypeComplexRealVecVec: A vector of vectors of complex real numbers.
 */
typedef NS_ENUM(NSUInteger, IODataType) {
  IODataTypeReal,
  IODataTypeString,
  IODataTypeInt,
  IODataTypeComplexReal,
  IODataTypeStereoSample,
  IODataTypePool,
  IODataTypeRealMatrix,
  IODataTypeComplexRealVec,
  IODataTypeRealVec,
  IODataTypeStringVec,
  IODataTypeStereoSampleVec,
  IODataTypeRealVecVec,
  IODataTypeComplexRealVecVec
};

