all_test50chs = imageDatastore('E:\All-Subset-initialFiltered\initial-test50\all-lesser\chs','IncludeSubfolders',true,'FileExtensions','.png','LabelSource','foldernames','ReadFcn',@customReaderImage);
all_test50eng = imageDatastore('E:\All-Subset-initialFiltered\initial-test50\all-lesser\eng','IncludeSubfolders',true,'FileExtensions','.png','LabelSource','foldernames','ReadFcn',@customReaderImage);

all_test50chsBOF = encode(bigbag, all_test50chs); all_test50engBOF = encode(bigbag, all_test50eng);
all_test50chsHu = computeHuMomentsData(all_test50chs); all_test50engHu = computeHuMomentsData(all_test50eng);
all_test50engHu_log = log(abs(all_test50engHu)+1e-100); all_test50chsHu_log = log(abs(all_test50chsHu)+1e-100);
all_test50chsColour = computeRGBHistData(all_test50chs, 4, 0); all_test50engColour = computeRGBHistData(all_test50eng, 4, 0);

all_test50chsZ = computeZernikeMomentData(all_test50chs); all_test50engZ = computeZernikeMomentData(all_test50eng);


all_test50chsVec = horzcat(all_test50chsHu_log, all_test50chsColour, all_test50chsBOF); all_test50engVec = horzcat(all_test50engHu_log, all_test50engColour, all_test50engBOF);


all_test50svmmlpE2C = multisvm2(all_test50chsVec, all_test50chs.Labels, all_test50engVec);
all_test50svmmlpC2E = multisvm2(all_test50engVec, all_test50eng.Labels, all_test50chsVec);

all_test50E2C_result = listSVMResult(all_test50svmmlpE2C, all_test50eng.Labels); all_test50C2E_result = listSVMResult(all_test50svmmlpC2E, all_test50chs.Labels);

all_test50svmmlpE2C_BOFonly = multisvm2(all_test50chsBOF, all_test50chs.Labels, all_test50engBOF); all_test50svmmlpC2E_BOFonly = multisvm2(all_test50engBOF, all_test50eng.Labels, all_test50chsBOF);
all_test50E2C_BOFonly_result = listSVMResult(all_test50svmmlpE2C_BOFonly, all_test50eng.Labels); all_test50C2E_BOFonly_result = listSVMResult(all_test50svmmlpC2E_BOFonly, all_test50chs.Labels);

all_test50svmmlpE2C_HUonly = multisvm2(all_test50chsHu_log, all_test50chs.Labels, all_test50engHu_log); all_test50svmmlpC2E_HUonly = multisvm2(all_test50engHu_log, all_test50eng.Labels, all_test50chsHu_log);
all_test50E2C_HUonly_result = listSVMResult(all_test50svmmlpE2C_HUonly, all_test50eng.Labels); all_test50C2E_HUonly_result = listSVMResult(all_test50svmmlpC2E_HUonly, all_test50chs.Labels);

all_test50svmmlpE2C_Conly = multisvm2(all_test50chsColour, all_test50chs.Labels, all_test50engColour); all_test50svmmlpC2E_Conly = multisvm2(all_test50engColour, all_test50eng.Labels, all_test50chsColour);
all_test50E2C_Conly_result = listSVMResult(all_test50svmmlpE2C_Conly, all_test50eng.Labels); all_test50C2E_Conly_result = listSVMResult(all_test50svmmlpC2E_Conly, all_test50chs.Labels);

all_test50svmmlpE2C_Zonly = multisvm2(all_test50chsZ, all_test50chs.Labels, all_test50engZ); all_test50svmmlpC2E_Zonly = multisvm2(all_test50engZ, all_test50eng.Labels, all_test50chsZ);
all_test50E2C_Zonly_result = listSVMResult(all_test50svmmlpE2C_Zonly, all_test50eng.Labels); all_test50C2E_Zonly_result = listSVMResult(all_test50svmmlpC2E_Zonly, all_test50chs.Labels);
