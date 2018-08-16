function [input, output, region] = runSalcut(image)

% run salcut.exe

imwrite(image, 'input.png');
system('SalCut-d.exe input.png reg.png output.png');
input = imread('input.png');
output = imread('output.png');
region = imread('reg.png');

end