//
//  SinkWrapper.h
//  Essentia
//
//  Created by Jason Cardwell on 11/25/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "WrappedTypes.h"
#import "IODataType.h"

NS_ASSUME_NONNULL_BEGIN

/**
 Base for wrapping C++ `SinkBase` and its subclasses.
 */
@interface SinkWrapper: NSObject

/**
 The full name of the sink.
 */
@property (nonatomic, readonly) NSString *fullName;

/**
 The name of the wrapped sink.
 */
@property (nonnull, nonatomic, readwrite) NSString *name;

/**
 The data held by the sink wrapper.
 */
@property (nonatomic, readwrite) id data;

/**
 The type of data associated with the wrapped sink.
 */
@property (nonatomic, readonly) IODataType dataType;

@end

NS_ASSUME_NONNULL_END
