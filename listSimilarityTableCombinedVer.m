function [tableList, answerMatrix, answerList] = listSimilarityTableCombinedVer(fvA, labelA, fvB, labelB)

% List similarity between two sets of feature vectors in table (combined)
% This code used similarity measurement AVGMAX used in the experiments of the following paper:
% Bergsma, S. & Durme, B. Van, 2011. Learning bilingual lexicons using the visual similarity of labeled web images
% By Usoneko, March 2018
% The similarity is to find a closest matching word for A from B;
% i.e. translating words from language A to language B.
% A in columns, B in rows

h = waitbar(0, 'Computing similarity...');

wordA = unique(labelA); na = length(wordA); 
wordB = unique(labelB); nb = length(wordB); 

simMatrix = zeros(na, nb);

for i = 1:na
    
    disp(['Compute similarity for label ' wordA(i)]);
    
    matrixA = getLabelVectors(fvA, labelA, wordA(i));
    
    for j = 1:nb
        
        disp(['Compare ', wordA(i), ' to ', wordB(j)]);
        
        waitbar(((i-1)*nb+j)/(na*nb));
        
        matrixB = getLabelVectors(fvB, labelB, wordB(j));
        
        simMatrix(j,i) = avgMaxCosSim(matrixA, matrixB);
        
        disp(['Similarity = ', num2str(simMatrix(j,i))]);
    end
    
end    

answerMatrix = simMatrix;
answerList = getAnswerList(answerMatrix, wordA, wordB);

listA = wordA.';
rowtab = ['lanB\lanA', listA];

%tableList = array2table(simMatrix);

tableList = [cellstr(wordB), num2cell(simMatrix)];
tableList = [cellstr(rowtab); tableList];

close(h);
end

function matrix = getLabelVectors(featureVectors, allLabels, labelString)

matrix = featureVectors(allLabels==labelString, :);

end


function answerTable = getAnswerList(matrix, wordA, wordB)
    

answerTable = [];


    for i = 1:length(wordA)
        
        simRank = matrix(:,i); % get columns (answer for A to B)
        
        answer = [];
        for j = 1:5  % get top-5 answers
            [~, index] = max(simRank); % index for highest similarity word B
            temp = wordB(index);
            answer = [answer; temp]; % add to top-5 list
            simRank(index) = [];
            wordB(index) = [];
        end
        
        answerTable = [answerTable, answer];
    end
    
    
end

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
