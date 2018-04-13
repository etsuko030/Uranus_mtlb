function answerTable = getAnswerList(matrix, wordA, wordB)
    

answerTable = [];


    for i = 1:length(wordA)
        
        simRank = matrix(:,i); % get columns (answer for A to B)
        wordlist = wordB; %% add
        disp(simRank);
        answer = [];
        for j = 1:5  % get top-5 answers
            [~, index] = max(simRank); % index for highest similarity word B
            disp(['index = ',num2str(index),', length wordB = ', num2str(length(wordlist))]);
            temp = wordlist(index);
            disp(['current wordB = ', temp]);
            answer = [answer; temp]; % add to top-5 list
            simRank(index) = [];
            wordlist(index) = [];
        end
        
        answerTable = [answerTable, answer];
    end
    
    
end