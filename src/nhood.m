function [nhoodP] = nhood(P, sr, sc, rows, cols, r, c, i, j)
%NHOOD Summary of this function goes here
%   Detailed explanation goes here
    srhalf = floor(sr/2);
    schalf = floor(sc/2);
    rU = max(1,i-srhalf);
    rD = min(rows, i+srhalf);
    cL = max(1,j-schalf);
    cR = min(cols,j+schalf);
    
    sz_nr = min(rD, rows-r+1)-rU+1;
    sz_nc = min(cR, cols-c+1)-cL+1;
    
    [patch_len, ~] = size(P);
    nhoodP = double(zeros(patch_len, sz_nr*sz_nc));
  
    for y=rU:min(rD,rows-r+1)
        for x=cL:min(cR, cols-c+1)
            %[i,j, sz_nr*sz_nc y x (y-rU)*sz_nc+x-cL+1 (y-1)*(cols-c+1)+ mod(x,cols-c+2) size(zeros(patch_len, sz_nr*sz_nc))]
            %size(nhoodP(:, (y-rU)*sz_nc+x-cL+1))
            nhoodP(:, (y-rU)*sz_nc+x-cL+1) = P(:,(y-1)*(cols-c+1)+ mod(x,cols-c+2));
        end
    end
end

