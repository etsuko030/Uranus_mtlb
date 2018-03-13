function tableList = listSimilarityTable(fvA, labelA, fvB, labelB)

% List similarity between two sets of feature vectors in table
% This code used similarity measurement AVGMAX used in the experiments of the following paper:
% Bergsma, S. & Durme, B. Van, 2011. Learning bilingual lexicons using the visual similarity of labeled web images
% By Usoneko, March 2018
% The similarity is to find a closest matching word for A from B;
% i.e. translating words from language A to language B.
% A in columns, B in rows

wordA = unique(labelA); na = length(wordA); 
wordB = unique(labelB); nb = length(wordB); 

simMatrix = zeros(na, nb);

for i = 1:na
    
    matrixA = getLabelVectors(fvA, labelA, wordA(i));
    
    for j = 1:nb
        
        matrixB = getLabelVectors(fvB, labelB, wordB(j));
        
        simMatrix(j,i) = avgMaxCosSim(matrixA, matrixB);
    end
    
end    
    
listA = wordA.';
rowtab = ['lanB\lanA', listA];

%tableList = array2table(simMatrix);

tableList = [cellstr(wordB), num2cell(simMatrix)];
tableList = [cellstr(rowtab); tableList];


end

function matrix = getLabelVectors(featureVectors, allLabels, labelString)

matrix = featureVectors(allLabels==labelString, :);

end