//
//  NSDictionary+BridgingExtensions.hpp
//  Essentia
//
//  Created by Jason Cardwell on 10/10/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <string>
#import <vector>
#import "essentia.h"
#import "WrappedTypes.h"
#import "WrappedTypes.hpp"

@interface NSDictionary (BridgingExtensions)

+ (nonnull OBJCRealMap)dictionaryWithRealMap:(RealMap)map;
+ (nonnull OBJCRealVecMap)dictionaryWithRealVecMap:(RealVecMap)map;
+ (nonnull OBJCRealVecVecMap)dictionaryWithRealVecVecMap:(RealVecVecMap)map;

+ (nonnull OBJCStringMap)dictionaryWithStringMap:(StringMap)map;
+ (nonnull OBJCStringVecMap)dictionaryWithStringVecMap:(StringVecMap)map;
+ (nonnull OBJCStringVecVecMap)dictionaryWithStringVecVecMap:(StringVecVecMap)map;

+ (nonnull OBJCIntVecMap)dictionaryWithIntVecMap:(IntVecMap)map;

+ (nonnull OBJCRealMatrixVecMap)dictionaryWithRealMatrixVecMap:(RealMatrixVecMap)map;

+ (nonnull OBJCStereoSampleVecMap)dictionaryWithStereoSampleVecMap:(StereoSampleVecMap)map;



@property (nonatomic, readonly) RealMap realMapValue;
@property (nonatomic, readonly) RealVecMap realVecMapValue;
@property (nonatomic, readonly) RealVecVecMap realVecVecMapValue;

@property (nonatomic, readonly) StringMap stringMapValue;
@property (nonatomic, readonly) StringVecMap stringVecMapValue;
@property (nonatomic, readonly) StringVecVecMap stringVecVecMapValue;

@property (nonatomic, readonly) IntVecMap intVecMapValue;

@property (nonatomic, readonly) RealMatrixVecMap realMatrixVecMapValue;

@property (nonatomic, readonly) StereoSampleVecMap stereoSampleVecMapValue;

@end
