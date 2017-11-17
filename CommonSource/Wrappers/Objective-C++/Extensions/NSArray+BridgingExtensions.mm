//
//  NSArray+BridgingExtensions.m
//  Essentia
//
//  Created by Jason Cardwell on 10/10/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
#import "NSArray+BridgingExtensions.hpp"
#import <Accelerate/Accelerate.h>
#import "NSValue+BridgingExtensions.h"
#import "NSString+BridgingExtensions.hpp"

@implementation NSArray (BridgingExtensions)

+ (nonnull OBJCStringVec)arrayWithStringVec:(StringVec&)value {

  NSMutableArray *result = [[NSMutableArray alloc] init];

  for (auto value : value) {
    [result addObject:[NSString stringWithCPPString:value]];
  }

  return result;

}

+ (nonnull OBJCRealVec)arrayWithRealVec:(RealVec&)value {

  NSMutableArray *result = [[NSMutableArray alloc] init];

  for (auto value : value) {
    [result addObject:[NSNumber numberWithFloat:value]];
  }

  return result;

}

+ (nonnull OBJCIntVec)arrayWithIntVec:(IntVec&)value {

  NSMutableArray *result = [[NSMutableArray alloc] init];

  for (auto value : value) {
    [result addObject:[NSNumber numberWithInt:value]];
  }

  return result;

}

+ (nonnull OBJCBoolVec)arrayWithBoolVec:(BoolVec&)value {

  NSMutableArray *result = [[NSMutableArray alloc] init];

  for (auto value : value) {
    [result addObject:[NSNumber numberWithBool:value]];
  }

  return result;

}

+ (nonnull OBJCStereoSampleVec)arrayWithStereoSampleVec:(StereoSampleVec&)value {

  NSMutableArray *result = [[NSMutableArray alloc] init];

  for (auto value : value) {
    [result addObject:[NSValue valueWithStereoSample:{value.left(), value.right()}]];
  }

  return result;

}

+ (nonnull OBJCRealVecVec)arrayWithRealVecVec:(RealVecVec&)value {

  NSMutableArray *result = [[NSMutableArray alloc] init];

  for (auto value : value) {

    [result addObject:[NSArray arrayWithRealVec:value]];

  }

  return result;

}

+ (nonnull OBJCStringVecVec)arrayWithStringVecVec:(StringVecVec&)value {

  NSMutableArray *result = [[NSMutableArray alloc] init];

  for (auto value : value) {

    [result addObject:[NSArray arrayWithStringVec:value]];

  }

  return result;

}

+ (nonnull OBJCStereoSampleVecVec)arrayWithStereoSampleVecVec:(StereoSampleVecVec&)value {

  NSMutableArray *result = [[NSMutableArray alloc] init];

  for (auto value : value) {

    [result addObject:[NSArray arrayWithStereoSampleVec:value]];

  }

  return result;

}

+ (nonnull OBJCRealMatrix)arrayWithRealMatrix:(RealMatrix&)value {

  NSMutableArray *result = [[NSMutableArray alloc] init];

  for (int m = 0; m < value.dim1(); m++) {

    NSMutableArray *rowResult = [[NSMutableArray alloc] init];

    for (int n = 0; n < value.dim2(); n++) {

      [rowResult addObject:[NSNumber numberWithFloat:value[m][n]]];

    }

    [result addObject:rowResult];

  }

  return result;

}

+ (nonnull OBJCRealMatrixVec)arrayWithRealMatrixVec:(RealMatrixVec&)value {

  NSMutableArray *result = [[NSMutableArray alloc] init];

  for (auto value : value) {

    [result addObject:[NSArray arrayWithRealMatrix:value]];

  }

  return result;

}

+ (nonnull OBJCComplexRealVec)arrayWithComplexRealVec:(ComplexRealVec&)value {

  NSMutableArray *result = [[NSMutableArray alloc] init];

  for (auto value : value) {

    DSPComplex complexValue = {value.real(), value.imag()};
    NSValue *wrappedValue = [NSValue valueWithComplex:complexValue];

    [result addObject:wrappedValue];

  }

  return result;

}

+ (nonnull OBJCComplexRealVecVec)arrayWithComplexRealVecVec:(ComplexRealVecVec&)value {

  NSMutableArray *result = [[NSMutableArray alloc] init];

  for (auto value : value) {

    [result addObject:[NSArray arrayWithComplexRealVec:value]];

  }

  return result;

}

- (StringVec)stringVecValue {

  StringVec stringVec;
  for (id value in self) {
    if ([value isKindOfClass:[NSString class]]) {
      stringVec.push_back(((NSString *)value).cppString);
    }
  }

  return stringVec;

}

- (RealVec)realVecValue {

  RealVec realVec;
  for (id value in self) {
    if ([value isKindOfClass:[NSNumber class]]) {
      realVec.push_back(((NSNumber *)value).floatValue);
    }
  }

  return realVec;

}

- (BoolVec)boolVecValue {

  BoolVec boolVec;
  for (id value in self) {
    if ([value isKindOfClass:[NSNumber class]]) {
      boolVec.push_back(((NSNumber *)value).boolValue);
    }
  }

  return boolVec;

}

- (IntVec)intVecValue {

  IntVec intVec;
  for (id value in self) {
    if ([value isKindOfClass:[NSNumber class]]) {
      intVec.push_back(((NSNumber *)value).intValue);
    }
  }

  return intVec;

}

- (StereoSampleVec)stereoSampleVecValue {

  StereoSampleVec stereoSampleVec;
  for (id value in self) {
    if ([value isKindOfClass:[NSValue class]]) {
      NSValue *valueWrapper = (NSValue *)value;
      if (strcmp(valueWrapper.objCType, @encode(_StereoSample)) != 0) { continue; }
      struct _StereoSample structSample = valueWrapper.stereoSampleValue;
      StereoSample stereoSample = {structSample.left, structSample.right};
      stereoSampleVec.push_back(stereoSample);
    }
  }

  return stereoSampleVec;

}

- (RealVecVec)realVecVecValue {

  RealVecVec realVecVec;
  for (id value in self) {
    if ([value isKindOfClass:[NSArray class]]) {
      realVecVec.push_back(((NSArray *)value).realVecValue);
    }
  }

  return realVecVec;

}

- (StringVecVec)stringVecVecValue {

  StringVecVec stringVecVec;
  for (id value in self) {
    if ([value isKindOfClass:[NSArray class]]) {
      stringVecVec.push_back(((NSArray *)value).stringVecValue);
    }
  }

  return stringVecVec;

}

- (StereoSampleVecVec)stereoSampleVecVecValue {

  StereoSampleVecVec stereoSampleVecVec;
  for (id value in self) {
    if ([value isKindOfClass:[NSArray class]]) {
      stereoSampleVecVec.push_back(((NSArray *)value).stereoSampleVecValue);
    }
  }

  return stereoSampleVecVec;

}

- (RealMatrix)realMatrixValue {

  int m = (int)self.count;

  if (m == 0) { return RealMatrix(); }

  int n = 0;

  for (id object in self) {
    if (![object isKindOfClass:[NSArray class]]) { return RealMatrix(); }
    else { n = MAX(n, (int)((NSArray *)object).count); }
  }

//  int n = [[self valueForKeyPath:@"@max.count"] intValue];

  if (n == 0) { return RealMatrix(); }

  RealMatrix realMatrix = RealMatrix(m, n, 0.0);

  for (int row = 0; row < m; row++) {
    NSArray *rowArray = (NSArray *)self[row];
    for (int column = 0; column < (int)rowArray.count; column++) {
      if (![rowArray[column] isKindOfClass:[NSNumber class]]) { continue; }
      realMatrix[row][column] = ((NSNumber *)rowArray[column]).floatValue;
    }
  }

  return realMatrix;

}

- (RealMatrixVec)realMatrixVecValue {

  RealMatrixVec realMatrixVec;
  for (id value in self) {
    if ([value isKindOfClass:[NSArray class]]) {
      realMatrixVec.push_back(((NSArray *)value).realMatrixValue);
    }
  }

  return realMatrixVec;

}

- (ComplexRealVec)complexRealVecValue {

  ComplexRealVec complexRealVec;

  for (id value in self) {
    if (![value isKindOfClass:[NSValue class]]) { continue; }
    NSValue *valueWrapper = (NSValue *)value;
    if (strcmp(valueWrapper.objCType, @encode(DSPComplex)) != 0) { continue; }
    DSPComplex wrappedValue = valueWrapper.complexValue;
    ComplexReal convertedValue = {wrappedValue.real, wrappedValue.imag};
    complexRealVec.push_back(convertedValue);
  }

  return complexRealVec;

}

- (ComplexRealVecVec)complexRealVecVecValue {

  ComplexRealVecVec complexRealVecVec;
  for (id value in self) {
    if ([value isKindOfClass:[NSArray class]]) {
      complexRealVecVec.push_back(((NSArray *)value).complexRealVecValue);
    }
  }

  return complexRealVecVec;

}

@end
