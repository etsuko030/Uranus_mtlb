function stegnoBatch(imfolder, exfolder)


% Import images and masks from the folder containing the divided masks(batchDivideMask.m) and put mask image into alpha channel of the original image.
% Write new images in the given folder.


% Get list of names of child folders.

% Get all contents
disp("Scanning all folders...");
imFiles = dir(imfolder);
dirFlags = [imFiles.isdir];
% Extract only those that are directories
subFolders = imFiles(dirFlags);
for k = 1 : length(subFolders)
    if strcmp(subFolders(k).name, '$RECYCLE.BIN') || strcmp(subFolders(k).name, 'System Volume Information') || strcmp(subFolders(k).name, '.') || strcmp(subFolders(k).name, '..')
        childName{k} = [];
    else childName{k} = subFolders(k).name;
    end
end

childName = childName(~cellfun(@isempty, childName));
disp(strcat(num2str(length(childName)), ' folders found in directory', '...'));

% Make child folders for destination folder
for k = 1 : length(childName)
    one{k} = char(strcat(exfolder, '\initial\', childName(k)));     % initial
    two{k} = char(strcat(exfolder, '\candidate\', childName(k)));     % candidate
%    disp(child{k});
    mkdir(one{k});
    mkdir(two{k});
end


% Find mask images from original folders
% For each mask image get original and do stegno

for k = 1 : length(childName)

    wb = waitbar(0, strcat('Processing folder "', childName(k), '"...'));
%    disp(strcat('Processing folder "', childName(k), '"...'));
    
    iniLocation = char(strcat(imfolder, '\', childName(k), '\initial')); % destination: one{k}
    canLocation = char(strcat(imfolder, '\', childName(k), '\candidate')); % destination: two{k}
    
    iniData = imageDatastore(iniLocation, 'FileExtensions', '.png'); % image locations
    canData = imageDatastore(canLocation, 'FileExtensions', '.png');
    
    
    % process single-object images
    for i = 1 : length(iniData.Files)
        
        nowloc = iniData.Files(i);
    	% get ID of the mask
        [~, name, ~] = fileparts(char(nowloc));
        ID = strrep(name, '-m-1', '');
%        disp(ID);
        % get original image by ID
        originalName = strcat(imfolder, '\', childName(k), '\', ID, '.png');
        originalImg = imread(char(originalName));
        % get mask image
        maskImg = imread(char(iniData.Files(i)));
        % stegno and write file
        saveName = char(strcat(one(k), '\', ID, '.png'));
        stegnoMask(originalImg, maskImg, saveName);
%        imshow(originalImg);
%        imwrite(s, char(strcat(one(k), '\', ID, '.png')));
        
        clear nowloc;
        clear name;
        clear ID;
        clear originalName;
        clear originalImg;
        clear maskImg;
        clear saveName;
        
        waitbar(i/(length(iniData.Files)+length(canData.Files)));
    end
    
    
    % process multiple-objects images
    
    for i = 1 : length(canData.Files)
              
        nowloc = canData.Files(i);
    	% get ID of the mask
        [~, name, ~] = fileparts(char(nowloc));
        ID = name(1:3);     % first 3 digits are numbers
        newID = strrep(name, '-m', '');   % xxx-m-x  ->  xxx-x
%        disp(ID);
        % get original image by ID
        originalName = strcat(imfolder, '\', childName(k), '\', ID, '.png');
        originalImg = imread(char(originalName));
        % get mask image
        maskImg = imread(char(canData.Files(i)));
        % stegno and write file
        saveName = char(strcat(two(k), '\', newID, '.png'));
        stegnoMask(originalImg, maskImg, saveName);
%        imshow(originalImg);
%        imwrite(s, saveName);

        clear nowloc;
        clear name;
        clear ID;
        clear originalName;
        clear originalImg;
        clear maskImg;
        clear saveName;
        
        waitbar((i+length(iniData.Files))/(length(iniData.Files)+length(canData.Files)));
    end
    
%    iniPattern = sprintf('%s/*-m-1.png', imLocation(k)); % needs to be cleared
%    initialList = dir(iniPattern); % needs to be cleared

%   candidateList = dir(canPattern); % needs to be cleared

    clear iniLocation;
    clear canLocation;
    clear iniData;
    clear canData;
    
    close(wb);
end


disp("Finished!");



end