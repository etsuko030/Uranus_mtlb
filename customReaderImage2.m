function image = customReaderImage2(location)

% keep location info

image = struct('image', imread(location), 'location', location);

end