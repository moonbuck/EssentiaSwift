//
//  WrappedTypes.hpp
//  Essentia
//
//  Created by Jason Cardwell on 10/11/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
#import <string>
#import <vector>
#import <complex>
#import <typeinfo>
#import "tnt_array2d.h"
#import "pool.h"
#import "WrappedTypes.h"
#import "Exceptions.h"

typedef essentia::Real Real;
typedef std::string String;
typedef int Int;
typedef essentia::StereoSample StereoSample;
typedef TNT::Array2D<essentia::Real> RealMatrix;
typedef std::complex<essentia::Real> ComplexReal;
typedef essentia::Pool Pool;

typedef std::vector<std::string> StringVec;
typedef std::vector<essentia::Real> RealVec;
typedef std::vector<bool> BoolVec;
typedef std::vector<int> IntVec;
typedef std::vector<essentia::StereoSample> StereoSampleVec;
typedef std::vector<TNT::Array2D<essentia::Real>> RealMatrixVec;
typedef std::vector<std::complex<essentia::Real>> ComplexRealVec;
typedef std::vector<essentia::AudioSample> AudioSampleVec;

typedef std::vector<std::vector<essentia::Real>> RealVecVec;
typedef std::vector<std::vector<std::complex<essentia::Real>>> ComplexRealVecVec;
typedef std::vector<std::vector<std::string>> StringVecVec;
typedef std::vector<std::vector<essentia::StereoSample>> StereoSampleVecVec;

typedef std::map<std::string, std::vector<essentia::Real>> RealVecMap;
typedef std::map<std::string, essentia::Real> RealMap;
typedef std::map<std::string, std::string> StringMap;
typedef std::map<std::string, std::vector<int>> IntVecMap;
typedef std::map<std::string, std::vector<std::string>> StringVecMap;
typedef std::map<std::string, std::vector<TNT::Array2D<essentia::Real>>> RealMatrixVecMap;
typedef std::map<std::string, std::vector<essentia::StereoSample>> StereoSampleVecMap;

typedef std::map<std::string, std::vector<std::vector<essentia::Real>>> RealVecVecMap;
typedef std::map<std::string, std::vector<std::vector<std::string>>> StringVecVecMap;

