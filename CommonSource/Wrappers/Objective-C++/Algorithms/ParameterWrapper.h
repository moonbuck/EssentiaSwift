//
//  ParameterWrapper.h
//  Essentia
//
//  Created by Jason Cardwell on 10/10/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "WrappedTypes.h"

/**
 An enumeration mirroring the C++ enum `essentia::Parameter::ParamType`.

 - ParameterWrapperTypeUndefined: Type unspecified.
 - ParameterWrapperTypeReal: A float value.
 - ParameterWrapperTypeString: A string value.
 - ParameterWrapperTypeBoolean: A boolean value.
 - ParameterWrapperTypeInteger: An integer value.
 - ParameterWrapperTypeRealVec: A vector of float values.
 - ParameterWrapperTypeStringVec: A vector of string values.
 - ParameterWrapperTypeStringVecMap: A map of vectors of string values.
 */
typedef NS_ENUM(NSUInteger, ParameterWrapperType) {
  ParameterWrapperTypeUndefined,
  ParameterWrapperTypeReal,
  ParameterWrapperTypeString,
  ParameterWrapperTypeBoolean,
  ParameterWrapperTypeInteger,
  ParameterWrapperTypeRealVec,
  ParameterWrapperTypeStringVec,
  ParameterWrapperTypeStringVecMap
};



/**
 A wrapper for bridging the C++ class `Parameter`.
 */
@interface ParameterWrapper: NSObject

/**
 The type of the value held by the wrapped parameter.
 */
@property (nonatomic, readonly) ParameterWrapperType dataType;

/**
 The value held by the wrapped parameter.
 */
@property (nullable, nonatomic, readonly) id value;

/**
 Whether the wrapped parameter has had its value set.
 */
@property (nonatomic, readonly) BOOL isConfigured;

NS_ASSUME_NONNULL_BEGIN

/**
 Creates a new unconfigured parameter wrapper for the specified data type.

 @param type The type of data the parameter will hold.
 @return The newly created, unconfigured parameter wrapper.
 */
+ (instancetype)parameterWrapperWithType:(ParameterWrapperType)type;

/**
 Creates a parameter wrapper configured with the specified `OBJCReal` value.

 @param value The value with which to configure the new parameter wrapper.
 @return The newly created parameter wrapper configured with `value`.
*/
+ (instancetype)parameterWrapperWithReal:(OBJCReal)value;

/**
 Creates a parameter wrapper configured with the specified `OBJCString` value.

 @param value The value with which to configure the new parameter wrapper.
 @return The newly created parameter wrapper configured with `value`.
*/
+ (instancetype)parameterWrapperWithString:(OBJCString)value;

/**
 Creates a parameter wrapper configured with the specified `OBJCBool` value.

 @param value The value with which to configure the new parameter wrapper.
 @return The newly created parameter wrapper configured with `value`.
*/
+ (instancetype)parameterWrapperWithBool:(OBJCBool)value;

/**
 Creates a parameter wrapper configured with the specified `OBJCInt` value.

 @param value The value with which to configure the new parameter wrapper.
 @return The newly created parameter wrapper configured with `value`.
*/
+ (instancetype)parameterWrapperWithInt:(OBJCInt)value;

/**
 Creates a parameter wrapper configured with the specified `OBJCRealVec` value.

 @param value The value with which to configure the new parameter wrapper.
 @return The newly created parameter wrapper configured with `value`.
*/
+ (instancetype)parameterWrapperWithRealVec:(OBJCRealVec)value;

/**
 Creates a parameter wrapper configured with the specified `OBJCStringVec` value.

 @param value The value with which to configure the new parameter wrapper.
 @return The newly created parameter wrapper configured with `value`.
*/
+ (instancetype)parameterWrapperWithStringVec:(OBJCStringVec)value;

/**
 Creates a parameter wrapper configured with the specified `OBJCStringVecMap` value.

 @param value The value with which to configure the new parameter wrapper.
 @return The newly created parameter wrapper configured with `value`.
*/
+ (instancetype)parameterWrapperWithStringVecMap:(OBJCStringVecMap)value;

NS_ASSUME_NONNULL_END

@end

