function huMomentData = computeHuMomentsData(data)

% Compute invariant moments matrix for imagedatastore
% each row is 7-dimension vector for one binary image

huMoments = [];

X = ['Computing invariant moments for ', num2str(length(data.Files)), ' images...'];

h = waitbar(0, X);

for i = 1:length(data.Files)
    
    I = readimage(data, i);
    hu = invmoments(I.mask);
    huMoments = vertcat(huMoments, hu);
    
    waitbar(i/length(data.Files));
end

close(h);
huMomentData = huMoments;

end