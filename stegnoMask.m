function steg = stegnoMask(original, mask, savingLoc)

% Combine image and mask image using png alpha channel.


if isempty(savingLoc)
	imwrite(original, 'steg.png', 'Alpha', mask);
    steg = imread('steg.png', 'png');
    %imshow(steg);
else 
    imwrite(original, savingLoc, 'Alpha', mask);
    steg = imread(savingLoc, 'png');
end 

%[newimg, map, mask] = imread('test.png', 'png');
% imshow(newimg);


end