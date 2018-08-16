function batchSalcut(imfolder, exfolder)

% batch resize images to square pixel x pixel

% get image paths

imgs = imageDatastore(imfolder,'IncludeSubfolders',true,'FileExtensions',{'.jpg','.png'},'LabelSource','foldernames');

h = waitbar(0,'Segmenting images...');

for i = 1:length(imgs.Files)
    
    image = imread(char(imgs.Files(i)));

    savepath = char(strrep(imgs.Files(i), imfolder, exfolder));
    [path, n, extension] = fileparts(savepath);
    if (extension =='.jpg')
        savepath = char(strrep(savepath, '.jpg', '.png'));
    end
       
    % check if folder exist, if not, create new folder
    if exist(path) == 0
    	mkdir(path);
    end
    maskname = char(strrep(savepath, '.png', '-m.png'));
    regname = char(strrep(savepath, '.png', '-reg.png'));
    
    [input, output, region] = runSalcut(image);
    imwrite(input, savepath);
    imwrite(output, maskname);
    imwrite(region, regname);

    
    waitbar(i/length(imgs.Files));
end

close(h);




end