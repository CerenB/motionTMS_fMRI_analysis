
% add conn toolbox into the path
addpath(genpath('/Users/battal/Documents/MATLAB/conn'));

% add spm 
warning('off');
addpath(genpath('/Users/battal/Documents/MATLAB/spm12'));

% define the result SPM.mat or .nii path
resultPath = '/Users/battal/Cerens_files/fMRI/Processed/MT_TMS/derivatives/cpp_spm-stats/group/task-visualLocalizer_space-MNI_FWHM-6_conFWHM-8/motion_gt_static';

% display single spm map
hf = conn_display(fullfile(resultPath,'SPM.mat'));
conn_display(hf, 'fwec.voxellevel.type', 1);
conn_display(hf, 'fwec.voxellevel.value', 0.0001);

% h = conn_display('SPM.mat',1); % loads second-level results
% conn_display(h,'vox-thr',{.005,1}); % sets voxel-level threshold (p-uncorrected < .005)
% conn_display(h,'clu-thr',{.05,3}); % sets cluster-level threshold (p-FDR<.05)
% conn_display(h,'switch',1); % sets one-sided positive stats
% conn_display(h,'export_mask','masfilenamePos.nii'); % exports mask file
% conn_display(h,'switch',2); % sets one-sided negative stats
% conn_display(h,'export_mask','masfilenameNeg.nii'); % exports mask file

%display single file - does not work.
resultsNiiFile = 'Group_motionvsstatic_uncorr_p00001.nii';
conn_display(fullfile(resultPath,resultsNiiFile));

%display single file - does not work.
% I think when it's not analysed by CONN, we cannot simply display t-maps.
resultsNiiFile = 'spmT_0001.nii';
conn_display(fullfile(resultPath,resultsNiiFile));

% display multiple slices in one SPM.mat
fh = conn_slice_display(fullfile(resultPath,resultsNiiFile)); 
fh('pointer_mm',[0 0 10]); 
fh('multisliceset',true,16,8); 
fh('togglegui',true); 



% mesh display - works
% the reference cortical surface -surfaces derived from the 
% ICBM MNI 2009b NLIN asymmetric template
resultsNiiFile = 'spmT_0001.nii';
fh = conn_mesh_display(fullfile(resultPath,resultsNiiFile)); 


resultsNiiFile = 'Group_motionvsstatic_uncorr_p00001.nii';
h = conn_mesh_display(fullfile(resultPath,resultsNiiFile)); 








