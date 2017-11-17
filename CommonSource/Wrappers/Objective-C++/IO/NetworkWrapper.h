//
//  NetworkWrapper.h
//  Essentia
//
//  Created by Jason Cardwell on 10/23/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
#import <Foundation/Foundation.h>

@class StreamingAlgorithmWrapper;

NS_ASSUME_NONNULL_BEGIN

/**
 A wrapper for a C++ `NetworkNode`.
 */
@interface NetworkNodeWrapper: NSObject

/**
 An array of wrappers for the child nodes.
 */
@property (nonnull, nonatomic, readwrite) NSArray<NetworkNodeWrapper *> *children;

/**
 A wrapper for the algorithm with which the node is associated.
 */
@property (nonnull, nonatomic, readonly) StreamingAlgorithmWrapper *algorithm;

@end

/**
 A wrapper for the C++ `Network`.
 */
@interface NetworkWrapper : NSObject

/**
 Initializing the network wrapper with a root algorithm wrapper.

 @param generator The algorithm to serve as the root of the network.
 @return The newly intialized network wrapper.
 */
- (nonnull instancetype)initWithGenerator:(nonnull StreamingAlgorithmWrapper *)generator;

/**
 Builds an execution Network using the given Algorithm. This will only work if the given algorithm
 is a generator, ie: it has no input ports.

 @param generator The root generator node to which all the network is connected.
 @return A wrapper for a newly created network with root `generator`.
 */
+ (instancetype)networkWrapperWithGenerator:(StreamingAlgorithmWrapper *)generator;

/**
 Executes all the algorithms in the network until all the tokens given by the source generator are
 processed by all the algorithms. Internally it just calls runPrepare and then runStep repeatedly.
 */
- (void)run;

/**
 Does the preparation needed to process the tokens of the network.
 */
- (void)runPrepare;

/**
 Processes all tokens generated with one call of `process` on the generator.

 @return `NO` if there are no more tokens to process and `YES` otherwise.
 */
- (BOOL)runStep;

/**
 Rebuilds the visible and execution network.
 */
- (void)update;

/**
 Invokes `reset` for each algorithm contained in the network.
 */
- (void)reset;

/**
 Clear the network to an empty state (ie: no algorithms contained in it). Deletes previous
 algorithms if the network had ownership of them.
 */
- (void)clear;

/**
 Queries the network for an algorithm with the specified name. An exception is thrown if the
 network does not contain an algorithm with the specified name.

 @param name The name of the algorithm to find.
 @return A proxy for the algorithm matching `name`.
 */
- (StreamingAlgorithmWrapper *)findAlgorithmWithName:(NSString *)name;

/**
 Return a list of algorithms which have been topologically sorted.
 */
@property (nonatomic, readonly) NSArray<StreamingAlgorithmWrapper *> *linearExecutionOrder;

/**
 The wrapped network node at the root of the visible algorithm network.
 */
@property (nullable, nonatomic, readonly) NetworkNodeWrapper *visibleNetworkRoot;

@end

NS_ASSUME_NONNULL_END
