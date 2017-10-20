function [oImg] = myPCADenoising1(iImg, r, c, sigma)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    P = splicerVectoriser(iImg, r, c);
    [V,~] = eig(P*P');
    V = normc(V);
    Coeff = P'*V;
    sigma2 = sigma^2;
    
    Coeff_2 = Coeff.*2;
    Coeff_2 = mean(Coeff_2);
    A = Coeff_2 - sigma2;
    alphabar2 = max(0, A);

    newCoeff = zeros(size(Coeff));
    sz = size(Coeff);
    for j=1:sz(2)
        newCoeff(:,j) = Coeff(:,j)/(1+sigma2/alphabar2(j));
    end
    newP = V*newCoeff';
    sz = size(iImg);
    oImg = de_splicerVectoriser(newP, r, c, sz(1), sz(2));
end