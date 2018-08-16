function [lambdaList, resultList] = validateLambdaBergsma(fvA1, fvA2, labelA, fvB1, fvB2, labelB, translation)

% validate translation from A to B

    wordA = unique(labelA); na = length(wordA); 
    wordB = unique(labelB); nb = length(wordB); 
    assert(length(translation)==na);
    
    lambdaList = [];
    resultList = []; %
    
    for i = 0.1:0.1:1 % lambda0 
        
       [tableList, answerMatrix, answerList] = listSimilarityTableCombinedVer(horzcat(fvA1, fvA2*i), labelA, horzcat(fvB1, fvB2*i), labelB);
       resultList = [resultList; struct('lambda', i, 'table', tableList, 'matrix', answerMatrix, 'answers', answerList)]; %
       
%       accuracy = comparingLabels(answerList(1,:), translation)/na;
%       result = [i, accuracy];
%       lambdaList = [lambdaList; result];

       mrr = computeMRR(answerList, translation); %
       mrres = [i, mrr]; %
       lambdaList = [lambdaList; mrres]; %
    end
    
end

function numCorrect = comparingLabels(topAnswers, trueTranslations)
    tf = contains(string(trueTranslations), string(topAnswers));
    numCorrect = sum(tf);
end

%
function mrr = computeMRR(rankedAnswers, trueTranslations)

    na = length(rankedAnswers(1,:));
    nb = length(rankedAnswers(:,1));
    nb1 = length(trueTranslations);
    assert(nb==nb1);
    
    for i = 1:na
        ranklist = rankedAnswers(:,i);
        for j = 1:nb
            if contains(string(trueTranslations(i)), string(ranklist(j)))
                break;
            end
        end
        ranknum(i) = 1/j;
    end
    
    mrr = mean(ranknum);
end