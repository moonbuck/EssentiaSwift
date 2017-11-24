//
//  ParameterWrapper.m
//  Essentia
//
//  Created by Jason Cardwell on 10/10/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
#import "ParameterWrapper.h"
#import "ParameterWrapper+BridgingExtensions.hpp"
#import "essentia.h"
#import "parameter.h"
#import "NSDictionary+BridgingExtensions.hpp"
#import "NSArray+BridgingExtensions.hpp"
#import "NSValue+BridgingExtensions.h"
#import "NSString+BridgingExtensions.hpp"
#import "tnt_array2d.h"
#import "Exceptions.h"

using namespace essentia;

/**
 Extension of `ParameterWrapper` to declare an ivar for the wrapped C++ `Parameter` and add
 a class constructor for internal use.
 */
@interface ParameterWrapper() { Parameter * _parameter; }

/**
 Creates a new wrapper for the specified rvalue parameter.

 @param parameter The rvalue parameter to wrap.
 @return The newly created wrapper for `parameter`.
 */
+ (instancetype)parameterWrapperForRValueParameter:(Parameter &&)parameter;

@end

@implementation ParameterWrapper

/**
 Creates a new wrapper for the specified parameter.

 @param parameter The parameter to wrap.
 @return The newly created wrapper for `parameter`.
 */
+ (instancetype)parameterWrapperForParameter:(Parameter &)parameter {
  ParameterWrapper *wrapper = [ParameterWrapper new];
  if (wrapper) { wrapper->_parameter = new Parameter(parameter); }
  else { @throw inconsistencyException(@"ParameterWrapper initializer returned `nil`."); }
  return wrapper;
}

/**
 Creates a new wrapper for the specified rvalue parameter.

 @param parameter The rvalue parameter to wrap.
 @return The newly created wrapper for `parameter`.
 */
+ (instancetype)parameterWrapperForRValueParameter:(Parameter &&)parameter {
  ParameterWrapper *wrapper = [ParameterWrapper new];
  if (wrapper) { wrapper->_parameter = new Parameter(parameter); }
  return wrapper;
}

/**
 Implemented to `delete` the C++ `Parameter` created via copy using `new`.
 */
- (void)dealloc { delete _parameter; }

/**
 Override that uses the wrapped parameter's `toString()` method for the description's content.

 @return An `NSString *` holding the description of the wrapped parameter.
 */
- (nonnull NSString *)description { return [NSString stringWithCPPString:_parameter->toString()]; }

/**
 Accessor for the wrapped C++ `Parameter`.

 @return The wrapped instance.
 */
- (Parameter *)parameter {
  assert(_parameter != nullptr);
  return _parameter;
}

/**
 Creates a new unconfigured parameter wrapper for the specified data type.

 @param type The type of data the parameter will hold.
 @return The newly created, unconfigured parameter wrapper.
 */
+ (instancetype)parameterWrapperWithType:(ParameterWrapperType)type {

  Parameter::ParamType paramType;

  switch (type) {
    case ParameterWrapperTypeUndefined:     paramType = Parameter::UNDEFINED;         break;
    case ParameterWrapperTypeReal:          paramType = Parameter::REAL;              break;
    case ParameterWrapperTypeString:        paramType = Parameter::STRING;            break;
    case ParameterWrapperTypeBoolean:       paramType = Parameter::BOOL;              break;
    case ParameterWrapperTypeInteger:       paramType = Parameter::INT;               break;
    case ParameterWrapperTypeRealVec:       paramType = Parameter::VECTOR_REAL;       break;
    case ParameterWrapperTypeStringVec:     paramType = Parameter::VECTOR_STRING;     break;
    case ParameterWrapperTypeStringVecMap:  paramType = Parameter::MAP_VECTOR_STRING; break;
  }

  return [self parameterWrapperForRValueParameter: Parameter(paramType)];

}

/**
 Creates a parameter wrapper configured with the specified `OBJCReal` value.

 @param value The value with which to configure the new parameter wrapper.
 @return The newly created parameter wrapper configured with `value`.
*/
+ (instancetype)parameterWrapperWithReal:(OBJCReal)value {
  return [self parameterWrapperForRValueParameter: Parameter(value.floatValue)];
 }

/**
 Creates a parameter wrapper configured with the specified `OBJCString` value.

 @param value The value with which to configure the new parameter wrapper.
 @return The newly created parameter wrapper configured with `value`.
*/
+ (instancetype)parameterWrapperWithString:(OBJCString)value {
  return [self parameterWrapperForRValueParameter: Parameter(value.cppString)];
}

/**
 Creates a parameter wrapper configured with the specified `OBJCBool` value.

 @param value The value with which to configure the new parameter wrapper.
 @return The newly created parameter wrapper configured with `value`.
*/
+ (instancetype)parameterWrapperWithBool:(OBJCBool)value {
  return [self parameterWrapperForRValueParameter: Parameter((bool)value.boolValue)];
}

/**
 Creates a parameter wrapper configured with the specified `OBJCInt` value.

 @param value The value with which to configure the new parameter wrapper.
 @return The newly created parameter wrapper configured with `value`.
*/
+ (instancetype)parameterWrapperWithInt:(OBJCInt)value {
  return [self parameterWrapperForRValueParameter: Parameter(value.intValue)];
}

/**
 Creates a parameter wrapper configured with the specified `OBJCRealVec` value.

 @param value The value with which to configure the new parameter wrapper.
 @return The newly created parameter wrapper configured with `value`.
*/
+ (instancetype)parameterWrapperWithRealVec:(OBJCRealVec)value {
  return [self parameterWrapperForRValueParameter: Parameter(value.realVecValue)];
}

/**
 Creates a parameter wrapper configured with the specified `OBJCStringVec` value.

 @param value The value with which to configure the new parameter wrapper.
 @return The newly created parameter wrapper configured with `value`.
*/
+ (instancetype)parameterWrapperWithStringVec:(OBJCStringVec)value {
  return [self parameterWrapperForRValueParameter: Parameter(value.stringVecValue)];
}

/**
 Creates a parameter wrapper configured with the specified `OBJCStringVecMap` value.

 @param value The value with which to configure the new parameter wrapper.
 @return The newly created parameter wrapper configured with `value`.
*/
+ (instancetype)parameterWrapperWithStringVecMap:(OBJCStringVecMap)value {
  return [self parameterWrapperForRValueParameter: Parameter(value.stringVecMapValue)];
}

/**
 Accessor for the type of value held by the wrapped parameter.

 @return The `ParameterWrapperType` corresponding to the data held by the wrapped parameter.
 */
- (ParameterWrapperType)dataType {

  assert(_parameter != nullptr);

  switch (_parameter->type()) {
    case Parameter::REAL:               return ParameterWrapperTypeReal;
    case Parameter::STRING:             return ParameterWrapperTypeString;
    case Parameter::BOOL:               return ParameterWrapperTypeBoolean;
    case Parameter::INT:                return ParameterWrapperTypeInteger;
    case Parameter::VECTOR_REAL:        return ParameterWrapperTypeRealVec;
    case Parameter::VECTOR_STRING:      return ParameterWrapperTypeStringVec;
    case Parameter::MAP_VECTOR_STRING:  return ParameterWrapperTypeStringVecMap;
    default:                            return ParameterWrapperTypeUndefined;
  }

}

/**
 Accessor for the value held by the wrapped parameter.

 @return The wrapped parameter's value or `nil` if the wrapped parameter has not been configured.
 */
- (nullable id)value {

  assert(_parameter != nullptr);

  if (!self.isConfigured) { return nil; }

  switch (_parameter->type()) {

    case Parameter::REAL:
      return [NSNumber numberWithFloat:_parameter->toFloat()];

    case Parameter::STRING:
      return [NSString stringWithCPPString:_parameter->toString()];

    case Parameter::BOOL:
      return [NSNumber numberWithBool:_parameter->toBool()];

    case Parameter::INT:
      return [NSNumber numberWithInt:_parameter->toInt()];

    case Parameter::VECTOR_REAL:{
      auto value = _parameter->toVectorReal();
      return [NSArray arrayWithRealVec:value];
    }

    case Parameter::VECTOR_STRING:{
      auto value = _parameter->toVectorString();
      return [NSArray arrayWithStringVec:value];
    }

    case Parameter::MAP_VECTOR_STRING:
      return [NSDictionary dictionaryWithStringVecMap:_parameter->toMapVectorString()];

    default:
      return nil;
  }

}

/**
 Queries the wrapped parameter to learn whether it has had its value initialized.

 @return `YES` if the parameter has had its value set and `NO` otherwise.
 */
- (BOOL)isConfigured { return (BOOL)_parameter->isConfigured(); }

@end

