function rate = compareLabels(true, classified)

% Count matching labels in two column vectors and compute "correct rate"

A = true;
B = classified; % no 'wrong word' yet

    if size(A) == size(B)
%        a = (A == 'wrong word');
        [row, ~] = size(A);
        correctness = sum(A == B);
        rate = correctness/row;
%        rate = (correctness+sum(a))/(row-sum(a));
    else
        rate = -1;
        error('Error. \nSize not equal.');
    end

end