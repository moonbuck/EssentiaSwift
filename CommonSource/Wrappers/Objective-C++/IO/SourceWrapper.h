//
//  SourceWrapper.h
//  Essentia
//
//  Created by Jason Cardwell on 10/11/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "WrappedTypes.h"
#import "IODataType.h"

NS_ASSUME_NONNULL_BEGIN

@class SinkWrapper;

/**
 Base for wrapping C++ `SourceBase` and its subclasses.
 */
@interface SourceWrapper: NSObject

/**
 The full name of the source.
 */
@property (nonnull, nonatomic, readonly) NSString *fullName;

/**
 The name of the wrapped source.
 */
@property (nonnull, nonatomic, readwrite) NSString *name;

/**
 The data held by the source wrapper.
 */
@property (nonatomic, readonly) id data;

/**
 The type of data associated with the wrapped source.
 */
@property (nonatomic, readonly) IODataType dataType;

/**
 Connects the source to the specified sink.

 @param sinkWrapper The wrapper for the sink to which the source will be connected.
 */
- (void)connectToSinkWrapper:(SinkWrapper *)sinkWrapper;

/**
 Connects the source to the specified pool.

 @param poolWrapper The wrapper for the pool to which the source will be connected.
 @param descriptorName The descriptor under which the source did will be store in `poolWrapper`.
 @param setSingle Boolean value indicating whether the single pool should be used.
 */
- (void)connectToPoolWrapper:(PoolWrapper *)poolWrapper
             usingDescriptor:(NSString *)descriptorName
                   setSingle:(BOOL)setSingle;

/**
 Disconnects the source from the specified sink.

 @param sinkWrapper The wrapper for the sink from which the source will be disconnected.
 */
- (void)disconnectFromSinkWrapper:(SinkWrapper *)sinkWrapper;

/**
 Disconnects the source from the specified pool.

 @param poolWrapper The wrapper for the pool from which the source will be disconnected.
 @param descriptorName The descriptor name to disconnect.
 */
- (void)disconnectFromPoolWrapper:(PoolWrapper *)poolWrapper
                   descriptorName:(NSString *)descriptorName;

/**
 Connects the source to the 'null' sink so that any output is simple ignored.
 */
- (void)capConnection;

/**
 Disconnects the source from the 'null' sink.
 */
- (void)uncapConnection;

/**
 Connects the wrappers vector storage as the sink to which the source flows.
 */
- (void)connectInternalStorage;

@end

NS_ASSUME_NONNULL_END
