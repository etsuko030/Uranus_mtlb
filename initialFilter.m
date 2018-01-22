function filterinfo = initialFilter(imfolder, exfolder)


% Initial filter


% get image paths

imgs = imageDatastore(imfolder,'IncludeSubfolders',true,'FileExtensions','.png','LabelSource','foldernames','ReadFcn',@customReaderImage);

list = [];

h = waitbar(0,'Filtering images...');

for i = 1:length(imgs.Files)
    
    [~, ~, mask] = imread(char(imgs.Files(i)));
    mask = logical(mask);
    fore = sum(mask(1:end)); % ???
    [row, col] = size(mask);
    
    % If the image is a wanted one, copy to the destination folder along
    % with the childfolder paths
    if (fore/(row*col) >= 5/100)&& (fore/(row*col) <= 95/100) && ((row*col)>=50) && (fore>=25)
        % check if folder exist, if not, create new folder
        nowpath = char(imgs.Files(i));
        savepath = char(strrep(imgs.Files(i), imfolder, exfolder));
        [path, ~, ~] = fileparts(savepath);
        if exist(path) == 0
            mkdir(path);
        end
        copyfile(nowpath, savepath);
%        disp(savepath);
        
    % Else keep record of location of the image
    else
        list = [list imgs.Files(i)];
    end
    
    waitbar(i/length(imgs.Files));
end

close(h);

filterinfo = list;

end