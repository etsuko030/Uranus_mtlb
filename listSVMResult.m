function tableList = listSVMResult(category, truelabels)

% organise the SVM classification results
% category - classified labels (what training classes are they classified)
% (vertically listed)
% trueLabels - the actual labels for test images (horizontally listed)

%, testclasses
label = unique(truelabels);
[n, ~] = size(label); % number of classes
tableList = [];

for i=1:n
    thisclass = (truelabels==label(i));
    classes = category(thisclass);
    T = tabulate(classes);
    if i==1
        T(:,2) = [];
        top = {'classifed\true', char(label(i))};
    else
        T(:,1) = [];
        T(:,1) = [];
        top = {char(label(i))};
    end
    T = [top; T];
    tableList = [tableList, T];
end



end