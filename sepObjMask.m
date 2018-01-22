function sepMask = sepObjMask(original_mask)

% Count connected components in the mask and create separate masks
% according to number of objects.
% If there are multiple objects, return a cell array of mask images.
% Otherwise return the single-object mask as it was.

cc = bwconncomp(original_mask);
if cc.NumObjects==0 % if no object in the mask
    sepMask = 0;
else
    for k = 1:cc.NumObjects
%       disp('Current k:')
%       disp(k)
        ii = zeros(cc.ImageSize);
        ii(cc.PixelIdxList{k}) = 1;
        sepMask{k}=ii;
%       imshow(mask{k})
    end
end


end
