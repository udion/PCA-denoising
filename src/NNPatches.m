function [NNSpace] = NNPatches(similarPatches, K)
%NNPATCHES Summary of this function goes here
%   Detailed explanation goes here
    sz = size(similarPatches);
    thisPatchMat = repmat(similarPatches(:,1), 1,sz(2));
    
    diff = similarPatches - thisPatchMat;
    dist = sqrt(sum(diff.^2, 1));
    sort_dist = sort(dist);
    
    c = min(K, sz(2));
    NNSpace = zeros(sz(1), c);
    for j=1:c
        d = sort_dist(j);
        for k=1:sz(2)
            if norm(thisPatchMat(:,1)-similarPatches(:,k)) == d
                NNSpace(:,j) = similarPatches(:,k);
            end
        end
    end
end

