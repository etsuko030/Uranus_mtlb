function trimmed = imtrim(image, pixel)

% rescale and trim image restricting larger side less than pixel value

[row, col] = size(image); 

if (row > pixel || col > pixel)
    if (row > col)
        trimmed = imresize(image, [pixel, NaN]);
    else
        trimmed = imresize(image, [NaN, pixel]);
    end
else
    % if both side less than pixel value
    % skip trimming
    disp(["size = ", row, "x",col, " Image is not trimmed."]);
    trimmed = image;
end

end