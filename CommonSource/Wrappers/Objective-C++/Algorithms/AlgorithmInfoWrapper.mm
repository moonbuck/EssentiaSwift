//
//  AlgorithmInfoWrapper.mm
//  Essentia
//
//  Created by Jason Cardwell on 10/27/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
#import "AlgorithmInfoWrapper+BridgingExtensions.hpp"
#import "AlgorithmFactoryWrapper.h"
#import "AlgorithmWrapper+BridgingExtensions.hpp"
#import "NSString+BridgingExtensions.hpp"

using namespace essentia;
using namespace std;

@implementation AlgorithmInfoWrapper @end

@implementation StandardAlgorithmInfoWrapper

/**
 Initializing with an instance of the C++ class to wrap.

 @param algorithmInfo The instance being wrapped.
 @return A new wrapper for `algorithmInfo`.
 */
- (nonnull instancetype)initWithAlgorithmInfo:(AlgorithmInfo<standard::Algorithm>)algorithmInfo {
  self = [super init];
  if (self) {
    _info = algorithmInfo;
  }
  return self;
}

/**
 Accessor for a closure that can be used to create new `Algorithm` instances.

 @return A block wrapping the `create` function provided by the wrapped `AlgorithmInfo` to create
 a new algorithm instance and return it inside an `AlgorithmWrapper`.
 */
- (AlgorithmWrapper * _Nonnull (^_Nonnull)(void))createAlgorithm {

  return ^StandardAlgorithmWrapper *(void) {

    standard::Algorithm *algorithm = _info.create();
    algorithm->setName(_info.name);
    algorithm->declareParameters();

    return [[StandardAlgorithmWrapper alloc] initWithAlgorithm: algorithm assumeOwnership:YES];
  };

}

/**
 Accessor for the name registered for the algorithm.

 @return The name provided by the wrapped `AlgorithmInfo`.
 */
- (nonnull NSString *)algorithmName {
  return [NSString stringWithCPPString: _info.name];
}

/**
 Accessor for the algorithm description provided by the wrapped instance.

 @return The description provided by the wrapped `AlgorithmInfo`.
 */
- (nonnull NSString *)algorithmDescription {
  return [NSString stringWithCPPString: _info.description];
}

/**
 Accessor for the category provided by the wrapped instance.

 @return The category provided by the wrapped `AlgorithmInfo`.
 */
- (nonnull NSString *)algorithmCategory {
  return [NSString stringWithCPPString: _info.category];
}

/**
 Implemented to provide the algorithm name, category, and description.

 @return A string containing the algorithm name, category and description.
 */
- (nonnull NSString *)description {
  return [NSString stringWithFormat:@"%@ (%@)\n%@",
          self.algorithmName, self.algorithmCategory, self.algorithmDescription];
}

@end

@implementation StreamingAlgorithmInfoWrapper

/**
 Initializing with an instance of the C++ class to wrap.

 @param algorithmInfo The instance being wrapped.
 @return A new wrapper for `algorithmInfo`.
 */
- (nonnull instancetype)initWithAlgorithmInfo:(AlgorithmInfo<streaming::Algorithm>)algorithmInfo {
  self = [super init];
  if (self) {
    _info = algorithmInfo;
  }
  return self;
}

/**
 Accessor for a closure that can be used to create new `Algorithm` instances.

 @return A block wrapping the `create` function provided by the wrapped `AlgorithmInfo` to create
 a new algorithm instance and return it inside an `AlgorithmWrapper`.
 */
- (AlgorithmWrapper * _Nonnull (^_Nonnull)(void))createAlgorithm {

  return ^StreamingAlgorithmWrapper *(void) {

    streaming::Algorithm *algorithm = _info.create();
    algorithm->setName(_info.name);
    algorithm->declareParameters();

    return [[StreamingAlgorithmWrapper alloc] initWithAlgorithm: *algorithm assumeOwnership:YES];
  };

}

/**
 Accessor for the name registered for the algorithm.

 @return The name provided by the wrapped `AlgorithmInfo`.
 */
- (nonnull NSString *)algorithmName {
  return [NSString stringWithCPPString: _info.name];
}

/**
 Accessor for the algorithm description provided by the wrapped instance.

 @return The description provided by the wrapped `AlgorithmInfo`.
 */
- (nonnull NSString *)algorithmDescription {
  return [NSString stringWithCPPString: _info.description];
}

/**
 Accessor for the category provided by the wrapped instance.

 @return The category provided by the wrapped `AlgorithmInfo`.
 */
- (nonnull NSString *)algorithmCategory {
  return [NSString stringWithCPPString: _info.category];
}

/**
 Implemented to provide the algorithm name, category, and description.

 @return A string containing the algorithm name, category and description.
 */
- (nonnull NSString *)description {
  return [NSString stringWithFormat:@"%@ (%@)\n%@",
          self.algorithmName, self.algorithmCategory, self.algorithmDescription];
}

@end

