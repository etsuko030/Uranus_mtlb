function cropImageInfo = batchCropImage(pixel, imfolder, exfolder)


% batch cropping image and throw images too small

% get image paths

imgs = imageDatastore(imfolder,'IncludeSubfolders',true,'FileExtensions','.png','LabelSource','foldernames');

list = [];

h = waitbar(0,'Cropping images...');

for i = 1:length(imgs.Files)
    
    image = imread(char(imgs.Files(i)));
    [row, col] = size(image);
    
    nowpath = char(imgs.Files(i));
    savepath = char(strrep(imgs.Files(i), imfolder, exfolder));
    [path, ~, ~] = fileparts(savepath); 
    % check if folder exist, if not, create new folder
    if exist(path) == 0
    	mkdir(path);
    end
    
    % If the image is a wanted one
    if (row>=50 && col >=50)
        % trim image, save to target path
        target = imtrim(image, pixel);
        imwrite(target, savepath);

    % Else keep record of location of the image
    else     
        list = [list imgs.Files(i)];
    end
    
    waitbar(i/length(imgs.Files));
end

close(h);

cropImageInfo = list;

end