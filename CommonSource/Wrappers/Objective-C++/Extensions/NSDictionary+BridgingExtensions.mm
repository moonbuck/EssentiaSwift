//
//  NSDictionary+BridgingExtensions.m
//  Essentia
//
//  Created by Jason Cardwell on 10/10/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
#import "NSDictionary+BridgingExtensions.hpp"
#import "NSArray+BridgingExtensions.hpp"
#import "NSString+BridgingExtensions.hpp"

@implementation NSDictionary (BridgingExtensions)

+ (nonnull OBJCRealMap)dictionaryWithRealMap:(RealMap)realMap {

  NSMutableDictionary *result = [[NSMutableDictionary alloc] init];

  for (RealMap::const_iterator i = realMap.begin(); i != realMap.end(); ++i) {

    NSString * key = [NSString stringWithCPPString:i->first];

    NSNumber * value = [NSNumber numberWithFloat:i->second];

    result[key] = value;

  }

  return result;

}

+ (nonnull OBJCRealVecMap)dictionaryWithRealVecMap:(RealVecMap)realVecMap {

  NSMutableDictionary *result = [[NSMutableDictionary alloc] init];

  for (RealVecMap::const_iterator i = realVecMap.begin(); i != realVecMap.end(); ++i) {

    NSString * key = [NSString stringWithCPPString:i->first];

    auto cppValue = i->second;
    NSArray * value = [NSArray arrayWithRealVec:cppValue];

    result[key] = value;

  }

  return result;

}

+ (nonnull OBJCRealVecVecMap)dictionaryWithRealVecVecMap:(RealVecVecMap)realVecVecMap {

  NSMutableDictionary *result = [[NSMutableDictionary alloc] init];

  for (RealVecVecMap::const_iterator i = realVecVecMap.begin(); i != realVecVecMap.end(); ++i) {

    NSString * key = [NSString stringWithCPPString:i->first];

    auto cppValue = i->second;
    NSArray * value = [NSArray arrayWithRealVecVec:cppValue];

    result[key] = value;

  }

  return result;

}

+ (nonnull OBJCStringMap)dictionaryWithStringMap:(StringMap)stringMap {

  NSMutableDictionary *result = [[NSMutableDictionary alloc] init];

  for (StringMap::const_iterator i = stringMap.begin(); i != stringMap.end(); ++i) {

    NSString * key = [NSString stringWithCPPString:i->first];

    NSString * value = [NSString stringWithCPPString:i->second];

    result[key] = value;

  }

  return result;

}

+ (nonnull OBJCStringVecMap)dictionaryWithStringVecMap:(StringVecMap)stringVecMap {

  NSMutableDictionary *result = [[NSMutableDictionary alloc] init];

  for (StringVecMap::const_iterator i = stringVecMap.begin(); i != stringVecMap.end(); ++i) {

    NSString * key = [NSString stringWithCPPString:i->first];

    auto cppValue = i->second;
    NSArray * value = [NSArray arrayWithStringVec:cppValue];

    result[key] = value;

  }

  return result;

}

+ (nonnull OBJCStringVecVecMap)dictionaryWithStringVecVecMap:(StringVecVecMap)stringVecVecMap {

  NSMutableDictionary *result = [[NSMutableDictionary alloc] init];

  for (StringVecVecMap::const_iterator i = stringVecVecMap.begin(); i != stringVecVecMap.end(); ++i) {

    NSString * key = [NSString stringWithCPPString:i->first];

    auto cppValue = i->second;
    NSArray * value = [NSArray arrayWithStringVecVec:cppValue];

    result[key] = value;

  }

  return result;

}

+ (nonnull OBJCIntVecMap)dictionaryWithIntVecMap:(IntVecMap)intVecMap {

  NSMutableDictionary *result = [[NSMutableDictionary alloc] init];

  for (IntVecMap::const_iterator i = intVecMap.begin(); i != intVecMap.end(); ++i) {

    NSString * key = [NSString stringWithCPPString:i->first];

    auto cppValue = i->second;
    NSArray * value = [NSArray arrayWithIntVec:cppValue];

    result[key] = value;

  }

  return result;

}

+ (nonnull OBJCRealMatrixVecMap)dictionaryWithRealMatrixVecMap:(RealMatrixVecMap)realMatrixVecMap {

  NSMutableDictionary *result = [[NSMutableDictionary alloc] init];

  for (RealMatrixVecMap::const_iterator i = realMatrixVecMap.begin(); i != realMatrixVecMap.end(); ++i) {

    NSString * key = [NSString stringWithCPPString:i->first];

    auto cppValue = i->second;
    NSArray * value = [NSArray arrayWithRealMatrixVec:cppValue];

    result[key] = value;

  }

  return result;

}

+ (nonnull OBJCStereoSampleVecMap)dictionaryWithStereoSampleVecMap:(StereoSampleVecMap)stereoSampleVecMap {

  NSMutableDictionary *result = [[NSMutableDictionary alloc] init];

  for (StereoSampleVecMap::const_iterator i = stereoSampleVecMap.begin(); i != stereoSampleVecMap.end(); ++i) {

    NSString * key = [NSString stringWithCPPString:i->first];

    auto cppValue = i->second;
    NSArray * value = [NSArray arrayWithStereoSampleVec:cppValue];

    result[key] = value;

  }

  return result;

}

- (RealMap)realMapValue {

  RealMap realMap;

  for (id key in self.allKeys) {
    if (!([key isKindOfClass:[NSString class]] && [self[key] isKindOfClass:[NSNumber class]])) {
      return realMap;
    }

    realMap[((NSString *)key).cppString] = ((NSNumber *)self[key]).floatValue;
  }

  return realMap;

}

- (RealVecMap)realVecMapValue {

  RealVecMap realVecMap;

  for (id key in self.allKeys) {
    if (!([key isKindOfClass:[NSString class]] && [self[key] isKindOfClass:[NSArray class]])) {
      return realVecMap;
    }
    realVecMap[((NSString *)key).cppString] = ((NSArray *)self[key]).realVecValue;
  }

  return realVecMap;

}

- (RealVecVecMap)realVecVecMapValue {

  RealVecVecMap realVecVecMap;

  for (id key in self.allKeys) {
    if (!([key isKindOfClass:[NSString class]] && [self[key] isKindOfClass:[NSArray class]])) {
      return realVecVecMap;
    }

    realVecVecMap[((NSString *)key).cppString] = ((NSArray *)self[key]).realVecVecValue;

  }

  return realVecVecMap;

}

- (StringMap)stringMapValue {

  StringMap stringMap;

  for (id key in self.allKeys) {
    if (!([key isKindOfClass:[NSString class]] && [self[key] isKindOfClass:[NSString class]])) {
      return stringMap;
    }
    stringMap[((NSString *)key).cppString] = ((NSString *)self[key]).cppString;
  }


  return stringMap;

}

- (StringVecMap)stringVecMapValue {

  StringVecMap stringVecMap;

  for (id key in self.allKeys) {
    if (!([key isKindOfClass:[NSString class]] && [self[key] isKindOfClass:[NSArray class]])) {
      return stringVecMap;
    }

    stringVecMap[((NSString *)key).cppString] = ((NSArray *)self[key]).stringVecValue;
  }

  return stringVecMap;

}

- (StringVecVecMap)stringVecVecMapValue {

  StringVecVecMap stringVecVecMap;

  NSArray *keys = self.allKeys;
  for (id key in keys) {
    if (!([key isKindOfClass:[NSString class]] && [self[key] isKindOfClass:[NSArray class]])) {
      return stringVecVecMap;
    }

    stringVecVecMap[((NSString *)key).cppString] = ((NSArray *)self[key]).stringVecVecValue;
  }

  return stringVecVecMap;

}

- (IntVecMap)intVecMapValue {

  IntVecMap intVecMap;

  for (id key in self.allKeys) {
    if (!([key isKindOfClass:[NSString class]] && [self[key] isKindOfClass:[NSArray class]])) {
      return intVecMap;
    }

    intVecMap[((NSString *)key).cppString] = ((NSArray *)self[key]).intVecValue;
  }

  return intVecMap;

}

- (RealMatrixVecMap)realMatrixVecMapValue {

  RealMatrixVecMap realMatrixVecMap;

  for (id key in self.allKeys) {
    if (!([key isKindOfClass:[NSString class]] && [self[key] isKindOfClass:[NSArray class]])) {
      return realMatrixVecMap;
    }

    realMatrixVecMap[((NSString *)key).cppString] = ((NSArray *)self[key]).realMatrixVecValue;
  }

  return realMatrixVecMap;

}

- (StereoSampleVecMap)stereoSampleVecMapValue {

  StereoSampleVecMap stereoSampleVecMap;

  for (id key in self.allKeys) {
    if (!([key isKindOfClass:[NSString class]] && [self[key] isKindOfClass:[NSArray class]])) {
      return stereoSampleVecMap;
    }

    stereoSampleVecMap[((NSString *)key).cppString] = ((NSArray *)self[key]).stereoSampleVecValue;
  }

  return stereoSampleVecMap;

}


@end
