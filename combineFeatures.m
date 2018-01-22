function featureVector = combineFeatures(bofVectors)

% invariant moments
huMoments = [];

% global colour histogram
globalColour = [];
numberOfBins = 4;

for i = 1:length(data.Files)
    I = readimage(data, i);
    hu = invmoments(I.mask);
    go = rgbhist_mask(I.original, I.mask, numberOfBins, 0);
    huMoments = vertcat(huMoments, hu);
    globalColour = vertcat(globalColour, go);
end

%[h1, h2] = size(huMoments);
%[c1, c2] = size(globalColour);
%X = ['humoments: ', num2str(h1), 'x', num2str(h2),', colour:', num2str(c1), 'x', num2str(c2)];
%disp(X);

% need feature metrics (weights for different kinds of features) 
featureVector = horzcat(huMoments, globalColour, bofVectors);

[row, col] = size(featureVector);
featureMetrics = ones(1, col);
featureMetrics = repmat(featureMetrics, row, 1);
featureVector = bsxfun(@times, featureVector, featureMetrics);

end