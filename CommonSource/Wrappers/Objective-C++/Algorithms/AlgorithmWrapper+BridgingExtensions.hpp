//
//  AlgorithmWrapper+BridgingExtensions.hpp
//  Essentia
//
//  Created by Jason Cardwell on 10/29/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
#import "AlgorithmWrapper.h"

@interface AlgorithmWrapper(){
  @package
  BOOL _ownsAlgorithm;
}

@property (nonatomic, readwrite) BOOL ownsAlgorithm;

@end

#import "algorithm.h"

@interface StandardAlgorithmWrapper() {
  @package
  essentia::standard::Algorithm * _algorithm;
}

- (nonnull instancetype)initWithAlgorithm:(nonnull essentia::standard::Algorithm *)algorithm
                          assumeOwnership:(BOOL)assumeOwnership;

@end

#import "streamingalgorithm.h"

@interface StreamingAlgorithmWrapper() {
  @package
  essentia::streaming::Algorithm *_algorithm;
}

- (nonnull instancetype)initWithAlgorithm:(essentia::streaming::Algorithm&)algorithm
                          assumeOwnership:(BOOL)assumeOwnership;

@end
