function avgsim = avgMaxCosSim(me, mf)

% Similarity between two sets of feature vectors with equal dimensions
% For each vector in E, a best matching vector in F is found.
% An average of cosine distance between a vector in E and its
% best-match from F is returned.
% This code is for implementing similarity measurement AVGMAX used in the experiments of the following paper:
% Bergsma, S. & Durme, B. Van, 2011. Learning bilingual lexicons using the visual similarity of labeled web images
% By Usoneko, March 2018

% cosine distance: pdist([u;v],'cosine');

[rowE, colE] = size(me);
[rowF, colF] = size(mf);

if (colE~=colF)
    error('Dimension not comparable');
    return;
end

ee = rowE;
ff = rowF;

sim = [];

for i = 1:ee

    ve = me(i, :); % current vector E
    
    cdis = [];
    for j = 1:ff
        vf = mf(j, :);
        cdis = [cdis; pdist([ve;vf],'cosine')]; % cosine distance
    end
 
    sim = [sim; max(cdis)];

end

avgsim = mean(avgsim); % compute average

end
