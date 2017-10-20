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


%% Reconstruction from corrupt Image, technique 2
% This technique, takes above mentioned average only over certain 'similar'
% patches and hence is expected to perform better than the previous one 
rec2 = myPCADenoising2(I2_, 31, 31, 7, 7, 200, sigma);
diff2 = (double(I2)-rec2).^2;
% The error RSMD error of reconstructed image is
RSMD2 = sqrt(sum(diff2(:)));

figure;
colormap('gray');
subplot(1,3,1), imshow(I2,[]), title('orignal');
subplot(1,3,2), imshow(I2_,[]), title('corrupt');
subplot(1,3,3), imshow(rec2, []), title('denoised');
savefig('../images/PCAdenoise2');

toc;
