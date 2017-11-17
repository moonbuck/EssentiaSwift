//
//  VectorInputWrapper.mm
//  Essentia
//
//  Created by Jason Cardwell on 10/24/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
#import "VectorInputWrapper.h"
#import "AlgorithmWrapper+BridgingExtensions.hpp"
#import "vectorinput.h"
#import <typeinfo>
#import "NSString+BridgingExtensions.hpp"
#import "NSArray+BridgingExtensions.hpp"
#import "BridgedValue.hpp"
#import "Exceptions.h"

using namespace std;
using namespace essentia;
using namespace essentia::streaming;

@implementation VectorInputWrapper {
  BridgedValue *_input;
}

- (instancetype)initWithAlgorithm:(Algorithm&)algorithm assumeOwnership:(BOOL)assumeOwnership {

  NSString *algorithmName = [NSString stringWithCPPString:algorithm.name()];
  if (![algorithmName isEqualToString:@"VectorInput"]) {
    @throw invalidArgumentException(@"The algorithm is not an instance of `VectorInput`.");
  }

  return [super initWithAlgorithm:algorithm assumeOwnership:assumeOwnership];

}

/**
 Creates a new vector input wrapper for the specified real vector.

 @param value The vector.
 @return The newly created wrapper for a vector input with the specified data.
 */
+ (instancetype)vectorInputWrapperWithRealVec:(OBJCRealVec)value {
  RealVecBridgedValue * input = [RealVecBridgedValue bridgedValueBridging:value];
  VectorInput<Real> *algorithm = new VectorInput<Real>(input->_value.get(), false);
  VectorInputWrapper *wrapper = [[VectorInputWrapper alloc] initWithAlgorithm:*algorithm
                                                              assumeOwnership:YES];
  wrapper->_input = input;
  return wrapper;
}

/**
 Creates a new vector input wrapper for the specified real matrix.

 @param value The vector.
 @return The newly created wrapper for a vector input with the specified data.
 */
+ (instancetype)vectorInputWrapperWithRealMatrixVec:(OBJCRealMatrixVec)value {
  RealMatrixVecBridgedValue *input = [RealMatrixVecBridgedValue bridgedValueBridging:value];
  VectorInput<RealMatrix> *algorithm = new VectorInput<RealMatrix>(input->_value.get(), false);
  VectorInputWrapper *wrapper = [[VectorInputWrapper alloc] initWithAlgorithm:*algorithm
                                                              assumeOwnership:YES];
  wrapper->_input = input;
  return wrapper;
}

/**
 Creates a new vector input wrapper for the specified string vector.

 @param value The vector.
 @return The newly created wrapper for a vector input with the specified data.
 */
+ (instancetype)vectorInputWrapperWithStringVec:(OBJCStringVec)value {
  StringVecBridgedValue *input = [StringVecBridgedValue bridgedValueBridging:value];
  VectorInput<String> *algorithm = new VectorInput<String>(input->_value.get(), false);
  VectorInputWrapper *wrapper = [[VectorInputWrapper alloc] initWithAlgorithm:*algorithm
                                                              assumeOwnership:YES];
  wrapper->_input = input;
  return wrapper;
}

/**
 Creates a new vector input wrapper for the specified stereo sample vector.

 @param value The vector.
 @return The newly created wrapper for a vector input with the specified data.
 */
+ (instancetype)vectorInputWrapperWithStereoSampleVec:(OBJCStereoSampleVec)value {
  StereoSampleVecBridgedValue *input = [StereoSampleVecBridgedValue bridgedValueBridging:value];
  VectorInput<StereoSample> *algorithm = new VectorInput<StereoSample>(input->_value.get(), false);
  VectorInputWrapper *wrapper = [[VectorInputWrapper alloc] initWithAlgorithm:*algorithm
                                                              assumeOwnership:YES];
  wrapper->_input = input;
  return wrapper;
}

/**
 Creates a new vector input wrapper for the specified real vector vector.

 @param value The vector.
 @return The newly created wrapper for a vector input with the specified data.
 */
+ (instancetype)vectorInputWrapperWithRealVecVec:(OBJCRealVecVec)value {
  RealVecVecBridgedValue *input = [RealVecVecBridgedValue bridgedValueBridging:value];
  VectorInput<RealVec> *algorithm = new VectorInput<RealVec>(input->_value.get(), false);
  VectorInputWrapper *wrapper = [[VectorInputWrapper alloc] initWithAlgorithm:*algorithm
                                                              assumeOwnership:YES];
  wrapper->_input = input;
  return wrapper;
}

/**
 Creates a new vector input wrapper for the specified complex real vector.

 @param value The vector.
 @return The newly created wrapper for a vector input with the specified data.
 */
+ (instancetype)vectorInputWrapperWithComplexRealVec:(OBJCComplexRealVec)value {
  ComplexRealVecBridgedValue *input = [ComplexRealVecBridgedValue bridgedValueBridging:value];
  VectorInput<ComplexReal> *algorithm = new VectorInput<ComplexReal>(input->_value.get(), false);
  VectorInputWrapper *wrapper = [[VectorInputWrapper alloc] initWithAlgorithm:*algorithm
                                                              assumeOwnership:YES];
  wrapper->_input = input;
  return wrapper;
}

/**
 Creates a new vector input wrapper for the specified complex real vector.

 @param value The vector.
 @return The newly created wrapper for a vector input with the specified data.
 */
+ (instancetype)vectorInputWrapperWithComplexRealVecVec:(OBJCComplexRealVecVec)value {
  ComplexRealVecVecBridgedValue *input = [ComplexRealVecVecBridgedValue bridgedValueBridging:value];
  VectorInput<ComplexRealVec> *algorithm = new VectorInput<ComplexRealVec>(input->_value.get(), false);
  VectorInputWrapper *wrapper = [[VectorInputWrapper alloc] initWithAlgorithm:*algorithm
                                                              assumeOwnership:YES];
  wrapper->_input = input;
  return wrapper;
}

/**
 Accessor for the vector used as input data.

 @return The vector used as input data.
 */
- (NSArray *)vector {
  return (NSArray *)_input.objcValue;
}

/**
 Mutator for the vector used as input data.

 @param vector The new data to use as input.
 */
- (void)setVector:(nonnull NSArray *)vector {

  [_input setOBJCValue:vector];

  if ([_input isMemberOfClass:[RealVecBridgedValue class]]) {
    VectorInput<Real> *algorithm = static_cast<VectorInput<Real>*>(_algorithm);
    algorithm->setVector(((RealVecBridgedValue *)_input)->_value.get());
  } else if ([_input isMemberOfClass:[RealMatrixVecBridgedValue class]]) {
    VectorInput<RealMatrix> *algorithm = static_cast<VectorInput<RealMatrix>*>(_algorithm);
    algorithm->setVector(((RealMatrixVecBridgedValue *)_input)->_value.get());
  } else if ([_input isMemberOfClass:[StringVecBridgedValue class]]) {
    VectorInput<String> *algorithm = static_cast<VectorInput<String>*>(_algorithm);
    algorithm->setVector(((StringVecBridgedValue *)_input)->_value.get());
  } else if ([_input isMemberOfClass:[StereoSampleVecBridgedValue class]]) {
    VectorInput<StereoSample> *algorithm = static_cast<VectorInput<StereoSample>*>(_algorithm);
    algorithm->setVector(((StereoSampleVecBridgedValue *)_input)->_value.get());
  } else if ([_input isMemberOfClass:[RealVecVecBridgedValue class]]) {
    VectorInput<RealVec> *algorithm = static_cast<VectorInput<RealVec>*>(_algorithm);
    algorithm->setVector(((RealVecVecBridgedValue *)_input)->_value.get());
  } else if ([_input isMemberOfClass:[ComplexRealVecBridgedValue class]]) {
    VectorInput<ComplexReal> *algorithm = static_cast<VectorInput<ComplexReal>*>(_algorithm);
    algorithm->setVector(((ComplexRealVecBridgedValue *)_input)->_value.get());
  } else if ([_input isMemberOfClass:[ComplexRealVecVecBridgedValue class]]) {
    VectorInput<ComplexRealVec> *algorithm = static_cast<VectorInput<ComplexRealVec>*>(_algorithm);
    algorithm->setVector(((ComplexRealVecVecBridgedValue *)_input)->_value.get());
  }

}

@end
