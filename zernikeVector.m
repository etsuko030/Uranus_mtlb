function z = zernikeVector(mask)


% normalise size of shape - what size to use?
size = 150;
mask = cropZernikeShape(mask);
img = imresize(mask, [size size]);

%[img, normtform, xdata, ydata] = imnorm(mask); % affine normalisation
%[row, col] = size(img);
%if (row>col)
%    s = row;
%else
%    s = col;
%end
%img = imresize(mask, [s s]);

% img = mask;

img = logical(img);
z = [];

% Compute n = 0-10 orders
% n even: m = 0:2:n
% n odd: m = 1:2:n

for n = 0:10

	if mod(n,2)==0
        for m = 0:2:n
            [Z, A, Phi] = Zernikmoment(img, n, m);
            z = [z A];
        end
        
    else
        for m = 1:2:n
            [Z, A, Phi] = Zernikmoment(img, n, m);
            z = [z A];
        end
    end
    
end


end