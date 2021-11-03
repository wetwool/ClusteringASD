SUBJECTS_DIR=/mnt/methlab-drive/methlab-analysis/anpapa/AllSubjects
mris_preproc --fsgd ASDComparisonSNR.fsgd --cache-in area.fwhm10.fsaverage --target fsaverage --hemi lh --out lh.ASDComparisonSNR.area.10.mgh
mri_glmfit --y lh.ASDComparisonSNR.area.10.mgh --fsgd ASDComparisonSNR.fsgd dods --surf fsaverage lh --C  GroupDifferencesCov.mtx --cortex --glmdir lh.ASDComparisonSNR.area.10.glmdir
mri_glmfit-sim --glmdir lh.ASDComparisonSNR.area.10.glmdir --cache 4 abs --cwp 0.05 --2spaces
SUBJECTS_DIR=/mnt/methlab-drive/methlab-analysis/anpapa/AllSubjects
mris_preproc --fsgd ASDComparisonSNR.fsgd --cache-in thickness.fwhm10.fsaverage --target fsaverage --hemi lh --out lh.ASDComparisonSNR.thickness.10.mgh
mri_glmfit --y lh.ASDComparisonSNR.thickness.10.mgh --fsgd ASDComparisonSNR.fsgd dods --surf fsaverage lh --C  GroupDifferencesCov.mtx --cortex --glmdir lh.ASDComparisonSNR.thickness.10.glmdir
mri_glmfit-sim --glmdir lh.ASDComparisonSNR.thickness.10.glmdir --cache 4 abs --cwp 0.05 --2spaces
SUBJECTS_DIR=/mnt/methlab-drive/methlab-analysis/anpapa/AllSubjects
mris_preproc --fsgd ASDComparisonSNR.fsgd --cache-in area.fwhm10.fsaverage --target fsaverage --hemi rh --out rh.ASDComparisonSNR.area.10.mgh
mri_glmfit --y rh.ASDComparisonSNR.area.10.mgh --fsgd ASDComparisonSNR.fsgd dods --surf fsaverage rh --C  GroupDifferencesCov.mtx --cortex --glmdir rh.ASDComparisonSNR.area.10.glmdir
mri_glmfit-sim --glmdir rh.ASDComparisonSNR.area.10.glmdir --cache 4 abs --cwp 0.05 --2spaces
SUBJECTS_DIR=/mnt/methlab-drive/methlab-analysis/anpapa/AllSubjects
mris_preproc --fsgd ASDComparisonSNR.fsgd --cache-in thickness.fwhm10.fsaverage --target fsaverage --hemi rh --out rh.ASDComparisonSNR.thickness.10.mgh
mri_glmfit --y rh.ASDComparisonSNR.thickness.10.mgh --fsgd ASDComparisonSNR.fsgd dods --surf fsaverage rh --C  GroupDifferencesCov.mtx --cortex --glmdir rh.ASDComparisonSNR.thickness.10.glmdir
mri_glmfit-sim --glmdir rh.ASDComparisonSNR.thickness.10.glmdir --cache 4 abs --cwp 0.05 --2spaces
