function rgbHistData = computeRGBHistData(data, nBin, nInd)

% Compute RGB colour histogram matrix for imagedatastore
% each row is 7-dimension vector for one binary image

% nBins   : number of bins per EACH color => histogram is 'nBins^3' long.
% Nind    : Normalization index
%
%           0 -> Un-Normalized historam
%           1 -> l1 normalized
%           2 -> l2 normalized

rgbHist = [];

X = ['Computing RGB colour histogram for ', num2str(length(data.Files)), ' images (number of bins = ', num2str(nBin),')'];

h = waitbar(0, X);

for i = 1:length(data.Files)
    
    I = readimage(data, i);
    disp(data.Files(i));
    go = rgbhist_mask(I.original, I.mask, nBin, nInd);
%    go = go/norm(go); % normalise
    rgbHist = vertcat(rgbHist, go);
    
    waitbar(i/length(data.Files));
end

close(h);
rgbHistData = rgbHist;

end