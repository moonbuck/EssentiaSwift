//
//  SourceWrapper+BridgingExtensions.hpp
//  Essentia
//
//  Created by Jason Cardwell on 10/11/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
#import "SourceWrapper.h"
#import "sourcebase.h"
#import "BridgedValue.hpp"

@interface SourceWrapper() {
  @package
  essentia::streaming::SourceBase *_sourceBase;
  IODataType _dataType;
  BridgedValue *_data;
}

/**
 Initializing with a specified source.

 @param sourceBase The C++ source to wrap.
 @param dataType The data type used by `sourceBase`.
 @return The new source wrapper with `sourceBase`.
 */
- (nonnull instancetype)initWrapping:(essentia::streaming::SourceBase&)sourceBase
                            dataType: (IODataType)dataType;

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
