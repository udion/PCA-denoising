%% MyMainScript
% This is to demo PCA based denoising

tic;
%% Loading Image
I = imread('../data/barbara256.png');
sigma = 20;
I_ = gaussianCorrupt(I, 0, sigma);

%% Reconstruction from corrupt Image, technique 1
rec1 = myPCADenoising1(I_, 7, 7, sigma);
toc;
