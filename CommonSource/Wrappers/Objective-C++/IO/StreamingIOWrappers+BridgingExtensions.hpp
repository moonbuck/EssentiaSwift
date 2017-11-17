//
//  StreamingIOWrappers+BridgingExtensions.hpp
//  Essentia
//
//  Created by Jason Cardwell on 10/11/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
#import "StreamingIOWrappers.h"
#import "sinkbase.h"
#import "sink.h"
#import "sinkproxy.h"
#import "sourcebase.h"
#import "source.h"
#import "sourceproxy.h"

@interface SinkWrapper()

/**
 Initializing with a specified sink.

 @param sinkBase The C++ sink to wrap.
 @return The new sink wrapper with `sinkBase`.
 */
- (nonnull instancetype)initWrapping:(essentia::streaming::SinkBase&)sinkBase;

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

@interface SourceWrapper()

/**
 Initializing with a specified source.

 @param sourceBase The C++ source to wrap.
 @return The new source wrapper with `sourceBase`.
 */
- (nonnull instancetype)initWrapping:(essentia::streaming::SourceBase&)sourceBase;

/**
 Creates a new source wrapper for the specified source.

 @param sourceBase The C++ source to wrap.
 @return The new source wrapper with `sourceBase`.
 */
+ (nonnull instancetype)sourceWrapperWrapping:(essentia::streaming::SourceBase&)sourceBase;

/**
 Property that recasts the inherited `typeProxy` property to the more specific `SourceBase`.
 */
@property (nonnull, nonatomic, readonly) const essentia::streaming::SourceBase * source;

@end
