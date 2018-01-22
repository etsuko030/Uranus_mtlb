function squaremask = cropZernikeShape(mask)

% crop bounding circle and crop image according to circle

cc = bwconncomp(mask);
[x, y] = ind2sub(size(mask), cc.PixelIdxList{1}); % applied only to single-object
X = [y, x]; % flip over for 'exact min bound circle' code
[R, C, ~] = ExactMinBoundCircle(X);

% pad image and adjust centroid
% compare circle edge and current image edge
padvalue = 300;
paddedmask = padarray(mask, [padvalue, padvalue]); % pad to both direction, row/col both add padvalue*2
% modify centre coodinates
C = C + padvalue;
% R = ceil(R); % round up to the larger integer
%[xdim, ydim, ~] = size(paddedmask);
circleMask = createCirclesMask(paddedmask, C, R);
% Cut square along circle mask
stats = regionprops(circleMask, 'BoundingBox');
squaremask = imcrop(paddedmask, stats.BoundingBox);

end