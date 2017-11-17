//
//  AlgorithmWrapper.h
//  Essentia
//
//  Created by Jason Cardwell on 10/27/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ParameterWrapper;

NS_ASSUME_NONNULL_BEGIN

@interface AlgorithmWrapper : NSObject

/**
 Whether the wrapper owns its algorithm. When `YES`, the wrapper will delete the algorithm upon being deallocated.
 */
@property (nonatomic, readonly) BOOL ownsAlgorithm;

/**
 The name of the wrapped configurable.
 */
@property (nonatomic, readwrite) NSString *name;

/**
 The list of names for the algorithm's parameters.
 */
@property (nonatomic, readonly) NSArray<NSString *> *parameterNames;

/**
 An index of parameter descriptions keyed by parameter name.
 */
@property (nonatomic, readonly) NSDictionary<NSString *, NSString*> *parameterDescription;

/**
 An index of the configurable's default parameters with optional default values.
 */
@property (nonatomic, readonly) NSDictionary<NSString *, ParameterWrapper *> *defaultParameters;

/**
 Sets the specified parameter values as the current ones. Parameters not redefined will
 keep their current values.

 @param parameters The new parameter values.
 */
- (void)setParameters:(NSDictionary<NSString *, ParameterWrapper *> *)parameters NS_SWIFT_NAME(set(parameters:));

/**
 Uses the specified parameter values to reconfigure the wrapped algorithm.

 @param parameters The new parameter values.
 */
- (void)configureWithParameters:(NSDictionary<NSString *, ParameterWrapper *> *)parameters NS_SWIFT_NAME(configure(parameters:));

/**
 Accessor for retrieiving parameters by name.

 @param name The name of the desired parameter.
 @return The wrapped parameter value or `nil`.
 */
- (nullable ParameterWrapper *)parameterWithName:(NSString *)name NS_SWIFT_NAME(parameter(name:));

/**
 The list of names for the algorithm's input parameters.
 */
@property (nonnull, nonatomic, readonly) NSArray<NSString *> *inputNames;

/**
 The list of names for the algorithm's output parameters.
 */
@property (nonnull, nonatomic, readonly) NSArray<NSString *> *outputNames;

@end

@class InputWrapper, OutputWrapper;

/**
 A wrapper for `Algorithm` that serves as a bridge bewteen C++ and swift.
 */
@interface StandardAlgorithmWrapper: AlgorithmWrapper

/**
 The collection of wrappers for the algorithm's named inputs.
 */
@property (nonnull, nonatomic, readonly) NSDictionary<NSString *, InputWrapper *> * inputs;

/**
 The collection of wrappers for the algorithm's named outputs.
 */
@property (nonnull, nonatomic, readonly) NSDictionary<NSString *, OutputWrapper *> * outputs;

/**
 Resets the state of the wrapped algorithm.
 */
- (void)reset;

/**
 Computes the wrapped algorithm with it's current parameter values.
 */
- (void)compute;

@end

typedef NS_ENUM(NSUInteger, StreamingAlgorithmStatus) {
  StreamingAlgorithmStatusOK = 0,
  StreamingAlgorithmStatusContinue = 0,
  StreamingAlgorithmStatusPass,
  StreamingAlgorithmStatusFinished,
  StreamingAlgorithmStatusNoInput,
  StreamingAlgorithmStatusNoOutput
};

@class SinkWrapper, SourceWrapper;

/**
 A wrapper for `Algorithm` that serves as a bridge bewteen C++ and swift.
 */
@interface StreamingAlgorithmWrapper: AlgorithmWrapper

/**
 The collection of wrappers for the algorithm's named inputs.
 */
@property (nonnull, nonatomic, readonly) NSDictionary<NSString *, SinkWrapper *> * inputs;

/**
 The collection of wrappers for the algorithm's named outputs.
 */
@property (nonnull, nonatomic, readonly) NSDictionary<NSString *, SourceWrapper *> * outputs;

/**
 Resets the state of the wrapped algorithm.
 */
- (void)reset;

/**
 Processes the wrapped algorithm with it's current parameter values.
 */
- (void)process;

/**
 Whether the algorithm should stop as soon as it has finished processing all of its inputs.
 */
@property (nonatomic, readwrite) BOOL shouldStop;

/**
 Disconnect all sources and sinks of this algorithm from anything they would be connected to.
 */
- (void)disconnectAll;

- (StreamingAlgorithmStatus)aquireData;

- (void)releaseData;

@end

NS_ASSUME_NONNULL_END
