//
//  NetworkWrapper+BridgingExtensions.hpp
//  Essentia
//
//  Created by Jason Cardwell on 10/23/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
#import "NetworkWrapper.h"
#import "network.h"
#import <memory>

@interface NetworkNodeWrapper() {
  std::unique_ptr<essentia::scheduler::NetworkNode> _node;
}

+ (nonnull instancetype)networkNodeWrapperWithNode:(const essentia::scheduler::NetworkNode&)node;

@end

@interface NetworkWrapper() {
  @package
  std::unique_ptr<essentia::scheduler::Network> _network;
  StreamingAlgorithmWrapper *_generator;
}

@end
