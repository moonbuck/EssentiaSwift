//
//  NSValue+BridgingExtensions.mm
//  Essentia
//
//  Created by Jason Cardwell on 10/15/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
#import "NSValue+BridgingExtensions.h"
#import "NSValue+CPPBridgingExtensions.hpp"

using namespace essentia;
using namespace std;

@implementation NSValue (BridgingExtensions)

+ (nonnull instancetype)valueWithComplex:(DSPComplex)complexValue {
  return [NSValue valueWithBytes:&complexValue objCType:@encode(DSPComplex)];
}

- (DSPComplex)complexValue {
  DSPComplex value;
  if (strcmp(self.objCType, @encode(DSPComplex)) == 0) {
    [self getValue:&value size:sizeof(DSPComplex)];
  }
  return value;
}

+ (nonnull instancetype)valueWithStereoSample:(struct _StereoSample)stereoSampleValue {
  return [NSValue valueWithBytes:&stereoSampleValue objCType:@encode(struct _StereoSample)];
}

- (struct _StereoSample)stereoSampleValue {
  struct _StereoSample value = {0.0f, 0.0f};
  if (strcmp(self.objCType, @encode(_StereoSample)) == 0) {
    [self getValue:&value size:sizeof(struct _StereoSample)];
  }
  return value;
}

+ (nonnull instancetype)valueWithEvent:(DebuggingScheduleEvent)eventValue {
  return [NSValue valueWithBytes:&eventValue objCType:@encode(DebuggingScheduleEvent)];
}

- (DebuggingScheduleEvent)eventValue {
  DebuggingScheduleEvent value = {0, 0, 0};
  if (strcmp(self.objCType, @encode(DebuggingScheduleEvent)) == 0) {
    [self getValue:&value size:sizeof(DebuggingScheduleEvent)];
  }
  return value;
}

+ (nonnull instancetype)valueWithCPPComplex:(complex<Real>)complexValue {
  return [NSValue valueWithComplex:{complexValue.real(), complexValue.imag()}];
}

- (DSPComplex)cppComplexValue {
  DSPComplex value;
  [self getValue:&value size:sizeof(DSPComplex)];
  return {value.real, value.imag};
}

+ (nonnull instancetype)valueWithCPPStereoSample:(StereoSample)stereoSampleValue {
  return [NSValue valueWithStereoSample:{stereoSampleValue.left(), stereoSampleValue.right()}];
}

- (StereoSample)cppStereoSampleValue {
  struct _StereoSample value = self.stereoSampleValue;
  return {value.left, value.right};
}

@end
