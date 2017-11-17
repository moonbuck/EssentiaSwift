//
//  StandardIOWrappers+BridgingExtensions.hpp
//  Essentia
//
//  Created by Jason Cardwell on 10/11/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
#import "StandardIOWrappers.h"
#import "iotypewrappers_impl.h"

@interface InputWrapper()

/**
 Initializing with a specified input.

 @param inputBase The C++ input to wrap.
 @return The new input wrapper with `inputBase`.
 */
- (nonnull instancetype)initWrapping:(essentia::standard::InputBase&)inputBase;

/**
 Creates a new input wrapper for the specified input.

 @param inputBase The C++ input to wrap.
 @return The new input wrapper with `inputBase`.
 */
+ (nonnull instancetype)inputWrapperWrapping:(essentia::standard::InputBase&)inputBase;

/**
 Property that recasts the inherited `typeProxy` property to the more specific `InputBase`.
 */
@property (nonnull, nonatomic, readonly) const essentia::standard::InputBase * input;


@end

@interface OutputWrapper()

/**
 Initializing with a specified output.

 @param outputBase The C++ output to wrap.
 @return The new output wrapper with `outputBase`.
 */
- (nonnull instancetype)initWrapping:(essentia::standard::OutputBase&)outputBase;

/**
 Creates a new output wrapper for the specified output.

 @param outputBase The C++ output to wrap.
 @return The new output wrapper with `outputBase`.
 */
+ (nonnull instancetype)outputWrapperWrapping:(essentia::standard::OutputBase&)outputBase;

/**
 Property that recasts the inherited `typeProxy` property to the more specific `OutputBase`.
 */
@property (nonnull, nonatomic, readonly) const essentia::standard::OutputBase * output;

@end
