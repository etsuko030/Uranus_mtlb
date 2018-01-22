function salcutFolder(imfolder, exfolder)

x = imread('shindasakananome.jpg');
imwrite(x, 'input.png');
system('"SalCut.exe" input.png reg.png output.png');
input = imread('input.png');
output = imread('output.png');
region = imread('reg.png');

imwrite(input, strcat(exfolder, '\', 'original.png'));
imwrite(output, strcat(exfolder, '\', 'mask.png'));
imwrite(region, strcat(exfolder, '\', 'reg.png'));
end