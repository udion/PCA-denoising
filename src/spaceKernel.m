function [Ks] = spaceKernel(sig, w)
%SPACEKERNEL Summary of this function goes here
%   Detailed explanation goes here
    [X,Y] = meshgrid(-w:w, -w:w);
    Ks = exp(-(X.^2+Y.^2)/(2*sig^2));
    Ks = Ks/sum(Ks(:));
end

