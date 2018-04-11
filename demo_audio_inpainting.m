

%% Initialisation

clear;
close all;

% Loading toolbox
init_unlocbox();
ltfatstart(); % start the ltfat toolbox

verbose = 1;    % verbosity level

% Load the signal
[sig_ori, fs] = gspi();
% soundsc(sig_ori, fs)

%% Problem 1: a lots of small holes

Mask1 = randn(length(sig_ori),1)>0;
sig_hole1 = sig_ori.*Mask1;
% soundsc(sig_hole1, fs)


% Design the Short Time Fourier Transform

% select a gabor frame for a real signal with a Gaussian window
a=64; % size of the shift in time
M=256;% number of frequencies
F=frametight(frame('dgtreal','gauss',a,M));
% % Get the framebounds
% GB = M/a;

% Define the Frame operators
Psi = @(x) frana(F,x);
Psit = @(x) frsyn(F,x);

% Solve the problem

% setting different parameters  for the simulation
param.verbose = verbose; % display parameter
param.maxit = 60; % maximum iteration
param.tol = 10e-5; % tolerance to stop iterating
param.gamma = 0.01;
sig_sol1 = audio_inpainting_l1(sig_hole1, Mask1, Psi, Psit, param);

fprintf('The SNR after inpainting is %2.2f\n',snr(sig_ori, sig_sol1))
fprintf('The original SNR is %2.2f\n',snr(sig_ori, sig_hole1))
% soundsc(sig_sol1, fs)


%%
figure(1)
sgram(sig_ori)
title('Original signal')

figure(2)
sgram(sig_hole1)
title('Signal with a hole')

figure(3)
sgram(sig_sol1)
title('Solution of the inpainting')



%% Problem 2: a single bigger hole

Mask2 = ones(length(sig_ori),1);
Mask2(10000:11024)=0;
sig_hole2 = sig_ori.*Mask2;
% soundsc(sig_hole2, fs)


% Design the Short Time Fourier Transform
% Fix Hann window
g = firwin('hann',1920*2);
g = g./norm(g)./2;
a=1024; % size of the shift in time
M=4*a;% number of frequencies
F=frametight(frame('dgtreal',g,a,M));

% Define the Frame operators
Psi = @(x) frana(F,x);
Psit = @(x) frsyn(F,x);

% Solve the problem

% setting different parameters  for the simulation
param.verbose = verbose; % display parameter
param.maxit = 60; % maximum iteration
param.tol = 10e-5; % tolerance to stop iterating
param.gamma = 0.01;
sig_sol2 = audio_inpainting_l1(sig_hole2, Mask2, Psi, Psit, param);

fprintf('The SNR after inpainting is %2.2f\n',snr(sig_ori, sig_sol2))
fprintf('The original SNR is %2.2f\n',snr(sig_ori, sig_hole2))
% soundsc(sig_sol2, fs)

%%
figure(4)
sgram(sig_ori)
title('Original signal')

figure(5)
sgram(sig_hole2)
title('Signal with a hole')

figure(6)
sgram(sig_sol2)
title('Solution of the inpainting')