//
//  NSString+BridgingExtensions.hpp
//  Essentia
//
//  Created by Jason Cardwell on 10/17/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <string>

@interface NSString (BridgingExtensions)

+ (nonnull instancetype)stringWithCPPString:(std::string)string;

@property (nonatomic, readonly) std::string cppString;

@end
