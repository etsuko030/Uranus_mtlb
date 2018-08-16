function deletedInfo = batchFilterChannels(imageDatastore, numOfChannels)

% delete not qualifying images (channel~=3)
% operated directly to file directory

deletedInfo = [];

for i = 1:length(imageDatastore.Files)
    
    I = readimage(imageDatastore, i);
    [~, ~, channel] = size(I.original);
    disp(channel);
    if (channel ~= numOfChannels)
        disp(imageDatastore.Files(i));
        deletedInfo = [deletedInfo; imageDatastore.Files(i)];
%        delete(char(imageDatastore.Files(i)));
    end

end
end