/*
 * Copyright (C) 2006-2016  Music Technology Group - Universitat Pompeu Fabra
 *
 * This file is part of Essentia
 *
 * Essentia is free software: you can redistribute it and/or modify it under
 * the terms of the GNU Affero General Public License as published by the Free
 * Software Foundation (FSF), either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
 * details.
 *
 * You should have received a copy of the Affero GNU General Public License
 * version 3 along with this program.  If not, see http://www.gnu.org/licenses/
 */

#include "fftca.h"
#include "essentia.h"

using namespace std;
using namespace essentia;
using namespace standard;

const char* FFTCA::name = "FFTC";
const char* FFTCA::category = "Standard";
const char* FFTCA::description = DOC("This algorithm computes the positive complex short-term Fourier transform (STFT) of an array using the FFT algorithm. The resulting fft has a size of (s/2)+1, where s is the size of the input frame.\n"
"At the moment FFT can only be computed on frames which size is even and non zero, otherwise an exception is thrown.\n"
"\n"
"FFT computation will be carried out using the Accelerate Framework [3]"
"\n"
"References:\n"
"  [1] Fast Fourier transform - Wikipedia, the free encyclopedia, http://en.wikipedia.org/wiki/Fft\n\n"
"  [2] Fast Fourier Transform -- from Wolfram MathWorld, http://mathworld.wolfram.com/FastFourierTransform.html\n"
"  [3] vDSP Programming Guide -- from Apple https://developer.apple.com/library/ios/documentation/Performance/Conceptual/vDSP_Programming_Guide/UsingFourierTransforms/UsingFourierTransforms.html"
                                    );

ForcedMutex FFTCA::globalFFTCAMutex;

FFTCA::~FFTCA() {
  ForcedMutexLocker lock(globalFFTCAMutex);

  // we might have called essentia::shutdown() before this algorithm goes out
  // of scope, so make sure we're not doing stupid things here
  // This will cause a memory leak then, but it is definitely a better choice
  // than a crash (right, right??? :-) )
  if (essentia::isInitialized()) {
      vDSP_DFT_DestroySetup(fftSetup);
      free(accelBuffer.realp);
      free(accelBuffer.imagp);
      free(outputBuffer.realp);
      free(outputBuffer.imagp);
  }
}

void FFTCA::compute() {
    
  const std::vector<std::complex<Real> >& signal = _signal.get();
  std::vector<std::complex<Real> >& fft = _fft.get();

  // check if input is OK
  int size = int(signal.size());
  if (size == 0) {
    throw EssentiaException("FFTC: Input size cannot be 0");
  }
 
  if ((fftSetup == 0) ||
      ((fftSetup != 0) && _fftPlanSize != size)) {
    createFFTObject(size);
  }

  for (int i = 0; i < size; i++) {
    accelBuffer.realp[i] = signal[i].real();
    accelBuffer.imagp[i] = signal[i].imag();
  }

  vDSP_DFT_Execute(fftSetup, accelBuffer.realp, accelBuffer.imagp, outputBuffer.realp, outputBuffer.imagp);

    fft.resize(size/2+1);
    
    //Prob a much better way of doing this but for now this works
    //Things to note: need to scale by /2.0f
    //In Accelerate fttOutput[0] contains the real for point 0 and point N/2+1

    //Construct first point
    fft[0] = std::complex<Real>(accelBuffer.realp[0]/2.0f, 0.0f);
    
    for(int i=0; i<(size/2 + 1); i++) {
        std::complex<Real> point(outputBuffer.realp[i], outputBuffer.imagp[i]);
        fft[i] = point;
    }
    
}

void FFTCA::configure() {
  createFFTObject(parameter("size").toInt());
}

void FFTCA::createFFTObject(int size) {
  ForcedMutexLocker lock(globalFFTCAMutex);

  // This is only needed because at the moment we return half of the spectrum,
  // which means that there are 2 different input signals that could yield the
  // same FFT...
  if (size % 2 == 1) {
    throw EssentiaException("FFTC: can only compute FFT of arrays which have an even size");
  }
    
    free(accelBuffer.realp);
    free(accelBuffer.imagp);
    free(outputBuffer.realp);
    free(outputBuffer.imagp);

    accelBuffer.realp         = (float *) malloc(sizeof(float) * size);
    accelBuffer.imagp         = (float *) malloc(sizeof(float) * size);
    outputBuffer.realp        = (float *) malloc(sizeof(float) * size);
    outputBuffer.imagp        = (float *) malloc(sizeof(float) * size);

    logSize = log2(size);
    
    //With vDSP you only need to create a new fft if you've increased the size
  if (fftSetup == nullptr) {
      fftSetup = vDSP_DFT_zop_CreateSetup(NULL, pow((float)2.0, (float)logSize), vDSP_DFT_FORWARD);
  } else if (size > _fftPlanSize) {
      vDSP_DFT_DestroySetup(fftSetup);
      fftSetup = vDSP_DFT_zop_CreateSetup(NULL, pow((float)2.0, (float)logSize), vDSP_DFT_FORWARD);
    }
    
    _fftPlanSize = size;
}
