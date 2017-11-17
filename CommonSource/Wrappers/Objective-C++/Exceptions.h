//
//  Exceptions.h
//  Essentia
//
//  Created by Jason Cardwell on 10/21/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
#import <Foundation/Foundation.h>


#define inconsistencyException(REASON)                             \
  [NSException exceptionWithName: NSInternalInconsistencyException \
                          reason: (REASON)                         \
                        userInfo: nil]
#define invalidArgumentException(REASON)                     \
  [NSException exceptionWithName: NSInvalidArgumentException \
                          reason: (REASON)                   \
                        userInfo: nil]
