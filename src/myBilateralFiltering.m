function [oImg, Ks] = myBilateralFiltering(iImg, sigSpace, sigIntensity, w)
%MYBILATERALFILTERING Summary of this function goes here
    %Detailed explanation goes here
    %To be practical,  w really depends on sigSpace as after 3sigspace,
    %gaussian will die off, but still for the generalisation purpose 
    %I have kept w.
    
    K_space = spaceKernel(sigSpace,w);
    Ks = K_space;
    [r,c] = size(iImg);
    oImg = zeros(r,c);
    for i=1:r
        iMin = max(i-w,1);
        iMax = min(i+w,r);
        temp = iImg(iMin:iMax,:);
        for j=1:c
            jMin = max(j-w,1);
            jMax = min(j+w,c);
            I = temp(:,jMin:jMax);
            K_intensity = exp(-((I-iImg(i,j)).^2)/(2*sigIntensity^2));
            K_bilatFil = K_intensity.*K_space((iMin:iMax)-i+w+1,(jMin:jMax)-j+w+1);
            oImg(i,j) = sum(I(:).*K_bilatFil(:))/sum(K_bilatFil(:));
        end
    end
end