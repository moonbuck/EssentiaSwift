//
//  SinkWrapper+BridgingExtensions.hpp
//  Essentia
//
//  Created by Jason Cardwell on 10/11/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
#import "SinkWrapper.h"
#import "sinkbase.h"
#import "BridgedValue.hpp"

@interface SinkWrapper() {
  @package
  essentia::streaming::SinkBase *_sinkBase;
  IODataType _dataType;
  BridgedValue *_data;
}

/**
 Initializing with a specified sink.

 @param sinkBase The C++ sink to wrap.
 @param dataType The data type used by `sinkBase`.
 @return The new sink wrapper with `sinkBase`.
 */
- (nonnull instancetype)initWrapping:(essentia::streaming::SinkBase&)sinkBase
                            dataType:(IODataType)dataType;

/**
 Creates a new sink wrapper for the specified sink.

 @param sinkBase The C++ sink to wrap.
 @return The new sink wrapper with `sinkBase`.
 */
+ (nonnull instancetype)sinkWrapperWrapping:(essentia::streaming::SinkBase&)sinkBase;

/**
 Property that recasts the inherited `typeProxy` property to the more specific `SinkBase`.
 */
@property (nonnull, nonatomic, readonly) const essentia::streaming::SinkBase * sink;


@end

