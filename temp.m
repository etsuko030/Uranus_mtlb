
set_seed_01_chs = imageDatastore('E:\_seed_set_50\01\chs','IncludeSubfolders',true,'FileExtensions','.png','LabelSource','foldernames');
set_seed_01_eng = imageDatastore('E:\_seed_set_50\01\eng','IncludeSubfolders',true,'FileExtensions','.png','LabelSource','foldernames');
set_seed_01_chs.ReadFcn = @(loc)imresize(imread(loc),[227,227]);
set_seed_01_eng.ReadFcn = @(loc)imresize(imread(loc),[227,227]);

set_seed_01_chs_ft = activations(net, set_seed_01_chs, layer);
set_seed_01_eng_ft = activations(net, set_seed_01_eng, layer);

set_seed_01_chs_classifier = TreeBagger(100, set_seed_01_chs_ft, set_seed_01_chs.Labels);
set_seed_01_eng_classifier = TreeBagger(100, set_seed_01_eng_ft, set_seed_01_eng.Labels);

set_seed_01_chs_predict = predict(set_seed_01_chs_classifier, set_seed_01_chs_ft);
table_set_seed_01_chs = listSVMResult(categorical(set_seed_01_chs_predict), set_seed_01_chs.Labels);
set_seed_01_eng_predict = predict(set_seed_01_eng_classifier, set_seed_01_eng_ft);
table_set_seed_01_eng = listSVMResult(categorical(set_seed_01_eng_predict), set_seed_01_eng.Labels);

flagging_01_chs_predict = predict(set_seed_01_chs_classifier, set_original_01_chs_ft);
table_flagging_01_chs = listSVMResult(categorical(flagging_01_chs_predict), set_seed_01_chs.Labels);
flagging_01_eng_predict = predict(set_seed_01_eng_classifier, set_original_01_eng_ft);
table_flagging_01_eng = listSVMResult(categorical(flagging_01_eng_predict), set_seed_01_eng.Labels);

flagging_01_chs = correctSampleSelection(categorical(flagging_01_chs_predict), set_original_01_chs.Labels);
flagging_01_eng = correctSampleSelection(categorical(flagging_01_eng_predict), set_original_01_eng.Labels);

info_filter_01_chs = designatedFilter('E:\_cropped_set_01-03\01-3c\chs', 'E:\_cropped_set_01-03\01-filtered-L7\chs', flagging_01_chs);
info_filter_01_eng = designatedFilter('E:\_cropped_set_01-03\01-3c\eng', 'E:\_cropped_set_01-03\01-filtered-L7\eng', flagging_01_eng);


set_filtered_01_chs = imageDatastore('E:\_cropped_set_01-03\01-filtered-L7\chs','IncludeSubfolders',true,'FileExtensions','.png','LabelSource','foldernames');
set_filtered_01_eng = imageDatastore('E:\_cropped_set_01-03\01-filtered-L7\eng','IncludeSubfolders',true,'FileExtensions','.png','LabelSource','foldernames');
set_filtered_01_chs.ReadFcn = @(loc)imresize(imread(loc),[227,227]);
set_filtered_01_eng.ReadFcn = @(loc)imresize(imread(loc),[227,227]);

set_filtered_01_chs_ft = activations(net, set_filtered_01_chs, layer);
set_filtered_01_eng_ft = activations(net, set_filtered_01_eng, layer);

set_filtered_01_chs_seed_classifier = TreeBagger(100, set_filtered_01_chs_ft, set_filtered_01_chs.Labels);
set_filtered_01_eng_seed_classifier = TreeBagger(100, set_filtered_01_eng_ft, set_filtered_01_eng.Labels);



% eng -> chs
set_filtered_01_chs_eng_predict = predict(set_filtered_01_chs_seed_classifier, set_filtered_01_eng_ft);
table_set_filtered_01_chs_eng = listSVMResult(categorical(set_filtered_01_chs_eng_predict), set_filtered_01_eng.Labels);
% chs -> eng
set_filtered_01_eng_chs_predict = predict(set_filtered_01_eng_seed_classifier, set_filtered_01_chs_ft);
table_set_filtered_01_eng_chs = listSVMResult(categorical(set_filtered_01_eng_chs_predict), set_filtered_01_chs.Labels);





% 02

set_seed_02_chs = imageDatastore('E:\_seed_set_50\02\chs','IncludeSubfolders',true,'FileExtensions','.png','LabelSource','foldernames');
set_seed_02_eng = imageDatastore('E:\_seed_set_50\02\eng','IncludeSubfolders',true,'FileExtensions','.png','LabelSource','foldernames');
set_seed_02_chs.ReadFcn = @(loc)imresize(imread(loc),[227,227]);
set_seed_02_eng.ReadFcn = @(loc)imresize(imread(loc),[227,227]);

set_seed_02_chs_ft = activations(net, set_seed_02_chs, layer);
set_seed_02_eng_ft = activations(net, set_seed_02_eng, layer);

set_seed_02_chs_classifier = TreeBagger(100, set_seed_02_chs_ft, set_seed_02_chs.Labels);
set_seed_02_eng_classifier = TreeBagger(100, set_seed_02_eng_ft, set_seed_02_eng.Labels);

set_seed_02_chs_predict = predict(set_seed_02_chs_classifier, set_seed_02_chs_ft);
table_set_seed_02_chs = listSVMResult(categorical(set_seed_02_chs_predict), set_seed_02_chs.Labels);
set_seed_02_eng_predict = predict(set_seed_02_eng_classifier, set_seed_02_eng_ft);
table_set_seed_02_eng = listSVMResult(categorical(set_seed_02_eng_predict), set_seed_02_eng.Labels);

flagging_02_chs_predict = predict(set_seed_02_chs_classifier, set_original_02_chs_ft);
table_flagging_02_chs = listSVMResult(categorical(flagging_02_chs_predict), set_seed_02_chs.Labels);
flagging_02_eng_predict = predict(set_seed_02_eng_classifier, set_original_02_eng_ft);
table_flagging_02_eng = listSVMResult(categorical(flagging_02_eng_predict), set_seed_02_eng.Labels);

flagging_02_chs = correctSampleSelection(categorical(flagging_02_chs_predict), set_original_02_chs.Labels);
flagging_02_eng = correctSampleSelection(categorical(flagging_02_eng_predict), set_original_02_eng.Labels);

info_filter_02_chs = designatedFilter('E:\_cropped_set_01-03\02-3c\chs', 'E:\_cropped_set_01-03\02-filtered-L7\chs', flagging_02_chs);
info_filter_02_eng = designatedFilter('E:\_cropped_set_01-03\02-3c\eng', 'E:\_cropped_set_01-03\02-filtered-L7\eng', flagging_02_eng);


set_filtered_02_chs = imageDatastore('E:\_cropped_set_01-03\02-filtered-L7\chs','IncludeSubfolders',true,'FileExtensions','.png','LabelSource','foldernames');
set_filtered_02_eng = imageDatastore('E:\_cropped_set_01-03\02-filtered-L7\eng','IncludeSubfolders',true,'FileExtensions','.png','LabelSource','foldernames');
set_filtered_02_chs.ReadFcn = @(loc)imresize(imread(loc),[227,227]);
set_filtered_02_eng.ReadFcn = @(loc)imresize(imread(loc),[227,227]);

set_filtered_02_chs_ft = activations(net, set_filtered_02_chs, layer);
set_filtered_02_eng_ft = activations(net, set_filtered_02_eng, layer);

set_filtered_02_chs_seed_classifier = TreeBagger(100, set_filtered_02_chs_ft, set_filtered_02_chs.Labels);
set_filtered_02_eng_seed_classifier = TreeBagger(100, set_filtered_02_eng_ft, set_filtered_02_eng.Labels);



% eng -> chs
set_filtered_02_chs_eng_predict = predict(set_filtered_02_chs_seed_classifier, set_filtered_02_eng_ft);
table_set_filtered_02_chs_eng = listSVMResult(categorical(set_filtered_02_chs_eng_predict), set_filtered_02_eng.Labels);
% chs -> eng
set_filtered_02_eng_chs_predict = predict(set_filtered_02_eng_seed_classifier, set_filtered_02_chs_ft);
table_set_filtered_02_eng_chs = listSVMResult(categorical(set_filtered_02_eng_chs_predict), set_filtered_02_chs.Labels);




% 03

set_seed_03_chs = imageDatastore('E:\_seed_set_50\03\chs','IncludeSubfolders',true,'FileExtensions','.png','LabelSource','foldernames');
set_seed_03_eng = imageDatastore('E:\_seed_set_50\03\eng','IncludeSubfolders',true,'FileExtensions','.png','LabelSource','foldernames');
set_seed_03_chs.ReadFcn = @(loc)imresize(imread(loc),[227,227]);
set_seed_03_eng.ReadFcn = @(loc)imresize(imread(loc),[227,227]);

set_seed_03_chs_ft = activations(net, set_seed_03_chs, layer);
set_seed_03_eng_ft = activations(net, set_seed_03_eng, layer);

set_seed_03_chs_classifier = TreeBagger(100, set_seed_03_chs_ft, set_seed_03_chs.Labels);
set_seed_03_eng_classifier = TreeBagger(100, set_seed_03_eng_ft, set_seed_03_eng.Labels);

set_seed_03_chs_predict = predict(set_seed_03_chs_classifier, set_seed_03_chs_ft);
table_set_seed_03_chs = listSVMResult(categorical(set_seed_03_chs_predict), set_seed_03_chs.Labels);
set_seed_03_eng_predict = predict(set_seed_03_eng_classifier, set_seed_03_eng_ft);
table_set_seed_03_eng = listSVMResult(categorical(set_seed_03_eng_predict), set_seed_03_eng.Labels);

flagging_03_chs_predict = predict(set_seed_03_chs_classifier, set_original_03_chs_ft);
table_flagging_03_chs = listSVMResult(categorical(flagging_03_chs_predict), set_seed_03_chs.Labels);
flagging_03_eng_predict = predict(set_seed_03_eng_classifier, set_original_03_eng_ft);
table_flagging_03_eng = listSVMResult(categorical(flagging_03_eng_predict), set_seed_03_eng.Labels);

flagging_03_chs = correctSampleSelection(categorical(flagging_03_chs_predict), set_original_03_chs.Labels);
flagging_03_eng = correctSampleSelection(categorical(flagging_03_eng_predict), set_original_03_eng.Labels);

info_filter_03_chs = designatedFilter('E:\_cropped_set_01-03\03-3c\chs', 'E:\_cropped_set_01-03\03-filtered-L7\chs', flagging_03_chs);
info_filter_03_eng = designatedFilter('E:\_cropped_set_01-03\03-3c\eng', 'E:\_cropped_set_01-03\03-filtered-L7\eng', flagging_03_eng);


set_filtered_03_chs = imageDatastore('E:\_cropped_set_01-03\03-filtered-L7\chs','IncludeSubfolders',true,'FileExtensions','.png','LabelSource','foldernames');
set_filtered_03_eng = imageDatastore('E:\_cropped_set_01-03\03-filtered-L7\eng','IncludeSubfolders',true,'FileExtensions','.png','LabelSource','foldernames');
set_filtered_03_chs.ReadFcn = @(loc)imresize(imread(loc),[227,227]);
set_filtered_03_eng.ReadFcn = @(loc)imresize(imread(loc),[227,227]);

set_filtered_03_chs_ft = activations(net, set_filtered_03_chs, layer);
set_filtered_03_eng_ft = activations(net, set_filtered_03_eng, layer);

set_filtered_03_chs_seed_classifier = TreeBagger(100, set_filtered_03_chs_ft, set_filtered_03_chs.Labels);
set_filtered_03_eng_seed_classifier = TreeBagger(100, set_filtered_03_eng_ft, set_filtered_03_eng.Labels);



% eng -> chs
set_filtered_03_chs_eng_predict = predict(set_filtered_03_chs_seed_classifier, set_filtered_03_eng_ft);
table_set_filtered_03_chs_eng = listSVMResult(categorical(set_filtered_03_chs_eng_predict), set_filtered_03_eng.Labels);
% chs -> eng
set_filtered_03_eng_chs_predict = predict(set_filtered_03_eng_seed_classifier, set_filtered_03_chs_ft);
table_set_filtered_03_eng_chs = listSVMResult(categorical(set_filtered_03_eng_chs_predict), set_filtered_03_chs.Labels);