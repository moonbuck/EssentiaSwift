//
//  IODataType.mm
//  Essentia
//
//  Created by Jason Cardwell on 10/23/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
#import "IODataType+BridgingExtensions.hpp"
#import <typeinfo>
#import "Exceptions.h"
#import "WrappedTypes.hpp"

/**
 Determines the corresponding `IODataType` for the specified C++ `type_info`.

 @param type The type to match with an `IODataType`.
 @return The corresponding `IODataType` for `type`.
 */
IODataType dataTypeForType(const std::type_info& type) {

  if (type == typeid(Real))                   { return IODataTypeReal;            }
  else if (type == typeid(String))            { return IODataTypeString;          }
  else if (type == typeid(Int))               { return IODataTypeInt;             }
  else if (type == typeid(ComplexReal))       { return IODataTypeComplexReal;     }
  else if (type == typeid(StereoSample))      { return IODataTypeStereoSample;    }
  else if (type == typeid(Pool))              { return IODataTypePool;            }
  else if (type == typeid(RealMatrix))        { return IODataTypeRealMatrix;      }
  else if (type == typeid(ComplexRealVec))    { return IODataTypeComplexRealVec;  }
  else if (type == typeid(RealVec))           { return IODataTypeRealVec;         }
  else if (type == typeid(StringVec))         { return IODataTypeStringVec;       }
  else if (type == typeid(StereoSampleVec))   { return IODataTypeStereoSampleVec; }
  else if (type == typeid(RealVecVec))        { return IODataTypeRealVecVec;      }
  else if (type == typeid(ComplexRealVecVec)) { return IODataTypeComplexRealVec;  }
  else {
    @throw invalidArgumentException(@"Unsupported type provided.");
  }

}
