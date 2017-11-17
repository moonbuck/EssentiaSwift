//
//  StandardIOWrappers.mm
//  Essentia
//
//  Created by Jason Cardwell on 10/11/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
#import "StandardIOWrappers+BridgingExtensions.hpp"
#import "WrappedTypes.h"
#import "WrappedTypes.hpp"
#import "pool.h"
#import "PoolWrapper+BridgingExtensions.hpp"
#import "iotypewrappers.h"
#import "iotypewrappers_impl.h"
#import "sink.h"
#import "sinkbase.h"
#import "sinkproxy.h"
#import "NSArray+BridgingExtensions.hpp"
#import "NSString+BridgingExtensions.hpp"
#import "NSValue+BridgingExtensions.h"
#import <memory>
#import "Exceptions.h"
#import "IODataType.h"
#import "IODataType+BridgingExtensions.hpp"

using namespace essentia;
using namespace std;

/*
 Input types detected via grepping source folder:

 Input< std::vector<Real> >  ➞  RealVecInputWrapper
 Input<Pool>  ➞  PoolInputWrapper
 Input<Real>  ➞  RealInputWrapper
 Input<TNT::Array2D<Real>>  ➞ RealMatrixInputWrapper
 Input<int>  ➞ IntInputWrapper
 Input<std::string>  ➞  StringInputWrapper
 Input<std::vector<std::vector<Real>>>  ➞  RealVecVecInputWrapper
 Input<std::vector<AudioSample>>  ➞  RealVecInputWrapper
 Input<std::vector<Real>>  ➞  RealVecInputWrapper
 Input<std::vector<StereoSample>>  ➞  StereoSampleVecInputWrapper
 Input<std::vector<std::complex<Real>>>  ➞  ComplexRealVecWrapper
 Input<std::vector<std::string>>  ➞  StringVecInputWrapper
 std::vector<Input<std::vector<Real>>*>  ➞ VecRealVecInputWrapper ****************
 std::vector<Input<std::vector<std::vector<Real>>>*>  ➞  VecRealVecVecInputWrapper *************

 Output types detected via grepping source folder:

 Output<std::vector<Real>>  ➞  RealVecOutputWrapper
 Output<Pool>  ➞  PoolOutputWrapper
 Output<Real>  ➞  RealOutputWrapper
 Output<TNT::Array2D<Real>>  ➞  RealMatrixOutputWrapper
 Output<int>  ➞  IntOutputWrapper
 Output<std::string>  ➞  StringOutputWrapper
 Output<std::vector<AudioSample>>  ➞  RealVecOutputWrapper
 Output<std::vector<StereoSample>>  ➞  StereoSampleVecOutputWrapper
 Output<std::vector<std::complex<Real>>>  ➞  ComplexRealVecOutputWrapper
 Output<std::vector<std::string>>  ➞  StringVecOutputWrapper
 Output<std::vector<std::vector<Real>>>  ➞  RealVecVecOutputWrapper
 std::vector<Output<Real>*>  ➞  VecRealOutputWrapper********************

 */

/**
 Subclass of `InputWrapper` for C++ class `Input<Real>`.
 */
@interface RealInputWrapper: InputWrapper {
  @package
  shared_ptr<Real> _data;
  standard::Input<Real> *_input;
}

- (nonnull instancetype)initWithInput:(standard::Input<Real>&)input;

@end

/**
 Subclass of `InputWrapper` for C++ class `Input<String>`.
 */
@interface StringInputWrapper: InputWrapper {
  @package
   shared_ptr<String> _data;
   standard::Input<String> *_input;
}

- (nonnull instancetype)initWithInput:(standard::Input<String>&)input;

@end

/**
 Subclass of `InputWrapper` for C++ class `Input<Int>`.
 */
@interface IntInputWrapper: InputWrapper {
  @package
  shared_ptr<Int> _data;
  standard::Input<Int> *_input;
}


- (nonnull instancetype)initWithInput:(standard::Input<Int>&)input;

@end

/**
 Subclass of `InputWrapper` for C++ class `Input<ComplexReal>`.
 */
@interface ComplexRealInputWrapper: InputWrapper {
  @package
  shared_ptr<ComplexReal> _data;
  standard::Input<ComplexReal> *_input;
}


- (nonnull instancetype)initWithInput:(standard::Input<ComplexReal>&)input;

@end

/**
 Subclass of `InputWrapper` for C++ class `Input<StereoSample>`.
 */
@interface StereoSampleInputWrapper: InputWrapper {
  @package
  shared_ptr<StereoSample> _data;
  standard::Input<StereoSample> *_input;
}


- (nonnull instancetype)initWithInput:(standard::Input<StereoSample>&)input;

@end

/**
 Subclass of `InputWrapper` for C++ class `Input<Pool>`.
 */
@interface PoolInputWrapper: InputWrapper {
  @package
  shared_ptr<Pool> _data;
  standard::Input<Pool> *_input;
}

- (nonnull instancetype)initWithInput:(standard::Input<Pool>&)input;

@end

/**
 Subclass of `InputWrapper` for C++ class `Input<RealMatrix>`.
 */
@interface RealMatrixInputWrapper: InputWrapper {
  @package
  shared_ptr<RealMatrix> _data;
  standard::Input<RealMatrix> *_input;
}

- (nonnull instancetype)initWithInput:(standard::Input<RealMatrix>&)input;

@end

/**
 Subclass of `InputWrapper` for C++ class `Input<ComplexRealVec>`.
 */
@interface ComplexRealVecInputWrapper: InputWrapper {
  @package
  shared_ptr<ComplexRealVec> _data;
  standard::Input<ComplexRealVec> *_input;
}

- (nonnull instancetype)initWithInput:(standard::Input<ComplexRealVec>&)input;

@end

/**
 Subclass of `InputWrapper` for C++ class `Input<RealVec>`.
 */
@interface RealVecInputWrapper: InputWrapper {
  @package
  shared_ptr<RealVec> _data;
  standard::Input<RealVec> *_input;
}

- (nonnull instancetype)initWithInput:(standard::Input<RealVec>&)input;

@end

/**
 Subclass of `InputWrapper` for C++ class `Input<StringVec>`.
 */
@interface StringVecInputWrapper: InputWrapper {
  @package
  shared_ptr<StringVec> _data;
  standard::Input<StringVec> *_input;
}

- (nonnull instancetype)initWithInput:(standard::Input<StringVec>&)input;

@end

/**
 Subclass of `InputWrapper` for C++ class `Input<StereoSampleVec>`.
 */
@interface StereoSampleVecInputWrapper: InputWrapper {
  @package
  shared_ptr<StereoSampleVec> _data;
  standard::Input<StereoSampleVec> *_input;
}

- (nonnull instancetype)initWithInput:(standard::Input<StereoSampleVec>&)input;

@end

/**
 Subclass of `InputWrapper` for C++ class `Input<RealVecVec>`.
 */
@interface RealVecVecInputWrapper: InputWrapper {
  @package
  shared_ptr<RealVecVec> _data;
  standard::Input<RealVecVec> *_input;
}

- (nonnull instancetype)initWithInput:(standard::Input<RealVecVec>&)input;

@end

/**
 Subclass of `InputWrapper` for C++ class `Input<ComplexRealVecVec>`.
 */
@interface ComplexRealVecVecInputWrapper: InputWrapper {
  @package
  shared_ptr<ComplexRealVecVec> _data;
  standard::Input<ComplexRealVecVec> *_input;
}

- (nonnull instancetype)initWithInput:(standard::Input<ComplexRealVecVec>&)input;

@end

@implementation InputWrapper {
  standard::InputBase *_inputBase;
}

/**
 Initializing with a specified input.

 @param inputBase The C++ input to wrap.
 @return The new input wrapper with `inputBase`.
 */
- (instancetype)initWrapping:(standard::InputBase &)inputBase {
  self = [super init];
  if (self) {
    _inputBase = &inputBase;
  }
  return self;
}

/**
 Creates a new input wrapper for the specified input.

 @param inputBase The C++ input to wrap.
 @return The new input wrapper with `inputBase`.
 */
+ (instancetype)inputWrapperWrapping:(standard::InputBase&)inputBase {

  switch (dataTypeForType(inputBase.typeInfo())) {

    case IODataTypeReal:
      return [[RealInputWrapper alloc]
              initWithInput:static_cast<standard::Input<Real>&>(inputBase)];
    case IODataTypeString:
      return [[StringInputWrapper alloc]
              initWithInput:static_cast<standard::Input<String>&>(inputBase)];
    case IODataTypeInt:
      return [[IntInputWrapper alloc]
              initWithInput:static_cast<standard::Input<Int>&>(inputBase)];
    case IODataTypeComplexReal:
      return [[ComplexRealInputWrapper alloc]
              initWithInput:static_cast<standard::Input<ComplexReal>&>(inputBase)];
    case IODataTypeStereoSample:
      return [[StereoSampleInputWrapper alloc]
              initWithInput:static_cast<standard::Input<StereoSample>&>(inputBase)];
    case IODataTypePool:
      return [[PoolInputWrapper alloc]
              initWithInput:static_cast<standard::Input<Pool>&>(inputBase)];
    case IODataTypeRealMatrix:
      return [[RealMatrixInputWrapper alloc]
              initWithInput:static_cast<standard::Input<RealMatrix>&>(inputBase)];
    case IODataTypeComplexRealVec:
      return [[ComplexRealVecInputWrapper alloc]
              initWithInput:static_cast<standard::Input<ComplexRealVec>&>(inputBase)];
    case IODataTypeRealVec:
      return [[RealVecInputWrapper alloc]
              initWithInput:static_cast<standard::Input<RealVec>&>(inputBase)];
    case IODataTypeStringVec:
      return [[StringVecInputWrapper alloc]
              initWithInput:static_cast<standard::Input<StringVec>&>(inputBase)];
    case IODataTypeStereoSampleVec:
      return [[StereoSampleVecInputWrapper alloc]
              initWithInput:static_cast<standard::Input<StereoSampleVec>&>(inputBase)];
    case IODataTypeRealVecVec:
      return [[RealVecVecInputWrapper alloc]
              initWithInput:static_cast<standard::Input<RealVecVec>&>(inputBase)];
    case IODataTypeComplexRealVecVec:
      return [[ComplexRealVecVecInputWrapper alloc]
              initWithInput:static_cast<standard::Input<ComplexRealVecVec>&>(inputBase)];
  }

}

/**
 Sets the data held by the input wrapper. Must be overridden by subclasses as `InputWrapper`
 itself does not hold any data.

 @param data The new data for the input wrapper.
 */
- (void)setData:(id)data {
  @throw inconsistencyException(@"`InputWrapper` is an abstract base.");
}

/**
 The data held by the input wrapper. Must be overridden by subclasses as `InputWrapper` itself
 holds no data.
 */
- (id)data {
  @throw inconsistencyException(@"`InputWrapper` is an abstract base.");
}

/**
 Accessor for the wrapped C++ `InputBase`.

 @return The wrapped input.
 */
- (nonnull const standard::InputBase *)input { return _inputBase; }

/**
 The full name of the input.
 */
- (nonnull NSString *)fullName {
  return [NSString  stringWithCPPString:_inputBase->fullName()];
}

/**
 Accessor for the name given the wrapped input.

 @return The input's name.
 */
- (nonnull NSString *)name { return [NSString stringWithCPPString:_inputBase->name()]; }

/**
 Mutator for the name given the wrapped input.

 @param name The new name to assign to the wrapped input.
 */
- (void)setName:(nonnull NSString *)name { _inputBase->setName(name.cppString); }

@end

@implementation RealInputWrapper

/**
 Creates a new `Input<Real>` instance which is used to invoke `initWithTypeProxy:`.

 @return The initialized input wrapper.
 */
- (nonnull instancetype)initWithInput:(standard::Input<Real>&)input {
  self = [super initWrapping: input];
  if (self) {
    _data = make_shared<Real>();
    _input = &input;
    input.set(*_data);
  }
  return self;
}

/**
 Mutator for the input wrapper's data.

 @param data The new data for the input wrapper.
 */
- (void)setData:(id)data {
  if ([data isKindOfClass:[NSNumber class]]) { *_data = ((NSNumber *)data).floatValue; }
}

/**
 Accessor for the input wrapper's data.

 @return `_data` converted to `OBJCReal`.
 */
- (id)data { return [NSNumber numberWithFloat:*_data]; }

/**
 The type of data associated with the wrapped input.

 @return The data type.
 */
- (IODataType)dataType { return IODataTypeReal; }

@end

@implementation StringInputWrapper

/**
 Creates a new `Input<String>` instance which is used to invoke `initWithTypeProxy:`.

 @return The initialized input wrapper.
 */
- (nonnull instancetype)initWithInput:(standard::Input<String>&)input {
  self = [super initWrapping: input];
  if (self) {
    _data = make_shared<String>();
    _input = &input;
    input.set(*_data);
  }
  return self;
}

/**
 Mutator for the input wrapper's data.

 @param data The new data for the input wrapper.
 */
- (void)setData:(id)data {
  if ([data isKindOfClass:[NSString class]]) { *_data = ((NSString *)data).cppString; }
}

/**
 Accessor for the input wrapper's data.

 @return `_data` converted to `OBJCString`.
 */
- (id)data { return [NSString stringWithCPPString:*_data]; }

/**
 The type of data associated with the wrapped input.

 @return The data type.
 */
- (IODataType)dataType { return IODataTypeString; }

@end

@implementation IntInputWrapper

/**
 Creates a new `Input<Int>` instance which is used to invoke `initWithTypeProxy:`.

 @return The initialized input wrapper.
 */
- (nonnull instancetype)initWithInput:(standard::Input<Int>&)input {
  self = [super initWrapping: input];
  if (self) {
    _data = make_shared<Int>();
    _input = &input;
    input.set(*_data);
  }
  return self;
}

/**
 Mutator for the input wrapper's data.

 @param data The new data for the input wrapper.
 */
- (void)setData:(id)data {
  if ([data isKindOfClass:[NSNumber class]]) { *_data = ((NSNumber *)data).intValue; }
}

/**
 Accessor for the input wrapper's data.

 @return `_data` converted to `OBJCInt`.
 */
- (id)data { return [NSNumber numberWithInt:*_data]; }

/**
 The type of data associated with the wrapped input.

 @return The data type.
 */
- (IODataType)dataType { return IODataTypeInt; }

@end

@implementation ComplexRealInputWrapper

/**
 Creates a new `Input<ComplexReal>` instance which is used to invoke `initWithTypeProxy:`.

 @return The initialized input wrapper.
 */
- (nonnull instancetype)initWithInput:(standard::Input<ComplexReal>&)input {
  self = [super initWrapping: input];
  if (self) {
    _data = make_shared<ComplexReal>();
    _input = &input;
    input.set(*_data);
  }
  return self;
}

/**
 Mutator for the input wrapper's data.

 @param data The new data for the input wrapper.
 */
- (void)setData:(id)data {
  if ([data isKindOfClass:[NSValue class]]) {
    DSPComplex value = ((NSValue *)data).complexValue;
    _data->real(value.real);
    _data->imag(value.imag);
  }
}

/**
 Accessor for the input wrapper's data.

 @return `_data` converted to `OBJCInt`.
 */
- (id)data { return [NSValue valueWithComplex:{_data->real(), _data->imag()}]; }

/**
 The type of data associated with the wrapped input.

 @return The data type.
 */
- (IODataType)dataType { return IODataTypeComplexReal; }

@end

@implementation StereoSampleInputWrapper

/**
 Creates a new `Input<StereoSample>` instance which is used to invoke `initWithTypeProxy:`.

 @return The initialized input wrapper.
 */
- (nonnull instancetype)initWithInput:(standard::Input<StereoSample>&)input {
  self = [super initWrapping: input];
  if (self) {
    _data = make_shared<StereoSample>();
    _input = &input;
    input.set(*_data);
  }
  return self;
}

/**
 Mutator for the input wrapper's data.

 @param data The new data for the input wrapper.
 */
- (void)setData:(id)data {
  if ([data isKindOfClass:[NSValue class]]) {
    struct _StereoSample value = ((NSValue *)data).stereoSampleValue;
    _data->first = value.left;
    _data->second = value.right;
  }
}

/**
 Accessor for the input wrapper's data.

 @return `_data` converted to `OBJCInt`.
 */
- (id)data { return [NSValue valueWithStereoSample:{_data->left(), _data->right()}]; }

/**
 The type of data associated with the wrapped input.

 @return The data type.
 */
- (IODataType)dataType { return IODataTypeStereoSample; }

@end

@implementation PoolInputWrapper

/**
 Creates a new `Input<Pool>` instance which is used to invoke `initWithTypeProxy:`.

 @return The initialized input wrapper.
 */
- (nonnull instancetype)initWithInput:(standard::Input<Pool>&)input {
  self = [super initWrapping: input];
  if (self) {
    _data = make_shared<Pool>();
    _input = &input;
    input.set(*_data);
  }
  return self;
}

/**
 Mutator for the input wrapper's data.

 @param data The new data for the input wrapper.
 */
- (void)setData:(id)data {
  if ([data isKindOfClass:[PoolWrapper class]]) {
    _data->clear();
    _data->merge(*((PoolWrapper *)data)->_pool);

  }
}

/**
 Accessor for the input wrapper's data.

 @return `_data` converted to `OBJCPool`.
 */
- (id)data { return [PoolWrapper poolWrapperWithPool:_data.get()]; }

/**
 The type of data associated with the wrapped input.

 @return The data type.
 */
- (IODataType)dataType { return IODataTypePool; }

@end

@implementation RealMatrixInputWrapper

/**
 Creates a new `Input<RealMatrix>` instance which is used to invoke `initWithTypeProxy:`.

 @return The initialized input wrapper.
 */
- (nonnull instancetype)initWithInput:(standard::Input<RealMatrix>&)input {
  self = [super initWrapping: input];
  if (self) {
    _data = make_shared<RealMatrix>();
    _input = &input;
    input.set(*_data);
  }
  return self;
}

/**
 Mutator for the input wrapper's data.

 @param data The new data for the input wrapper.
 */
- (void)setData:(id)data {
  if ([data isKindOfClass:[NSArray class]]) { *_data = ((NSArray *)data).realMatrixValue; }
}

/**
 Accessor for the input wrapper's data.

 @return `_data` converted to `OBJCRealMatrix`.
 */
- (id)data { return [NSArray arrayWithRealMatrix:*_data]; }

/**
 The type of data associated with the wrapped input.

 @return The data type.
 */
- (IODataType)dataType { return IODataTypeRealMatrix; }

@end

@implementation ComplexRealVecInputWrapper

/**
 Creates a new `Input<ComplexRealVec>` instance which is used to invoke `initWithTypeProxy:`.

 @return The initialized input wrapper.
 */
- (nonnull instancetype)initWithInput:(standard::Input<ComplexRealVec>&)input {
  self = [super initWrapping: input];
  if (self) {
    _data = make_shared<ComplexRealVec>();
    _input = &input;
    input.set(*_data);
  }
  return self;
}

/**
 Mutator for the input wrapper's data.

 @param data The new data for the input wrapper.
 */
- (void)setData:(id)data {
  if ([data isKindOfClass:[NSArray class]]) { *_data = ((NSArray *)data).complexRealVecValue; }
}

/**
 Accessor for the input wrapper's data.

 @return `_data` converted to `OBJCComplexRealVec`.
 */
- (id)data { return [NSArray arrayWithComplexRealVec:*_data]; }

/**
 The type of data associated with the wrapped input.

 @return The data type.
 */
- (IODataType)dataType { return IODataTypeComplexRealVec; }

@end

@implementation RealVecInputWrapper

/**
 Creates a new `Input<RealVec>` instance which is used to invoke `initWithTypeProxy:`.

 @return The initialized input wrapper.
 */
- (nonnull instancetype)initWithInput:(standard::Input<RealVec>&)input {
  self = [super initWrapping: input];
  if (self) {
    _data = make_shared<RealVec>();
    _input = &input;
    input.set(*_data);
  }
  return self;
}

/**
 Mutator for the input wrapper's data.

 @param data The new data for the input wrapper.
 */
- (void)setData:(id)data {
  if ([data isKindOfClass:[NSArray class]]) { *_data = ((NSArray *)data).realVecValue; }
}

/**
 Accessor for the input wrapper's data.

 @return `_data` converted to `OBJCRealVec`.
 */
- (id)data { return [NSArray arrayWithRealVec:*_data]; }

/**
 The type of data associated with the wrapped input.

 @return The data type.
 */
- (IODataType)dataType { return IODataTypeRealVec; }

@end

@implementation StringVecInputWrapper

/**
 Creates a new `Input<StringVec>` instance which is used to invoke `initWithTypeProxy:`.

 @return The initialized input wrapper.
 */
- (nonnull instancetype)initWithInput:(standard::Input<StringVec>&)input {
  self = [super initWrapping: input];
  if (self) {
    _data = make_shared<StringVec>();
    _input = &input;
    input.set(*_data);
  }
  return self;
}

/**
 Mutator for the input wrapper's data.

 @param data The new data for the input wrapper.
 */
- (void)setData:(id)data {
  if ([data isKindOfClass:[NSArray class]]) { *_data = ((NSArray *)data).stringVecValue; }
}

/**
 Accessor for the input wrapper's data.

 @return `_data` converted to `OBJCRealVec`.
 */
- (id)data { return [NSArray arrayWithStringVec:*_data]; }

/**
 The type of data associated with the wrapped input.

 @return The data type.
 */
- (IODataType)dataType { return IODataTypeStringVec; }

@end

@implementation StereoSampleVecInputWrapper

/**
 Creates a new `Input<StereoSampleVec>` instance which is used to invoke `initWithTypeProxy:`.

 @return The initialized input wrapper.
 */
- (nonnull instancetype)initWithInput:(standard::Input<StereoSampleVec>&)input {
  self = [super initWrapping: input];
  if (self) {
    _data = make_shared<StereoSampleVec>();
    _input = &input;
    input.set(*_data);
  }
  return self;
}

/**
 Mutator for the input wrapper's data.

 @param data The new data for the input wrapper.
 */
- (void)setData:(id)data {
  if ([data isKindOfClass:[NSArray class]]) { *_data = ((NSArray *)data).stereoSampleVecValue; }
}

/**
 Accessor for the input wrapper's data.

 @return `_data` converted to `OBJCStereoSampleVec`.
 */
- (id)data { return [NSArray arrayWithStereoSampleVec:*_data]; }

/**
 The type of data associated with the wrapped input.

 @return The data type.
 */
- (IODataType)dataType { return IODataTypeStereoSampleVec; }

@end

@implementation RealVecVecInputWrapper

/**
 Creates a new `Input<RealVecVec>` instance which is used to invoke `initWithTypeProxy:`.

 @return The initialized input wrapper.
 */
- (nonnull instancetype)initWithInput:(standard::Input<RealVecVec>&)input {
  self = [super initWrapping: input];
  if (self) {
    _data = make_shared<RealVecVec>();
    _input = &input;
    input.set(*_data);
  }
  return self;
}

/**
 Mutator for the input wrapper's data.

 @param data The new data for the input wrapper.
 */
- (void)setData:(id)data {
  if ([data isKindOfClass:[NSArray class]]) { *_data = ((NSArray *)data).realVecVecValue; }
}

/**
 Accessor for the input wrapper's data.

 @return `_data` converted to `OBJCRealVecVec`.
 */
- (id)data { return [NSArray arrayWithRealVecVec:*_data]; }

/**
 The type of data associated with the wrapped input.

 @return The data type.
 */
- (IODataType)dataType { return IODataTypeRealVecVec; }

@end

@implementation ComplexRealVecVecInputWrapper

/**
 Creates a new `Input<ComplexRealVecVec>` instance which is used to invoke `initWithTypeProxy:`.

 @return The initialized input wrapper.
 */
- (nonnull instancetype)initWithInput:(standard::Input<ComplexRealVecVec>&)input {
  self = [super initWrapping: input];
  if (self) {
    _data = make_shared<ComplexRealVecVec>();
    _input = &input;
    input.set(*_data);
  }
  return self;
}

/**
 Mutator for the input wrapper's data.

 @param data The new data for the input wrapper.
 */
- (void)setData:(id)data {
  if ([data isKindOfClass:[NSArray class]]) { *_data = ((NSArray *)data).complexRealVecVecValue; }
}

/**
 Accessor for the input wrapper's data.

 @return `_data` converted to `OBJCComplexRealVecVec`.
 */
- (id)data { return [NSArray arrayWithComplexRealVecVec:*_data]; }

/**
 The type of data associated with the wrapped input.

 @return The data type.
 */
- (IODataType)dataType { return IODataTypeComplexRealVecVec; }

@end

/**
 Subclass of `OutputWrapper` for C++ class `Output<Real>`.
 */
@interface RealOutputWrapper: OutputWrapper {
  @package
  shared_ptr<Real> _data;
  standard::Output<Real> *_output;
}

- (instancetype)initWithOutput:(standard::Output<Real>&)output;
- (void)connectTo:(RealInputWrapper *)inputWrapper;

@end

/**
 Subclass of `OutputWrapper` for C++ class `Output<String>`.
 */
@interface StringOutputWrapper: OutputWrapper {
  @package
  shared_ptr<String> _data;
  standard::Output<String> *_output;
}

- (instancetype)initWithOutput:(standard::Output<String>&)output;
- (void)connectTo:(StringInputWrapper *)inputWrapper;

@end

/**
 Subclass of `OutputWrapper` for C++ class `Output<Int>`.
 */
@interface IntOutputWrapper: OutputWrapper {
  @package
  shared_ptr<Int> _data;
  standard::Output<Int> *_output;
}

- (instancetype)initWithOutput:(standard::Output<Int>&)output;
- (void)connectTo:(IntInputWrapper *)inputWrapper;

@end

/**
 Subclass of `OutputWrapper` for C++ class `Output<ComplexReal>`.
 */
@interface ComplexRealOutputWrapper: OutputWrapper {
  @package
  shared_ptr<ComplexReal> _data;
  standard::Output<ComplexReal> *_output;
}


- (nonnull instancetype)initWithOutput:(standard::Output<ComplexReal>&)output;
- (void)connectTo:(ComplexRealInputWrapper *)inputWrapper;

@end

/**
 Subclass of `OutputWrapper` for C++ class `Output<StereoSample>`.
 */
@interface StereoSampleOutputWrapper: OutputWrapper {
  @package
  shared_ptr<StereoSample> _data;
  standard::Output<StereoSample> *_output;
}

- (nonnull instancetype)initWithOutput:(standard::Output<StereoSample>&)output;
- (void)connectTo:(StereoSampleInputWrapper *)inputWrapper;

@end


/**
 Subclass of `OutputWrapper` for C++ class `Output<Pool>`.
 */
@interface PoolOutputWrapper: OutputWrapper {
  @package
  shared_ptr<Pool> _data;
  standard::Output<Pool> *_output;
}

- (instancetype)initWithOutput:(standard::Output<Pool>&)output;
- (void)connectTo:(PoolInputWrapper *)inputWrapper;

@end

/**
 Subclass of `OutputWrapper` for C++ class `Output<RealMatrix>`.
 */
@interface RealMatrixOutputWrapper: OutputWrapper {
  @package
  shared_ptr<RealMatrix> _data;
  standard::Output<RealMatrix> *_output;
}

- (instancetype)initWithOutput:(standard::Output<RealMatrix>&)output;
- (void)connectTo:(RealMatrixInputWrapper *)inputWrapper;

@end

/**
 Subclass of `OutputWrapper` for C++ class `Output<ComplexRealVec>`.
 */
@interface ComplexRealVecOutputWrapper: OutputWrapper {
  @package
  shared_ptr<ComplexRealVec> _data;
  standard::Output<ComplexRealVec> *_output;
}

- (instancetype)initWithOutput:(standard::Output<ComplexRealVec>&)output;
- (void)connectTo:(ComplexRealVecInputWrapper *)inputWrapper;

@end

/**
 Subclass of `OutputWrapper` for C++ class `Output<RealVec>`.
 */
@interface RealVecOutputWrapper: OutputWrapper {
  @package
  shared_ptr<RealVec> _data;
  standard::Output<RealVec> *_output;
}

- (instancetype)initWithOutput:(standard::Output<RealVec>&)output;
- (void)connectTo:(RealVecInputWrapper *)inputWrapper;

@end

/**
 Subclass of `OutputWrapper` for C++ class `Output<StringVec>`.
 */
@interface StringVecOutputWrapper: OutputWrapper {
  @package
  shared_ptr<StringVec> _data;
  standard::Output<StringVec> *_output;
}

- (instancetype)initWithOutput:(standard::Output<StringVec>&)output;
- (void)connectTo:(StringVecInputWrapper *)inputWrapper;

@end

/**
 Subclass of `OutputWrapper` for C++ class `Output<StereoSampleVec>`.
 */
@interface StereoSampleVecOutputWrapper: OutputWrapper {
  @package
  shared_ptr<StereoSampleVec> _data;
  standard::Output<StereoSampleVec> *_output;
}

- (instancetype)initWithOutput:(standard::Output<StereoSampleVec>&)output;
- (void)connectTo:(StereoSampleVecInputWrapper *)inputWrapper;

@end

/**
 Subclass of `OutputWrapper` for C++ class `Output<RealVecVec>`.
 */
@interface RealVecVecOutputWrapper: OutputWrapper {
  @package
  shared_ptr<RealVecVec> _data;
  standard::Output<RealVecVec> *_output;
}

- (instancetype)initWithOutput:(standard::Output<RealVecVec>&)output;
- (void)connectTo:(RealVecVecInputWrapper *)inputWrapper;

@end

/**
 Subclass of `OutputWrapper` for C++ class `Output<ComplexRealVecVec>`.
 */
@interface ComplexRealVecVecOutputWrapper: OutputWrapper {
  @package
  shared_ptr<ComplexRealVecVec> _data;
  standard::Output<ComplexRealVecVec> *_output;
}

- (instancetype)initWithOutput:(standard::Output<ComplexRealVecVec>&)output;
- (void)connectTo:(ComplexRealVecVecInputWrapper *)inputWrapper;

@end

@implementation OutputWrapper {
  standard::OutputBase *_outputBase;
}

/**
 Initializing with a specified output.

 @param outputBase The C++ output to wrap.
 @return The new output wrapper with `outputBase`.
 */
- (instancetype)initWrapping:(standard::OutputBase &)outputBase {
  self = [super init];
  if (self) {
    _outputBase = &outputBase;
  }
  return self;
}

/**
 Creates a new output wrapper for the specified output.

 @param outputBase The C++ output to wrap.
 @return The new output wrapper with `outputBase`.
 */
+ (instancetype)outputWrapperWrapping:(standard::OutputBase&)outputBase {

  switch (dataTypeForType(outputBase.typeInfo())) {

    case IODataTypeReal:
      return [[RealOutputWrapper alloc]
              initWithOutput:static_cast<standard::Output<Real>&>(outputBase)];
    case IODataTypeString:
      return [[StringOutputWrapper alloc]
              initWithOutput:static_cast<standard::Output<String>&>(outputBase)];
    case IODataTypeInt:
      return [[IntOutputWrapper alloc]
              initWithOutput:static_cast<standard::Output<Int>&>(outputBase)];
    case IODataTypeComplexReal:
      return [[ComplexRealOutputWrapper alloc]
              initWithOutput:static_cast<standard::Output<ComplexReal>&>(outputBase)];
    case IODataTypeStereoSample:
      return [[StereoSampleOutputWrapper alloc]
              initWithOutput:static_cast<standard::Output<StereoSample>&>(outputBase)];
    case IODataTypePool:
      return [[PoolOutputWrapper alloc]
              initWithOutput:static_cast<standard::Output<Pool>&>(outputBase)];
    case IODataTypeRealMatrix:
      return [[RealMatrixOutputWrapper alloc]
              initWithOutput:static_cast<standard::Output<RealMatrix>&>(outputBase)];
    case IODataTypeComplexRealVec:
      return [[ComplexRealVecOutputWrapper alloc]
              initWithOutput:static_cast<standard::Output<ComplexRealVec>&>(outputBase)];
    case IODataTypeRealVec:
      return [[RealVecOutputWrapper alloc]
              initWithOutput:static_cast<standard::Output<RealVec>&>(outputBase)];
    case IODataTypeStringVec:
      return [[StringVecOutputWrapper alloc]
              initWithOutput:static_cast<standard::Output<StringVec>&>(outputBase)];
    case IODataTypeStereoSampleVec:
      return [[StereoSampleVecOutputWrapper alloc]
              initWithOutput:static_cast<standard::Output<StereoSampleVec>&>(outputBase)];
    case IODataTypeRealVecVec:
      return [[RealVecVecOutputWrapper alloc]
              initWithOutput:static_cast<standard::Output<RealVecVec>&>(outputBase)];

    case IODataTypeComplexRealVecVec:
      return [[ComplexRealVecVecOutputWrapper alloc]
              initWithOutput:static_cast<standard::Output<ComplexRealVecVec>&>(outputBase)];

  }

}

/**
 Accessor for the wrapped C++ `OutputBase`.

 @return The wrapped output.
 */
- (nonnull const standard::OutputBase *)output { return _outputBase; }

/**
 The full name of the output.
 */
- (nonnull NSString *)fullName {
  return [NSString  stringWithCPPString:_outputBase->fullName()];
}

/**
 Accessor for the name given the wrapped input.

 @return The input's name.
 */
- (nonnull NSString *)name { return [NSString stringWithCPPString:_outputBase->name()]; }

/**
 Mutator for the name given the wrapped input.

 @param name The new name to assign to the wrapped input.
 */
- (void)setName:(nonnull NSString *)name { _outputBase->setName(name.cppString); }

/**
 The data held by the output wrapper. Must be overridden by subclasses since `OutputWrapper` holds
 no data.
 */
- (id)data {
  @throw inconsistencyException(@"`OutputWrapper` is an abstract base.");
}

/**
 Joins the output wrapper with the specified input wrapper so that the data for the input
 wrapper becomes the data from the output wrapper.

 @param inputWrapper The input wrapper to feed the output wrapper's data.
 */
- (void)connectToInputWrapper:(InputWrapper *)inputWrapper {

  if (   [self isMemberOfClass: [RealOutputWrapper class]]
      && [inputWrapper isMemberOfClass: [RealInputWrapper class]])
  {
    [(RealOutputWrapper *)self connectTo: (RealInputWrapper *)inputWrapper];
  } else if (   [self isMemberOfClass: [StringOutputWrapper class]]
             && [inputWrapper isMemberOfClass: [StringInputWrapper class]])
  {
    [(StringOutputWrapper *)self connectTo: (StringInputWrapper *)inputWrapper];
  } else if (   [self isMemberOfClass: [IntOutputWrapper class]]
             && [inputWrapper isMemberOfClass: [IntInputWrapper class]])
  {
    [(IntOutputWrapper *)self connectTo: (IntInputWrapper *)inputWrapper];
  } else if (   [self isMemberOfClass: [ComplexRealOutputWrapper class]]
             && [inputWrapper isMemberOfClass: [ComplexRealInputWrapper class]])
  {
    [(ComplexRealOutputWrapper *)self connectTo: (ComplexRealInputWrapper *)inputWrapper];
  } else if (   [self isMemberOfClass: [StereoSampleOutputWrapper class]]
             && [inputWrapper isMemberOfClass: [StereoSampleInputWrapper class]])
  {
    [(StereoSampleOutputWrapper *)self connectTo: (StereoSampleInputWrapper *)inputWrapper];
  } else if (   [self isMemberOfClass: [PoolOutputWrapper class]]
             && [inputWrapper isMemberOfClass: [PoolInputWrapper class]])
  {
    [(PoolOutputWrapper *)self connectTo: (PoolInputWrapper *)inputWrapper];
  } else if (   [self isMemberOfClass: [RealMatrixOutputWrapper class]]
             && [inputWrapper isMemberOfClass: [RealMatrixInputWrapper class]])
  {
    [(RealMatrixOutputWrapper *)self connectTo: (RealMatrixInputWrapper *)inputWrapper];
  } else if (   [self isMemberOfClass: [ComplexRealVecOutputWrapper class]]
             && [inputWrapper isMemberOfClass: [ComplexRealVecInputWrapper class]])
  {
    [(ComplexRealVecOutputWrapper *)self connectTo: (ComplexRealVecInputWrapper *)inputWrapper];
  } else if (   [self isMemberOfClass: [RealVecOutputWrapper class]]
             && [inputWrapper isMemberOfClass: [RealVecInputWrapper class]])
  {
    [(RealVecOutputWrapper *)self connectTo: (RealVecInputWrapper *)inputWrapper];
  } else if (   [self isMemberOfClass: [StringVecOutputWrapper class]]
             && [inputWrapper isMemberOfClass: [StringVecInputWrapper class]])
  {
    [(StringVecOutputWrapper *)self connectTo: (StringVecInputWrapper *)inputWrapper];
  } else if (   [self isMemberOfClass: [StereoSampleVecOutputWrapper class]]
             && [inputWrapper isMemberOfClass: [StereoSampleVecInputWrapper class]])
  {
    [(StereoSampleVecOutputWrapper *)self connectTo: (StereoSampleVecInputWrapper *)inputWrapper];
  } else if (   [self isMemberOfClass: [RealVecVecOutputWrapper class]]
             && [inputWrapper isMemberOfClass: [RealVecVecInputWrapper class]])
  {
    [(RealVecVecOutputWrapper *)self connectTo: (RealVecVecInputWrapper *)inputWrapper];
  } else if (   [self isMemberOfClass: [ComplexRealVecVecOutputWrapper class]]
             && [inputWrapper isMemberOfClass: [ComplexRealVecVecInputWrapper class]])
  {
    [(ComplexRealVecVecOutputWrapper *)self connectTo: (ComplexRealVecVecInputWrapper *)inputWrapper];
  } else {
    @throw invalidArgumentException(@"IO data type mismatch.");
  }

}

@end

@implementation RealOutputWrapper

/**
 Creates a new wrapper for a C++ `Output<Real>`.

 @param output The C++ object to wrap.
 @return The initialized output wrapper.
 */
- (nonnull instancetype)initWithOutput:(standard::Output<Real>&)output {
  self = [super initWrapping:output];
  if (self) {
    _data = make_shared<Real>();
    _output = &output;
    output.set(*_data);
  }
  return self;
}

/**
 Accessor for the output wrapper's data.

 @return `_data` converted to `OBJCReal`.
 */
- (id)data { return [NSNumber numberWithFloat:*_data]; }

/**
 The type of data associated with the wrapped input.

 @return The data type.
 */
- (IODataType)dataType { return IODataTypeReal; }

/**
 Joins the output wrapper with the specified input wrapper so that the data for the input
 wrapper becomes the data from the output wrapper.

 @param inputWrapper The input wrapper to feed the output wrapper's data.
 */
- (void)connectTo:(RealInputWrapper *)inputWrapper {

  inputWrapper->_data = _data;
  inputWrapper->_input->set(*(inputWrapper->_data));

}

@end

@implementation StringOutputWrapper

/**
 Creates a new wrapper for a C++ `Output<String>`.

 @param output The C++ object to wrap.
 @return The initialized output wrapper.
 */
- (nonnull instancetype)initWithOutput:(standard::Output<String>&)output {
  self = [super initWrapping:output];
  if (self) {
    _data = make_shared<String>();
    _output = &output;
    output.set(*_data);
  }
  return self;
}

/**
 Accessor for the output wrapper's data.

 @return `_data` converted to `OBJCString`.
 */
- (id)data { return [NSString stringWithCPPString:*_data]; }

/**
 The type of data associated with the wrapped input.

 @return The data type.
 */
- (IODataType)dataType { return IODataTypeString; }

/**
 Joins the output wrapper with the specified input wrapper so that the data for the input
 wrapper becomes the data from the output wrapper.

 @param inputWrapper The input wrapper to feed the output wrapper's data.
 */
- (void)connectTo:(StringInputWrapper *)inputWrapper {

  inputWrapper->_data = _data;
  inputWrapper->_input->set(*(inputWrapper->_data));

}

@end

@implementation IntOutputWrapper

/**
 Creates a new wrapper for a C++ `Output<Int>`.

 @param output The C++ object to wrap.
 @return The initialized output wrapper.
 */
- (nonnull instancetype)initWithOutput:(standard::Output<Int>&)output {
  self = [super initWrapping:output];
  if (self) {
    _data = make_shared<Int>();
    _output = &output;
    output.set(*_data);
  }
  return self;
}

/**
 Accessor for the output wrapper's data.

 @return `_data` converted to `OBJCInt`.
 */
- (id)data { return [NSNumber numberWithInt:*_data]; }

/**
 The type of data associated with the wrapped input.

 @return The data type.
 */
- (IODataType)dataType { return IODataTypeInt; }

/**
 Joins the output wrapper with the specified input wrapper so that the data for the input
 wrapper becomes the data from the output wrapper.

 @param inputWrapper The input wrapper to feed the output wrapper's data.
 */
- (void)connectTo:(IntInputWrapper *)inputWrapper {

  inputWrapper->_data = _data;
  inputWrapper->_input->set(*(inputWrapper->_data));

}

@end

@implementation ComplexRealOutputWrapper

/**
 Creates a new wrapper for a C++ `Output<ComplexReal>`.

 @param output The C++ object to wrap.
 @return The initialized output wrapper.
 */
- (nonnull instancetype)initWithOutput:(standard::Output<ComplexReal>&)output {
  self = [super initWrapping:output];
  if (self) {
    _data = make_shared<ComplexReal>();
    _output = &output;
    output.set(*_data);
  }
  return self;
}

/**
 Accessor for the output wrapper's data.

 @return `_data` converted to `OBJCInt`.
 */
- (id)data { return [NSValue valueWithComplex:{_data->real(), _data->imag()}]; }

/**
 The type of data associated with the wrapped input.

 @return The data type.
 */
- (IODataType)dataType { return IODataTypeComplexReal; }

/**
 Joins the output wrapper with the specified input wrapper so that the data for the input
 wrapper becomes the data from the output wrapper.

 @param inputWrapper The input wrapper to feed the output wrapper's data.
 */
- (void)connectTo:(ComplexRealInputWrapper *)inputWrapper {

  inputWrapper->_data = _data;
  inputWrapper->_input->set(*(inputWrapper->_data));

}

@end

@implementation StereoSampleOutputWrapper

/**
 Creates a new wrapper for a C++ `Output<StereoSample>`.

 @param output The C++ object to wrap.
 @return The initialized output wrapper.
 */
- (nonnull instancetype)initWithOutput:(standard::Output<StereoSample>&)output {
  self = [super initWrapping:output];
  if (self) {
    _data = make_shared<StereoSample>();
    _output = &output;
    output.set(*_data);
  }
  return self;
}

/**
 Accessor for the output wrapper's data.

 @return `_data` converted to `OBJCInt`.
 */
- (id)data { return [NSValue valueWithComplex:{_data->left(), _data->right()}]; }

/**
 The type of data associated with the wrapped input.

 @return The data type.
 */
- (IODataType)dataType { return IODataTypeStereoSample; }

/**
 Joins the output wrapper with the specified input wrapper so that the data for the input
 wrapper becomes the data from the output wrapper.

 @param inputWrapper The input wrapper to feed the output wrapper's data.
 */
- (void)connectTo:(StereoSampleInputWrapper *)inputWrapper {

  inputWrapper->_data = _data;
  inputWrapper->_input->set(*(inputWrapper->_data));

}

@end

@implementation PoolOutputWrapper

/**
 Creates a new wrapper for a C++ `Output<Pool>`.

 @param output The C++ object to wrap.
 @return The initialized output wrapper.
 */
- (nonnull instancetype)initWithOutput:(standard::Output<Pool>&)output {
  self = [super initWrapping:output];
  if (self) {
    _data =make_shared<Pool>();
    _output = &output;
    output.set(*_data);
  }
  return self;
}

/**
 Accessor for the output wrapper's data.

 @return `_data` converted to `OBJCPool`.
 */
- (id)data { return [PoolWrapper poolWrapperWithPool:_data.get()]; }

/**
 The type of data associated with the wrapped input.

 @return The data type.
 */
- (IODataType)dataType { return IODataTypePool; }

/**
 Joins the output wrapper with the specified input wrapper so that the data for the input
 wrapper becomes the data from the output wrapper.

 @param inputWrapper The input wrapper to feed the output wrapper's data.
 */
- (void)connectTo:(PoolInputWrapper *)inputWrapper {

  inputWrapper->_data = _data;
  inputWrapper->_input->set(*(inputWrapper->_data));

}

@end

@implementation RealMatrixOutputWrapper

/**
 Creates a new wrapper for a C++ `Output<RealMatrix>`.

 @param output The C++ object to wrap.
 @return The initialized output wrapper.
 */
- (nonnull instancetype)initWithOutput:(standard::Output<RealMatrix>&)output {
  self = [super initWrapping:output];
  if (self) {
    _data = make_shared<RealMatrix>();
    _output = &output;
    output.set(*_data);
  }
  return self;
}

/**
 Accessor for the output wrapper's data.

 @return `_data` converted to `OBJCRealMatrix`.
 */
- (id)data { return [NSArray arrayWithRealMatrix:*_data]; }

/**
 The type of data associated with the wrapped input.

 @return The data type.
 */
- (IODataType)dataType { return IODataTypeRealMatrix; }

/**
 Joins the output wrapper with the specified input wrapper so that the data for the input
 wrapper becomes the data from the output wrapper.

 @param inputWrapper The input wrapper to feed the output wrapper's data.
 */
- (void)connectTo:(RealMatrixInputWrapper *)inputWrapper {

  inputWrapper->_data = _data;
  inputWrapper->_input->set(*(inputWrapper->_data));

}

@end

@implementation ComplexRealVecOutputWrapper

/**
 Creates a new wrapper for a C++ `Output<ComplexRealVec>`.

 @param output The C++ object to wrap.
 @return The initialized output wrapper.
 */
- (nonnull instancetype)initWithOutput:(standard::Output<ComplexRealVec>&)output {
  self = [super initWrapping:output];
  if (self) {
    _data = make_shared<ComplexRealVec>();
    _output = &output;
    output.set(*_data);
  }
  return self;
}

/**
 Accessor for the output wrapper's data.

 @return `_data` converted to `OBJCComplexRealVec`.
 */
- (id)data { return [NSArray arrayWithComplexRealVec:*_data]; }

/**
 The type of data associated with the wrapped input.

 @return The data type.
 */
- (IODataType)dataType { return IODataTypeComplexRealVec; }

/**
 Joins the output wrapper with the specified input wrapper so that the data for the input
 wrapper becomes the data from the output wrapper.

 @param inputWrapper The input wrapper to feed the output wrapper's data.
 */
- (void)connectTo:(ComplexRealVecInputWrapper *)inputWrapper {

  inputWrapper->_data = _data;
  inputWrapper->_input->set(*(inputWrapper->_data));

}

@end

@implementation RealVecOutputWrapper

/**
 Creates a new wrapper for a C++ `Output<RealVec>`.

 @param output The C++ object to wrap.
 @return The initialized output wrapper.
 */
- (nonnull instancetype)initWithOutput:(standard::Output<RealVec>&)output {
  self = [super initWrapping:output];
  if (self) {
    _data = make_shared<RealVec>();
    _output = &output;
    output.set(*_data);
  }
  return self;
}

/**
 Accessor for the output wrapper's data.

 @return `_data` converted to `OBJCRealVec`.
 */
- (id)data { return [NSArray arrayWithRealVec:*_data]; }

/**
 The type of data associated with the wrapped input.

 @return The data type.
 */
- (IODataType)dataType { return IODataTypeRealVec; }

/**
 Joins the output wrapper with the specified input wrapper so that the data for the input
 wrapper becomes the data from the output wrapper.

 @param inputWrapper The input wrapper to feed the output wrapper's data.
 */
- (void)connectTo:(RealVecInputWrapper *)inputWrapper {

  inputWrapper->_data = _data;
  inputWrapper->_input->set(*(inputWrapper->_data));

}

@end

@implementation StringVecOutputWrapper

/**
 Creates a new wrapper for a C++ `Output<StringVec>`.

 @param output The C++ object to wrap.
 @return The initialized output wrapper.
 */
- (nonnull instancetype)initWithOutput:(standard::Output<StringVec>&)output {
  self = [super initWrapping:output];
  if (self) {
    _data = make_shared<StringVec>();
    _output = &output;
    output.set(*_data);
  }
  return self;
}

/**
 Accessor for the output wrapper's data.

 @return `_data` converted to `OBJCRealVec`.
 */
- (id)data { return [NSArray arrayWithStringVec:*_data]; }

/**
 The type of data associated with the wrapped input.

 @return The data type.
 */
- (IODataType)dataType { return IODataTypeStringVec; }

/**
 Joins the output wrapper with the specified input wrapper so that the data for the input
 wrapper becomes the data from the output wrapper.

 @param inputWrapper The input wrapper to feed the output wrapper's data.
 */
- (void)connectTo:(StringVecInputWrapper *)inputWrapper {

  inputWrapper->_data = _data;
  inputWrapper->_input->set(*(inputWrapper->_data));

}

@end

@implementation StereoSampleVecOutputWrapper

/**
 Creates a new wrapper for a C++ `Output<StereoSampleVec>`.

 @param output The C++ object to wrap.
 @return The initialized output wrapper.
 */
- (nonnull instancetype)initWithOutput:(standard::Output<StereoSampleVec>&)output {
  self = [super initWrapping:output];
  if (self) {
    _data = make_shared<StereoSampleVec>();
    _output = &output;
    output.set(*_data);
  }
  return self;
}

/**
 Accessor for the output wrapper's data.

 @return `_data` converted to `OBJCStereoSampleVec`.
 */
- (id)data { return [NSArray arrayWithStereoSampleVec:*_data]; }

/**
 The type of data associated with the wrapped input.

 @return The data type.
 */
- (IODataType)dataType { return IODataTypeStereoSampleVec; }

/**
 Joins the output wrapper with the specified input wrapper so that the data for the input
 wrapper becomes the data from the output wrapper.

 @param inputWrapper The input wrapper to feed the output wrapper's data.
 */
- (void)connectTo:(StereoSampleVecInputWrapper *)inputWrapper {

  inputWrapper->_data = _data;
  inputWrapper->_input->set(*(inputWrapper->_data));

}

@end

@implementation RealVecVecOutputWrapper

/**
 Creates a new wrapper for a C++ `Output<RealVecVec>`.

 @param output The C++ object to wrap.
 @return The initialized output wrapper.
 */
- (nonnull instancetype)initWithOutput:(standard::Output<RealVecVec>&)output {
  self = [super initWrapping:output];
  if (self) {
    _data = make_shared<RealVecVec>();
    _output = &output;
    output.set(*_data);
  }
  return self;
}

/**
 Accessor for the output wrapper's data.

 @return `_data` converted to `OBJCRealVecVec`.
 */
- (id)data { return [NSArray arrayWithRealVecVec:*_data]; }

/**
 The type of data associated with the wrapped input.

 @return The data type.
 */
- (IODataType)dataType { return IODataTypeRealVecVec; }

/**
 Joins the output wrapper with the specified input wrapper so that the data for the input
 wrapper becomes the data from the output wrapper.

 @param inputWrapper The input wrapper to feed the output wrapper's data.
 */
- (void)connectTo:(RealVecVecInputWrapper *)inputWrapper {

  inputWrapper->_data = _data;
  inputWrapper->_input->set(*(inputWrapper->_data));

}

@end

@implementation ComplexRealVecVecOutputWrapper

/**
 Creates a new wrapper for a C++ `Output<ComplexRealVecVec>`.

 @param output The C++ object to wrap.
 @return The initialized output wrapper.
 */
- (nonnull instancetype)initWithOutput:(standard::Output<ComplexRealVecVec>&)output {
  self = [super initWrapping:output];
  if (self) {
    _data = make_shared<ComplexRealVecVec>();
    _output = &output;
    output.set(*_data);
  }
  return self;
}

/**
 Accessor for the output wrapper's data.

 @return `_data` converted to `OBJCComplexRealVecVec`.
 */
- (id)data { return [NSArray arrayWithComplexRealVecVec:*_data]; }

/**
 The type of data associated with the wrapped input.

 @return The data type.
 */
- (IODataType)dataType { return IODataTypeComplexRealVecVec; }

/**
 Joins the output wrapper with the specified input wrapper so that the data for the input
 wrapper becomes the data from the output wrapper.

 @param inputWrapper The input wrapper to feed the output wrapper's data.
 */
- (void)connectTo:(ComplexRealVecVecInputWrapper *)inputWrapper {

  inputWrapper->_data = _data;
  inputWrapper->_input->set(*(inputWrapper->_data));

}

@end
