//
//  VectorOutputWrapper.h
//  Essentia
//
//  Created by Jason Cardwell on 10/24/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "AlgorithmWrapper.h"
#import "IODataType.h"

NS_ASSUME_NONNULL_BEGIN

@interface VectorOutputWrapper : StreamingAlgorithmWrapper

/**
 Creates a new vector output wrapper for receiving the data of the specified type. An exception
 is thrown if the tape is not one of the vector types.

 @param type The vector type for the wrapper.
 @return The newly created wrapper for `type`.
 */
+ (instancetype)vectorOutputWrapperForDataType:(IODataType)type;

/**
 The data received over the algorithm's input.
 */
@property (nonatomic, readonly) NSArray * vector;

/**
 The type of data stored by the algorithm.
 */
@property (nonatomic, readonly) IODataType type;

@end

NS_ASSUME_NONNULL_END
