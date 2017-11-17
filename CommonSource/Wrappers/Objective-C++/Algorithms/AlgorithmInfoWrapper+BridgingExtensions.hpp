//
//  AlgorithmInfoWrapper+BridgingExtensions.hpp
//  Essentia
//
//  Created by Jason Cardwell on 10/27/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
#import "AlgorithmInfoWrapper.h"
#import "algorithmfactory.h"
#import "algorithmfactory_impl.h"

@interface StandardAlgorithmInfoWrapper () {
  @package
  essentia::AlgorithmInfo<essentia::standard::Algorithm> _info; /// Storage for the wrapped C++ class.
}

/**
 Initializing with an instance of the C++ class to wrap.

 @param algorithmInfo The instance being wrapped.
 @return A new wrapper for `algorithmInfo`.
 */
- (nonnull instancetype)initWithAlgorithmInfo:(essentia::AlgorithmInfo<essentia::standard::Algorithm>)algorithmInfo;

@end

@interface StreamingAlgorithmInfoWrapper () {
  @package
  essentia::AlgorithmInfo<essentia::streaming::Algorithm> _info; /// Storage for the wrapped C++ class.
}

/**
 Initializing with an instance of the C++ class to wrap.

 @param algorithmInfo The instance being wrapped.
 @return A new wrapper for `algorithmInfo`.
 */
- (nonnull instancetype)initWithAlgorithmInfo:(essentia::AlgorithmInfo<essentia::streaming::Algorithm>)algorithmInfo;

@end

