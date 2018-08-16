function zernikeMomentData = computeZernikeMomentData(data)

% Compute invariant moments matrix for imagedatastore
% each row is 36-dimension vector for one binary image

zMoments = [];

X = ['Computing Zernike moments for ', num2str(length(data.Files)), ' images...'];

h = waitbar(0, X);

for i = 1:length(data.Files)
    
%    disp(i);
    I = readimage(data, i);
    z = zernikeVector(I.mask);
    zMoments = vertcat(zMoments, z);
    
    waitbar(i/length(data.Files));
end

close(h);
zernikeMomentData = zMoments;

end