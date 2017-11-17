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

#include "ifftca.h"
#include "fftca.h"

using namespace std;
using namespace essentia;
using namespace standard;

const char* IFFTCA::name = "IFFTC";
const char* IFFTCA::category = "Standard";
const char* IFFTCA::description = DOC("This algorithm calculates the inverse short-term Fourier transform (STFT) of an array of complex values using the FFT algorithm. The resulting frame has a size of (s-1)*2, where s is the size of the input fft frame. The inverse Fourier transform is not defined for frames which size is less than 2 samples. Otherwise an exception is thrown.\n"
"\n"
"An exception is thrown if the input's size is not larger than 1.\n"
"\n"
"FFT computation will be carried out using the Accelerate Framework [3]"
"\n"
"References:\n"
"  [1] Fast Fourier transform - Wikipedia, the free encyclopedia, http://en.wikipedia.org/wiki/Fft\n\n"
"  [2] Fast Fourier Transform -- from Wolfram MathWorld, http://mathworld.wolfram.com/FastFourierTransform.html\n"
"  [3] vDSP Programming Guide -- from Apple https://developer.apple.com/library/ios/documentation/Performance/Conceptual/vDSP_Programming_Guide/UsingFourierTransforms/UsingFourierTransforms.html"
);


IFFTCA::~IFFTCA() {
  ForcedMutexLocker lock(FFTCA::globalFFTCAMutex);

    vDSP_DFT_DestroySetup(fftSetup);
    free(accelBuffer.realp);
    free(accelBuffer.imagp);
    free(outputBuffer.realp);
    free(outputBuffer.imagp);
}

void IFFTCA::compute() {

  const std::vector<std::complex<Real> >& fft = _fft.get();
  std::vector<std::complex<Real> >& signal = _signal.get();

  // check if input is OK
  int size = ((int)fft.size()-1)*2;
  if (size <= 0) {
    throw EssentiaException("IFFTC: Input size cannot be 0 or 1");
  }
  if ((fftSetup == 0) ||
      ((fftSetup != 0) && _fftPlanSize != size)) {
    createFFTObject(size);
  }

    for(int i=0; i<fft.size(); i++) {
        accelBuffer.realp[i] = fft[i].real();
        accelBuffer.imagp[i] = fft[i].imag();
    }

    vDSP_DFT_Execute(fftSetup, accelBuffer.realp, accelBuffer.imagp, outputBuffer.realp, outputBuffer.imagp);

    // copy result from plan to output vector
    signal.resize(size);

  for(int i=0; i<fft.size(); i++) {
    signal[i].real(outputBuffer.realp[i]);
    signal[i].imag(outputBuffer.imagp[i]);
  }

}

void IFFTCA::configure() {
  createFFTObject(parameter("size").toInt());
}

void IFFTCA::createFFTObject(int size) {
  ForcedMutexLocker lock(FFTCA::globalFFTCAMutex);

    //Delete stuff before assigning
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
    if(size > _fftPlanSize) {
        vDSP_DFT_DestroySetup(fftSetup);

        fftSetup = vDSP_DFT_zop_CreateSetup(NULL, (vDSP_Length)size, vDSP_DFT_INVERSE);
    }

    _fftPlanSize = size;
}
