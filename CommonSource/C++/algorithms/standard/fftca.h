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

#ifndef ESSENTIA_FFTCA_H
#define ESSENTIA_FFTCA_H

#include "algorithm.h"
#include "threading.h"
#include <complex>
#include <Accelerate/Accelerate.h>

namespace essentia {
    namespace standard {

        class FFTCA : public Algorithm {

        protected:
            Input<std::vector<std::complex<Real> > > _signal;
            Output<std::vector<std::complex<Real> > > _fft;

        public:
            FFTCA() {
                declareInput(_signal, "frame", "the input audio frame (complex)");
                declareOutput(_fft, "fft", "the FFT of the input frame");

                accelBuffer.realp = NULL;
                accelBuffer.imagp = NULL;
                fftSetup = NULL;
            }

            ~FFTCA();

            void declareParameters() {
                declareParameter("size", "the expected size of the input frame. This is purely optional and only targeted at optimizing the creation time of the FFT object", "[1,inf)", 1024);
            }

            void compute();
            void configure();

            static const char* name;
            static const char* category;
            static const char* description;

        protected:
            friend class IFFTCA;
            static ForcedMutex globalFFTCAMutex;

            FFTSetup fftSetup;

            int logSize;
            int _fftPlanSize;
            DSPSplitComplex accelBuffer;

            void createFFTObject(int size);
        };

    } // namespace standard
} // namespace essentia

#include "streamingalgorithmwrapper.h"

namespace essentia {
    namespace streaming {

        class FFTCA : public StreamingAlgorithmWrapper {

        protected:
            Sink<std::vector<std::complex<Real> > > _signal;
            Source<std::vector<std::complex<Real> > > _fft;

        public:
            FFTCA() {
                declareAlgorithm("FFTC");
                declareInput(_signal, TOKEN, "frame");
                declareOutput(_fft, TOKEN, "fft");
            }
        };

    } // namespace streaming
} // namespace essentia

#endif // ESSENTIA_FFTW_H
