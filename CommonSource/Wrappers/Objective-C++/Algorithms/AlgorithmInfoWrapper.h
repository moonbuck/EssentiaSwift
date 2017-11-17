//
//  AlgorithmInfoWrapper.h
//  Essentia
//
//  Created by Jason Cardwell on 10/27/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
#import <Foundation/Foundation.h>

@class AlgorithmWrapper, StandardAlgorithmWrapper, StreamingAlgorithmWrapper;

/**
 Wrapper for bridging C++ class `AlgorithmInfo` to Objective-C.
 */
@interface AlgorithmInfoWrapper: NSObject

/**
 Accessor for a closure that can be used to create new `Algorithm` instances.
 */
@property (nonnull, nonatomic, copy, readonly) AlgorithmWrapper * _Nonnull (^createAlgorithm)(void);

/**
 The name registered for the algorithm.
 */
@property (nonnull, nonatomic, readonly) NSString * algorithmName;

/**
 A description of the algorithm.
 */
@property (nonnull, nonatomic, readonly) NSString * algorithmDescription;

/**
 The category for the algorithm.
 */
@property (nonnull, nonatomic, readonly) NSString * algorithmCategory;

@end


/**
 Wrapper for bridging C++ class `AlgorithmInfo` to Objective-C.
 */
@interface StandardAlgorithmInfoWrapper: AlgorithmInfoWrapper @end

/**
 Wrapper for bridging C++ class `AlgorithmInfo` to Objective-C.
 */
@interface StreamingAlgorithmInfoWrapper: AlgorithmInfoWrapper @end

