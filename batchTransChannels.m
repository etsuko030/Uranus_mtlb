function transInfo = batchTransChannels(imageDatastore, numOfChannels)

% delete not qualifying images (channel~=3)
% operated directly to file directory

transInfo = [];

for i = 1:length(imageDatastore.Files)
    
    I = readimage(imageDatastore, i);
    [~, ~, channel] = size(I.original);
    disp(channel);
    if (channel ~= numOfChannels)
        disp(imageDatastore.Files(i));
        transInfo = [transInfo; imageDatastore.Files(i)];
        rgbImage = cat(3, I.original, I.original, I.original);
        imwrite(rgbImage, char(imageDatastore.Files(i)), 'Alpha', I.mask);
    end

end
end