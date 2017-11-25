//
//  SourceWrapper.mm
//  Essentia
//
//  Created by Jason Cardwell on 10/11/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
#import "SourceWrapper+BridgingExtensions.hpp"
#import "NSString+BridgingExtensions.hpp"
#import "IODataType+BridgingExtensions.hpp"
#import "poolstorage.h"
#import "PoolWrapper+BridgingExtensions.hpp"
#import "vectoroutput.h"
#import "SinkWrapper+BridgingExtensions.hpp"

using namespace essentia;
using namespace std;

@implementation SourceWrapper

/**
 Initializing with a specified source.

 @param sourceBase The C++ source to wrap.
 @param dataType The data type used by `sourceBase`.
 @return The new source wrapper with `sourceBase`.
 */
- (instancetype)initWrapping:(streaming::SourceBase &)sourceBase dataType:(IODataType)dataType {

  self = [super init];

  if (self) {

    _sourceBase = &sourceBase;
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
 Creates a new source wrapper for the specified source.

 @param sourceBase The C++ source to wrap.
 @return The new source wrapper with `sourceBase`.
 */
+ (instancetype)sourceWrapperWrapping:(streaming::SourceBase&)sourceBase {
  return [[SourceWrapper alloc] initWrapping:sourceBase
                                    dataType:dataTypeForType(sourceBase.typeInfo())];
}

/**
 Accessor for the wrapped C++ `SourceBase`.

 @return The wrapped source.
 */
- (nonnull const streaming::SourceBase *)source { return _sourceBase; }

/**
 The full name of the source.
 */
- (nonnull NSString *)fullName {
  return [NSString  stringWithCPPString:_sourceBase->fullName()];
}

/**
 Accessor for the name given the wrapped sink.

 @return The sink's name.
 */
- (nonnull NSString *)name { return [NSString stringWithCPPString:_sourceBase->name()]; }

/**
 Mutator for the name given the wrapped sink.

 @param name The new name to assign to the wrapped sink.
 */
- (void)setName:(nonnull NSString *)name { _sourceBase->setName(name.cppString); }

/**
 The data held by the source wrapper.
 */
- (id)data {
  return _data.objcValue;
}

/**
 Accessor for the type of data associated with the wrapped source.

 @return The type of data associated with the wrapped source.
 */
- (IODataType)dataType {
  return _dataType;
}

/**
 Connects the source to the specified sink.

 @param sinkWrapper The wrapper for the sink to which the source will be connected.
 */
- (void)connectToSinkWrapper:(nonnull SinkWrapper *)sinkWrapper {
  streaming::connect(*(_sourceBase), *(sinkWrapper->_sinkBase));
}

/**
 Connects the source to the specified pool.

 @param poolWrapper The wrapper for the pool to which the source will be connected.
 @param descriptorName The descriptor under which the source did will be store in `poolWrapper`.
 @param setSingle Boolean value indicating whether the single pool should be used.
 */
- (void)connectToPoolWrapper:(PoolWrapper *)poolWrapper
             usingDescriptor:(NSString *)descriptorName
                   setSingle:(BOOL)setSingle
{
  if (setSingle) {
    streaming::connectSingleValue(*(_sourceBase), *(poolWrapper->_pool), descriptorName.cppString);
  } else {
    streaming::connect(*(_sourceBase), *(poolWrapper->_pool), descriptorName.cppString);
  }
}

/**
 Disconnects the source from the specified sink.

 @param sinkWrapper The wrapper for the sink from which the source will be disconnected.
 */
- (void)disconnectFromSinkWrapper:(nonnull SinkWrapper *)sinkWrapper {
  streaming::disconnect(*(_sourceBase), *(sinkWrapper->_sinkBase));
}

/**
 Disconnects the source from the specified pool.

 @param poolWrapper The wrapper for the pool from which the source will be disconnected.
 @param descriptorName The descriptor name to disconnect.
 */
- (void)disconnectFromPoolWrapper:(PoolWrapper *)poolWrapper
                   descriptorName:(NSString *)descriptorName
{
  streaming::disconnect(*(_sourceBase), *(poolWrapper->_pool), descriptorName.cppString);
}

/**
 Connects the source to the 'null' sink so that any output is simple ignored.
 */
- (void)capConnection {
  streaming::connect(*(_sourceBase), streaming::DEVNULL);
}

/**
 Disconnects the source from the 'null' sink.
 */
- (void)uncapConnection {
  streaming::disconnect(*(_sourceBase), streaming::DEVNULL);
}

/**
 Connects the wrappers vector storage as the sink to which the source flows.
 */
- (void)connectInternalStorage {

  switch (_dataType) {

    case IODataTypeReal:
    case IODataTypeString:
    case IODataTypeInt:
    case IODataTypeComplexReal:
    case IODataTypeStereoSample:
    case IODataTypePool:
    case IODataTypeRealMatrix:
      break;

    case IODataTypeComplexRealVec:
      connect(*(_sourceBase), *((ComplexRealVecBridgedValue *)_data)->_value.get());
      break;

    case IODataTypeRealVec:
      connect(*(_sourceBase), *((RealVecBridgedValue *)_data)->_value.get());
      break;

    case IODataTypeStringVec:
      connect(*(_sourceBase), *((StringVecBridgedValue *)_data)->_value.get());
      break;

    case IODataTypeStereoSampleVec:
      connect(*(_sourceBase), *((StereoSampleVecBridgedValue *)_data)->_value.get());
      break;

    case IODataTypeRealVecVec:
      connect(*(_sourceBase), *((RealVecVecBridgedValue *)_data)->_value.get());
      break;

    case IODataTypeComplexRealVecVec:
      connect(*(_sourceBase), *((ComplexRealVecVecBridgedValue *)_data)->_value.get());
      break;

  }

}

@end
