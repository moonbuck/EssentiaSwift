//
//  AlgorithmFactoryWrapper.h
//  Essentia
//
//  Created by Jason Cardwell on 10/15/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
#import <Foundation/Foundation.h>

@class StandardAlgorithmWrapper, StandardAlgorithmInfoWrapper;
@class StreamingAlgorithmWrapper, StreamingAlgorithmInfoWrapper;
@class ParameterWrapper;

/**
 Wrapper for bridging C++ singleton class `AlgorithmFactory` to Objective-C.
 */
@interface AlgorithmFactoryWrapper : NSObject

/**
 The names of all algorithms registered with the factory.
 */
@property (nonnull, class, nonatomic, readonly) NSArray<NSString *> * standardRegisteredNames;

/**

 Provides the algorithm info for the algorithm registered for `name`.

 @param name The name of the algorithm.
 @return The info for `name` or `nil` if no algorithm is registered for `name`.
 */
+ (nullable StandardAlgorithmInfoWrapper *)standardInfoForName:(nonnull NSString *)name;

/**
 Creates a new algorithm instance using the registration for `name`.

 @param name The name of the algorithm.
 @return A wrapper for the newly create algorithm.
 */
+ (nullable StandardAlgorithmWrapper *)createStandardAlgorithmWithName:(nonnull NSString *)name;

/**
 Creates a new algorithm instance using the registration for `name`.

 @param name The name of the algorithm.
 @param parameters The dictionary of parameter values to set keyed by their names.
 @return A wrapper for the newly create algorithm.
 */
+ (nullable StandardAlgorithmWrapper *)
  createStandardAlgorithmWithName:(nonnull NSString *)name
                  parameterValues:(nullable NSDictionary<NSString *, ParameterWrapper *> *)parameters;

/**
 The names of all algorithms registered with the factory.
 */
@property (nonnull, class, nonatomic, readonly) NSArray<NSString *> * streamingRegisteredNames;

/**

 Provides the algorithm info for the algorithm registered for `name`.

 @param name The name of the algorithm.
 @return The info for `name` or `nil` if no algorithm is registered for `name`.
 */
+ (nullable StreamingAlgorithmInfoWrapper *)streamingInfoForName:(nonnull NSString *)name;

/**
 Creates a new algorithm instance using the registration for `name`.

 @param name The name of the algorithm.
 @return A wrapper for the newly create algorithm.
 */
+ (nullable StreamingAlgorithmWrapper *)createStreamingAlgorithmWithName:(nonnull NSString *)name;

/**
 Creates a new algorithm instance using the registration for `name`.

 @param name The name of the algorithm.
 @param parameters The dictionary of parameter values to set keyed by their names.
 @return A wrapper for the newly create algorithm.
 */
+ (nullable StreamingAlgorithmWrapper *)
  createStreamingAlgorithmWithName:(nonnull NSString *)name
                   parameterValues:(nullable NSDictionary<NSString *, ParameterWrapper *> *)parameters;

@end
