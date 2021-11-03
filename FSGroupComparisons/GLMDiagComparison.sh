SUBJECTS_DIR=/mnt/methlab-drive/methlab-analysis/anpapa/AllSubjects
mris_preproc --fsgd DiagComparison.fsgd --cache-in area.fwhm10.fsaverage --target fsaverage --hemi lh --out lh.DiagComparison.area.10.mgh
mri_glmfit --y lh.DiagComparison.area.10.mgh --fsgd DiagComparison.fsgd dods --surf fsaverage lh --C  DiagDifferences.mtx --cortex --glmdir lh.DiagComparison.area.10.glmdir
mri_glmfit-sim --glmdir lh.DiagComparison.area.10.glmdir --cache 4 abs --cwp 0.05 --2spaces
SUBJECTS_DIR=/mnt/methlab-drive/methlab-analysis/anpapa/AllSubjects
mris_preproc --fsgd DiagComparison.fsgd --cache-in thickness.fwhm10.fsaverage --target fsaverage --hemi lh --out lh.DiagComparison.thickness.10.mgh
mri_glmfit --y lh.DiagComparison.thickness.10.mgh --fsgd DiagComparison.fsgd dods --surf fsaverage lh --C  DiagDifferences.mtx --cortex --glmdir lh.DiagComparison.thickness.10.glmdir
mri_glmfit-sim --glmdir lh.DiagComparison.thickness.10.glmdir --cache 4 abs --cwp 0.05 --2spaces
SUBJECTS_DIR=/mnt/methlab-drive/methlab-analysis/anpapa/AllSubjects
mris_preproc --fsgd DiagComparison.fsgd --cache-in area.fwhm10.fsaverage --target fsaverage --hemi rh --out rh.DiagComparison.area.10.mgh
mri_glmfit --y rh.DiagComparison.area.10.mgh --fsgd DiagComparison.fsgd dods --surf fsaverage rh --C  DiagDifferences.mtx --cortex --glmdir rh.DiagComparison.area.10.glmdir
mri_glmfit-sim --glmdir rh.DiagComparison.area.10.glmdir --cache 4 abs --cwp 0.05 --2spaces
SUBJECTS_DIR=/mnt/methlab-drive/methlab-analysis/anpapa/AllSubjects
mris_preproc --fsgd DiagComparison.fsgd --cache-in thickness.fwhm10.fsaverage --target fsaverage --hemi rh --out rh.DiagComparison.thickness.10.mgh
mri_glmfit --y rh.DiagComparison.thickness.10.mgh --fsgd DiagComparison.fsgd dods --surf fsaverage rh --C  DiagDifferences.mtx --cortex --glmdir rh.DiagComparison.thickness.10.glmdir
mri_glmfit-sim --glmdir rh.DiagComparison.thickness.10.glmdir --cache 4 abs --cwp 0.05 --2spaces
