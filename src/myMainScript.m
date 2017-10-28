%% PCA based Denoising
% This is to demo PCA based denoising using weiner filter
% It describes 2 techniques, the first one is not so very good, as it takes
% the average over all the possible patches the second variation however
% takes avarage over a subset of 'similar' patches.

tic;
%% Loading Image
I1 = imread('../data/barbara256.png');
I2 = imread('../data/barbara256-part.png');
sigma = 20;
I1_ = gaussianCorrupt(I1, 0, sigma);
I2_ = gaussianCorrupt(I2, 0, sigma);

%% Reconstruction from corrupt Image, technique 1
% As can be seen from the result, this technique causses a lot of blurring
% like effect, this happens because, when calculating the estimate for the
% true eigen coefficient of the patches of denoised image, it takes the
% average over all possible patches for every patch.
rec1 = myPCADenoising1(I1_, 7, 7, sigma);
diff1 = (double(I1)-rec1).^2;
% The error RSMD error of reconstructed image is
RSMD1 = sqrt(sum(diff1(:)));

figure;
colormap('gray');
subplot(1,3,1), imshow(I1,[]), title('orignal');
subplot(1,3,2), imshow(I1_,[]), title('corrupt');
subplot(1,3,3), imshow(rec1, []), title('denoised');
savefig('../images/PCAdenoise1');
pause(0.5);

%% Reconstruction from corrupt Image, technique 2
% This technique, takes above mentioned average only over certain 'similar'
% patches and hence is expected to perform better than the previous one 
rec2 = myPCADenoising2(I1_, 31, 31, 7, 7, 200, sigma);
diff2 = (double(I1)-rec2).^2;
% The error RSMD error of reconstructed image is
RSMD2 = sqrt(sum(diff2(:)));

figure;
colormap('gray');
subplot(1,3,1), imshow(I1,[]), title('orignal');
subplot(1,3,2), imshow(I1_,[]), title('corrupt');
subplot(1,3,3), imshow(rec2, []), title('denoised');
savefig('../images/PCAdenoise2');
pause(0.5);

%% Results with Bilateral Filtering
% This method denoises the above corrupted image using the bilateral
% filtering, note that the performance here does depend upon the tuning of
% the 2 parameters corresponding to the sigma of space kernel and that of
% intensity kernel and hence is very subjective.
s1 = 10;
s2 = 24;
[rec3, Ks] = myBilateralFiltering(I1_,s1,s2,floor(3*s1));

diff3 = (double(I1)-rec3).^2;
% The error RSMD error of reconstructed image is
RSMD3 = sqrt(sum(diff3(:)));

figure;
colormap('gray');
subplot(1,3,1), imshow(I1,[]), title('orignal');
subplot(1,3,2), imshow(I1_,[]), title('corrupt');
subplot(1,3,3), imshow(rec3, []), title('denoised');
savefig('../images/BLdenoise3');
pause(0.5);

%% RSMD, good enough?
% As can be seen in the above results, Even though the ouput of technique 2
% is visually more appealing than the output of Bilateral filtering, RSMD
% of bilateral filtered image is the least, hence if one can not blindly
% believs in RSMD, and it's not a good enough measure.

toc;