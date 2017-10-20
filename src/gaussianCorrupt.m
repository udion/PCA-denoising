function [oImg] = gaussianCorrupt(iImg, m, std)
    oImg = (double(iImg) + randn(size(iImg))*std) + m;
end