function image = customReaderImage(location)

[img, ~, msk] = imread(location, 'png');

image = struct('original', img, 'mask', msk, 'location', location);

end