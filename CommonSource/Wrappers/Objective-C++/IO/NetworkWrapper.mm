//
//  NetworkWrapper.mm
//  Essentia
//
//  Created by Jason Cardwell on 10/23/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
#import "NetworkWrapper+BridgingExtensions.hpp"
#import "AlgorithmWrapper+BridgingExtensions.hpp"
#import "NSString+BridgingExtensions.hpp"
#import <memory>

using namespace essentia;
using namespace essentia::scheduler;
using namespace std;

@implementation NetworkNodeWrapper

+ (instancetype)networkNodeWrapperWithNode:(const essentia::scheduler::NetworkNode &)node {
  NetworkNodeWrapper *wrapper = [NetworkNodeWrapper new];
  wrapper->_node = make_unique<NetworkNode>(node);
  return wrapper;
}

- (StreamingAlgorithmWrapper *)algorithm {
  streaming::Algorithm *algorithm = _node->algorithm();
  StreamingAlgorithmWrapper *wrapper = [[StreamingAlgorithmWrapper alloc] initWithAlgorithm:*algorithm
                                                                            assumeOwnership:NO];
  return wrapper;
}

- (NSArray<NetworkNodeWrapper *> *)children {

  NSMutableArray *result = [NSMutableArray new];

  auto children = _node->children();

  for (auto child : children) {
    [result addObject:[NetworkNodeWrapper networkNodeWrapperWithNode:*child]];
  }

  return [NSArray arrayWithArray:result];

}

- (void)setChildren:(NSArray<NetworkNodeWrapper *> *)children {

  vector<NetworkNode*> nodes;

  for (NetworkNodeWrapper *wrapper in children) {
    nodes.push_back(wrapper->_node.get());
  }

  _node->setChildren(nodes);

}

@end

@implementation NetworkWrapper

/**
 Initializing the network wrapper with a root algorithm wrapper.

 @param generator The algorithm to serve as the root of the network.
 @return The newly intialized network wrapper.
 */
- (instancetype)initWithGenerator:(StreamingAlgorithmWrapper *)generator {
  self = [super init];
  if (self) {
    _network = make_unique<Network>(generator->_algorithm, false);
    _generator = generator;
  }
  return self;
}

/**
 Builds an execution Network using the given Algorithm. This will only work if the given algorithm
 is a generator, ie: it has no input ports.

 @param generator The root generator node to which all the network is connected.
 @return A wrapper for a newly created network with root `generator`.
 */
+ (instancetype)networkWrapperWithGenerator:(StreamingAlgorithmWrapper *)generator {
  return [[NetworkWrapper alloc] initWithGenerator:generator];
}

/**
 Executes all the algorithms in the network until all the tokens given by the source generator are
 processed by all the algorithms. Internally it just calls runPrepare and then runStep repeatedly.
 */
- (void)run { _network->run(); }

/**
 Does the preparation needed to process the tokens of the network.
 */
- (void)runPrepare { _network->runPrepare(); }

/**
 Processes all tokens generated with one call of `process` on the generator.

 @return `NO` if there are no more tokens to process and `YES` otherwise.
 */
- (BOOL)runStep { return (BOOL)_network->runStep(); }

/**
 Rebuilds the visible and execution network.
 */
- (void)update { _network->update(); }

/**
 Invokes `reset` for each algorithm contained in the network.
 */
- (void)reset { _network->reset(); }

/**
 Clear the network to an empty state (ie: no algorithms contained in it). Deletes previous
 algorithms if the network had ownership of them.
 */
- (void)clear { _network->clear(); }

/**
 Queries the network for an algorithm with the specified name. An exception is thrown if the
 network does not contain an algorithm with the specified name.

 @param name The name of the algorithm to find.
 @return A proxy for the algorithm matching `name`.
 */
- (nonnull StreamingAlgorithmWrapper *)findAlgorithmWithName:(nonnull NSString *)name {
  auto result = _network->findAlgorithm(name.cppString);
  StreamingAlgorithmWrapper *proxy = [[StreamingAlgorithmWrapper alloc] initWithAlgorithm:*result assumeOwnership:NO];
  return proxy;
}

/**
 Accessor for the list of topologically sorted algorithms wrapped within proxies.

 @return The list of algorithm proxies.
 */
- (NSArray<StreamingAlgorithmWrapper *> *)linearExecutionOrder {
  auto algorithms = _network->linearExecutionOrder();
  NSMutableArray *result = [NSMutableArray new];
  for (auto algorithm : algorithms) {
    [result addObject:[[StreamingAlgorithmWrapper alloc] initWithAlgorithm:*algorithm assumeOwnership:NO]];
  }
  return [NSArray arrayWithArray:result];
}

- (NetworkNodeWrapper *)visibleNetworkRoot {

  NetworkNode *root = _network->visibleNetworkRoot();

  if (root == nullptr) { return nil; }
  else { return [NetworkNodeWrapper networkNodeWrapperWithNode:*root]; }

}

@end
