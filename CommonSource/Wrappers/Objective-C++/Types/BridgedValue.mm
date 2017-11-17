//
//  BridgedValue.mm
//  Essentia
//
//  Created by Jason Cardwell on 10/25/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
#import "BridgedValue.hpp"
#import "NSArray+BridgingExtensions.hpp"
#import "NSDictionary+BridgingExtensions.hpp"
#import "NSValue+BridgingExtensions.h"
#import "NSValue+CPPBridgingExtensions.hpp"
#import "NSString+BridgingExtensions.hpp"
#import "PoolWrapper+BridgingExtensions.hpp"
#import "Exceptions.h"

@implementation BridgedValue {
  @package
  BridgedType _type;
}

+ (instancetype)bridgedValueWithType:(BridgedType)type {

  switch (type) {
    case BridgedTypeReal:               return [RealBridgedValue new];
    case BridgedTypeString:             return [StringBridgedValue new];
    case BridgedTypeInt:                return [IntBridgedValue new];
    case BridgedTypeStereoSample:       return [StereoSampleBridgedValue new];
    case BridgedTypeRealMatrix:         return [RealMatrixBridgedValue new];
    case BridgedTypeComplexReal:        return [ComplexRealBridgedValue new];
    case BridgedTypePool:               return [PoolBridgedValue new];
    case BridgedTypeStringVec:          return [StringVecBridgedValue new];
    case BridgedTypeRealVec:            return [RealVecBridgedValue new];
    case BridgedTypeBoolVec:            return [BoolVecBridgedValue new];
    case BridgedTypeIntVec:             return [IntVecBridgedValue new];
    case BridgedTypeStereoSampleVec:    return [StereoSampleVecBridgedValue new];
    case BridgedTypeComplexRealVec:     return [ComplexRealVecBridgedValue new];
    case BridgedTypeRealMatrixVec:      return [RealMatrixVecBridgedValue new];
    case BridgedTypeRealVecVec:         return [RealVecVecBridgedValue new];
    case BridgedTypeStringVecVec:       return [StringVecVecBridgedValue new];
    case BridgedTypeComplexRealVecVec:  return [ComplexRealVecVecBridgedValue new];
    case BridgedTypeStereoSampleVecVec: return [StereoSampleVecVecBridgedValue new];
    case BridgedTypeRealVecMap:         return [RealVecMapBridgedValue new];
    case BridgedTypeRealMap:            return [RealMapBridgedValue new];
    case BridgedTypeStringMap:          return [StringMapBridgedValue new];
    case BridgedTypeIntVecMap:          return [IntVecMapBridgedValue new];
    case BridgedTypeStringVecMap:       return [StringVecMapBridgedValue new];
    case BridgedTypeRealMatrixVecMap:   return [RealMatrixVecMapBridgedValue new];
    case BridgedTypeStereoSampleVecMap: return [StereoSampleVecMapBridgedValue new];
    case BridgedTypeRealVecVecMap:      return [RealVecVecMapBridgedValue new];
    case BridgedTypeStringVecVecMap:    return [StringVecVecMapBridgedValue new];
  }


}


- (BridgedType)type { return _type; }

- (id)objcValue { @throw inconsistencyException(@"`BridgedValue` is an abstract base."); }

- (void)setOBJCValue:(id)objcValue { @throw inconsistencyException(@"`BridgedValue` is an abstract base."); }

@end

@implementation RealBridgedValue

- (Real&)value {
  return *_value;
}

- (void)setValue:(Real&)value {
  *_value = value;
}

- (OBJCReal)objcValue {
  return [NSNumber numberWithFloat:*_value];
}

- (void)setOBJCValue:(OBJCReal)objcValue {
  *_value = objcValue.floatValue;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    _type = BridgedTypeReal;
    _value = std::make_shared<Real>();
  }
  return self;
}

- (instancetype)initWithValue:(Real)value {
  self = [super init];
  if (self) {
    _type = BridgedTypeReal;
    _value = std::make_shared<Real>(value);
  }
  return self;
}

+ (instancetype)bridgedValueWithValue:(Real)value {
  return [[RealBridgedValue alloc] initWithValue:value];
}


- (instancetype)initBridgingValue:(OBJCReal)value {
  self = [super init];
  if (self) {
    _type = BridgedTypeReal;
    _value = std::make_shared<Real>(value.floatValue);
  }
  return self;
}

+ (instancetype)bridgedValueBridging:(OBJCReal)value {
  return [[RealBridgedValue alloc] initBridgingValue:value];
}


@end

@implementation StringBridgedValue

- (String&)value {
  return *_value;
}

- (void)setValue:(String&)value {
  *_value = value;
}

- (OBJCString)objcValue {
  return [NSString stringWithCPPString:*_value];
}

- (void)setOBJCValue:(OBJCString)objcValue {
  *_value = objcValue.cppString;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    _type = BridgedTypeString;
    _value = std::make_shared<String>();
  }
  return self;
}

- (instancetype)initWithValue:(String)value {
  self = [super init];
  if (self) {
    _type = BridgedTypeString;
    _value = std::make_shared<String>(value);
  }
  return self;
}

+ (instancetype)bridgedValueWithValue:(String)value {
  return [[StringBridgedValue alloc] initWithValue:value];
}


- (instancetype)initBridgingValue:(OBJCString)value {
  self = [super init];
  if (self) {
    _type = BridgedTypeString;
    _value = std::make_shared<String>(value.cppString);
  }
  return self;
}

+ (instancetype)bridgedValueBridging:(OBJCString)value {
  return [[StringBridgedValue alloc] initBridgingValue:value];
}


@end

@implementation IntBridgedValue

- (Int&)value {
  return *_value;
}

- (void)setValue:(Int&)value {
  *_value = value;
}

- (OBJCInt)objcValue {
  return [NSNumber numberWithInt:*_value];
}

- (void)setOBJCValue:(OBJCInt)objcValue {
  *_value = objcValue.intValue;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    _type = BridgedTypeInt;
    _value = std::make_shared<Int>();
  }
  return self;
}

- (instancetype)initWithValue:(Int)value {
  self = [super init];
  if (self) {
    _type = BridgedTypeInt;
    _value = std::make_shared<Int>(value);
  }
  return self;
}

+ (instancetype)bridgedValueWithValue:(Int)value {
  return [[IntBridgedValue alloc] initWithValue:value];
}


- (instancetype)initBridgingValue:(OBJCInt)value {
  self = [super init];
  if (self) {
    _type = BridgedTypeInt;
    _value = std::make_shared<Int>(value.intValue);
  }
  return self;
}

+ (instancetype)bridgedValueBridging:(OBJCInt)value {
  return [[IntBridgedValue alloc] initBridgingValue:value];
}


@end

@implementation StereoSampleBridgedValue

- (StereoSample&)value {
  return *_value;
}

- (void)setValue:(StereoSample&)value {
  *_value = value;
}

- (OBJCStereoSample)objcValue {
  return [NSValue valueWithCPPStereoSample:*_value];
}

- (void)setOBJCValue:(OBJCStereoSample)objcValue {
  *_value = objcValue.cppStereoSampleValue;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    _type = BridgedTypeStereoSample;
    _value = std::make_shared<StereoSample>();
  }
  return self;
}

- (instancetype)initWithValue:(StereoSample)value {
  self = [super init];
  if (self) {
    _type = BridgedTypeStereoSample;
    _value = std::make_shared<StereoSample>(value);
  }
  return self;
}

+ (instancetype)bridgedValueWithValue:(StereoSample)value {
  return [[StereoSampleBridgedValue alloc] initWithValue:value];
}


- (instancetype)initBridgingValue:(OBJCStereoSample)value {
  self = [super init];
  if (self) {
    _type = BridgedTypeStereoSample;
    _value = std::make_shared<StereoSample>(value.cppStereoSampleValue);
  }
  return self;
}

+ (instancetype)bridgedValueBridging:(OBJCStereoSample)value {
  return [[StereoSampleBridgedValue alloc] initBridgingValue:value];
}


@end

@implementation RealMatrixBridgedValue

- (RealMatrix&)value {
  return *_value;
}

- (void)setValue:(RealMatrix&)value {
  *_value = value;
}

- (OBJCRealMatrix)objcValue {
  return [NSArray arrayWithRealMatrix:*_value];
}

- (void)setOBJCValue:(OBJCRealMatrix)objcValue {
  *_value = objcValue.realMatrixValue;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    _type = BridgedTypeRealMatrix;
    _value = std::make_shared<RealMatrix>();
  }
  return self;
}

- (instancetype)initWithValue:(RealMatrix)value {
  self = [super init];
  if (self) {
    _type = BridgedTypeRealMatrix;
    _value = std::make_shared<RealMatrix>(value);
  }
  return self;
}

+ (instancetype)bridgedValueWithValue:(RealMatrix)value {
  return [[RealMatrixBridgedValue alloc] initWithValue:value];
}


- (instancetype)initBridgingValue:(OBJCRealMatrix)value {
  self = [super init];
  if (self) {
    _type = BridgedTypeRealMatrix;
    _value = std::make_shared<RealMatrix>(value.realMatrixValue);
  }
  return self;
}

+ (instancetype)bridgedValueBridging:(OBJCRealMatrix)value {
  return [[RealMatrixBridgedValue alloc] initBridgingValue:value];
}


@end

@implementation ComplexRealBridgedValue

- (ComplexReal&)value {
  return *_value;
}

- (void)setValue:(ComplexReal&)value {
  *_value = value;
}

- (OBJCComplexReal)objcValue {
  return [NSValue valueWithCPPComplex:*_value];
}

- (void)setOBJCValue:(OBJCComplexReal)objcValue {
  *_value = objcValue.cppComplexValue;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    _type = BridgedTypeComplexReal;
    _value = std::make_shared<ComplexReal>();
  }
  return self;
}

- (instancetype)initWithValue:(ComplexReal)value {
  self = [super init];
  if (self) {
    _type = BridgedTypeComplexReal;
    _value = std::make_shared<ComplexReal>(value);
  }
  return self;
}

+ (instancetype)bridgedValueWithValue:(ComplexReal)value {
  return [[ComplexRealBridgedValue alloc] initWithValue:value];
}


- (instancetype)initBridgingValue:(OBJCComplexReal)value {
  self = [super init];
  if (self) {
    _type = BridgedTypeComplexReal;
    _value = std::make_shared<ComplexReal>(value.cppComplexValue);
  }
  return self;
}

+ (instancetype)bridgedValueBridging:(OBJCComplexReal)value {
  return [[ComplexRealBridgedValue alloc] initBridgingValue:value];
}


@end

@implementation PoolBridgedValue

- (Pool&)value {
  return *_value;
}

- (void)setValue:(Pool&)value {
  *_value = value;
}

- (OBJCPool)objcValue {
  return [PoolWrapper poolWrapperWithPool:_value.get()];
}

- (void)setOBJCValue:(OBJCPool)objcValue {
  *_value = *(objcValue->_pool);
}

- (instancetype)init {
  self = [super init];
  if (self) {
    _type = BridgedTypePool;
    _value = std::make_shared<Pool>();
  }
  return self;
}

- (instancetype)initWithValue:(Pool)value {
  self = [super init];
  if (self) {
    _type = BridgedTypePool;
    _value = std::make_shared<Pool>(value);
  }
  return self;
}

+ (instancetype)bridgedValueWithValue:(Pool)value {
  return [[PoolBridgedValue alloc] initWithValue:value];
}


- (instancetype)initBridgingValue:(OBJCPool)value {
  self = [super init];
  if (self) {
    _type = BridgedTypePool;
    _value = std::make_shared<Pool>(*(value->_pool));
  }
  return self;
}

+ (instancetype)bridgedValueBridging:(OBJCPool)value {
  return [[PoolBridgedValue alloc] initBridgingValue:value];
}


@end

@implementation StringVecBridgedValue

- (StringVec&)value {
  return *_value;
}

- (void)setValue:(StringVec&)value {
  *_value = value;
}

- (OBJCStringVec)objcValue {
  return [NSArray arrayWithStringVec:*_value];
}

- (void)setOBJCValue:(OBJCStringVec)objcValue {
  *_value = objcValue.stringVecValue;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    _type = BridgedTypeStringVec;
    _value = std::make_shared<StringVec>();
  }
  return self;
}

- (instancetype)initWithValue:(StringVec)value {
  self = [super init];
  if (self) {
    _type = BridgedTypeStringVec;
    _value = std::make_shared<StringVec>(value);
  }
  return self;
}

+ (instancetype)bridgedValueWithValue:(StringVec)value {
  return [[StringVecBridgedValue alloc] initWithValue:value];
}


- (instancetype)initBridgingValue:(OBJCStringVec)value {
  self = [super init];
  if (self) {
    _type = BridgedTypeStringVec;
    _value = std::make_shared<StringVec>(value.stringVecValue);
  }
  return self;
}

+ (instancetype)bridgedValueBridging:(OBJCStringVec)value {
  return [[StringVecBridgedValue alloc] initBridgingValue:value];
}


@end

@implementation RealVecBridgedValue

- (RealVec&)value {
  return *_value;
}

- (void)setValue:(RealVec&)value {
  *_value = value;
}

- (OBJCRealVec)objcValue {
  return [NSArray arrayWithRealVec:*_value];
}

- (void)setOBJCValue:(OBJCRealVec)objcValue {
  *_value = objcValue.realVecValue;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    _type = BridgedTypeRealVec;
    _value = std::make_shared<RealVec>();
  }
  return self;
}

- (instancetype)initWithValue:(RealVec)value {
  self = [super init];
  if (self) {
    _type = BridgedTypeRealVec;
    _value = std::make_shared<RealVec>(value);
  }
  return self;
}

+ (instancetype)bridgedValueWithValue:(RealVec)value {
  return [[RealVecBridgedValue alloc] initWithValue:value];
}


- (instancetype)initBridgingValue:(OBJCRealVec)value {
  self = [super init];
  if (self) {
    _type = BridgedTypeRealVec;
    _value = std::make_shared<RealVec>(value.realVecValue);
  }
  return self;
}

+ (instancetype)bridgedValueBridging:(OBJCRealVec)value {
  return [[RealVecBridgedValue alloc] initBridgingValue:value];
}


@end

@implementation BoolVecBridgedValue

- (BoolVec&)value {
  return *_value;
}

- (void)setValue:(BoolVec&)value {
  *_value = value;
}

- (OBJCBoolVec)objcValue {
  return [NSArray arrayWithBoolVec:*_value];
}

- (void)setOBJCValue:(OBJCBoolVec)objcValue {
  *_value = objcValue.boolVecValue;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    _type = BridgedTypeBoolVec;
    _value = std::make_shared<BoolVec>();
  }
  return self;
}

- (instancetype)initWithValue:(BoolVec)value {
  self = [super init];
  if (self) {
    _type = BridgedTypeBoolVec;
    _value = std::make_shared<BoolVec>(value);
  }
  return self;
}

+ (instancetype)bridgedValueWithValue:(BoolVec)value {
  return [[BoolVecBridgedValue alloc] initWithValue:value];
}


- (instancetype)initBridgingValue:(OBJCBoolVec)value {
  self = [super init];
  if (self) {
    _type = BridgedTypeBoolVec;
    _value = std::make_shared<BoolVec>(value.boolVecValue);
  }
  return self;
}

+ (instancetype)bridgedValueBridging:(OBJCBoolVec)value {
  return [[BoolVecBridgedValue alloc] initBridgingValue:value];
}


@end

@implementation IntVecBridgedValue

- (IntVec&)value {
  return *_value;
}

- (void)setValue:(IntVec&)value {
  *_value = value;
}

- (OBJCIntVec)objcValue {
  return [NSArray arrayWithIntVec:*_value];;
}

- (void)setOBJCValue:(OBJCIntVec)objcValue {
  *_value = objcValue.intVecValue;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    _type = BridgedTypeIntVec;
    _value = std::make_shared<IntVec>();
  }
  return self;
}

- (instancetype)initWithValue:(IntVec)value {
  self = [super init];
  if (self) {
    _type = BridgedTypeIntVec;
    _value = std::make_shared<IntVec>(value);
  }
  return self;
}

+ (instancetype)bridgedValueWithValue:(IntVec)value {
  return [[IntVecBridgedValue alloc] initWithValue:value];
}


- (instancetype)initBridgingValue:(OBJCIntVec)value {
  self = [super init];
  if (self) {
    _type = BridgedTypeIntVec;
    _value = std::make_shared<IntVec>(value.intVecValue);
  }
  return self;
}

+ (instancetype)bridgedValueBridging:(OBJCIntVec)value {
  return [[IntVecBridgedValue alloc] initBridgingValue:value];
}


@end

@implementation StereoSampleVecBridgedValue

- (StereoSampleVec&)value {
  return *_value;
}

- (void)setValue:(StereoSampleVec&)value {
  *_value = value;
}

- (OBJCStereoSampleVec)objcValue {
  return [NSArray arrayWithStereoSampleVec:*_value];
}

- (void)setOBJCValue:(OBJCStereoSampleVec)objcValue {
  *_value = objcValue.stereoSampleVecValue;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    _type = BridgedTypeStereoSampleVec;
    _value = std::make_shared<StereoSampleVec>();
  }
  return self;
}

- (instancetype)initWithValue:(StereoSampleVec)value {
  self = [super init];
  if (self) {
    _type = BridgedTypeStereoSampleVec;
    _value = std::make_shared<StereoSampleVec>(value);
  }
  return self;
}

+ (instancetype)bridgedValueWithValue:(StereoSampleVec)value {
  return [[StereoSampleVecBridgedValue alloc] initWithValue:value];
}


- (instancetype)initBridgingValue:(OBJCStereoSampleVec)value {
  self = [super init];
  if (self) {
    _type = BridgedTypeStereoSampleVec;
    _value = std::make_shared<StereoSampleVec>(value.stereoSampleVecValue);
  }
  return self;
}

+ (instancetype)bridgedValueBridging:(OBJCStereoSampleVec)value {
  return [[StereoSampleVecBridgedValue alloc] initBridgingValue:value];
}


@end

@implementation ComplexRealVecBridgedValue

- (ComplexRealVec&)value {
  return *_value;
}

- (void)setValue:(ComplexRealVec&)value {
  *_value = value;
}

- (OBJCComplexRealVec)objcValue {
  return [NSArray arrayWithComplexRealVec:*_value];
}

- (void)setOBJCValue:(OBJCComplexRealVec)objcValue {
  *_value = objcValue.complexRealVecValue;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    _type = BridgedTypeComplexRealVec;
    _value = std::make_shared<ComplexRealVec>();
  }
  return self;
}

- (instancetype)initWithValue:(ComplexRealVec)value {
  self = [super init];
  if (self) {
    _type = BridgedTypeComplexRealVec;
    _value = std::make_shared<ComplexRealVec>(value);
  }
  return self;
}

+ (instancetype)bridgedValueWithValue:(ComplexRealVec)value {
  return [[ComplexRealVecBridgedValue alloc] initWithValue:value];
}


- (instancetype)initBridgingValue:(OBJCComplexRealVec)value {
  self = [super init];
  if (self) {
    _type = BridgedTypeComplexRealVec;
    _value = std::make_shared<ComplexRealVec>(value.complexRealVecValue);
  }
  return self;
}

+ (instancetype)bridgedValueBridging:(OBJCComplexRealVec)value {
  return [[ComplexRealVecBridgedValue alloc] initBridgingValue:value];
}


@end

@implementation RealMatrixVecBridgedValue

- (RealMatrixVec&)value {
  return *_value;
}

- (void)setValue:(RealMatrixVec&)value {
  *_value = value;
}

- (OBJCRealMatrixVec)objcValue {
  return [NSArray arrayWithRealMatrixVec:*_value];
}

- (void)setOBJCValue:(OBJCRealMatrixVec)objcValue {
  *_value = objcValue.realMatrixVecValue;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    _type = BridgedTypeRealMatrixVec;
    _value = std::make_shared<RealMatrixVec>();
  }
  return self;
}

- (instancetype)initWithValue:(RealMatrixVec)value {
  self = [super init];
  if (self) {
    _type = BridgedTypeRealMatrixVec;
    _value = std::make_shared<RealMatrixVec>(value);
  }
  return self;
}

+ (instancetype)bridgedValueWithValue:(RealMatrixVec)value {
  return [[RealMatrixVecBridgedValue alloc] initWithValue:value];
}


- (instancetype)initBridgingValue:(OBJCRealMatrixVec)value {
  self = [super init];
  if (self) {
    _type = BridgedTypeRealMatrixVec;
    _value = std::make_shared<RealMatrixVec>(value.realMatrixVecValue);
  }
  return self;
}

+ (instancetype)bridgedValueBridging:(OBJCRealMatrixVec)value {
  return [[RealMatrixVecBridgedValue alloc] initBridgingValue:value];
}


@end

@implementation RealVecVecBridgedValue

- (RealVecVec&)value {
  return *_value;
}

- (void)setValue:(RealVecVec&)value {
  *_value = value;
}

- (OBJCRealVecVec)objcValue {
  return [NSArray arrayWithRealVecVec:*_value];
}

- (void)setOBJCValue:(OBJCRealVecVec)objcValue {
  *_value = objcValue.realVecVecValue;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    _type = BridgedTypeRealVecVec;
    _value = std::make_shared<RealVecVec>();
  }
  return self;
}

- (instancetype)initWithValue:(RealVecVec)value {
  self = [super init];
  if (self) {
    _type = BridgedTypeRealVecVec;
    _value = std::make_shared<RealVecVec>(value);
  }
  return self;
}

+ (instancetype)bridgedValueWithValue:(RealVecVec)value {
  return [[RealVecVecBridgedValue alloc] initWithValue:value];
}


- (instancetype)initBridgingValue:(OBJCRealVecVec)value {
  self = [super init];
  if (self) {
    _type = BridgedTypeRealVecVec;
    _value = std::make_shared<RealVecVec>(value.realVecVecValue);
  }
  return self;
}

+ (instancetype)bridgedValueBridging:(OBJCRealVecVec)value {
  return [[RealVecVecBridgedValue alloc] initBridgingValue:value];
}


@end

@implementation StringVecVecBridgedValue

- (StringVecVec&)value {
  return *_value;
}

- (void)setValue:(StringVecVec&)value {
  *_value = value;
}

- (OBJCStringVecVec)objcValue {
  return [NSArray arrayWithStringVecVec:*_value];
}

- (void)setOBJCValue:(OBJCStringVecVec)objcValue {
  *_value = objcValue.stringVecVecValue;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    _type = BridgedTypeStringVecVec;
    _value = std::make_shared<StringVecVec>();
  }
  return self;
}

- (instancetype)initWithValue:(StringVecVec)value {
  self = [super init];
  if (self) {
    _type = BridgedTypeStringVecVec;
    _value = std::make_shared<StringVecVec>(value);
  }
  return self;
}

+ (instancetype)bridgedValueWithValue:(StringVecVec)value {
  return [[StringVecVecBridgedValue alloc] initWithValue:value];
}


- (instancetype)initBridgingValue:(OBJCStringVecVec)value {
  self = [super init];
  if (self) {
    _type = BridgedTypeStringVecVec;
    _value = std::make_shared<StringVecVec>(value.stringVecVecValue);
  }
  return self;
}

+ (instancetype)bridgedValueBridging:(OBJCStringVecVec)value {
  return [[StringVecVecBridgedValue alloc] initBridgingValue:value];
}


@end

@implementation ComplexRealVecVecBridgedValue

- (ComplexRealVecVec&)value {
  return *_value;
}

- (void)setValue:(ComplexRealVecVec&)value {
  *_value = value;
}

- (OBJCComplexRealVecVec)objcValue {
  return [NSArray arrayWithComplexRealVecVec:*_value];
}

- (void)setOBJCValue:(OBJCComplexRealVecVec)objcValue {
  *_value = objcValue.complexRealVecVecValue;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    _type = BridgedTypeComplexRealVecVec;
    _value = std::make_shared<ComplexRealVecVec>();
  }
  return self;
}

- (instancetype)initWithValue:(ComplexRealVecVec)value {
  self = [super init];
  if (self) {
    _type = BridgedTypeComplexRealVecVec;
    _value = std::make_shared<ComplexRealVecVec>(value);
  }
  return self;
}

+ (instancetype)bridgedValueWithValue:(ComplexRealVecVec)value {
  return [[ComplexRealVecVecBridgedValue alloc] initWithValue:value];
}


- (instancetype)initBridgingValue:(OBJCComplexRealVecVec)value {
  self = [super init];
  if (self) {
    _type = BridgedTypeComplexRealVecVec;
    _value = std::make_shared<ComplexRealVecVec>(value.complexRealVecVecValue);
  }
  return self;
}

+ (instancetype)bridgedValueBridging:(OBJCComplexRealVecVec)value {
  return [[ComplexRealVecVecBridgedValue alloc] initBridgingValue:value];
}


@end

@implementation StereoSampleVecVecBridgedValue

- (StereoSampleVecVec&)value {
  return *_value;
}

- (void)setValue:(StereoSampleVecVec&)value {
  *_value = value;
}

- (OBJCStereoSampleVecVec)objcValue {
  return [NSArray arrayWithStereoSampleVecVec:*_value];
}

- (void)setOBJCValue:(OBJCStereoSampleVecVec)objcValue {
  *_value = objcValue.stereoSampleVecVecValue;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    _type = BridgedTypeStereoSampleVecVec;
    _value = std::make_shared<StereoSampleVecVec>();
  }
  return self;
}

- (instancetype)initWithValue:(StereoSampleVecVec)value {
  self = [super init];
  if (self) {
    _type = BridgedTypeStereoSampleVecVec;
    _value = std::make_shared<StereoSampleVecVec>(value);
  }
  return self;
}

+ (instancetype)bridgedValueWithValue:(StereoSampleVecVec)value {
  return [[StereoSampleVecVecBridgedValue alloc] initWithValue:value];
}


- (instancetype)initBridgingValue:(OBJCStereoSampleVecVec)value {
  self = [super init];
  if (self) {
    _type = BridgedTypeStereoSampleVecVec;
    _value = std::make_shared<StereoSampleVecVec>(value.stereoSampleVecVecValue);
  }
  return self;
}

+ (instancetype)bridgedValueBridging:(OBJCStereoSampleVecVec)value {
  return [[StereoSampleVecVecBridgedValue alloc] initBridgingValue:value];
}


@end

@implementation RealVecMapBridgedValue

- (RealVecMap&)value {
  return *_value;
}

- (void)setValue:(RealVecMap&)value {
  *_value = value;
}

- (OBJCRealVecMap)objcValue {
  return [NSDictionary dictionaryWithRealVecMap:*_value];
}

- (void)setOBJCValue:(OBJCRealVecMap)objcValue {
  *_value = objcValue.realVecMapValue;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    _type = BridgedTypeRealVecMap;
    _value = std::make_shared<RealVecMap>();
  }
  return self;
}

- (instancetype)initWithValue:(RealVecMap)value {
  self = [super init];
  if (self) {
    _type = BridgedTypeRealVecMap;
    _value = std::make_shared<RealVecMap>(value);
  }
  return self;
}

+ (instancetype)bridgedValueWithValue:(RealVecMap)value {
  return [[RealVecMapBridgedValue alloc] initWithValue:value];
}


- (instancetype)initBridgingValue:(OBJCRealVecMap)value {
  self = [super init];
  if (self) {
    _type = BridgedTypeRealVecMap;
    _value = std::make_shared<RealVecMap>(value.realVecMapValue);
  }
  return self;
}

+ (instancetype)bridgedValueBridging:(OBJCRealVecMap)value {
  return [[RealVecMapBridgedValue alloc] initBridgingValue:value];
}


@end

@implementation RealMapBridgedValue

- (RealMap&)value {
  return *_value;
}

- (void)setValue:(RealMap&)value {
  *_value = value;
}

- (OBJCRealMap)objcValue {
  return [NSDictionary dictionaryWithRealMap:*_value];
}

- (void)setOBJCValue:(OBJCRealMap)objcValue {
  *_value = objcValue.realMapValue;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    _type = BridgedTypeRealMap;
    _value = std::make_shared<RealMap>();
  }
  return self;
}

- (instancetype)initWithValue:(RealMap)value {
  self = [super init];
  if (self) {
    _type = BridgedTypeRealMap;
    _value = std::make_shared<RealMap>(value);
  }
  return self;
}

+ (instancetype)bridgedValueWithValue:(RealMap)value {
  return [[RealMapBridgedValue alloc] initWithValue:value];
}


- (instancetype)initBridgingValue:(OBJCRealMap)value {
  self = [super init];
  if (self) {
    _type = BridgedTypeRealMap;
    _value = std::make_shared<RealMap>(value.realMapValue);
  }
  return self;
}

+ (instancetype)bridgedValueBridging:(OBJCRealMap)value {
  return [[RealMapBridgedValue alloc] initBridgingValue:value];
}


@end

@implementation StringMapBridgedValue

- (StringMap&)value {
  return *_value;
}

- (void)setValue:(StringMap&)value {
  *_value = value;
}

- (OBJCStringMap)objcValue {
  return [NSDictionary dictionaryWithStringMap:*_value];
}

- (void)setOBJCValue:(OBJCStringMap)objcValue {
  *_value = objcValue.stringMapValue;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    _type = BridgedTypeStringMap;
    _value = std::make_shared<StringMap>();
  }
  return self;
}

- (instancetype)initWithValue:(StringMap)value {
  self = [super init];
  if (self) {
    _type = BridgedTypeStringMap;
    _value = std::make_shared<StringMap>(value);
  }
  return self;
}

+ (instancetype)bridgedValueWithValue:(StringMap)value {
  return [[StringMapBridgedValue alloc] initWithValue:value];
}


- (instancetype)initBridgingValue:(OBJCStringMap)value {
  self = [super init];
  if (self) {
    _type = BridgedTypeStringMap;
    _value = std::make_shared<StringMap>(value.stringMapValue);
  }
  return self;
}

+ (instancetype)bridgedValueBridging:(OBJCStringMap)value {
  return [[StringMapBridgedValue alloc] initBridgingValue:value];
}


@end

@implementation IntVecMapBridgedValue

- (IntVecMap&)value {
  return *_value;
}

- (void)setValue:(IntVecMap&)value {
  *_value = value;
}

- (OBJCIntVecMap)objcValue {
  return [NSDictionary dictionaryWithIntVecMap:*_value];
}

- (void)setOBJCValue:(OBJCIntVecMap)objcValue {
  *_value = objcValue.intVecMapValue;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    _type = BridgedTypeIntVecMap;
    _value = std::make_shared<IntVecMap>();
  }
  return self;
}

- (instancetype)initWithValue:(IntVecMap)value {
  self = [super init];
  if (self) {
    _type = BridgedTypeIntVecMap;
    _value = std::make_shared<IntVecMap>(value);
  }
  return self;
}

+ (instancetype)bridgedValueWithValue:(IntVecMap)value {
  return [[IntVecMapBridgedValue alloc] initWithValue:value];
}


- (instancetype)initBridgingValue:(OBJCIntVecMap)value {
  self = [super init];
  if (self) {
    _type = BridgedTypeIntVecMap;
    _value = std::make_shared<IntVecMap>(value.intVecMapValue);
  }
  return self;
}

+ (instancetype)bridgedValueBridging:(OBJCIntVecMap)value {
  return [[IntVecMapBridgedValue alloc] initBridgingValue:value];
}


@end

@implementation StringVecMapBridgedValue

- (StringVecMap&)value {
  return *_value;
}

- (void)setValue:(StringVecMap&)value {
  *_value = value;
}

- (OBJCStringVecMap)objcValue {
  return [NSDictionary dictionaryWithStringVecMap:*_value];
}

- (void)setOBJCValue:(OBJCStringVecMap)objcValue {
  *_value = objcValue.stringVecMapValue;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    _type = BridgedTypeStringVecMap;
    _value = std::make_shared<StringVecMap>();
  }
  return self;
}

- (instancetype)initWithValue:(StringVecMap)value {
  self = [super init];
  if (self) {
    _type = BridgedTypeStringVecMap;
    _value = std::make_shared<StringVecMap>(value);
  }
  return self;
}

+ (instancetype)bridgedValueWithValue:(StringVecMap)value {
  return [[StringVecMapBridgedValue alloc] initWithValue:value];
}


- (instancetype)initBridgingValue:(OBJCStringVecMap)value {
  self = [super init];
  if (self) {
    _type = BridgedTypeStringVecMap;
    _value = std::make_shared<StringVecMap>(value.stringVecMapValue);
  }
  return self;
}

+ (instancetype)bridgedValueBridging:(OBJCStringVecMap)value {
  return [[StringVecMapBridgedValue alloc] initBridgingValue:value];
}


@end

@implementation RealMatrixVecMapBridgedValue

- (RealMatrixVecMap&)value {
  return *_value;
}

- (void)setValue:(RealMatrixVecMap&)value {
  *_value = value;
}

- (OBJCRealMatrixVecMap)objcValue {
  return [NSDictionary dictionaryWithRealMatrixVecMap:*_value];
}

- (void)setOBJCValue:(OBJCRealMatrixVecMap)objcValue {
  *_value = objcValue.realMatrixVecMapValue;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    _type = BridgedTypeRealMatrixVecMap;
    _value = std::make_shared<RealMatrixVecMap>();
  }
  return self;
}

- (instancetype)initWithValue:(RealMatrixVecMap)value {
  self = [super init];
  if (self) {
    _type = BridgedTypeRealMatrixVecMap;
    _value = std::make_shared<RealMatrixVecMap>(value);
  }
  return self;
}

+ (instancetype)bridgedValueWithValue:(RealMatrixVecMap)value {
  return [[RealMatrixVecMapBridgedValue alloc] initWithValue:value];
}


- (instancetype)initBridgingValue:(OBJCRealMatrixVecMap)value {
  self = [super init];
  if (self) {
    _type = BridgedTypeRealMatrixVecMap;
    _value = std::make_shared<RealMatrixVecMap>(value.realMatrixVecMapValue);
  }
  return self;
}

+ (instancetype)bridgedValueBridging:(OBJCRealMatrixVecMap)value {
  return [[RealMatrixVecMapBridgedValue alloc] initBridgingValue:value];
}


@end

@implementation StereoSampleVecMapBridgedValue

- (StereoSampleVecMap&)value {
  return *_value;
}

- (void)setValue:(StereoSampleVecMap&)value {
  *_value = value;
}

- (OBJCStereoSampleVecMap)objcValue {
  return [NSDictionary dictionaryWithStereoSampleVecMap:*_value];
}

- (void)setOBJCValue:(OBJCStereoSampleVecMap)objcValue {
  *_value = objcValue.stereoSampleVecMapValue;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    _type = BridgedTypeStereoSampleVecMap;
    _value = std::make_shared<StereoSampleVecMap>();
  }
  return self;
}

- (instancetype)initWithValue:(StereoSampleVecMap)value {
  self = [super init];
  if (self) {
    _type = BridgedTypeStereoSampleVecMap;
    _value = std::make_shared<StereoSampleVecMap>(value);
  }
  return self;
}

+ (instancetype)bridgedValueWithValue:(StereoSampleVecMap)value {
  return [[StereoSampleVecMapBridgedValue alloc] initWithValue:value];
}


- (instancetype)initBridgingValue:(OBJCStereoSampleVecMap)value {
  self = [super init];
  if (self) {
    _type = BridgedTypeStereoSampleVecMap;
    _value = std::make_shared<StereoSampleVecMap>(value.stereoSampleVecMapValue);
  }
  return self;
}

+ (instancetype)bridgedValueBridging:(OBJCStereoSampleVecMap)value {
  return [[StereoSampleVecMapBridgedValue alloc] initBridgingValue:value];
}


@end

@implementation RealVecVecMapBridgedValue

- (RealVecVecMap&)value {
  return *_value;
}

- (void)setValue:(RealVecVecMap&)value {
  *_value = value;
}

- (OBJCRealVecVecMap)objcValue {
  return [NSDictionary dictionaryWithRealVecVecMap:*_value];
}

- (void)setOBJCValue:(OBJCRealVecVecMap)objcValue {
  *_value = objcValue.realVecVecMapValue;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    _type = BridgedTypeRealVecVecMap;
    _value = std::make_shared<RealVecVecMap>();
  }
  return self;
}

- (instancetype)initWithValue:(RealVecVecMap)value {
  self = [super init];
  if (self) {
    _type = BridgedTypeRealVecVecMap;
    _value = std::make_shared<RealVecVecMap>(value);
  }
  return self;
}

+ (instancetype)bridgedValueWithValue:(RealVecVecMap)value {
  return [[RealVecVecMapBridgedValue alloc] initWithValue:value];
}


- (instancetype)initBridgingValue:(OBJCRealVecVecMap)value {
  self = [super init];
  if (self) {
    _type = BridgedTypeRealVecVecMap;
    _value = std::make_shared<RealVecVecMap>(value.realVecVecMapValue);
  }
  return self;
}

+ (instancetype)bridgedValueBridging:(OBJCRealVecVecMap)value {
  return [[RealVecVecMapBridgedValue alloc] initBridgingValue:value];
}


@end

@implementation StringVecVecMapBridgedValue

- (StringVecVecMap&)value {
  return *_value;
}

- (void)setValue:(StringVecVecMap&)value {
  *_value = value;
}

- (OBJCStringVecVecMap)objcValue {
  return [NSDictionary dictionaryWithStringVecVecMap:*_value];
}

- (void)setOBJCValue:(OBJCStringVecVecMap)objcValue {
  *_value = objcValue.stringVecVecMapValue;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    _type = BridgedTypeStringVecVecMap;
    _value = std::make_shared<StringVecVecMap>();
  }
  return self;
}

- (instancetype)initWithValue:(StringVecVecMap)value {
  self = [super init];
  if (self) {
    _type = BridgedTypeStringVecVecMap;
    _value = std::make_shared<StringVecVecMap>(value);
  }
  return self;
}

+ (instancetype)bridgedValueWithValue:(StringVecVecMap)value {
  return [[StringVecVecMapBridgedValue alloc] initWithValue:value];
}


- (instancetype)initBridgingValue:(OBJCStringVecVecMap)value {
  self = [super init];
  if (self) {
    _type = BridgedTypeStringVecVecMap;
    _value = std::make_shared<StringVecVecMap>(value.stringVecVecMapValue);
  }
  return self;
}

+ (instancetype)bridgedValueBridging:(OBJCStringVecVecMap)value {
  return [[StringVecVecMapBridgedValue alloc] initBridgingValue:value];
}


@end
