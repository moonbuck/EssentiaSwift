//
//  IODataType+BridgingExtensions.hpp
//  Essentia
//
//  Created by Jason Cardwell on 10/23/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
#import "IODataType.h"
#import <typeinfo>

IODataType dataTypeForType(const std::type_info& type);
