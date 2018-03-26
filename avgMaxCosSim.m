function avgsim = avgMaxCosSim(me, mf)

% Similarity between two sets of feature vectors with equal dimensions
% For each vector in E, a best matching vector in F is found.
% An average of cosine distance between a vector in E and its
% best-match from F is returned.
% This code is for implementing similarity measurement AVGMAX used in the experiments of the following paper:
% Bergsma, S. & Durme, B. Van, 2011. Learning bilingual lexicons using the visual similarity of labeled web images
% By Usoneko, March 2018


[rowE, colE] = size(me);
[rowF, colF] = size(mf);

if (colE~=colF)
    error('Dimension not comparable');
    return;
end

ee = rowE;
ff = rowF;

sim = [];

emptyI = 0;

for i = 1:ee
    
    cdis = [];
    ve = me(i, :); % current vector E
%    assert(norm(ve)~=0, 'Vector magnitude (matrix E) equals zero.');
    if norm(ve)==0
        emptyI = emptyI + 1;
        continue
    end
    
    emptyJ = 0;
    for j = 1:ff
 
        disp(['Current position i(E) = ', num2str(i), ', j(F) = ', num2str(j)]);
        
        vf = mf(j, :);
        
 %       assert(norm(vf)~=0, 'Vector magnitude (matrix F) equals zero.');
        if norm(vf)~=0
            cdis = [cdis; pdist([ve;vf],'cosine')]; % cosine distance
        else
            emptyJ = emptyJ +1;
        end
        
    end
    
    sim = [sim; max(cdis)];

end

avgsim = mean([sim; zeros(emptyI, 1)]); % compute average (count value-invalid number as well)

end
