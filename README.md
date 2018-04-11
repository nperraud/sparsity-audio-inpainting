# sparsity-audio-inpainting

This code solves a sound inpainting problem, i.e. the recovery of missing audio content for a short period of time. 

It uses the assumption that the sound has a supposedly sparse time-frequency representation. The recovery problem is expressed as a convex optimization problem:
```
	x^* = argmin_x  || x ||_1     s. t.   M Gx = y
	sol = Gx,
```
where `x` is the time frequency representation of the solution, `M` a masking operator, `y` the known audio content and `G` the inverse Short Time Fourier Transform (iSTFT).

## Installation

1. Git clone this repository
```
	git clone https://github.com/nperraud/sparsity-audio-inpainting.git
```
2. Download the UNLocBoX
3. Download the LTFAT (the compiled library of the LTAT are important for efficiency)
4. Add the UNLocBoX to your path. In MATLAB, go to the root directory of the UNLocBoX and run
```
	init_unlocbox
```
5. Add the LTFAT to your path. In MATLAB, go to the root directory of the LTFAT and run
```
	ltfatstart
```
6. Run the demo. In MATLAB, go to the folder of this repository and run
```
	demo_audio_inpainting
```

## The result of the audio inpainting is bad?

* This code will not work if the missing content is too long.
* You may want to adapt the parameters of the Short Time Fourier Transform to your problem.

## The result of the audio inpainting is slow?

* They might be a solution for that too. Please raise an issue.


## Disclaimer

This code has not been tested extensively.
