//
//  NSArray+BridgingExtensions.hpp
//  Essentia
//
//  Created by Jason Cardwell on 10/10/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <string>
#import <vector>
#import "essentia.h"
#import "tnt_array2d.h"
#import "WrappedTypes.h"
#import "WrappedTypes.hpp"

@interface NSArray (BridgingExtensions)

+ (nonnull OBJCStringVec)arrayWithStringVec:(StringVec&)value;

+ (nonnull OBJCRealVec)arrayWithRealVec:(RealVec&)value;

+ (nonnull OBJCBoolVec)arrayWithBoolVec:(BoolVec&)value;

+ (nonnull OBJCIntVec)arrayWithIntVec:(IntVec&)value;

+ (nonnull OBJCStereoSampleVec)arrayWithStereoSampleVec:(StereoSampleVec&)value;

+ (nonnull OBJCRealVecVec)arrayWithRealVecVec:(RealVecVec&)value;

+ (nonnull OBJCComplexRealVec)arrayWithComplexRealVec:(ComplexRealVec&)value;

+ (nonnull OBJCComplexRealVecVec)arrayWithComplexRealVecVec:(ComplexRealVecVec&)value;

+ (nonnull OBJCStringVecVec)arrayWithStringVecVec:(StringVecVec&)value;

+ (nonnull OBJCStereoSampleVecVec)arrayWithStereoSampleVecVec:(StereoSampleVecVec&)value;

+ (nonnull OBJCRealMatrix)arrayWithRealMatrix:(RealMatrix&)value;

+ (nonnull OBJCRealMatrixVec)arrayWithRealMatrixVec:(RealMatrixVec&)value;

@property (nonatomic, readonly) StringVec stringVecValue;
@property (nonatomic, readonly) RealVec realVecValue;
@property (nonatomic, readonly) BoolVec boolVecValue;
@property (nonatomic, readonly) IntVec intVecValue;
@property (nonatomic, readonly) StereoSampleVec stereoSampleVecValue;
@property (nonatomic, readonly) RealVecVec realVecVecValue;
@property (nonatomic, readonly) StringVecVec stringVecVecValue;
@property (nonatomic, readonly) StereoSampleVecVec stereoSampleVecVecValue;
@property (nonatomic, readonly) RealMatrix realMatrixValue;
@property (nonatomic, readonly) RealMatrixVec realMatrixVecValue;
@property (nonatomic, readonly) ComplexRealVec complexRealVecValue;
@property (nonatomic, readonly) ComplexRealVecVec complexRealVecVecValue;

@end
