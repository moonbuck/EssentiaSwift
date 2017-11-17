//
//  PoolWrapper+BridgingExtensions.hpp
//  Essentia
//
//  Created by Jason Cardwell on 10/11/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
#import "PoolWrapper.h"
#import "pool.h"
#import <memory>

@interface PoolWrapper () {
  @package
  std::shared_ptr<essentia::Pool> _pool;
}

/**
 Initializing with an existing C++ `Pool`.

 @param pool The C++ `Pool` to wrap.
 @return The newly initialized wrapper for `pool`.
 */
- (nonnull instancetype)initWithPool:(nonnull essentia::Pool *)pool;

/**
 Creates a new wrapper for an existing C++ `Pool`.

 @param pool The C++ `Pool` to wrap.
 @return The newly created wrapper for `pool`.
 */
+ (nonnull instancetype)poolWrapperWithPool:(nonnull essentia::Pool *)pool;

@end

