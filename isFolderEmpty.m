function boolean = isFolderEmpty(directory)

% empty -> no png images in folder
% boolean = 1: folder is empty
% boolean = 0: folder is not empty
% boolean = -1: directory is not folder

if isfolder(directory)== 1
    
    files = dir(fullfile(directory, '*.png'));
    
    if length(files)==0
        boolean = 1;
    else boolean = 0;
    end
    
else
    boolean = -1;
end

end