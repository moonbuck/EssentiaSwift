//
//  NSValue+CPPBridgingExtensions.hpp
//  Essentia
//
//  Created by Jason Cardwell on 10/25/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <complex>
#import "types.h"

@interface NSValue (CPPBridgingExtensions)

+ (nonnull instancetype)valueWithCPPComplex:(std::complex<essentia::Real>)complexValue;

+ (nonnull instancetype)valueWithCPPStereoSample:(essentia::StereoSample)stereoSampleValue;

@property (nonatomic, readonly) std::complex<essentia::Real> cppComplexValue;

@property (nonatomic, readonly) essentia::StereoSample cppStereoSampleValue;

@end
