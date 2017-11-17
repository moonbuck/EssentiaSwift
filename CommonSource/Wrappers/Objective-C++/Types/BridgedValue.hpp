//
//  BridgedValue.hpp
//  Essentia
//
//  Created by Jason Cardwell on 10/25/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <memory>
#import "WrappedTypes.h"
#import "WrappedTypes.hpp"

/**
 Enumeration of type supported by `BridgedValue`.

 - BridgedTypeReal: A real value.
 - BridgedTypeString: A string value.
 - BridgedTypeInt: An integer value.
 - BridgedTypeStereoSample: A stereo sample value.
 - BridgedTypeRealMatrix: A real matrix.
 - BridgedTypeComplexReal: A complex real value.
 - BridgedTypePool: A pool value.
 - BridgedTypeStringVec: A vector of strings.
 - BridgedTypeRealVec: A vector of real values.
 - BridgedTypeBoolVec: A vector of boolean values.
 - BridgedTypeIntVec: A vector of integer values.
 - BridgedTypeStereoSampleVec: A vector of stereo samples.
 - BridgedTypeComplexRealVec: A vector of complex real values
 - BridgedTypeRealMatrixVec: A vector of real matrices.
 - BridgedTypeRealVecVec: A vector of vectors of real values.
 - BridgedTypeStringVecVec: A vector of vectors of strings.
 - BridgedTypeComplexRealVecVec: A vector of vectors of complex real values.
 - BridgedTypeStereoSampleVecVec: A vector of vectors of stereo samples.
 - BridgedTypeRealVecMap: A map of vectors of real values.
 - BridgedTypeRealMap: A map of real values.
 - BridgedTypeStringMap: A map of strings.
 - BridgedTypeIntVecMap: A map of vectors of integer values.
 - BridgedTypeStringVecMap: A map of vectors of strings.
 - BridgedTypeRealMatrixVecMap: A map of vectors of real matrices.
 - BridgedTypeStereoSampleVecMap: A map of vectors of stereo samples.
 - BridgedTypeRealVecVecMap: A map of vectors of vectors of real values.
 - BridgedTypeStringVecVecMap: A map of vectors of vectors of strings.
 */
typedef NS_ENUM(NSUInteger, BridgedType) {
  BridgedTypeReal,
  BridgedTypeString,
  BridgedTypeInt,
  BridgedTypeStereoSample,
  BridgedTypeRealMatrix,
  BridgedTypeComplexReal,
  BridgedTypePool,

  BridgedTypeStringVec,
  BridgedTypeRealVec,
  BridgedTypeBoolVec,
  BridgedTypeIntVec,
  BridgedTypeStereoSampleVec,
  BridgedTypeComplexRealVec,
  BridgedTypeRealMatrixVec,

  BridgedTypeRealVecVec,
  BridgedTypeStringVecVec,
  BridgedTypeComplexRealVecVec,
  BridgedTypeStereoSampleVecVec,

  BridgedTypeRealVecMap,
  BridgedTypeRealMap,
  BridgedTypeStringMap,
  BridgedTypeIntVecMap,
  BridgedTypeStringVecMap,
  BridgedTypeRealMatrixVecMap,
  BridgedTypeStereoSampleVecMap,

  BridgedTypeRealVecVecMap,
  BridgedTypeStringVecVecMap
};

NS_ASSUME_NONNULL_BEGIN

@interface BridgedValue : NSObject

+ (instancetype)bridgedValueWithType:(BridgedType)type;

@property (nonatomic, readonly) BridgedType type;

@property (nonatomic, readwrite, setter=setOBJCValue:) id objcValue;

@end

@interface RealBridgedValue : BridgedValue {
  @package
  std::shared_ptr<Real> _value;
}

@property (nonatomic, readwrite) Real& value;

@property (nonatomic, readwrite, setter=setOBJCValue:) OBJCReal objcValue;

- (instancetype)initWithValue:(Real)value;
+ (instancetype)bridgedValueWithValue:(Real)value;

- (instancetype)initBridgingValue:(OBJCReal)value;
+ (instancetype)bridgedValueBridging:(OBJCReal)value;

@end

@interface StringBridgedValue : BridgedValue {
  @package
  std::shared_ptr<String> _value;
}

@property (nonatomic, readwrite) String& value;

@property (nonatomic, readwrite, setter=setOBJCValue:) OBJCString objcValue;

- (instancetype)initWithValue:(String)value;
+ (instancetype)bridgedValueWithValue:(String)value;

- (instancetype)initBridgingValue:(OBJCString)value;
+ (instancetype)bridgedValueBridging:(OBJCString)value;

@end

@interface IntBridgedValue : BridgedValue {
  @package
  std::shared_ptr<Int> _value;
}

@property (nonatomic, readwrite) Int& value;

@property (nonatomic, readwrite, setter=setOBJCValue:) OBJCInt objcValue;

- (instancetype)initWithValue:(Int)value;
+ (instancetype)bridgedValueWithValue:(Int)value;

- (instancetype)initBridgingValue:(OBJCInt)value;
+ (instancetype)bridgedValueBridging:(OBJCInt)value;

@end

@interface StereoSampleBridgedValue : BridgedValue {
  @package
  std::shared_ptr<StereoSample> _value;
}

@property (nonatomic, readwrite) StereoSample& value;

@property (nonatomic, readwrite, setter=setOBJCValue:) OBJCStereoSample objcValue;

- (instancetype)initWithValue:(StereoSample)value;
+ (instancetype)bridgedValueWithValue:(StereoSample)value;

- (instancetype)initBridgingValue:(OBJCStereoSample)value;
+ (instancetype)bridgedValueBridging:(OBJCStereoSample)value;

@end

@interface RealMatrixBridgedValue : BridgedValue {
  @package
  std::shared_ptr<RealMatrix> _value;
}

@property (nonatomic, readwrite) RealMatrix& value;

@property (nonatomic, readwrite, setter=setOBJCValue:) OBJCRealMatrix objcValue;

- (instancetype)initWithValue:(RealMatrix)value;
+ (instancetype)bridgedValueWithValue:(RealMatrix)value;

- (instancetype)initBridgingValue:(OBJCRealMatrix)value;
+ (instancetype)bridgedValueBridging:(OBJCRealMatrix)value;

@end

@interface ComplexRealBridgedValue : BridgedValue {
  @package
  std::shared_ptr<ComplexReal> _value;
}

@property (nonatomic, readwrite) ComplexReal& value;

@property (nonatomic, readwrite, setter=setOBJCValue:) OBJCComplexReal objcValue;

- (instancetype)initWithValue:(ComplexReal)value;
+ (instancetype)bridgedValueWithValue:(ComplexReal)value;

- (instancetype)initBridgingValue:(OBJCComplexReal)value;
+ (instancetype)bridgedValueBridging:(OBJCComplexReal)value;

@end

@interface PoolBridgedValue : BridgedValue {
  @package
  std::shared_ptr<Pool> _value;
}

@property (nonatomic, readwrite) Pool& value;

@property (nonatomic, readwrite, setter=setOBJCValue:) OBJCPool objcValue;

- (instancetype)initWithValue:(Pool)value;
+ (instancetype)bridgedValueWithValue:(Pool)value;

- (instancetype)initBridgingValue:(OBJCPool)value;
+ (instancetype)bridgedValueBridging:(OBJCPool)value;

@end

@interface StringVecBridgedValue : BridgedValue {
  @package
  std::shared_ptr<StringVec> _value;
}

@property (nonatomic, readwrite) StringVec& value;

@property (nonatomic, readwrite, setter=setOBJCValue:) OBJCStringVec objcValue;

- (instancetype)initWithValue:(StringVec)value;
+ (instancetype)bridgedValueWithValue:(StringVec)value;

- (instancetype)initBridgingValue:(OBJCStringVec)value;
+ (instancetype)bridgedValueBridging:(OBJCStringVec)value;

@end

@interface RealVecBridgedValue : BridgedValue {
  @package
  std::shared_ptr<RealVec> _value;
}

@property (nonatomic, readwrite) RealVec& value;

@property (nonatomic, readwrite, setter=setOBJCValue:) OBJCRealVec objcValue;

- (instancetype)initWithValue:(RealVec)value;
+ (instancetype)bridgedValueWithValue:(RealVec)value;

- (instancetype)initBridgingValue:(OBJCRealVec)value;
+ (instancetype)bridgedValueBridging:(OBJCRealVec)value;

@end

@interface BoolVecBridgedValue : BridgedValue {
  @package
  std::shared_ptr<BoolVec> _value;
}

@property (nonatomic, readwrite) BoolVec& value;

@property (nonatomic, readwrite, setter=setOBJCValue:) OBJCBoolVec objcValue;

- (instancetype)initWithValue:(BoolVec)value;
+ (instancetype)bridgedValueWithValue:(BoolVec)value;

- (instancetype)initBridgingValue:(OBJCBoolVec)value;
+ (instancetype)bridgedValueBridging:(OBJCBoolVec)value;

@end

@interface IntVecBridgedValue : BridgedValue {
  @package
  std::shared_ptr<IntVec> _value;
}

@property (nonatomic, readwrite) IntVec& value;

@property (nonatomic, readwrite, setter=setOBJCValue:) OBJCIntVec objcValue;

- (instancetype)initWithValue:(IntVec)value;
+ (instancetype)bridgedValueWithValue:(IntVec)value;

- (instancetype)initBridgingValue:(OBJCIntVec)value;
+ (instancetype)bridgedValueBridging:(OBJCIntVec)value;

@end

@interface StereoSampleVecBridgedValue : BridgedValue {
  @package
  std::shared_ptr<StereoSampleVec> _value;
}

@property (nonatomic, readwrite) StereoSampleVec& value;

@property (nonatomic, readwrite, setter=setOBJCValue:) OBJCStereoSampleVec objcValue;

- (instancetype)initWithValue:(StereoSampleVec)value;
+ (instancetype)bridgedValueWithValue:(StereoSampleVec)value;

- (instancetype)initBridgingValue:(OBJCStereoSampleVec)value;
+ (instancetype)bridgedValueBridging:(OBJCStereoSampleVec)value;

@end

@interface ComplexRealVecBridgedValue : BridgedValue {
  @package
  std::shared_ptr<ComplexRealVec> _value;
}

@property (nonatomic, readwrite) ComplexRealVec& value;

@property (nonatomic, readwrite, setter=setOBJCValue:) OBJCComplexRealVec objcValue;

- (instancetype)initWithValue:(ComplexRealVec)value;
+ (instancetype)bridgedValueWithValue:(ComplexRealVec)value;

- (instancetype)initBridgingValue:(OBJCComplexRealVec)value;
+ (instancetype)bridgedValueBridging:(OBJCComplexRealVec)value;

@end

@interface RealMatrixVecBridgedValue : BridgedValue {
  @package
  std::shared_ptr<RealMatrixVec> _value;
}

@property (nonatomic, readwrite) RealMatrixVec& value;

@property (nonatomic, readwrite, setter=setOBJCValue:) OBJCRealMatrixVec objcValue;

- (instancetype)initWithValue:(RealMatrixVec)value;
+ (instancetype)bridgedValueWithValue:(RealMatrixVec)value;

- (instancetype)initBridgingValue:(OBJCRealMatrixVec)value;
+ (instancetype)bridgedValueBridging:(OBJCRealMatrixVec)value;

@end

@interface RealVecVecBridgedValue : BridgedValue {
  @package
  std::shared_ptr<RealVecVec> _value;
}

@property (nonatomic, readwrite) RealVecVec& value;

@property (nonatomic, readwrite, setter=setOBJCValue:) OBJCRealVecVec objcValue;

- (instancetype)initWithValue:(RealVecVec)value;
+ (instancetype)bridgedValueWithValue:(RealVecVec)value;

- (instancetype)initBridgingValue:(OBJCRealVecVec)value;
+ (instancetype)bridgedValueBridging:(OBJCRealVecVec)value;

@end

@interface StringVecVecBridgedValue : BridgedValue {
  @package
  std::shared_ptr<StringVecVec> _value;
}

@property (nonatomic, readwrite) StringVecVec& value;

@property (nonatomic, readwrite, setter=setOBJCValue:) OBJCStringVecVec objcValue;

- (instancetype)initWithValue:(StringVecVec)value;
+ (instancetype)bridgedValueWithValue:(StringVecVec)value;

- (instancetype)initBridgingValue:(OBJCStringVecVec)value;
+ (instancetype)bridgedValueBridging:(OBJCStringVecVec)value;

@end

@interface ComplexRealVecVecBridgedValue : BridgedValue {
  @package
  std::shared_ptr<ComplexRealVecVec> _value;
}

@property (nonatomic, readwrite) ComplexRealVecVec& value;

@property (nonatomic, readwrite, setter=setOBJCValue:) OBJCComplexRealVecVec objcValue;

- (instancetype)initWithValue:(ComplexRealVecVec)value;
+ (instancetype)bridgedValueWithValue:(ComplexRealVecVec)value;

- (instancetype)initBridgingValue:(OBJCComplexRealVecVec)value;
+ (instancetype)bridgedValueBridging:(OBJCComplexRealVecVec)value;

@end

@interface StereoSampleVecVecBridgedValue : BridgedValue {
  @package
  std::shared_ptr<StereoSampleVecVec> _value;
}

@property (nonatomic, readwrite) StereoSampleVecVec& value;

@property (nonatomic, readwrite, setter=setOBJCValue:) OBJCStereoSampleVecVec objcValue;

- (instancetype)initWithValue:(StereoSampleVecVec)value;
+ (instancetype)bridgedValueWithValue:(StereoSampleVecVec)value;

- (instancetype)initBridgingValue:(OBJCStereoSampleVecVec)value;
+ (instancetype)bridgedValueBridging:(OBJCStereoSampleVecVec)value;

@end

@interface RealVecMapBridgedValue : BridgedValue {
  @package
  std::shared_ptr<RealVecMap> _value;
}

@property (nonatomic, readwrite) RealVecMap& value;

@property (nonatomic, readwrite, setter=setOBJCValue:) OBJCRealVecMap objcValue;

- (instancetype)initWithValue:(RealVecMap)value;
+ (instancetype)bridgedValueWithValue:(RealVecMap)value;

- (instancetype)initBridgingValue:(OBJCRealVecMap)value;
+ (instancetype)bridgedValueBridging:(OBJCRealVecMap)value;

@end

@interface RealMapBridgedValue : BridgedValue {
  @package
  std::shared_ptr<RealMap> _value;
}

@property (nonatomic, readwrite) RealMap& value;

@property (nonatomic, readwrite, setter=setOBJCValue:) OBJCRealMap objcValue;

- (instancetype)initWithValue:(RealMap)value;
+ (instancetype)bridgedValueWithValue:(RealMap)value;

- (instancetype)initBridgingValue:(OBJCRealMap)value;
+ (instancetype)bridgedValueBridging:(OBJCRealMap)value;

@end

@interface StringMapBridgedValue : BridgedValue {
  @package
  std::shared_ptr<StringMap> _value;
}

@property (nonatomic, readwrite) StringMap& value;

@property (nonatomic, readwrite, setter=setOBJCValue:) OBJCStringMap objcValue;

- (instancetype)initWithValue:(StringMap)value;
+ (instancetype)bridgedValueWithValue:(StringMap)value;

- (instancetype)initBridgingValue:(OBJCStringMap)value;
+ (instancetype)bridgedValueBridging:(OBJCStringMap)value;

@end

@interface IntVecMapBridgedValue : BridgedValue {
  @package
  std::shared_ptr<IntVecMap> _value;
}

@property (nonatomic, readwrite) IntVecMap& value;

@property (nonatomic, readwrite, setter=setOBJCValue:) OBJCIntVecMap objcValue;

- (instancetype)initWithValue:(IntVecMap)value;
+ (instancetype)bridgedValueWithValue:(IntVecMap)value;

- (instancetype)initBridgingValue:(OBJCIntVecMap)value;
+ (instancetype)bridgedValueBridging:(OBJCIntVecMap)value;

@end

@interface StringVecMapBridgedValue : BridgedValue {
  @package
  std::shared_ptr<StringVecMap> _value;
}

@property (nonatomic, readwrite) StringVecMap& value;

@property (nonatomic, readwrite, setter=setOBJCValue:) OBJCStringVecMap objcValue;

- (instancetype)initWithValue:(StringVecMap)value;
+ (instancetype)bridgedValueWithValue:(StringVecMap)value;

- (instancetype)initBridgingValue:(OBJCStringVecMap)value;
+ (instancetype)bridgedValueBridging:(OBJCStringVecMap)value;

@end

@interface RealMatrixVecMapBridgedValue : BridgedValue {
  @package
  std::shared_ptr<RealMatrixVecMap> _value;
}

@property (nonatomic, readwrite) RealMatrixVecMap& value;

@property (nonatomic, readwrite, setter=setOBJCValue:) OBJCRealMatrixVecMap objcValue;

- (instancetype)initWithValue:(RealMatrixVecMap)value;
+ (instancetype)bridgedValueWithValue:(RealMatrixVecMap)value;

- (instancetype)initBridgingValue:(OBJCRealMatrixVecMap)value;
+ (instancetype)bridgedValueBridging:(OBJCRealMatrixVecMap)value;

@end

@interface StereoSampleVecMapBridgedValue : BridgedValue {
  @package
  std::shared_ptr<StereoSampleVecMap> _value;
}

@property (nonatomic, readwrite) StereoSampleVecMap& value;

@property (nonatomic, readwrite, setter=setOBJCValue:) OBJCStereoSampleVecMap objcValue;

- (instancetype)initWithValue:(StereoSampleVecMap)value;
+ (instancetype)bridgedValueWithValue:(StereoSampleVecMap)value;

- (instancetype)initBridgingValue:(OBJCStereoSampleVecMap)value;
+ (instancetype)bridgedValueBridging:(OBJCStereoSampleVecMap)value;

@end

@interface RealVecVecMapBridgedValue : BridgedValue {
  @package
  std::shared_ptr<RealVecVecMap> _value;
}

@property (nonatomic, readwrite) RealVecVecMap& value;

@property (nonatomic, readwrite, setter=setOBJCValue:) OBJCRealVecVecMap objcValue;

- (instancetype)initWithValue:(RealVecVecMap)value;
+ (instancetype)bridgedValueWithValue:(RealVecVecMap)value;

- (instancetype)initBridgingValue:(OBJCRealVecVecMap)value;
+ (instancetype)bridgedValueBridging:(OBJCRealVecVecMap)value;

@end

@interface StringVecVecMapBridgedValue : BridgedValue {
  @package
  std::shared_ptr<StringVecVecMap> _value;
}

@property (nonatomic, readwrite) StringVecVecMap& value;

@property (nonatomic, readwrite, setter=setOBJCValue:) OBJCStringVecVecMap objcValue;

- (instancetype)initWithValue:(StringVecVecMap)value;
+ (instancetype)bridgedValueWithValue:(StringVecVecMap)value;

- (instancetype)initBridgingValue:(OBJCStringVecVecMap)value;
+ (instancetype)bridgedValueBridging:(OBJCStringVecVecMap)value;

@end


NS_ASSUME_NONNULL_END
