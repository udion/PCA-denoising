function [P_i] = test(P, sr, sc, rows, cols, r, c, K, i, j)
%TEST Summary of this function goes here
%   Detailed explanation goes here
    this_patch_neighbrhoood = nhood(P, sr, sc, rows, cols, r, c, i, j);
    [patch_len, num_patches] = size(this_patch_neighbrhoood);
    search_num_patches = min(num_patches, K);
    
    %[i, j, (i-1)*(cols-c+1)+mod(j,cols-c+2)]
    this_patch = P(:,(i-1)*(cols-c+1)+mod(j,cols-c+2));
    this_patch_mat = repmat(this_patch, [1, num_patches]);
    
    diff = (this_patch_neighbrhoood-this_patch_mat).^2;
    
    dist_mat = sqrt(sum(diff));
    %a trick to get the patches in the sorted order
    dist_appended_patch_mat = zeros(patch_len+1, num_patches);
    dist_appended_patch_mat(1, :) = dist_mat;
    dist_appended_patch_mat(2:patch_len+1, :) = this_patch_neighbrhoood;
    
    [~, inx] = sort(dist_appended_patch_mat(1,:));
    sorted_patch_mat = dist_appended_patch_mat(2:patch_len+1, inx);
    
    P_i = sorted_patch_mat(:, 1:search_num_patches);
end

