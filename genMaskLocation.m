function locations = genMaskLocation(binmask)

% Generate pixel location info from binary mask.
% (only one object in the mask)

cc = bwconncomp(binmask);
if cc.NumObjects==0 % if no object in the mask
    locations = [];
else
    locations = [];
    for k = 1:cc.NumObjects
        [i, j] = ind2sub(cc.ImageSize, cc.PixelIdxList{k});
        locations = horzcat(locations, [i, j]);
    end
end

end

