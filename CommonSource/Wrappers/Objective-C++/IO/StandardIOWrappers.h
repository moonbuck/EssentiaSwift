//
//  StandardIOWrappers.h
//  Essentia
//
//  Created by Jason Cardwell on 10/11/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "WrappedTypes.h"
#import "IODataType.h"

NS_ASSUME_NONNULL_BEGIN

/**
 Base for wrapping C++ `InputBase` and its subclasses.
 */
@interface InputWrapper: NSObject

/**
 The full name of the input.
 */
@property (nonatomic, readonly) NSString *fullName;

/**
 The name of the wrapped input.
 */
@property (nonnull, nonatomic, readwrite) NSString *name;

/**
 The data held by the input wrapper.
 */
@property (nonatomic, readwrite) id data;

/**
 The type of data associated with the wrapped input.
 */
@property (nonatomic, readonly) IODataType dataType;

@end

/**
 Base for wrapping C++ `OutputBase` and its subclasses.
 */
@interface OutputWrapper: NSObject

/**
 The full name of the output.
 */
@property (nonnull, nonatomic, readonly) NSString *fullName;

/**
 The name of the wrapped output.
 */
@property (nonnull, nonatomic, readwrite) NSString *name;

/**
 The data held by the output wrapper.
 */
@property (nonatomic, readonly) id data;

/**
 The type of data associated with the wrapped output.
 */
@property (nonatomic, readonly) IODataType dataType;

/**
 Joins the output wrapper with the specified input wrapper so that the data for the input
 wrapper becomes the data from the output wrapper.

 @param inputWrapper The input wrapper to feed the output wrapper's data.
 */
- (void)connectToInputWrapper:(InputWrapper *)inputWrapper;

@end

NS_ASSUME_NONNULL_END
