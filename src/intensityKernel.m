function [Ki] = intensityKernel(A,sigIntensity,w)
%INTENSITYKERNEL Summary of this function goes here
%   Detailed explanation goes here
    [r,c] = size(A); %r=c
    sigSpace = (r-1)/6; %make sure r is such that sigSpace is integer
    centralPixl = A(ceil(r/2),ceil(r/2));
    Ki_ = double(10^-100*ones(r));
    for i=-3*sigSpace:3*sigSpace
        for j=-3*sigSpace:3*sigSpace
            Ki_(1+3*sigSpace+i,1+3*sigSpace+j) = Ki_(1+3*sigSpace+i,1+3*sigSpace+j) + exp(-(A(1+3*sigSpace+i,1+3*sigSpace+j)-centralPixl)^2/2*sigIntensity^2);
            display(Ki_(1+3*sigSpace+i,1+3*sigSpace+j));
        end
    end
    Ki = Ki_/sum(Ki_(:));
end

