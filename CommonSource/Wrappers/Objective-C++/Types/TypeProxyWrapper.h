//
//  TypeProxyWrapper.h
//  Essentia
//
//  Created by Jason Cardwell on 10/13/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface TypeProxyWrapper : NSObject

@property (nonnull, nonatomic, readwrite) NSString *name;

- (void)checkSameTypeAs:(nonnull TypeProxyWrapper *)typeProxyWrapper;
- (void)checkVectorSameTypeAs:(nonnull TypeProxyWrapper *)typeProxyWrapper;

@end
