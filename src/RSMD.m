function [rsmdval] = RSMD(iImg1, iImg2)
%RSMD Summary of this function goes here
%   Detailed explanation goes here
    dim = size(iImg1);
    N = dim(1)*dim(2);
    I = iImg1-iImg2;
    I = I.^2;
    rsmdval = sqrt((1/N)*sum(I(:)));
end

