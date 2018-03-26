function rgbHistData = computeGlobalRGBHistData(data, nBin, nInd)

% Compute RGB colour histogram matrix for imagedatastore
% each row is 7-dimension vector for one binary image

% nBins   : number of bins per EACH color => histogram is 'nBins^3' long.
% Nind    : Normalization index
%
%           0 -> Un-Normalized historam
%           1 -> l1 normalized
%           2 -> l2 normalized

if(nargin<3)
    nInd=0;
    % Default is un-normalized histogram
end

rgbHist = [];

X = ['Computing RGB colour histogram for ', num2str(length(data.Files)), ' images (number of bins = ', num2str(nBin),')'];

h = waitbar(0, X);

for i = 1:length(data.Files)
    
    I = readimage(data, i);
    if (size(I.image, 3) == 1)
    	img = cat(3, I.image, I.image, I.image);
    else
        img = I.image;
    end
    go = rgbhist(img, nBin, nInd).';
    rgbHist = vertcat(rgbHist, go);
    
    waitbar(i/length(data.Files));
end

close(h);
rgbHistData = rgbHist;

end