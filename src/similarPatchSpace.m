function [P] = similarPatchSpace(iImg, sr, sc, r, c, K, thisr, thisc)
%PATCHEIGENSPACE Summary of this function goes here
%   Detailed explanation goes here
    sz = size(iImg);
    sbImg = iImg(thisr:min(thisr+sr-1, sz(1)), thisc:min(thisc+sc-1, sz(2)));
    %size(sbImg)
    A = splicerVectoriser(sbImg, r, c);
    P = NNPatches(A, K);
end

