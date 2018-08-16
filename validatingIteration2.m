function results = validatingIteration2(fta, ftb, ftc, label)


results = ["a", "b", "c", "acc."];

for a = 0:0.1:1
    for b = 0:0.1:1
        for c = 0:0.1:1
            if (a+b+c)~=1
                continue;
            end
            disp(['a = ',num2str(a),', b = ',num2str(b),', c = ',num2str(c)]);
            feature = horzcat(fta*a, ftb*b, ftc*c);
            tree = TreeBagger(100, feature, label);
            predictLabel = predict(tree, feature);
            accuracy = compareLabels(testLabel, predictLabel);
            disp(['accuracy = ',num2str(avg)]);
            results = [results; a, b, c, avg];
        end
    end
end


end