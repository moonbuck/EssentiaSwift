//
//  SinkWrapper.mm
//  Essentia
//
//  Created by Jason Cardwell on 11/25/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
#import "SinkWrapper+BridgingExtensions.hpp"
#import "NSString+BridgingExtensions.hpp"
#import "IODataType+BridgingExtensions.hpp"

using namespace essentia;
using namespace std;

@implementation SinkWrapper

/**
 Initializing with a specified sink.

 @param sinkBase The C++ sink to wrap.
 @param dataType The data type used by `sinkBase`.
 @return The new sink wrapper with `sinkBase`.
 */
- (instancetype)initWrapping:(streaming::SinkBase &)sinkBase dataType:(IODataType)dataType {

  self = [super init];

  if (self) {

    _sinkBase = &sinkBase;
    _dataType = dataType;

    switch (dataType) {
      case IODataTypeReal:
        _data = [BridgedValue bridgedValueWithType:BridgedTypeReal];
        break;
      case IODataTypeString:
        _data = [BridgedValue bridgedValueWithType:BridgedTypeString];
        break;
      case IODataTypeInt:
        _data = [BridgedValue bridgedValueWithType:BridgedTypeInt];
        break;
      case IODataTypeComplexReal:
        _data = [BridgedValue bridgedValueWithType:BridgedTypeComplexReal];
        break;
      case IODataTypeStereoSample:
        _data = [BridgedValue bridgedValueWithType:BridgedTypeStereoSample];
        break;
      case IODataTypePool:
        _data = [BridgedValue bridgedValueWithType:BridgedTypePool];
        break;
      case IODataTypeRealMatrix:
        _data = [BridgedValue bridgedValueWithType:BridgedTypeRealMatrix];
        break;
      case IODataTypeComplexRealVec:
        _data = [BridgedValue bridgedValueWithType:BridgedTypeComplexRealVec];
        break;
      case IODataTypeRealVec:
        _data = [BridgedValue bridgedValueWithType:BridgedTypeRealVec];
        break;
      case IODataTypeStringVec:
        _data = [BridgedValue bridgedValueWithType:BridgedTypeStringVec];
        break;
      case IODataTypeStereoSampleVec:
        _data = [BridgedValue bridgedValueWithType:BridgedTypeStereoSampleVec];
        break;
      case IODataTypeRealVecVec:
        _data = [BridgedValue bridgedValueWithType:BridgedTypeRealVecVec];
        break;
      case IODataTypeComplexRealVecVec:
        _data = [BridgedValue bridgedValueWithType:BridgedTypeComplexRealVecVec];
        break;
    }

  }

  return self;

}

/**
 Creates a new sink wrapper for the specified sink.

 @param sinkBase The C++ sink to wrap.
 @return The new sink wrapper with `sinkBase`.
 */
+ (instancetype)sinkWrapperWrapping:(streaming::SinkBase&)sinkBase {
  return [[SinkWrapper alloc] initWrapping:sinkBase
                                  dataType:dataTypeForType(sinkBase.typeInfo())];
}

/**
 Sets the data held by the sink wrapper.

 @param data The new data for the sink wrapper.
 */
- (void)setData:(id)data {
  [_data setOBJCValue:data];
}

/**
 The data held by the sink wrapper.
 */
- (id)data {
  return _data.objcValue;
}

/**
 Accessor for the type of data associated with the wrapped sink.

 @return The type of data associated with the wrapped sink.
 */
- (IODataType)dataType {
  return _dataType;
}

/**
 Accessor for the wrapped C++ `SinkBase`.

 @return The wrapped sink.
 */
- (nonnull const streaming::SinkBase *)sink { return _sinkBase; }

/**
 The full name of the sink.
 */
- (nonnull NSString *)fullName {
  return [NSString stringWithCPPString:_sinkBase->fullName()];
}

/**
 Accessor for the name given the wrapped sink.

 @return The sink's name.
 */
- (nonnull NSString *)name { return [NSString stringWithCPPString:_sinkBase->name()]; }

/**
 Mutator for the name given the wrapped sink.

 @param name The new name to assign to the wrapped sink.
 */
- (void)setName:(nonnull NSString *)name { _sinkBase->setName(name.cppString); }

@end
