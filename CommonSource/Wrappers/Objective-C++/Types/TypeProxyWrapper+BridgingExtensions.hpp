//
//  TypeProxyWrapper+BridgingExtensions.hpp
//  Essentia
//
//  Created by Jason Cardwell on 10/13/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
#import "TypeProxyWrapper.h"
#import <typeinfo>
#import "types.h"

using namespace essentia;
using namespace std;

@interface TypeProxyWrapper() {
  @package
  TypeProxy * _typeProxy;
}

@property (nonnull, nonatomic, readonly) TypeProxy *typeProxy;

- (const type_info&) typeInfo;
- (const type_info&) vectorTypeInfo;

- (nonnull instancetype)initWithTypeProxy:(nonnull TypeProxy *)typeProxy;

@end
