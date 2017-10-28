function [oImg] = corruptImage(iImg)
%CORROUPTIMAGE Summary of this function goes here
%   Detailed explanation goes here
    maxI = max(max(iImg));
    minI = min(min(iImg));
    range = maxI - minI;
    errdev = 0.05*range;
    
    [r,c] = size(iImg);
    noiseMat = errdev*randn(r,c);
    oImg = iImg + noiseMat;
end

