function lambdaList = validateLambdaBergsma(fvA1, fvA2, labelA, fvB1, fvB2, labelB, translation)

% validate translation from A to B

    wordA = unique(labelA); na = length(wordA); 
    wordB = unique(labelB); nb = length(wordB); 
    assert(length(translation)==na);
    
    lambdaList = [];
    for i = 0:0.1:1 % lambda0 
        
       [tableList, answerMatrix, answerList] = listSimilarityTableCombinedVer(horzcat(fvA1, fvA2*i), labelA, horzcat(fvB1, fvB2*i), labelB);
        accuracy = comparingLabels(answerList(1,:), trueTranslations)/na;
        result = [i, accuracy];
        lambdaList = [lambdaList; result];
    end
    
end

function numCorrect = comparingLabels(topAnswers, trueTranslations)
    tf = contains(cellstr(trueTranslations), cellstr(topAnswers));
    numCorrect = sum(tf);
end