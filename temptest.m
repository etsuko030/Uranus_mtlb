knife1_c = imageDatastore('E:\All-Subset-initialFiltered\initial-separated\knife\chs','IncludeSubfolders',true,'FileExtensions','.png','LabelSource','foldernames','ReadFcn',@customReaderImage);
knife1_e = imageDatastore('E:\All-Subset-initialFiltered\initial-separated\knife\eng','IncludeSubfolders',true,'FileExtensions','.png','LabelSource','foldernames','ReadFcn',@customReaderImage);

knife_ini_c_Z = computeZernikeMomentData(knife_ini_c);
knife_ini_e_Z = computeZernikeMomentData(knife_ini_e);

knife_ini_c_H = log(abs(computeHuMomentsData(knife_ini_c))+1e-100);
knife_ini_e_H = log(abs(computeHuMomentsData(knife_ini_e))+1e-100);

knife_ini_c_BOF = encode(bigbag, knife_ini_c);
knife_ini_e_BOF = encode(bigbag, knife_ini_e);

knife_ini_c_Co = computeRGBHistData(knife_ini_c, 4, 0);
knife_ini_e_Co = computeRGBHistData(knife_ini_e, 4, 0);

knife_ini_c_svmmlp_H = multisvm2(knife_ini_c_H, knife_ini_c.Labels, knife_ini_e_H); % chs as training
knife_ini_e_svmmlp_H = multisvm2(knife_ini_e_H, knife_ini_e.Labels, knife_ini_c_H); % eng as training

knife_ini_c_svmmlp_Z = multisvm2(knife_ini_c_Z, knife_ini_c.Labels, knife_ini_e_Z); 
knife_ini_e_svmmlp_Z = multisvm2(knife_ini_e_Z, knife_ini_e.Labels, knife_ini_c_Z); 

knife_ini_c_H_res = listSVMResult(knife_ini_c_svmmlp_H, knife_ini_e.Labels); 
knife_ini_e_H_res = listSVMResult(knife_ini_e_svmmlp_H, knife_ini_c.Labels); 
knife_ini_c_Z_res = listSVMResult(knife_ini_c_svmmlp_Z, knife_ini_e.Labels); 
knife_ini_e_Z_res = listSVMResult(knife_ini_e_svmmlp_Z, knife_ini_c.Labels); 

knife1_c_BOF = encode(bigbag, knife1_c); knife1_e_BOF = encode(bigbag, knife1_e);

trees_100_c_Z = TreeBagger(100, knife1_c_Z, knife1_c.Labels); trees_100_e_Z = TreeBagger(100, knife1_e_Z, knife1_e.Labels);
treebagger_c_Z = predict(trees_100_c_Z, knife1_e_Z); treebagger_e_Z = predict(trees_100_e_Z, knife1_c_Z);
trees_e_Z_res = listSVMResult(categorical(treebagger_e_Z), knife1_c.Labels); trees_c_Z_res = listSVMResult(categorical(treebagger_c_Z), knife1_e.Labels);




set_01_eng = imageDatastore('E:\_raw_cropped_only\01\eng','IncludeSubfolders',true,'FileExtensions','.png','LabelSource','foldernames','ReadFcn',@customReaderImage2);
set_02_eng = imageDatastore('E:\_raw_cropped_only\02\eng','IncludeSubfolders',true,'FileExtensions','.png','LabelSource','foldernames','ReadFcn',@customReaderImage2);
set_03_eng = imageDatastore('E:\_raw_cropped_only\03\eng','IncludeSubfolders',true,'FileExtensions','.png','LabelSource','foldernames','ReadFcn',@customReaderImage2);
set_01_chs = imageDatastore('E:\_raw_cropped_only\01\chs','IncludeSubfolders',true,'FileExtensions','.png','LabelSource','foldernames','ReadFcn',@customReaderImage2);
set_02_chs = imageDatastore('E:\_raw_cropped_only\02\chs','IncludeSubfolders',true,'FileExtensions','.png','LabelSource','foldernames','ReadFcn',@customReaderImage2);
set_03_chs = imageDatastore('E:\_raw_cropped_only\03\chs','IncludeSubfolders',true,'FileExtensions','.png','LabelSource','foldernames','ReadFcn',@customReaderImage2);


bof_20000_01 = bagOfFeatures(set_01_eng, 'CustomExtractor', @bofExtractorSIFT, 'VocabularySize', 20000, 'StrongestFeatures', 1);
bof_20000_02 = bagOfFeatures(set_02_eng, 'CustomExtractor', @bofExtractorSIFT, 'VocabularySize', 20000, 'StrongestFeatures', 1);
bof_20000_03 = bagOfFeatures(set_03_eng, 'CustomExtractor', @bofExtractorSIFT, 'VocabularySize', 20000, 'StrongestFeatures', 1);


sift_bof_01_chs = encode(bof_20000_01, set_01_chs, 'Normalization', 'none');
sift_bof_01_eng = encode(bof_20000_01, set_01_eng, 'Normalization', 'none'); %

sift_bof_02_chs = encode(bof_20000_02, set_02_chs, 'Normalization', 'none');
sift_bof_02_eng = encode(bof_20000_02, set_02_eng, 'Normalization', 'none');

sift_bof_03_chs = encode(bof_20000_03, set_03_chs, 'Normalization', 'none');
sift_bof_03_eng = encode(bof_20000_03, set_03_eng, 'Normalization', 'none');