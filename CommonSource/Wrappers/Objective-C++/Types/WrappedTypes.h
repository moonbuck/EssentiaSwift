//
//  WrappedTypes.h
//  Essentia
//
//  Created by Jason Cardwell on 10/11/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
#import <Foundation/Foundation.h>

@class PoolWrapper;

struct _StereoSample {
  const float left;
  const float right;
} NS_SWIFT_NAME(StereoSample);

typedef NSNumber * OBJCReal;
typedef NSNumber * OBJCAudioSample;
typedef NSString * OBJCString;
typedef NSNumber * OBJCBool;
typedef NSNumber * OBJCInt;

typedef NSValue * OBJCStereoSample;
typedef NSValue * OBJCComplexReal;
typedef NSArray<NSArray<NSNumber *> *> * OBJCRealMatrix;
typedef PoolWrapper * OBJCPool;

typedef NSArray<OBJCReal> * OBJCRealVec;
typedef NSArray<OBJCString> * OBJCStringVec;
typedef NSArray<OBJCBool> * OBJCBoolVec;
typedef NSArray<OBJCInt> * OBJCIntVec;
typedef NSArray<OBJCStereoSample> * OBJCStereoSampleVec;
typedef NSArray<OBJCRealMatrix> * OBJCRealMatrixVec;
typedef NSArray<OBJCComplexReal> * OBJCComplexRealVec;
typedef NSArray<OBJCAudioSample> * OBJCAudioSampleVec;

typedef NSArray<OBJCRealVec> * OBJCRealVecVec;
typedef NSArray<OBJCStringVec> * OBJCStringVecVec;
typedef NSArray<OBJCStereoSampleVec> * OBJCStereoSampleVecVec;
typedef NSArray<OBJCComplexRealVec> * OBJCComplexRealVecVec;

typedef NSDictionary<OBJCString, OBJCReal> * OBJCRealMap;
typedef NSDictionary<OBJCString, OBJCString> * OBJCStringMap;

typedef NSDictionary<OBJCString, OBJCRealVec> * OBJCRealVecMap;
typedef NSDictionary<OBJCString, OBJCStringVec> * OBJCStringVecMap;
typedef NSDictionary<OBJCString, OBJCIntVec> * OBJCIntVecMap;
typedef NSDictionary<OBJCString, OBJCRealMatrixVec> * OBJCRealMatrixVecMap;
typedef NSDictionary<OBJCString, OBJCStereoSampleVec> * OBJCStereoSampleVecMap;

typedef NSDictionary<OBJCString, OBJCRealVecVec> * OBJCRealVecVecMap;
typedef NSDictionary<OBJCString, OBJCStringVecVec> * OBJCStringVecVecMap;


