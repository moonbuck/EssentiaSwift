//
//  Essentia.h
//  Essentia
//
//  Created by Jason Cardwell on 11/17/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//

#if TARGET_OS_IOS
#import <UIKit/UIKit.h>

//! Project version number for Essentia_iOS.
FOUNDATION_EXPORT double Essentia_iOSVersionNumber;

//! Project version string for Essentia_iOS.
FOUNDATION_EXPORT const unsigned char Essentia_iOSVersionString[];
#elif TARGET_OS_OSX
#import <AppKit/AppKit.h>

//! Project version number for Essentia_iOS.
FOUNDATION_EXPORT double Essentia_MacVersionNumber;

//! Project version string for Essentia_iOS.
FOUNDATION_EXPORT const unsigned char Essentia_MacVersionString[];
#endif

#import <Essentia/AlgorithmWrapper.h>
#import <Essentia/AlgorithmInfoWrapper.h>
#import <Essentia/WrappedTypes.h>
#import <Essentia/ParameterWrapper.h>
#import <Essentia/PoolWrapper.h>
#import <Essentia/StandardIOWrappers.h>
#import <Essentia/SinkWrapper.h>
#import <Essentia/SourceWrapper.h>
#import <Essentia/IODataType.h>
#import <Essentia/TypeProxyWrapper.h>
#import <Essentia/NSValue+BridgingExtensions.h>
#import <Essentia/AlgorithmFactoryWrapper.h>
#import <Essentia/NetworkWrapper.h>
#import <Essentia/VectorInputWrapper.h>
#import <Essentia/VectorOutputWrapper.h>
#import <Essentia/LoggerWrapper.h>
