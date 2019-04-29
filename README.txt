Daniel Zuerbig
ECE413 Music and Engineering HW 5 - Compression

The hw5.m file runs, and calls both the analyze and synthesize functions on the sound file in question. Then the audio is played back to show that the process is 100% lossless. The quant.m file shows a script testing the basic functionality of adding the psychoacoustic model by taking a fft of the 512 sample bins surrounding each 12 sample set of 32 subbands. If I finished this model, I would copy the code into the quantize function. The quantize file includes creating a 3rd order Butterworth high pass filter, just to remove the DC componants of the audio signal. The signal post filtered is not used at all, except to go through a fft and thus informing the psychoacoustic modeling.
