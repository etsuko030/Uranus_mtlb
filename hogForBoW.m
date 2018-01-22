function [features, validPoints] = hogForBoW(grey, mask)

locations = genMaskLocation(mask);
[features, validPoints] = extractHOGFeatures(grey, locations);

end