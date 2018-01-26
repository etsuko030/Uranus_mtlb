function batchResizeImage(pixel, imfolder, exfolder)


% batch resize images to square pixel x pixel

% get image paths

imgs = imageDatastore(imfolder,'IncludeSubfolders',true,'FileExtensions','.png','LabelSource','foldernames');

h = waitbar(0,'Resizing images...');

for i = 1:length(imgs.Files)
    
    image = imread(char(imgs.Files(i)));

    savepath = char(strrep(imgs.Files(i), imfolder, exfolder));
    [path, ~, ~] = fileparts(savepath); 
    % check if folder exist, if not, create new folder
    if exist(path) == 0
    	mkdir(path);
    end
    
    target = imresize(image,[pixel pixel]);
    imwrite(target, savepath);

    
    waitbar(i/length(imgs.Files));
end

close(h);


end