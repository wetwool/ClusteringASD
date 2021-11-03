SUBJECTS_DIR=/mnt/methlab-drive/methlab-analysis/anpapa/AllSubjects
mris_preproc --fsgd ASDComparison.fsgd --cache-in area.fwhm10.fsaverage --target fsaverage --hemi lh --out lh.ASDComparison.area.10.mgh
mri_glmfit --y lh.ASDComparison.area.10.mgh --fsgd ASDComparison.fsgd dods --surf fsaverage lh --C  ASD1vsASD2.mtx --C  ASD1vsHC.mtx --C  ASD2vsHC.mtx  --cortex --glmdir lh.ASDComparison.area.10.glmdir
mri_glmfit-sim --glmdir lh.ASDComparison.area.10.glmdir --cache 4 abs --cwp 0.05 --2spaces
SUBJECTS_DIR=/mnt/methlab-drive/methlab-analysis/anpapa/AllSubjects
mris_preproc --fsgd ASDComparison.fsgd --cache-in thickness.fwhm10.fsaverage --target fsaverage --hemi lh --out lh.ASDComparison.thickness.10.mgh
mri_glmfit --y lh.ASDComparison.thickness.10.mgh --fsgd ASDComparison.fsgd dods --surf fsaverage lh --C  ASD1vsASD2.mtx --C  ASD1vsHC.mtx --C  ASD2vsHC.mtx  --cortex --glmdir lh.ASDComparison.thickness.10.glmdir
mri_glmfit-sim --glmdir lh.ASDComparison.thickness.10.glmdir --cache 4 abs --cwp 0.05 --2spaces
SUBJECTS_DIR=/mnt/methlab-drive/methlab-analysis/anpapa/AllSubjects
mris_preproc --fsgd ASDComparison.fsgd --cache-in area.fwhm10.fsaverage --target fsaverage --hemi rh --out rh.ASDComparison.area.10.mgh
mri_glmfit --y rh.ASDComparison.area.10.mgh --fsgd ASDComparison.fsgd dods --surf fsaverage rh --C  ASD1vsASD2.mtx --C  ASD1vsHC.mtx --C  ASD2vsHC.mtx --cortex --glmdir rh.ASDComparison.area.10.glmdir
mri_glmfit-sim --glmdir rh.ASDComparison.area.10.glmdir --cache 4 abs --cwp 0.05 --2spaces
SUBJECTS_DIR=/mnt/methlab-drive/methlab-analysis/anpapa/AllSubjects
mris_preproc --fsgd ASDComparison.fsgd --cache-in thickness.fwhm10.fsaverage --target fsaverage --hemi rh --out rh.ASDComparison.thickness.10.mgh
mri_glmfit --y rh.ASDComparison.thickness.10.mgh --fsgd ASDComparison.fsgd dods --surf fsaverage rh --C  ASD1vsASD2.mtx --C  ASD1vsHC.mtx --C  ASD2vsHC.mtx --cortex --glmdir rh.ASDComparison.thickness.10.glmdir
mri_glmfit-sim --glmdir rh.ASDComparison.thickness.10.glmdir --cache 4 abs --cwp 0.05 --2spaces
