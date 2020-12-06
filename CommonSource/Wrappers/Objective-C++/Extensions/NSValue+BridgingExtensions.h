//
//  NSValue+BridgingExtensions.h
//  Essentia
//
//  Created by Jason Cardwell on 10/15/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <Accelerate/Accelerate.h>
#import <Essentia/WrappedTypes.h>
#import <Essentia/LoggerWrapper.h>
//#import "WrappedTypes.h"
//#import "LoggerWrapper.h"

@interface NSValue (BridgingExtensions)

+ (nonnull instancetype)valueWithComplex:(DSPComplex)complexValue;

+ (nonnull instancetype)valueWithStereoSample:(struct _StereoSample)stereoSampleValue;

+ (nonnull instancetype)valueWithEvent:(DebuggingScheduleEvent)eventValue;

@property (nonatomic, readonly) DSPComplex complexValue;

@property (nonatomic, readonly) struct _StereoSample stereoSampleValue;

@property (nonatomic, readonly) DebuggingScheduleEvent eventValue;

@end
