//
//  StreamingAlgorithmWrapper.mm
//  Essentia
//
//  Created by Jason Cardwell on 10/8/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "AlgorithmWrapper+BridgingExtensions.hpp"
#import "NSArray+BridgingExtensions.hpp"
#import "NSDictionary+BridgingExtensions.hpp"
#import "NSString+BridgingExtensions.hpp"
#import "ParameterWrapper+BridgingExtensions.hpp"
#import "StreamingIOWrappers+BridgingExtensions.hpp"
#import "Exceptions.h"

using namespace std;
using namespace essentia;
using namespace essentia::streaming;

@implementation StreamingAlgorithmWrapper

/**
 Initializing the wrapper with an algorithm instance.

 @param algorithm The algorithm to wrap.
 @param assumeOwnership Whether the wrapper should delete `algorithm` upon deallocation.
 @return A wrapper initialized with a `algorithm`.
 */
- (nonnull instancetype)initWithAlgorithm:(Algorithm&)algorithm
                          assumeOwnership:(BOOL)assumeOwnership
{

  // Invoke `super` initializer using the configurable `algorithm`.
  self = [super init];

  // Initialize properties.
  if (self) {

    _algorithm = &algorithm;
    self.ownsAlgorithm = assumeOwnership;

    // Build a dictionary of the wrapped inputs.
    NSMutableDictionary<NSString *, SinkWrapper *> *inputs = [NSMutableDictionary new];
    Algorithm::InputMap inputMap = algorithm.inputs();
    for (Algorithm::InputMap::const_iterator i = inputMap.begin(); i != inputMap.end(); ++i) {
      NSString *inputName = [NSString stringWithCPPString:i->first];
      SinkWrapper *sinkWrapper = [SinkWrapper sinkWrapperWrapping:*(i->second)];
      inputs[inputName] = sinkWrapper;
    }

    // Initialize the immutable property value from the mutable dictionary.
    _inputs = [NSDictionary dictionaryWithDictionary:inputs];

    // Build a dictionary of the wrapped outputs.
    NSMutableDictionary<NSString *, SourceWrapper *> *outputs = [NSMutableDictionary new];
    Algorithm::OutputMap outputMap = algorithm.outputs();
    for (Algorithm::OutputMap::const_iterator i = outputMap.begin(); i != outputMap.end(); ++i) {
      NSString *outputName = [NSString stringWithCPPString:i->first];
      SourceWrapper *sourceWrapper = [SourceWrapper sourceWrapperWrapping:*(i->second)];
      outputs[outputName] = sourceWrapper;
    }

    // Initialize the immutable property value from the mutable dictionary.
    _outputs = [NSDictionary dictionaryWithDictionary:outputs];

  }

  return self;

}

//- (void)dealloc { if (self.ownsAlgorithm && _algorithm != nullptr) delete _algorithm; }

/**
 Accessor for name of the wrapped algorithm.
 */
- (nonnull NSString *)name { return [NSString stringWithCPPString:_algorithm->name()]; }

/**
 Mutator for the name of the wrapped algorithm.
 */
- (void)setName:(NSString *)name { _algorithm->setName(name.cppString); }


/**
 The list of names for the algorithm's parameters.
 */
- (nonnull NSArray<NSString *> *)parameterNames {

  auto keys = _algorithm->defaultParameters().keys();

  NSMutableArray *names = [[NSMutableArray alloc] init];

  for (auto key : keys) {
    [names addObject:[NSString stringWithCPPString:key]];
  }

  return names;


}

/**
 Access for the index of the configurable's default parameters with optional default values.

 @return The index of wrapped default parameters keyed by parameter name.
 */
- (nonnull NSDictionary<NSString *, ParameterWrapper *> *)defaultParameters {

  ParameterMap defaults = _algorithm->defaultParameters();

  NSMutableDictionary *result = [NSMutableDictionary new];

  for (ParameterMap::const_iterator i = defaults.begin(); i != defaults.end(); ++i) {
    Parameter parameter = i->second;
    ParameterWrapper * wrapper = [ParameterWrapper parameterWrapperForParameter:parameter];
    result[[NSString stringWithCPPString:i->first]] = wrapper;
  }

  return [NSDictionary dictionaryWithDictionary:result];

}

/**
 Accessor for the index of parameter descriptions keyed by parameter name.

 @return The index of parameter descriptions.
 */
- (nonnull NSDictionary<NSString *, NSString *> *)parameterDescription {

  NSMutableDictionary * result = [NSMutableDictionary new];
  DescriptionMap descriptions = _algorithm->parameterDescription;
  for (DescriptionMap::const_iterator i = descriptions.begin(); i != descriptions.end(); ++i) {
    result[[NSString stringWithCPPString:i->first]] = [NSString stringWithCPPString:i->second];
  }

  return [NSDictionary dictionaryWithDictionary:result];

}


/**
 Accessor for retrieiving parameters by name.

 @param name The name of the desired parameter.
 @return The wrapped parameter value or `nil`.
 */
- (nullable ParameterWrapper *)parameterWithName:(NSString *)name {

  try {

    auto parameter = _algorithm->parameter(name.cppString);

    return [ParameterWrapper parameterWrapperForParameter:parameter];


  } catch (exception e) {

    return nil;

  }

}

/**
 Sets the specified parameter values as the current ones. Parameters not redefined will
 keep their current values.

 @param parameters The new parameter values.
 */
- (void)setParameters:(nonnull NSDictionary<NSString *, ParameterWrapper *> *)parameters {

  ParameterMap map;

  for (NSString *key in parameters.allKeys) {
    map.add(key.cppString, parameters[key].parameter);
  }

  _algorithm->setParameters(map);

}

/**
 Uses the specified parameter values to reconfigure the wrapped algorithm.

 @param parameters The new parameter values.
 */
- (void)configureWithParameters:(nonnull NSDictionary<NSString *, ParameterWrapper *> *)parameters {

  ParameterMap map;

  for (NSString *key in parameters.allKeys) {
    map.add(key.cppString, parameters[key].parameter);
  }

  _algorithm->configure(map);

}

/**
 The list of names for the algorithm's inputs.
 */
- (NSArray<NSString*>*)inputNames { return self.inputs.allKeys; }

/**
 The list of names for the algorithm's outputs.
 */
- (NSArray<NSString*>*)outputNames { return self.outputs.allKeys; }

/**
 Processes the wrapped algorithm with it's current parameter values.
 */
- (void)process { _algorithm->process(); }

/**
 Resets the state of the wrapped algorithm.
 */
- (void)reset { _algorithm->reset(); }

/**
 Accessor for the flag indicating whether the algorithm should stop as soon as it has finished
 processing all of its inputs.

 @return `YES` if the algorithm is flagged to stop and `NO` otherwise.
 */
- (BOOL)shouldStop { return (BOOL)_algorithm->shouldStop(); }

/**
 Mutator for the flag indicating whether the algorithm should stop as soon as it has finished
 processing all of its inputs.

 @param shouldStop `YES` if the algorithm should be flagged to stop and `NO` otherwise.
 */
- (void)setShouldStop:(BOOL)shouldStop { _algorithm->shouldStop((bool)shouldStop); }

/**
 Disconnect all sources and sinks of this algorithm from anything they would be connected to.
 */
- (void)disconnectAll { _algorithm->disconnectAll(); }

- (StreamingAlgorithmStatus)aquireData {

  switch (_algorithm->acquireData()) {
    case OK:        return StreamingAlgorithmStatusOK;
    case PASS:      return StreamingAlgorithmStatusPass;
    case FINISHED:  return StreamingAlgorithmStatusFinished;
    case NO_INPUT:  return StreamingAlgorithmStatusNoInput;
    case NO_OUTPUT: return StreamingAlgorithmStatusNoOutput;
  }

}

- (void)releaseData { _algorithm->releaseData(); }

@end
