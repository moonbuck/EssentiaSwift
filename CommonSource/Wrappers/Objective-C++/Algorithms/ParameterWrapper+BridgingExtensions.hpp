//
//  ParameterWrapper+BridgingExtensions.hpp
//  Essentia
//
//  Created by Jason Cardwell on 10/10/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
#import "ParameterWrapper.h"
#import "essentia.h"
#import "parameter.h"

using namespace essentia;

/**
 Category adding properties/methods that utilize C++ classes.
 */
@interface ParameterWrapper (BridgingExtensions)

/**
 The wrapped parameter instance.
 */
@property (nonnull, nonatomic, readonly) Parameter *parameter;

/**
 Creates a new wrapper for the specified parameter.

 @param parameter The parameter to wrap.
 @return The newly created wrapper for `parameter`.
 */
+ (nonnull instancetype)parameterWrapperForParameter:(Parameter &)parameter;

@end

