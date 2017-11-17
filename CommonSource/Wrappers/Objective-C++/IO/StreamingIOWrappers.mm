//
//  StreamingIOWrappers.mm
//  Essentia
//
//  Created by Jason Cardwell on 10/11/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
#import "StreamingIOWrappers+BridgingExtensions.hpp"
#import "WrappedTypes.h"
#import "WrappedTypes.hpp"
#import "pool.h"
#import "sink.h"
#import "sinkbase.h"
#import "sinkproxy.h"
#import "sourcebase.h"
#import "source.h"
#import "sourceproxy.h"
#import "NSArray+BridgingExtensions.hpp"
#import "NSString+BridgingExtensions.hpp"
#import <memory>
#import "Exceptions.h"
#import "IODataType+BridgingExtensions.hpp"
#import "streamingalgorithm.h"
#import "poolstorage.h"
#import "PoolWrapper+BridgingExtensions.hpp"
#import "vectoroutput.h"
#import "NSValue+BridgingExtensions.h"

using namespace essentia;
using namespace std;

/**
 Subclass of `SinkWrapper` for C++ class `Sink<Real>`.
 */
@interface RealSinkWrapper: SinkWrapper {
  @package
  shared_ptr<Real> _data;
  streaming::Sink<Real> *_sink;
}

- (nonnull instancetype)initWithSink:(streaming::Sink<Real>&)sink;

@end

/**
 Subclass of `SinkWrapper` for C++ class `Sink<String>`.
 */
@interface StringSinkWrapper: SinkWrapper {
  @package
   shared_ptr<String> _data;
   streaming::Sink<String> *_sink;
}

- (nonnull instancetype)initWithSink:(streaming::Sink<String>&)sink;

@end

/**
 Subclass of `SinkWrapper` for C++ class `Sink<Int>`.
 */
@interface IntSinkWrapper: SinkWrapper {
  @package
  shared_ptr<Int> _data;
  streaming::Sink<Int> *_sink;
}

- (nonnull instancetype)initWithSink:(streaming::Sink<Int>&)sink;

@end

/**
 Subclass of `SinkWrapper` for C++ class `Sink<ComplexReal>`.
 */
@interface ComplexRealSinkWrapper: SinkWrapper {
  @package
  shared_ptr<ComplexReal> _data;
  streaming::Sink<ComplexReal> *_sink;
}


- (nonnull instancetype)initWithSink:(streaming::Sink<ComplexReal>&)sink;

@end

/**
 Subclass of `SinkWrapper` for C++ class `Sink<StereoSample>`.
 */
@interface StereoSampleSinkWrapper: SinkWrapper {
  @package
  shared_ptr<StereoSample> _data;
  streaming::Sink<StereoSample> *_sink;
}


- (nonnull instancetype)initWithSink:(streaming::Sink<StereoSample>&)sink;

@end

/**
 Subclass of `SinkWrapper` for C++ class `Sink<Pool>`.
 */
@interface PoolSinkWrapper: SinkWrapper {
  @package
  shared_ptr<Pool> _data;
  streaming::Sink<Pool> *_sink;
}

- (nonnull instancetype)initWithSink:(streaming::Sink<Pool>&)sink;

@end

/**
 Subclass of `SinkWrapper` for C++ class `Sink<RealMatrix>`.
 */
@interface RealMatrixSinkWrapper: SinkWrapper {
  @package
  shared_ptr<RealMatrix> _data;
  streaming::Sink<RealMatrix> *_sink;
}

- (nonnull instancetype)initWithSink:(streaming::Sink<RealMatrix>&)sink;

@end

/**
 Subclass of `SinkWrapper` for C++ class `Sink<ComplexRealVec>`.
 */
@interface ComplexRealVecSinkWrapper: SinkWrapper {
  @package
  shared_ptr<ComplexRealVec> _data;
  streaming::Sink<ComplexRealVec> *_sink;
}

- (nonnull instancetype)initWithSink:(streaming::Sink<ComplexRealVec>&)sink;

@end

/**
 Subclass of `SinkWrapper` for C++ class `Sink<RealVec>`.
 */
@interface RealVecSinkWrapper: SinkWrapper {
  @package
  shared_ptr<RealVec> _data;
  streaming::Sink<RealVec> *_sink;
}

- (nonnull instancetype)initWithSink:(streaming::Sink<RealVec>&)sink;

@end

/**
 Subclass of `SinkWrapper` for C++ class `Sink<StringVec>`.
 */
@interface StringVecSinkWrapper: SinkWrapper {
  @package
  shared_ptr<StringVec> _data;
  streaming::Sink<StringVec> *_sink;
}

- (nonnull instancetype)initWithSink:(streaming::Sink<StringVec>&)sink;

@end

/**
 Subclass of `SinkWrapper` for C++ class `Sink<StereoSampleVec>`.
 */
@interface StereoSampleVecSinkWrapper: SinkWrapper {
  @package
  shared_ptr<StereoSampleVec> _data;
  streaming::Sink<StereoSampleVec> *_sink;
}

- (nonnull instancetype)initWithSink:(streaming::Sink<StereoSampleVec>&)sink;

@end

/**
 Subclass of `SinkWrapper` for C++ class `Sink<RealVecVec>`.
 */
@interface RealVecVecSinkWrapper: SinkWrapper {
  @package
  shared_ptr<RealVecVec> _data;
  streaming::Sink<RealVecVec> *_sink;
}

- (nonnull instancetype)initWithSink:(streaming::Sink<RealVecVec>&)sink;

@end

/**
 Subclass of `SinkWrapper` for C++ class `Sink<ComplexRealVecVec>`.
 */
@interface ComplexRealVecVecSinkWrapper: SinkWrapper {
  @package
  shared_ptr<ComplexRealVecVec> _data;
  streaming::Sink<ComplexRealVecVec> *_sink;
}

- (nonnull instancetype)initWithSink:(streaming::Sink<ComplexRealVecVec>&)sink;

@end


@implementation SinkWrapper {
  @package
  streaming::SinkBase *_sinkBase;
}

/**
 Initializing with a specified sink.

 @param sinkBase The C++ sink to wrap.
 @return The new sink wrapper with `sinkBase`.
 */
- (instancetype)initWrapping:(streaming::SinkBase &)sinkBase {
  self = [super init];
  if (self) {
    _sinkBase = &sinkBase;
  }
  return self;
}

/**
 Creates a new sink wrapper for the specified sink.

 @param sinkBase The C++ sink to wrap.
 @return The new sink wrapper with `sinkBase`.
 */
+ (instancetype)sinkWrapperWrapping:(streaming::SinkBase&)sinkBase {

  switch (dataTypeForType(sinkBase.typeInfo())) {

    case IODataTypeReal:
      return [[RealSinkWrapper alloc]
              initWithSink:static_cast<streaming::Sink<Real>&>(sinkBase)];
    case IODataTypeString:
      return [[StringSinkWrapper alloc]
              initWithSink:static_cast<streaming::Sink<String>&>(sinkBase)];
    case IODataTypeInt:
      return [[IntSinkWrapper alloc]
              initWithSink:static_cast<streaming::Sink<Int>&>(sinkBase)];
    case IODataTypeComplexReal:
      return [[ComplexRealSinkWrapper alloc]
              initWithSink:static_cast<streaming::Sink<ComplexReal>&>(sinkBase)];
    case IODataTypeStereoSample:
      return [[StereoSampleSinkWrapper alloc]
              initWithSink:static_cast<streaming::Sink<StereoSample>&>(sinkBase)];
    case IODataTypePool:
      return [[PoolSinkWrapper alloc]
              initWithSink:static_cast<streaming::Sink<Pool>&>(sinkBase)];
    case IODataTypeRealMatrix:
      return [[RealMatrixSinkWrapper alloc]
              initWithSink:static_cast<streaming::Sink<RealMatrix>&>(sinkBase)];
    case IODataTypeComplexRealVec:
      return [[ComplexRealVecSinkWrapper alloc]
              initWithSink:static_cast<streaming::Sink<ComplexRealVec>&>(sinkBase)];
    case IODataTypeRealVec:
      return [[RealVecSinkWrapper alloc]
              initWithSink:static_cast<streaming::Sink<RealVec>&>(sinkBase)];
    case IODataTypeStringVec:
      return [[StringVecSinkWrapper alloc]
              initWithSink:static_cast<streaming::Sink<StringVec>&>(sinkBase)];
    case IODataTypeStereoSampleVec:
      return [[StereoSampleVecSinkWrapper alloc]
              initWithSink:static_cast<streaming::Sink<StereoSampleVec>&>(sinkBase)];
    case IODataTypeRealVecVec:
      return [[RealVecVecSinkWrapper alloc]
              initWithSink:static_cast<streaming::Sink<RealVecVec>&>(sinkBase)];
    case IODataTypeComplexRealVecVec:
      return [[ComplexRealVecVecSinkWrapper alloc]
              initWithSink:static_cast<streaming::Sink<ComplexRealVecVec>&>(sinkBase)];
      
  }

}

/**
 Sets the data held by the sink wrapper. Must be overridden by subclasses as `SinkWrapper`
 itself does not hold any data.

 @param data The new data for the sink wrapper.
 */
- (void)setData:(id)data {
  @throw inconsistencyException(@"`SinkWrapper` is an abstract base.");
}

/**
 The data held by the sink wrapper. Must be overridden by subclasses as `SinkWrapper` itself
 holds no data.
 */
- (id)data {
  @throw inconsistencyException(@"`SinkWrapper` is an abstract base.");
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
  return [NSString  stringWithCPPString:_sinkBase->fullName()];
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

@implementation RealSinkWrapper

/**
 Creates a new `Sink<Real>` instance which is used to invoke `initWithTypeProxy:`.

 @return The initialized sink wrapper.
 */
- (nonnull instancetype)initWithSink:(streaming::Sink<Real>&)sink {
  self = [super initWrapping: sink];
  if (self) {
    _data = make_shared<Real>();
    _sink = &sink;
  }
  return self;
}

/**
 Mutator for the sink wrapper's data.

 @param data The new data for the sink wrapper.
 */
- (void)setData:(id)data {
  if ([data isKindOfClass:[NSNumber class]]) { *_data = ((NSNumber *)data).floatValue; }
}

/**
 Accessor for the sink wrapper's data.

 @return `_data` converted to `OBJCReal`.
 */
- (id)data { return [NSNumber numberWithFloat:*_data]; }

/**
 The type of data associated with the wrapped sink.

 @return The data type.
 */
- (IODataType)dataType { return IODataTypeReal; }

@end

@implementation StringSinkWrapper

/**
 Creates a new `Sink<String>` instance which is used to invoke `initWithTypeProxy:`.

 @return The initialized sink wrapper.
 */
- (nonnull instancetype)initWithSink:(streaming::Sink<String>&)sink {
  self = [super initWrapping: sink];
  if (self) {
    _data = make_shared<String>();
    _sink = &sink;
  }
  return self;
}

/**
 Mutator for the sink wrapper's data.

 @param data The new data for the sink wrapper.
 */
- (void)setData:(id)data {
  if ([data isKindOfClass:[NSString class]]) { *_data = ((NSString *)data).cppString; }
}

/**
 Accessor for the sink wrapper's data.

 @return `_data` converted to `OBJCString`.
 */
- (id)data { return [NSString stringWithCPPString:*_data]; }

/**
 The type of data associated with the wrapped sink.

 @return The data type.
 */
- (IODataType)dataType { return IODataTypeString; }

@end

@implementation IntSinkWrapper

/**
 Creates a new `Sink<Int>` instance which is used to invoke `initWithTypeProxy:`.

 @return The initialized sink wrapper.
 */
- (nonnull instancetype)initWithSink:(streaming::Sink<Int>&)sink {
  self = [super initWrapping: sink];
  if (self) {
    _data = make_shared<Int>();
    _sink = &sink;
  }
  return self;
}

/**
 Mutator for the sink wrapper's data.

 @param data The new data for the sink wrapper.
 */
- (void)setData:(id)data {
  if ([data isKindOfClass:[NSNumber class]]) { *_data = ((NSNumber *)data).intValue; }
}

/**
 Accessor for the sink wrapper's data.

 @return `_data` converted to `OBJCInt`.
 */
- (id)data { return [NSNumber numberWithInt:*_data]; }

/**
 The type of data associated with the wrapped sink.

 @return The data type.
 */
- (IODataType)dataType { return IODataTypeInt; }

@end

@implementation ComplexRealSinkWrapper

/**
 Creates a new `Sink<ComplexReal>` instance which is used to invoke `initWithTypeProxy:`.

 @return The initialized sink wrapper.
 */
- (nonnull instancetype)initWithSink:(streaming::Sink<ComplexReal>&)sink {
  self = [super initWrapping: sink];
  if (self) {
    _data = make_shared<ComplexReal>();
    _sink = &sink;
  }
  return self;
}

/**
 Mutator for the sink wrapper's data.

 @param data The new data for the sink wrapper.
 */
- (void)setData:(id)data {
  if ([data isKindOfClass:[NSValue class]]) {
    DSPComplex value = ((NSValue *)data).complexValue;
    _data->real(value.real);
    _data->imag(value.imag);
  }
}

/**
 Accessor for the sink wrapper's data.

 @return `_data` converted to `OBJCInt`.
 */
- (id)data { return [NSValue valueWithComplex:{_data->real(), _data->imag()}]; }

/**
 The type of data associated with the wrapped sink.

 @return The data type.
 */
- (IODataType)dataType { return IODataTypeComplexReal; }

@end

@implementation StereoSampleSinkWrapper

/**
 Creates a new `Sink<StereoSample>` instance which is used to invoke `initWithTypeProxy:`.

 @return The initialized sink wrapper.
 */
- (nonnull instancetype)initWithSink:(streaming::Sink<StereoSample> &)sink {
  self = [super initWrapping: sink];
  if (self) {
    _data = make_shared<StereoSample>();
    _sink = &sink;
  }
  return self;
}

/**
 Mutator for the sink wrapper's data.

 @param data The new data for the sink wrapper.
 */
- (void)setData:(id)data {
  if ([data isKindOfClass:[NSValue class]]) {
    struct _StereoSample value = ((NSValue *)data).stereoSampleValue;
    _data->first = value.left;
    _data->second = value.right;
  }
}

/**
 Accessor for the sink wrapper's data.

 @return `_data` converted to `OBJCInt`.
 */
- (id)data { return [NSValue valueWithStereoSample:{_data->left(), _data->right()}]; }

/**
 The type of data associated with the wrapped input.

 @return The data type.
 */
- (IODataType)dataType { return IODataTypeStereoSample; }

@end

@implementation PoolSinkWrapper

/**
 Creates a new `Sink<Pool>` instance which is used to invoke `initWithTypeProxy:`.

 @return The initialized sink wrapper.
 */
- (nonnull instancetype)initWithSink:(streaming::Sink<Pool>&)sink {
  self = [super initWrapping: sink];
  if (self) {
    _data = make_shared<Pool>();
    _sink = &sink;
  }
  return self;
}

/**
 Mutator for the sink wrapper's data.

 @param data The new data for the sink wrapper.
 */
- (void)setData:(id)data {
  if ([data isKindOfClass:[PoolWrapper class]]) {
    _data->clear();
    _data->merge(*((PoolWrapper *)data)->_pool);

  }
}

/**
 Accessor for the sink wrapper's data.

 @return `_data` converted to `OBJCPool`.
 */
- (id)data { return [PoolWrapper poolWrapperWithPool:_data.get()]; }

/**
 The type of data associated with the wrapped sink.

 @return The data type.
 */
- (IODataType)dataType { return IODataTypePool; }

@end

@implementation RealMatrixSinkWrapper

/**
 Creates a new `Sink<RealMatrix>` instance which is used to invoke `initWithTypeProxy:`.

 @return The initialized sink wrapper.
 */
- (nonnull instancetype)initWithSink:(streaming::Sink<RealMatrix>&)sink {
  self = [super initWrapping: sink];
  if (self) {
    _data = make_shared<RealMatrix>();
    _sink = &sink;
  }
  return self;
}

/**
 Mutator for the sink wrapper's data.

 @param data The new data for the sink wrapper.
 */
- (void)setData:(id)data {
  if ([data isKindOfClass:[NSArray class]]) { *_data = ((NSArray *)data).realMatrixValue; }
}

/**
 Accessor for the sink wrapper's data.

 @return `_data` converted to `OBJCRealMatrix`.
 */
- (id)data { return [NSArray arrayWithRealMatrix:*_data]; }

/**
 The type of data associated with the wrapped sink.

 @return The data type.
 */
- (IODataType)dataType { return IODataTypeRealMatrix; }

@end

@implementation ComplexRealVecSinkWrapper

/**
 Creates a new `Sink<ComplexRealVec>` instance which is used to invoke `initWithTypeProxy:`.

 @return The initialized sink wrapper.
 */
- (nonnull instancetype)initWithSink:(streaming::Sink<ComplexRealVec>&)sink {
  self = [super initWrapping: sink];
  if (self) {
    _data = make_shared<ComplexRealVec>();
    _sink = &sink;
  }
  return self;
}

/**
 Mutator for the sink wrapper's data.

 @param data The new data for the sink wrapper.
 */
- (void)setData:(id)data {
  if ([data isKindOfClass:[NSArray class]]) { *_data = ((NSArray *)data).complexRealVecValue; }
}

/**
 Accessor for the sink wrapper's data.

 @return `_data` converted to `OBJCComplexRealVec`.
 */
- (id)data { return [NSArray arrayWithComplexRealVec:*_data]; }

/**
 The type of data associated with the wrapped sink.

 @return The data type.
 */
- (IODataType)dataType { return IODataTypeComplexRealVec; }

@end

@implementation RealVecSinkWrapper

/**
 Creates a new `Sink<RealVec>` instance which is used to invoke `initWithTypeProxy:`.

 @return The initialized sink wrapper.
 */
- (nonnull instancetype)initWithSink:(streaming::Sink<RealVec>&)sink {
  self = [super initWrapping: sink];
  if (self) {
    _data = make_shared<RealVec>();
    _sink = &sink;
  }
  return self;
}

/**
 Mutator for the sink wrapper's data.

 @param data The new data for the sink wrapper.
 */
- (void)setData:(id)data {
  if ([data isKindOfClass:[NSArray class]]) { *_data = ((NSArray *)data).realVecValue; }
}

/**
 Accessor for the sink wrapper's data.

 @return `_data` converted to `OBJCRealVec`.
 */
- (id)data { return [NSArray arrayWithRealVec:*_data]; }

/**
 The type of data associated with the wrapped sink.

 @return The data type.
 */
- (IODataType)dataType { return IODataTypeRealVec; }

@end

@implementation StringVecSinkWrapper

/**
 Creates a new `Sink<StringVec>` instance which is used to invoke `initWithTypeProxy:`.

 @return The initialized sink wrapper.
 */
- (nonnull instancetype)initWithSink:(streaming::Sink<StringVec>&)sink {
  self = [super initWrapping: sink];
  if (self) {
    _data = make_shared<StringVec>();
    _sink = &sink;
  }
  return self;
}

/**
 Mutator for the sink wrapper's data.

 @param data The new data for the sink wrapper.
 */
- (void)setData:(id)data {
  if ([data isKindOfClass:[NSArray class]]) { *_data = ((NSArray *)data).stringVecValue; }
}

/**
 Accessor for the sink wrapper's data.

 @return `_data` converted to `OBJCRealVec`.
 */
- (id)data { return [NSArray arrayWithStringVec:*_data]; }

/**
 The type of data associated with the wrapped sink.

 @return The data type.
 */
- (IODataType)dataType { return IODataTypeStringVec; }

@end

@implementation StereoSampleVecSinkWrapper

/**
 Creates a new `Sink<StereoSampleVec>` instance which is used to invoke `initWithTypeProxy:`.

 @return The initialized sink wrapper.
 */
- (nonnull instancetype)initWithSink:(streaming::Sink<StereoSampleVec>&)sink {
  self = [super initWrapping: sink];
  if (self) {
    _data = make_shared<StereoSampleVec>();
    _sink = &sink;
  }
  return self;
}

/**
 Mutator for the sink wrapper's data.

 @param data The new data for the sink wrapper.
 */
- (void)setData:(id)data {
  if ([data isKindOfClass:[NSArray class]]) { *_data = ((NSArray *)data).stereoSampleVecValue; }
}

/**
 Accessor for the sink wrapper's data.

 @return `_data` converted to `OBJCStereoSampleVec`.
 */
- (id)data { return [NSArray arrayWithStereoSampleVec:*_data]; }

/**
 The type of data associated with the wrapped sink.

 @return The data type.
 */
- (IODataType)dataType { return IODataTypeStereoSampleVec; }

@end

@implementation RealVecVecSinkWrapper

/**
 Creates a new `Sink<RealVecVec>` instance which is used to invoke `initWithTypeProxy:`.

 @return The initialized sink wrapper.
 */
- (nonnull instancetype)initWithSink:(streaming::Sink<RealVecVec>&)sink {
  self = [super initWrapping: sink];
  if (self) {
    _data = make_shared<RealVecVec>();
    _sink = &sink;
  }
  return self;
}

/**
 Mutator for the sink wrapper's data.

 @param data The new data for the sink wrapper.
 */
- (void)setData:(id)data {
  if ([data isKindOfClass:[NSArray class]]) { *_data = ((NSArray *)data).realVecVecValue; }
}

/**
 Accessor for the sink wrapper's data.

 @return `_data` converted to `OBJCRealVecVec`.
 */
- (id)data { return [NSArray arrayWithRealVecVec:*_data]; }

/**
 The type of data associated with the wrapped sink.

 @return The data type.
 */
- (IODataType)dataType { return IODataTypeRealVecVec; }

@end

@implementation ComplexRealVecVecSinkWrapper

/**
 Creates a new `Sink<ComplexRealVecVec>` instance which is used to invoke `initWithTypeProxy:`.

 @return The initialized sink wrapper.
 */
- (nonnull instancetype)initWithSink:(streaming::Sink<ComplexRealVecVec>&)sink {
  self = [super initWrapping: sink];
  if (self) {
    _data = make_shared<ComplexRealVecVec>();
    _sink = &sink;
  }
  return self;
}

/**
 Mutator for the sink wrapper's data.

 @param data The new data for the sink wrapper.
 */
- (void)setData:(id)data {
  if ([data isKindOfClass:[NSArray class]]) { *_data = ((NSArray *)data).complexRealVecVecValue; }
}

/**
 Accessor for the sink wrapper's data.

 @return `_data` converted to `OBJCComplexRealVecVec`.
 */
- (id)data { return [NSArray arrayWithComplexRealVecVec:*_data]; }

/**
 The type of data associated with the wrapped sink.

 @return The data type.
 */
- (IODataType)dataType { return IODataTypeComplexRealVecVec; }

@end

/**
 Subclass of `SourceWrapper` for C++ class `Source<Real>`.
 */
@interface RealSourceWrapper: SourceWrapper {
  @package
  shared_ptr<Real> _data;
  streaming::Source<Real> *_source;
}

- (instancetype)initWithSource:(streaming::Source<Real>&)source;

@end

/**
 Subclass of `SourceWrapper` for C++ class `Source<String>`.
 */
@interface StringSourceWrapper: SourceWrapper {
  @package
  shared_ptr<String> _data;
  streaming::Source<String> *_source;
}

- (instancetype)initWithSource:(streaming::Source<String>&)source;

@end

/**
 Subclass of `SourceWrapper` for C++ class `Source<Int>`.
 */
@interface IntSourceWrapper: SourceWrapper {
  @package
  shared_ptr<Int> _data;
  streaming::Source<Int> *_source;
}

- (instancetype)initWithSource:(streaming::Source<Int>&)source;

@end

/**
 Subclass of `SourceWrapper` for C++ class `Source<ComplexReal>`.
 */
@interface ComplexRealSourceWrapper: SourceWrapper {
  @package
  shared_ptr<ComplexReal> _data;
  streaming::Source<ComplexReal> *_source;
}

- (instancetype)initWithSource:(streaming::Source<ComplexReal>&)source;

@end

/**
 Subclass of `SourceWrapper` for C++ class `Source<Int>`.
 */
@interface StereoSampleSourceWrapper: SourceWrapper {
  @package
  shared_ptr<StereoSample> _data;
  streaming::Source<StereoSample> *_source;
}

- (instancetype)initWithSource:(streaming::Source<StereoSample>&)source;

@end

/**
 Subclass of `SourceWrapper` for C++ class `Source<Pool>`.
 */
@interface PoolSourceWrapper: SourceWrapper {
  @package
  shared_ptr<Pool> _data;
  streaming::Source<Pool> *_source;
}

- (instancetype)initWithSource:(streaming::Source<Pool>&)source;

@end

/**
 Subclass of `SourceWrapper` for C++ class `Source<RealMatrix>`.
 */
@interface RealMatrixSourceWrapper: SourceWrapper {
  @package
  shared_ptr<RealMatrix> _data;
  streaming::Source<RealMatrix> *_source;
}

- (instancetype)initWithSource:(streaming::Source<RealMatrix>&)source;

@end

/**
 Subclass of `SourceWrapper` for C++ class `Source<ComplexRealVec>`.
 */
@interface ComplexRealVecSourceWrapper: SourceWrapper {
  @package
  shared_ptr<ComplexRealVec> _data;
  streaming::Source<ComplexRealVec> *_source;
}

- (instancetype)initWithSource:(streaming::Source<ComplexRealVec>&)source;

@end

/**
 Subclass of `SourceWrapper` for C++ class `Source<RealVec>`.
 */
@interface RealVecSourceWrapper: SourceWrapper {
  @package
  shared_ptr<RealVec> _data;
  streaming::Source<RealVec> *_source;
}

- (instancetype)initWithSource:(streaming::Source<RealVec>&)source;

@end

/**
 Subclass of `SourceWrapper` for C++ class `Source<StringVec>`.
 */
@interface StringVecSourceWrapper: SourceWrapper {
  @package
  shared_ptr<StringVec> _data;
  streaming::Source<StringVec> *_source;
}

- (instancetype)initWithSource:(streaming::Source<StringVec>&)source;

@end

/**
 Subclass of `SourceWrapper` for C++ class `Source<StereoSampleVec>`.
 */
@interface StereoSampleVecSourceWrapper: SourceWrapper {
  @package
  shared_ptr<StereoSampleVec> _data;
  streaming::Source<StereoSampleVec> *_source;
}

- (instancetype)initWithSource:(streaming::Source<StereoSampleVec>&)source;

@end

/**
 Subclass of `SourceWrapper` for C++ class `Source<RealVecVec>`.
 */
@interface RealVecVecSourceWrapper: SourceWrapper {
  @package
  shared_ptr<RealVecVec> _data;
  streaming::Source<RealVecVec> *_source;
}

- (instancetype)initWithSource:(streaming::Source<RealVecVec>&)source;

@end

/**
 Subclass of `SourceWrapper` for C++ class `Source<ComplexRealVecVec>`.
 */
@interface ComplexRealVecVecSourceWrapper: SourceWrapper {
  @package
  shared_ptr<ComplexRealVecVec> _data;
  streaming::Source<ComplexRealVecVec> *_source;
}

- (instancetype)initWithSource:(streaming::Source<ComplexRealVecVec>&)source;

@end

@implementation SourceWrapper {
  streaming::SourceBase *_sourceBase;
}

/**
 Initializing with a specified source.

 @param sourceBase The C++ source to wrap.
 @return The new source wrapper with `sourceBase`.
 */
- (instancetype)initWrapping:(streaming::SourceBase &)sourceBase {
  self = [super init];
  if (self) {
    _sourceBase = &sourceBase;
  }
  return self;
}

/**
 Creates a new source wrapper for the specified source.

 @param sourceBase The C++ source to wrap.
 @return The new source wrapper with `sourceBase`.
 */
+ (instancetype)sourceWrapperWrapping:(streaming::SourceBase&)sourceBase {

  switch (dataTypeForType(sourceBase.typeInfo())) {

    case IODataTypeReal:
      return [[RealSourceWrapper alloc]
              initWithSource:static_cast<streaming::Source<Real>&>(sourceBase)];
    case IODataTypeString:
      return [[StringSourceWrapper alloc]
              initWithSource:static_cast<streaming::Source<String>&>(sourceBase)];
    case IODataTypeInt:
      return [[IntSourceWrapper alloc]
              initWithSource:static_cast<streaming::Source<Int>&>(sourceBase)];
    case IODataTypeComplexReal:
      return [[ComplexRealSourceWrapper alloc]
              initWithSource:static_cast<streaming::Source<ComplexReal>&>(sourceBase)];
    case IODataTypeStereoSample:
      return [[StereoSampleSourceWrapper alloc]
              initWithSource:static_cast<streaming::Source<StereoSample>&>(sourceBase)];
    case IODataTypePool:
      return [[PoolSourceWrapper alloc]
              initWithSource:static_cast<streaming::Source<Pool>&>(sourceBase)];
    case IODataTypeRealMatrix:
      return [[RealMatrixSourceWrapper alloc]
              initWithSource:static_cast<streaming::Source<RealMatrix>&>(sourceBase)];
    case IODataTypeComplexRealVec:
      return [[ComplexRealVecSourceWrapper alloc]
              initWithSource:static_cast<streaming::Source<ComplexRealVec>&>(sourceBase)];
    case IODataTypeRealVec:
      return [[RealVecSourceWrapper alloc]
              initWithSource:static_cast<streaming::Source<RealVec>&>(sourceBase)];
    case IODataTypeStringVec:
      return [[StringVecSourceWrapper alloc]
              initWithSource:static_cast<streaming::Source<StringVec>&>(sourceBase)];
    case IODataTypeStereoSampleVec:
      return [[StereoSampleVecSourceWrapper alloc]
              initWithSource:static_cast<streaming::Source<StereoSampleVec>&>(sourceBase)];
    case IODataTypeRealVecVec:
      return [[RealVecVecSourceWrapper alloc]
              initWithSource:static_cast<streaming::Source<RealVecVec>&>(sourceBase)];

    case IODataTypeComplexRealVecVec:
      return [[ComplexRealVecVecSourceWrapper alloc]
              initWithSource:static_cast<streaming::Source<ComplexRealVecVec>&>(sourceBase)];
  }

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
 The data held by the source wrapper. Must be overridden by subclasses since `SourceWrapper` holds
 no data.
 */
- (id)data {
  @throw inconsistencyException(@"`SourceWrapper` is an abstract base.");
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
  @throw invalidArgumentException(@"`SourceWrapper` is an abstract base.");
}

@end

@implementation RealSourceWrapper

/**
 Creates a new wrapper for a C++ `Source<Real>`.

 @param source The C++ object to wrap.
 @return The initialized source wrapper.
 */
- (nonnull instancetype)initWithSource:(streaming::Source<Real>&)source {
  self = [super initWrapping:source];
  if (self) {
    _data = make_shared<Real>();
    _source = &source;
  }
  return self;
}

/**
 Accessor for the source wrapper's data.

 @return `_data` converted to `OBJCReal`.
 */
- (id)data { return [NSNumber numberWithFloat:*_data]; }

/**
 The type of data associated with the wrapped sink.

 @return The data type.
 */
- (IODataType)dataType { return IODataTypeReal; }

/**
 Connects the wrappers vector storage as the sink to which the source flows.
 */
- (void)connectInternalStorage {
  @throw invalidArgumentException(@"Requires a vector data type.");
}

@end

@implementation StringSourceWrapper

/**
 Creates a new wrapper for a C++ `Source<String>`.

 @param source The C++ object to wrap.
 @return The initialized source wrapper.
 */
- (nonnull instancetype)initWithSource:(streaming::Source<String>&)source {
  self = [super initWrapping:source];
  if (self) {
    _data = make_shared<String>();
    _source = &source;
  }
  return self;
}

/**
 Accessor for the source wrapper's data.

 @return `_data` converted to `OBJCString`.
 */
- (id)data { return [NSString stringWithCPPString:*_data]; }

/**
 The type of data associated with the wrapped sink.

 @return The data type.
 */
- (IODataType)dataType { return IODataTypeString; }

/**
 Connects the wrappers vector storage as the sink to which the source flows.
 */
- (void)connectInternalStorage {
  @throw invalidArgumentException(@"Requires a vector data type.");
}

@end

@implementation IntSourceWrapper

/**
 Creates a new wrapper for a C++ `Source<Int>`.

 @param source The C++ object to wrap.
 @return The initialized source wrapper.
 */
- (nonnull instancetype)initWithSource:(streaming::Source<Int>&)source {
  self = [super initWrapping:source];
  if (self) {
    _data = make_shared<Int>();
    _source = &source;
  }
  return self;
}

/**
 Accessor for the source wrapper's data.

 @return `_data` converted to `OBJCInt`.
 */
- (id)data { return [NSNumber numberWithInt:*_data]; }

/**
 The type of data associated with the wrapped sink.

 @return The data type.
 */
- (IODataType)dataType { return IODataTypeInt; }

/**
 Connects the wrappers vector storage as the sink to which the source flows.
 */
- (void)connectInternalStorage {
  @throw invalidArgumentException(@"Requires a vector data type.");
}

@end

@implementation ComplexRealSourceWrapper

/**
 Creates a new wrapper for a C++ `Source<ComplexReal>`.

 @param source The C++ object to wrap.
 @return The initialized source wrapper.
 */
- (nonnull instancetype)initWithSource:(streaming::Source<ComplexReal>&)source {
  self = [super initWrapping:source];
  if (self) {
    _data = make_shared<ComplexReal>();
    _source = &source;
  }
  return self;
}

/**
 Accessor for the source wrapper's data.

 @return `_data` converted to `OBJCInt`.
 */
- (id)data { return [NSValue valueWithComplex:{_data->real(), _data->imag()}]; }

/**
 The type of data associated with the wrapped sink.

 @return The data type.
 */
- (IODataType)dataType { return IODataTypeComplexReal; }

/**
 Connects the wrappers vector storage as the sink to which the source flows.
 */
- (void)connectInternalStorage {
  @throw invalidArgumentException(@"Requires a vector data type.");
}

@end

@implementation StereoSampleSourceWrapper

/**
 Creates a new wrapper for a C++ `Source<StereoSample>`.

 @param source The C++ object to wrap.
 @return The initialized source wrapper.
 */
- (nonnull instancetype)initWithSource:(streaming::Source<StereoSample>&)source {
  self = [super initWrapping:source];
  if (self) {
    _data = make_shared<StereoSample>();
    _source = &source;
  }
  return self;
}

/**
 Accessor for the source wrapper's data.

 @return `_data` converted to `OBJCInt`.
 */
- (id)data { return [NSValue valueWithComplex:{_data->left(), _data->right()}]; }

/**
 The type of data associated with the wrapped sink.

 @return The data type.
 */
- (IODataType)dataType { return IODataTypeStereoSample; }

/**
 Connects the wrappers vector storage as the sink to which the source flows.
 */
- (void)connectInternalStorage {
  @throw invalidArgumentException(@"Requires a vector data type.");
}

@end

@implementation PoolSourceWrapper

/**
 Creates a new wrapper for a C++ `Source<Pool>`.

 @param source The C++ object to wrap.
 @return The initialized source wrapper.
 */
- (nonnull instancetype)initWithSource:(streaming::Source<Pool>&)source {
  self = [super initWrapping:source];
  if (self) {
    _data =make_shared<Pool>();
    _source = &source;
  }
  return self;
}

/**
 Accessor for the source wrapper's data.

 @return `_data` converted to `OBJCPool`.
 */
- (id)data { return [PoolWrapper poolWrapperWithPool:_data.get()]; }

/**
 The type of data associated with the wrapped sink.

 @return The data type.
 */
- (IODataType)dataType { return IODataTypePool; }

/**
 Connects the wrappers vector storage as the sink to which the source flows.
 */
- (void)connectInternalStorage {
  @throw invalidArgumentException(@"Requires a vector data type.");
}

@end

@implementation RealMatrixSourceWrapper

/**
 Creates a new wrapper for a C++ `Source<RealMatrix>`.

 @param source The C++ object to wrap.
 @return The initialized source wrapper.
 */
- (nonnull instancetype)initWithSource:(streaming::Source<RealMatrix>&)source {
  self = [super initWrapping:source];
  if (self) {
    _data = make_shared<RealMatrix>();
    _source = &source;
  }
  return self;
}

/**
 Accessor for the source wrapper's data.

 @return `_data` converted to `OBJCRealMatrix`.
 */
- (id)data { return [NSArray arrayWithRealMatrix:*_data]; }

/**
 The type of data associated with the wrapped sink.

 @return The data type.
 */
- (IODataType)dataType { return IODataTypeRealMatrix; }

/**
 Connects the wrappers vector storage as the sink to which the source flows.
 */
- (void)connectInternalStorage {
  @throw invalidArgumentException(@"Requires a vector data type.");
}

@end

@implementation ComplexRealVecSourceWrapper

/**
 Creates a new wrapper for a C++ `Source<ComplexRealVec>`.

 @param source The C++ object to wrap.
 @return The initialized source wrapper.
 */
- (nonnull instancetype)initWithSource:(streaming::Source<ComplexRealVec>&)source {
  self = [super initWrapping:source];
  if (self) {
    _data = make_shared<ComplexRealVec>();
    _source = &source;
  }
  return self;
}

/**
 Accessor for the source wrapper's data.

 @return `_data` converted to `OBJCComplexRealVec`.
 */
- (id)data { return [NSArray arrayWithComplexRealVec:*_data]; }

/**
 The type of data associated with the wrapped sink.

 @return The data type.
 */
- (IODataType)dataType { return IODataTypeComplexRealVec; }

/**
 Connects the wrappers vector storage as the sink to which the source flows.
 */
- (void)connectInternalStorage {
  connect(*(_source), *(_data.get()));
}

@end

@implementation RealVecSourceWrapper

/**
 Creates a new wrapper for a C++ `Source<RealVec>`.

 @param source The C++ object to wrap.
 @return The initialized source wrapper.
 */
- (nonnull instancetype)initWithSource:(streaming::Source<RealVec>&)source {
  self = [super initWrapping:source];
  if (self) {
    _data = make_shared<RealVec>();
    _source = &source;
  }
  return self;
}

/**
 Accessor for the source wrapper's data.

 @return `_data` converted to `OBJCRealVec`.
 */
- (id)data { return [NSArray arrayWithRealVec:*_data]; }

/**
 The type of data associated with the wrapped sink.

 @return The data type.
 */
- (IODataType)dataType { return IODataTypeRealVec; }

/**
 Connects the wrappers vector storage as the sink to which the source flows.
 */
- (void)connectInternalStorage {
  connect(*(_source), *(_data.get()));
}

@end

@implementation StringVecSourceWrapper

/**
 Creates a new wrapper for a C++ `Source<StringVec>`.

 @param source The C++ object to wrap.
 @return The initialized source wrapper.
 */
- (nonnull instancetype)initWithSource:(streaming::Source<StringVec>&)source {
  self = [super initWrapping:source];
  if (self) {
    _data = make_shared<StringVec>();
    _source = &source;
  }
  return self;
}

/**
 Accessor for the source wrapper's data.

 @return `_data` converted to `OBJCRealVec`.
 */
- (id)data { return [NSArray arrayWithStringVec:*_data]; }

/**
 The type of data associated with the wrapped sink.

 @return The data type.
 */
- (IODataType)dataType { return IODataTypeStringVec; }

/**
 Connects the wrappers vector storage as the sink to which the source flows.
 */
- (void)connectInternalStorage {
  connect(*(_source), *(_data.get()));
}

@end

@implementation StereoSampleVecSourceWrapper

/**
 Creates a new wrapper for a C++ `Source<StereoSampleVec>`.

 @param source The C++ object to wrap.
 @return The initialized source wrapper.
 */
- (nonnull instancetype)initWithSource:(streaming::Source<StereoSampleVec>&)source {
  self = [super initWrapping:source];
  if (self) {
    _data = make_shared<StereoSampleVec>();
    _source = &source;
  }
  return self;
}

/**
 Accessor for the source wrapper's data.

 @return `_data` converted to `OBJCStereoSampleVec`.
 */
- (id)data { return [NSArray arrayWithStereoSampleVec:*_data]; }

/**
 The type of data associated with the wrapped sink.

 @return The data type.
 */
- (IODataType)dataType { return IODataTypeStereoSampleVec; }

/**
 Connects the wrappers vector storage as the sink to which the source flows.
 */
- (void)connectInternalStorage {
  connect(*(_source), *(_data.get()));
}

@end

@implementation RealVecVecSourceWrapper

/**
 Creates a new wrapper for a C++ `Source<RealVecVec>`.

 @param source The C++ object to wrap.
 @return The initialized source wrapper.
 */
- (nonnull instancetype)initWithSource:(streaming::Source<RealVecVec>&)source {
  self = [super initWrapping:source];
  if (self) {
    _data = make_shared<RealVecVec>();
    _source = &source;
  }
  return self;
}

/**
 Accessor for the source wrapper's data.

 @return `_data` converted to `OBJCRealVecVec`.
 */
- (id)data { return [NSArray arrayWithRealVecVec:*_data]; }

/**
 The type of data associated with the wrapped sink.

 @return The data type.
 */
- (IODataType)dataType { return IODataTypeRealVecVec; }

/**
 Connects the wrappers vector storage as the sink to which the source flows.
 */
- (void)connectInternalStorage {
  connect(*(_source), *(_data.get()));
}

@end

@implementation ComplexRealVecVecSourceWrapper

/**
 Creates a new wrapper for a C++ `Source<ComplexRealVecVec>`.

 @param source The C++ object to wrap.
 @return The initialized source wrapper.
 */
- (nonnull instancetype)initWithSource:(streaming::Source<ComplexRealVecVec>&)source {
  self = [super initWrapping:source];
  if (self) {
    _data = make_shared<ComplexRealVecVec>();
    _source = &source;
  }
  return self;
}

/**
 Accessor for the source wrapper's data.

 @return `_data` converted to `OBJCComplexRealVecVec`.
 */
- (id)data { return [NSArray arrayWithComplexRealVecVec:*_data]; }

/**
 The type of data associated with the wrapped sink.

 @return The data type.
 */
- (IODataType)dataType { return IODataTypeComplexRealVecVec; }

/**
 Connects the wrappers vector storage as the sink to which the source flows.
 */
- (void)connectInternalStorage {
  connect(*(_source), *(_data.get()));
}

@end
