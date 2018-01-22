function results = validatingIteration(fta, ftb, ftc, label)

k = 10; % 5-folds
partition = cvpartition(label, 'KFold', k);

results = ["a", "b", "c", "avg. acc."];

for a = 0:0.1:1
    for b = 0:0.1:1
        for c = 0:0.1:1
            if (a+b+c)~=1
                continue;
            end
            disp(['a = ',num2str(a),', b = ',num2str(b),', c = ',num2str(c)]);
            accuracy = [];
            feature = horzcat(fta*a, ftb*b, ftc*c);
            for i = 1:k
                trainingIdx = training(partition, i);
                testIdx = test(partition, i);
                trainingFt = feature(trainingIdx,:);
                testFt = feature(testIdx,:);
                trainingLabel = label(trainingIdx,:);
                testLabel = label(testIdx,:);
                tree = TreeBagger(100, trainingFt, trainingLabel);
                predictLabel = predict(tree, testFt);
                accuracy = [accuracy, compareLabels(testLabel, predictLabel)];
            end
            avg = mean(accuracy);
            disp(['average accuracy = ',num2str(avg)]);
            results = [results; a, b, c, avg];
        end
    end
end


end