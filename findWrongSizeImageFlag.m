function [wrongSizeInfo, chooseFlag] = findWrongSizeImageFlag(folder)


% batch cropping image and throw images too small

% get image paths

imgs = imageDatastore(folder,'IncludeSubfolders',true,'FileExtensions','.png','LabelSource','foldernames');

list = [];
flag = [];

h = waitbar(0,'Scanning folder...');

for i = 1:length(imgs.Files)
    
    image = imread(char(imgs.Files(i)));
    [~, ~, channel] = size(image);

    if (channel~=3) 
        f = 0;
        flag = [flag; f];
        list = [list; imgs.Files(i)];
    else
        f = 1;
        flag = [flag; f];        
    end
    
    waitbar(i/length(imgs.Files));
end

close(h);

wrongSizeInfo = list;
chooseFlag = flag;

end