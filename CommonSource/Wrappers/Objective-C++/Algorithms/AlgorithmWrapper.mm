//
//  AlgorithmWrapper.m
//  Essentia
//
//  Created by Jason Cardwell on 10/27/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
#import "AlgorithmWrapper+BridgingExtensions.hpp"
#import "Exceptions.h"

@implementation AlgorithmWrapper

- (BOOL)ownsAlgorithm { return _ownsAlgorithm; }

- (void)setOwnsAlgorithm:(BOOL)ownsAlgorithm { _ownsAlgorithm = ownsAlgorithm; }

/**
 The name of the wrapped configurable.
 */
- (NSString *)name { @throw inconsistencyException(@"`AlgorithmWrapper` is an abstract base."); }

/**
 The list of names for the algorithm's parameters.
 */
- (NSArray<NSString *> *)parameterNames {
  @throw inconsistencyException(@"`AlgorithmWrapper` is an abstract base.");
}

/**
 An index of parameter descriptions keyed by parameter name.
 */
- (NSDictionary<NSString *, NSString*> *)parameterDescription {
  @throw inconsistencyException(@"`AlgorithmWrapper` is an abstract base.");
}

/**
 An index of the configurable's default parameters with optional default values.
 */
- (NSDictionary<NSString *, ParameterWrapper *> *)defaultParameters {
  @throw inconsistencyException(@"`AlgorithmWrapper` is an abstract base.");
}

/**
 Sets the specified parameter values as the current ones. Parameters not redefined will
 keep their current values.

 @param parameters The new parameter values.
 */
- (void)setParameters:(NSDictionary<NSString *, ParameterWrapper *> *)parameters {
  @throw inconsistencyException(@"`AlgorithmWrapper` is an abstract base.");
}

/**
 Uses the specified parameter values to reconfigure the wrapped algorithm.

 @param parameters The new parameter values.
 */
- (void)configureWithParameters:(NSDictionary<NSString *, ParameterWrapper *> *)parameters {
  @throw inconsistencyException(@"`AlgorithmWrapper` is an abstract base.");
}

/**
 Accessor for retrieiving parameters by name.

 @param name The name of the desired parameter.
 @return The wrapped parameter value or `nil`.
 */
- (nullable ParameterWrapper *)parameterWithName:(NSString *)name {
  @throw inconsistencyException(@"`AlgorithmWrapper` is an abstract base.");
}

/**
 The list of names for the algorithm's input parameters.
 */
- (NSArray<NSString *> *)inputNames {
  @throw inconsistencyException(@"`AlgorithmWrapper` is an abstract base.");
}

/**
 The list of names for the algorithm's output parameters.
 */
- (NSArray<NSString *> *)outputNames {
  @throw inconsistencyException(@"`AlgorithmWrapper` is an abstract base.");
}

@end
