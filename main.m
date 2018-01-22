
testdata = imageDatastore('C:\Users\Tianyi Zhang\Desktop\smalltestdata','IncludeSubfolders',true,'FileExtensions','.png','LabelSource','foldernames','ReadFcn',@customReaderImage);
bag = bagOfFeatures(testdata, 'CustomExtractor', @bagOfFeaturesExtractor);



[trainingSet, validationSet] = splitEachLabel(testdata, 0.3, 'randomize');
categoryClassifier = trainImageCategoryClassifier(trainingSet, bag);
confMatrix = evaluate(categoryClassifier, trainingSet);



test50chs = imageDatastore('E:\All-Subset-initialFiltered\initial-test50\knife\chs','IncludeSubfolders',true,'FileExtensions','.png','LabelSource','foldernames','ReadFcn',@customReaderImage);
test50eng = imageDatastore('E:\All-Subset-initialFiltered\initial-test50\knife\eng','IncludeSubfolders',true,'FileExtensions','.png','LabelSource','foldernames','ReadFcn',@customReaderImage);

test50chsBOF = encode(bigbag, test50chs); test50engBOF = encode(bigbag, test50eng);
test50chsHu = computeHuMomentsData(test50chs); test50engHu = computeHuMomentsData(test50eng);
test50engHu_log = log(abs(test50engHu)+1e-100); test50chsHu_log = log(abs(test50chsHu)+1e-100);
test50chsColour = computeRGBHistData(test50chs, 4, 0); test50engColour = computeRGBHistData(test50eng, 4, 0);

test50chsZ = computeZernikeMomentData(test50chs); test50engZ = computeZernikeMomentData(test50eng);


test50chsVec = horzcat(test50chsHu_log, test50chsColour, test50chsBOF); test50engVec = horzcat(test50engHu_log, test50engColour, test50engBOF);


test50svmmlpE2C = multisvm2(test50chsVec, test50chs.Labels, test50engVec);
test50svmmlpC2E = multisvm2(test50engVec, test50eng.Labels, test50chsVec);

test50E2C_result = listSVMResult(test50svmmlpE2C, test50eng.Labels); test50C2E_result = listSVMResult(test50svmmlpC2E, test50chs.Labels);

test50svmmlpE2C_BOFonly = multisvm2(test50chsBOF, test50chs.Labels, test50engBOF); test50svmmlpC2E_BOFonly = multisvm2(test50engBOF, test50eng.Labels, test50chsBOF);
test50E2C_BOFonly_result = listSVMResult(test50svmmlpE2C_BOFonly, test50eng.Labels); test50C2E_BOFonly_result = listSVMResult(test50svmmlpC2E_BOFonly, test50chs.Labels);

test50svmmlpE2C_HUonly = multisvm2(test50chsHu_log, test50chs.Labels, test50engHu_log); test50svmmlpC2E_HUonly = multisvm2(test50engHu_log, test50eng.Labels, test50chsHu_log);
test50E2C_HUonly_result = listSVMResult(test50svmmlpE2C_HUonly, test50eng.Labels); test50C2E_HUonly_result = listSVMResult(test50svmmlpC2E_HUonly, test50chs.Labels);

test50svmmlpE2C_Conly = multisvm2(test50chsColour, test50chs.Labels, test50engColour); test50svmmlpC2E_Conly = multisvm2(test50engColour, test50eng.Labels, test50chsColour);
test50E2C_Conly_result = listSVMResult(test50svmmlpE2C_Conly, test50eng.Labels); test50C2E_Conly_result = listSVMResult(test50svmmlpC2E_Conly, test50chs.Labels);

test50svmmlpE2C_Zonly = multisvm2(test50chsZ, test50chs.Labels, test50engZ); test50svmmlpC2E_Zonly = multisvm2(test50engZ, test50eng.Labels, test50chsZ);
test50E2C_Zonly_result = listSVMResult(test50svmmlpE2C_Zonly, test50eng.Labels); test50C2E_Zonly_result = listSVMResult(test50svmmlpC2E_Zonly, test50chs.Labels);

