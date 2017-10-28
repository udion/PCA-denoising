function [oImg,A] = myPCADenoising2(iImg, sr, sc, r, c, K, sigma)
%MYPCADENOISING2 Summary of this function goes here
%   Detailed explanation goes here
    sz = size(iImg);
    %display(sz);
    A = zeros(sz(1), sz(2), 2);
    sigma2 = sigma^2;
    P = splicerVectoriser(iImg, r, c);
    for i=1:sz(1)-r+1
        %display(sz(2))
        for j=1:sz(2)-c+1
            %display(j)
            %P_i = similarPatchSpace(iImg, sr, sc, r, c, K, i, j);
            P_i = test(P, sr, sc, sz(1), sz(2), r, c, K, i, j);
            [V, ~] = eig(P_i*P_i');
            V = normc(V);
            Coeff = P_i'*V;
            
            Coeff_2 = Coeff.*2;
            Coeff_2 = mean(Coeff_2,1);
            a = Coeff_2 - sigma2;
            alphabar2 = max(0, a);
            %display(size(alphabar2),'alphar2');
            %display(size(Coeff_2),'Coeff_2');
            
            newCoeff = zeros(size(Coeff));
            %display(size(newCoeff),'newCoeff');
            sz_ = size(Coeff);
            %display(sz_)
            for k=1:sz_(2)
                newCoeff(:,k) = Coeff(:,k)/(1+sigma2/alphabar2(k));
            end
            newP = V*newCoeff';
            new_thisPatch = reshape(newP(:,1), r,c);
            A(i:i+r-1, j:j+c-1, 1) = A(i:i+r-1, j:j+c-1, 1) + new_thisPatch;
            A(i:i+r-1, j:j+c-1, 2) = A(i:i+r-1, j:j+c-1, 2) + 1;
        end
    end
    oImg = A(:,:,1)./A(:,:,2);
end