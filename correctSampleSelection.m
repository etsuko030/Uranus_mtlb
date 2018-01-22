function table = correctSampleSelection(resultLabels, trueLabels)

% mark the samples that are correctly classified
% labels - category type

table = ifSampleCorrect(resultLabels, trueLabels);

end

function f = ifSampleCorrect(lbl1, lbl2)
    f = (lbl1==lbl2);
end