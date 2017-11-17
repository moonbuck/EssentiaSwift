//
//  NSString+BridgingExtensions.mm
//  Essentia
//
//  Created by Jason Cardwell on 10/17/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
#import "NSString+BridgingExtensions.hpp"

@implementation NSString (BridgingExtensions)

+ (nonnull instancetype)stringWithCPPString:(std::string)string {
  return [NSString stringWithUTF8String:string.c_str()];
}

- (std::string)cppString { return std::string(self.UTF8String); }

@end
