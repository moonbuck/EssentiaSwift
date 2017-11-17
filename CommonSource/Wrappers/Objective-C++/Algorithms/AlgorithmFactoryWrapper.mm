//
//  AlgorithmFactoryWrapper.mm
//  Essentia
//
//  Created by Jason Cardwell on 10/15/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
#import "AlgorithmFactoryWrapper.h"
#import "algorithmfactory.h"
#import "algorithmfactory_impl.h"
#import "AlgorithmInfoWrapper+BridgingExtensions.hpp"
#import "AlgorithmWrapper+BridgingExtensions.hpp"
#import "NSArray+BridgingExtensions.hpp"
#import "NSString+BridgingExtensions.hpp"
#import "ParameterWrapper+BridgingExtensions.hpp"

using namespace essentia;
using namespace std;


@implementation AlgorithmFactoryWrapper

/**
 Implemented to invoke `essentia::init()`, which registers the algorithms with the factory.
 */
+ (void)initialize {
  if (self == [AlgorithmFactoryWrapper class]) {
    essentia::init();
  }
}

/**
 Accessor for the names registered with the algorithm factory.

 @return The array of string values retrieved via `AlgorithmFactory::keys`.
 */
+ (nonnull NSArray<NSString *> *)standardRegisteredNames {
  auto value = standard::AlgorithmFactory::keys();
  return [NSArray arrayWithStringVec:value];
}

/**
 Accessor for the names registered with the algorithm factory.

 @return The array of string values retrieved via `AlgorithmFactory::keys`.
 */
+ (nonnull NSArray<NSString *> *)streamingRegisteredNames {
  auto value = streaming::AlgorithmFactory::keys();
  return [NSArray arrayWithStringVec:value];
}

/**
 Queries the algorithm factory for info registered under the specified name.

 @param name The registered name for the algorithm for which to fetch info.
 @return The wrapped info for `name` or `nil` if there is no algorithm registered for `name`.
 */
+ (nullable StandardAlgorithmInfoWrapper *)standardInfoForName:(nonnull NSString *)name {

  if (![self.standardRegisteredNames containsObject:name]) { return nil; }

  return [[StandardAlgorithmInfoWrapper alloc]
          initWithAlgorithmInfo:standard::AlgorithmFactory::getInfo(name.cppString)];

}

/**
 Queries the algorithm factory for info registered under the specified name.

 @param name The registered name for the algorithm for which to fetch info.
 @return The wrapped info for `name` or `nil` if there is no algorithm registered for `name`.
 */
+ (nullable StreamingAlgorithmInfoWrapper *)streamingInfoForName:(nonnull NSString *)name {

  if (![self.standardRegisteredNames containsObject:name]) { return nil; }

  return [[StreamingAlgorithmInfoWrapper alloc]
          initWithAlgorithmInfo:streaming::AlgorithmFactory::getInfo(name.cppString)];

}

/**
 Creates a new algorithm instance of the algorithm registered for the specified name.

 @param name The registered name for the algorithm to create.
 @return A wrapper for the new algorithm instance or `nil` if there is no algorithm for `name`.
 */
+ (nullable StandardAlgorithmWrapper *)createStandardAlgorithmWithName:(NSString *)name {

  try {
    return [[StandardAlgorithmWrapper alloc] initWithAlgorithm:standard::AlgorithmFactory::create(name.cppString)
                                               assumeOwnership:YES];
  } catch (exception) {
    return nil;
  }

}

/**
 Creates a new algorithm instance using the registration for `name`.

 @param name The name of the algorithm.
 @param parameters The dictionary of parameter values to set keyed by their names.
 @return A wrapper for the newly create algorithm.
 */
+ (nullable StandardAlgorithmWrapper *)
  createStandardAlgorithmWithName:(nonnull NSString *)name
                  parameterValues:(nullable NSDictionary<NSString *, ParameterWrapper *> *)parameters
{

  StandardAlgorithmWrapper *wrapper = [self createStandardAlgorithmWithName:name];
  [wrapper configureWithParameters:parameters];

  return wrapper;

}

/**
 Creates a new algorithm instance of the algorithm registered for the specified name.

 @param name The registered name for the algorithm to create.
 @return A wrapper for the new algorithm instance or `nil` if there is no algorithm for `name`.
 */
+ (nullable StreamingAlgorithmWrapper *)createStreamingAlgorithmWithName:(NSString *)name {

  try {
    return [[StreamingAlgorithmWrapper alloc] initWithAlgorithm:*streaming::AlgorithmFactory::create(name.cppString)
                                                assumeOwnership:YES];
  } catch (exception) {
    return nil;
  }

}

/**
 Creates a new algorithm instance using the registration for `name`.

 @param name The name of the algorithm.
 @param parameters The dictionary of parameter values to set keyed by their names.
 @return A wrapper for the newly create algorithm.
 */
+ (nullable StreamingAlgorithmWrapper *)
  createStreamingAlgorithmWithName:(nonnull NSString *)name
                   parameterValues:(nullable NSDictionary<NSString *, ParameterWrapper *> *)parameters
{

  StreamingAlgorithmWrapper *wrapper = [self createStreamingAlgorithmWithName:name];
  [wrapper configureWithParameters:parameters];

  return wrapper;

}

@end
