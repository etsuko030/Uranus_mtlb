function s = divideMask(imfolder, exfolder)

% Import mask images (-m.png) from one folder and save divided masks to another folder.

% find all files whose names end with '-m.png'
filePattern = sprintf('%s/*-m.png', imfolder);
list = dir(filePattern);
%   disp(list(1).name)
numOfMask = length(list);
numOfS = 0;


for k = 1:numOfMask
    
    flag = 0;   % if flag==0, the mask is not a single object
    fullFileName = fullfile(imfolder, list(k).name);    % full address of mask
    unexName = strrep(list(k).name, '-m.png', '');  % name with only the numbers
    originalName = strrep(fullFileName, '-m.png', '.png');  % full address of original image
%   disp(fullFileName);
%   disp(unexName);
%   listOfOriginal{k} = strrep(fullFileName, '-m.png', '.png'); 
%   listOfMask{k} = fullFileName;
%   copyfile originalName exfolder;    % copy original to folder ?

    copyOriginal{k} = strrep(originalName, imfolder, exfolder); % full address of original image to copy
    copyfile(char(originalName), char(copyOriginal{k}));
%    imwrite(imread(originalName), copyOriginal{k});
    
    mask = imread(fullFileName);
    sepMask = sepObjMask(mask); % divided masks using sepObjMask()
    num{k} = length(sepMask);    

    if length(sepMask)==1
        numOfS = numOfS +1;
        flag = 1;
    end
    

    if iscell(sepMask)
        for i = 1:length(sepMask)
            savePattern = sprintf('%s\\%s-m-%s.png', exfolder, unexName, num2str(i));
 %          disp(savePattern);
            imwrite(sepMask{i}, savePattern);
            sepMaskLocation{i} = savePattern;
        end
    else % sepMask is not cell; sepMask == 0
       if sepMask == 0
        %  no objects in the mask
        sepMaskLocation = 0;
        flag = -1;
       end
    end
    
    listOfMask{k} = sepMaskLocation;    % masks for current image
    singleFlag{k} = flag;

    clear sepMask;
    clear sepMaskLocation;
end

disp(strcat(num2str(numOfMask), ' masks of png images is processed.'));

s = struct('originalImage', copyOriginal, 'numOfMasks', num, 'dividedMasks', listOfMask, 'isSingle', singleFlag);
%s = struct('originalImage', copyOriginal, 'dividedMasks', listOfMask, 'isSingle', singleFlag);

end
