function makeOverlappingRoi
% this is a small function to store.
% the idea is it takes the given two .nii files, binarise them
% then only keep the overlapping part (as 1s), and zeros assigned to
% non-overlapping part
% so it can be visualised as a thirs ROI/.nii result in workbench
% side note: for workbench to visualise surface maps, more steps are
% needed: 
% - Brain templates: Conte69_atlas_164k_wb
% - wb_command volume-to-surface-mapping (see wb.docx stored in Dp)

% let's make for our overlap ROI 

% add cpp-spm which has nifti-toolbox 
run ../lib/CPP_SPM/initCppSpm.m;

  
% 17.08.2021 CB
pathToRois = '/Users/battal/Cerens_files/fMRI/Processed/MT_TMS/derivatives/cpp_spm-stats/group/';

roi1Path = fullfile(pathToRois, ...
    'task-visualLocalizer_space-MNI_FWHM-6_conFWHM-8/motion_gt_static');
roi2Path = fullfile(pathToRois, ...
    'task-auditoryLocalizer_space-MNI_FWHM-6_conFWHM-8/motion_gt_static');

% define the names & load the rois
roi1Name = 'Group_motionvsstatic_uncorr_p00001.nii';
roi1 = load_nii(fullfile(roi1Path,roi1Name));


roi2Name = 'Group_motionvsstatic_uncorr_p00001.nii';
roi2 = load_nii(fullfile(roi2Path,roi2Name));

roi3Name = 'Group_motionstatic_overlapAudVis.nii';

% make binary rois
% assign zero to all smaller then 0 values
roi1.img (abs(roi1.img) >0 ) = 1;
roi1.img (roi1.img ~=1) = 0;
roi2.img (abs(roi2.img) >0 ) = 1;
roi2.img (roi2.img ~=1) = 0;



temp = roi1;
temp.fileprefix = 'temp';
temp.img = [];

% mask out the non-common areas
temp.img = roi1.img + roi2.img;
temp.img(temp.img < 2) = 0;
temp.img(temp.img == 2) = 1;

% save binary overlap roi
save_nii(temp, fullfile(pathToRois,roi3Name));
      
