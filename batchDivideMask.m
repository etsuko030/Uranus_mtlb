function info = batchDivideMask(imfolder, exfolder)

% Do divideMask() for each child folder of the given path
% Create word-wise child folders with the same names for the destination path
% Create further two child folders for each named 'initial' 'candidate'
% Put masks that are initially with single object to folder 'initial'
% And the rest to folder 'candidate'


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
disp(strcat(num2str(length(childName)), ' folders found in directory',  '"...'));
% Make child folders for destination folder

for k = 1 : length(childName)
    one{k} = char(strcat(exfolder, '\', childName(k), '\initial'));     % initial
    two{k} = char(strcat(exfolder, '\', childName(k), '\candidate'));   % candidate
%    disp(one{k});
%    disp(two{k});
    mkdir(one{k});
    mkdir(two{k});
end




for k = 1 : length(childName)
    
    
    % Divide masks
    disp(strcat('Processing folder "', childName(k), '"...'));
    imLocation{k} = fullfile(imfolder, childName(k));
    exLocation{k} = fullfile(exfolder, childName(k));
%    disp('imlocation:');
%    disp(imLocation{k});
    info{k} = divideMask(char(imLocation{k}), char(exLocation{k}));
    
%    clear imLocation;
%    clear exLocation;
    
    % Organise masks according to whether they are divided or not (according to number of objects in the original image)
    % disp('before moving');
    % disp('current length:');
    % disp(length(info{k}));
    for i = 1 : length(info{k})
        if info{k}(i).isSingle == 1
        	movefile(char(info{k}(i).dividedMasks), one{k});
%           disp('moving');
%        	disp(info{k}(i).dividedMasks);
%        	disp(one{k});
        end
        if info{k}(i).isSingle == 0
            for j = 1 : info{k}(i).numOfMasks
            	movefile(char(info{k}(i).dividedMasks(j)), two{k});
        	end
        end
    %        if info{k}(i).isSingle == -1     % ignore images with no mask      
    %        end
    end
    
    
end


%    for k = 1 : length(childName)

%    end



end



