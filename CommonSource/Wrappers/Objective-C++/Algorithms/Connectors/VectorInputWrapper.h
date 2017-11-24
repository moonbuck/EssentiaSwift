//
//  VectorInputWrapper.h
//  Essentia
//
//  Created by Jason Cardwell on 10/24/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "AlgorithmWrapper.h"
#import "WrappedTypes.h"

NS_ASSUME_NONNULL_BEGIN

@interface VectorInputWrapper : StreamingAlgorithmWrapper

/**
 Creates a new vector input wrapper for the specified real vector.

 @param value The vector.
 @return The newly created wrapper for a vector input with the specified data.
 */
+ (instancetype)vectorInputWrapperWithRealVec:(OBJCRealVec)value;

/**
 Creates a new vector input wrapper for the specified real matrix.

 @param value The vector.
 @return The newly created wrapper for a vector input with the specified data.
 */
+ (instancetype)vectorInputWrapperWithRealMatrixVec:(OBJCRealMatrixVec)value;

/**
 Creates a new vector input wrapper for the specified string vector.

 @param value The vector.
 @return The newly created wrapper for a vector input with the specified data.
 */
+ (instancetype)vectorInputWrapperWithStringVec:(OBJCStringVec)value;

/**
 Creates a new vector input wrapper for the specified stereo sample vector.

 @param value The vector.
 @return The newly created wrapper for a vector input with the specified data.
 */
+ (instancetype)vectorInputWrapperWithStereoSampleVec:(OBJCStereoSampleVec)value;

/**
 Creates a new vector input wrapper for the specified real vector vector.

 @param value The vector.
 @return The newly created wrapper for a vector input with the specified data.
 */
+ (instancetype)vectorInputWrapperWithRealVecVec:(OBJCRealVecVec)value;

/**
 Creates a new vector input wrapper for the specified complex real vector.

 @param value The vector.
 @return The newly created wrapper for a vector input with the specified data.
 */
+ (instancetype)vectorInputWrapperWithComplexRealVec:(OBJCComplexRealVec)value;

/**
 Creates a new vector input wrapper for the specified complex real vector.

 @param value The vector.
 @return The newly created wrapper for a vector input with the specified data.
 */
+ (instancetype)vectorInputWrapperWithComplexRealVecVec:(OBJCComplexRealVecVec)value;

/**
 The vector used as input data. The vector's data type must match the type used to
 initialize the vector input instance.
 */
@property (nonatomic, readwrite) NSArray * vector;

@end

NS_ASSUME_NONNULL_END
