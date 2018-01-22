function featureVector = horizontalConcatFeature(A, B, C)
% need feature metrics (weights for different kinds of features) 

featureVector = horzcat(A, B, C);



[row, col] = size(featureVector);
featureMetrics = ones(1, col);
featureMetrics = repmat(featureMetrics, row, 1);
featureVector = bsxfun(@times, featureVector, featureMetrics);

end