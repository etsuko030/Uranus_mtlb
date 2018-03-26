function [features, validPoints] = siftForBoW(imageFile)

% used original SIFT programme: http://www.cs.ubc.ca/~lowe/keypoints/
% input: image filename

% Image will automatically convert to greyscale in the following line.
[~, features, validPoints] = sift(imageFile);

%     image: the image array in double format
%     descriptors: a K-by-128 matrix, where each row gives an invariant
%         descriptor for one of the K keypoints.  The descriptor is a vector
%         of 128 values normalized to unit length.
%     locs: K-by-4 matrix, in which each row has the 4 values for a
%         keypoint location (row, column, scale, orientation).  The 
%         orientation is in the range [-PI, PI] radians.



end