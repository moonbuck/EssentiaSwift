//
//  TypeProxyWrapper.mm
//  Essentia
//
//  Created by Jason Cardwell on 10/13/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
#import "TypeProxyWrapper.h"
#import "TypeProxyWrapper+BridgingExtensions.hpp"
#import "types.h"
#import "NSString+BridgingExtensions.hpp"

using namespace essentia;
using namespace std;

@implementation TypeProxyWrapper

- (nonnull instancetype)initWithTypeProxy:(TypeProxy *)typeProxy {
  self = [super init];
  if (self) {
    _typeProxy = typeProxy;
  }
  return self;
}

- (const type_info&)typeInfo { return _typeProxy->typeInfo(); }

- (const type_info&)vectorTypeInfo { return _typeProxy->vectorTypeInfo(); }

- (void)checkSameTypeAs:(TypeProxyWrapper *)typeProxyWrapper {

  _typeProxy->checkType(self.typeInfo, typeProxyWrapper.typeInfo);

}

- (void)checkVectorSameTypeAs:(TypeProxyWrapper *)typeProxyWrapper {

  _typeProxy->checkType(self.vectorTypeInfo, typeProxyWrapper.vectorTypeInfo);

}

- (nonnull NSString *)name {
  return [NSString stringWithCPPString:_typeProxy->name()];
}

- (void)setName:(nonnull NSString *)name { _typeProxy->setName(name.cppString); }

@end
