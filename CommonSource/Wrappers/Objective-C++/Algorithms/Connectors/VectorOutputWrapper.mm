//
//  VectorOutputWrapper.mm
//  Essentia
//
//  Created by Jason Cardwell on 10/24/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
#import "VectorOutputWrapper.h"
#import "AlgorithmWrapper+BridgingExtensions.hpp"
#import "vectoroutput.h"
#import "NSString+BridgingExtensions.hpp"
//#import "NSArray+BridgingExtensions.hpp"
#import "BridgedValue.hpp"
#import "Exceptions.h"

using namespace std;
using namespace essentia;
using namespace essentia::streaming;

@implementation VectorOutputWrapper {
  BridgedValue *_output;
  IODataType _type;
}

- (instancetype)initWithAlgorithm:(Algorithm&)algorithm assumeOwnership:(BOOL)assumeOwnership {

  NSString *algorithmName = [NSString stringWithCPPString:algorithm.name()];
  if (![algorithmName isEqualToString:@"VectorOutput"]) {
    @throw invalidArgumentException(@"The algorithm is not an instance of `VectorOutput`.");
  }

  return [super initWithAlgorithm:algorithm assumeOwnership:assumeOwnership];

}

/**
 Creates a new vector output wrapper for receiving data of the specified type. An exception
 is thrown if the type is not one of the vector types.

 @param type The vector type for the wrapper.
 @return The newly created wrapper for `type`.
 */
+ (instancetype)vectorOutputWrapperForDataType:(IODataType)type {

  switch (type) {

    case IODataTypeComplexRealVec: {
      ComplexRealVecBridgedValue *output = [ComplexRealVecBridgedValue new];
      VectorOutput<ComplexReal> *algorithm = new VectorOutput<ComplexReal>(output->_value.get());
      VectorOutputWrapper *wrapper = [[VectorOutputWrapper alloc] initWithAlgorithm:*algorithm
                                                                    assumeOwnership:YES];
      wrapper->_output = output;
      wrapper->_type = type;
      return wrapper;
    }

    case IODataTypeRealVec: {
      RealVecBridgedValue *output = [RealVecBridgedValue new];
      VectorOutput<Real> *algorithm = new VectorOutput<Real>(output->_value.get());
      VectorOutputWrapper *wrapper = [[VectorOutputWrapper alloc] initWithAlgorithm:*algorithm
                                                                    assumeOwnership:YES];
      wrapper->_output = output;
      wrapper->_type = type;
      return wrapper;
    }

    case IODataTypeStringVec: {
      StringVecBridgedValue *output = [StringVecBridgedValue new];
      VectorOutput<String> *algorithm = new VectorOutput<String>(output->_value.get());
      VectorOutputWrapper *wrapper = [[VectorOutputWrapper alloc] initWithAlgorithm:*algorithm
                                                                    assumeOwnership:YES];
      wrapper->_output = output;
      wrapper->_type = type;
      return wrapper;
    }

    case IODataTypeStereoSampleVec: {
      StereoSampleVecBridgedValue *output = [StereoSampleVecBridgedValue new];
      VectorOutput<StereoSample> *algorithm = new VectorOutput<StereoSample>(output->_value.get());
      VectorOutputWrapper *wrapper = [[VectorOutputWrapper alloc] initWithAlgorithm:*algorithm
                                                                    assumeOwnership:YES];
      wrapper->_output = output;
      wrapper->_type = type;
      return wrapper;
    }

    case IODataTypeRealVecVec: {
      RealVecVecBridgedValue *output = [RealVecVecBridgedValue new];
      VectorOutput<RealVec> *algorithm = new VectorOutput<RealVec>(output->_value.get());
      VectorOutputWrapper *wrapper = [[VectorOutputWrapper alloc] initWithAlgorithm:*algorithm
                                                                    assumeOwnership:YES];
      wrapper->_output = output;
      wrapper->_type = type;
      return wrapper;
    }

    case IODataTypeComplexRealVecVec: {
      ComplexRealVecVecBridgedValue *output = [ComplexRealVecVecBridgedValue new];
      VectorOutput<ComplexRealVec>
        *algorithm = new VectorOutput<ComplexRealVec>(output->_value.get());
      VectorOutputWrapper *wrapper = [[VectorOutputWrapper alloc] initWithAlgorithm:*algorithm
                                                                    assumeOwnership:YES];
      wrapper->_output = output;
      wrapper->_type = type;
      return wrapper;
    }

    case IODataTypeReal:
    case IODataTypeString:
    case IODataTypeInt:
    case IODataTypePool:
    case IODataTypeRealMatrix:
    case IODataTypeComplexReal:
    case IODataTypeStereoSample:
      @throw invalidArgumentException(@"The data type must be one of the vector types.");

  }

}

/**
 The data received over the algorithm's input.
 */
- (NSArray *)vector { return (NSArray *)_output.objcValue; }

/**
 The type of data stored by the algorithm.
 */
- (IODataType)type { return _type; }

@end

