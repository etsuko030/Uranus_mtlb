function filterinfo = designatedFilter(imfolder, exfolder, flag)


% Filter with an input flag: 1 to save 0 to throw


% get image paths

imgs = imageDatastore(imfolder,'IncludeSubfolders',true,'FileExtensions','.png','LabelSource','foldernames','ReadFcn',@customReaderImage);

list = [];

% check consistency

if (length(imgs.Files)~=length(flag))
    error('Length of flag is not compatible with number of images.');
end

h = waitbar(0,'Filtering images...');

for i = 1:length(imgs.Files)
    
    current = flag(i);

    % If the image is a wanted one, copy to the destination folder along
    % with the childfolder paths
    if (current)
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

filterinfo = list; % the unwanted images

end