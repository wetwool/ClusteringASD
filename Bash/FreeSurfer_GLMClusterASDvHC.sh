SUBJECTS_DIR=/mnt/methlab-drive/methlab-analysis/anpapa/AllSubjects
mris_preproc --fsgd ClusterASDvHCComparison.fsgd --cache-in area.fwhm10.fsaverage --target fsaverage --hemi lh --out lh.ClusterASDvHCComparison.area.10.mgh
mri_glmfit --y lh.ClusterASDvHCComparison.area.10.mgh --fsgd ClusterASDvHCComparison.fsgd dods --surf fsaverage lh --C ClusterASDvHCComparison01-1.mtx --C ClusterASDvHCComparison10-1.mtx --C ClusterASDvHCComparison1-10.mtx --cortex --glmdir lh.ClusterASDvHCComparison.area.10.glmdir

mris_preproc --fsgd ClusterASDvHCComparison.fsgd --cache-in thickness.fwhm10.fsaverage --target fsaverage --hemi lh --out lh.ClusterASDvHCComparison.thickness.10.mgh
mri_glmfit --y lh.ClusterASDvHCComparison.thickness.10.mgh --fsgd ClusterASDvHCComparison.fsgd dods --surf fsaverage lh --C ClusterASDvHCComparison01-1.mtx --C ClusterASDvHCComparison10-1.mtx --C ClusterASDvHCComparison1-10.mtx --cortex --glmdir lh.ClusterASDvHCComparison.thickness.10.glmdir

mris_preproc --fsgd ClusterASDvHCComparison.fsgd --cache-in area.fwhm10.fsaverage --target fsaverage --hemi rh --out rh.ClusterASDvHCComparison.area.10.mgh
mri_glmfit --y rh.ClusterASDvHCComparison.area.10.mgh --fsgd ClusterASDvHCComparison.fsgd dods --surf fsaverage rh --C ClusterASDvHCComparison01-1.mtx --C ClusterASDvHCComparison10-1.mtx --C ClusterASDvHCComparison1-10.mtx --cortex --glmdir rh.ClusterASDvHCComparison.area.10.glmdir

mris_preproc --fsgd ClusterASDvHCComparison.fsgd --cache-in thickness.fwhm10.fsaverage --target fsaverage --hemi rh --out rh.ClusterASDvHCComparison.thickness.10.mgh
mri_glmfit --y rh.ClusterASDvHCComparison.thickness.10.mgh --fsgd ClusterASDvHCComparison.fsgd dods --surf fsaverage rh --C ClusterASDvHCComparison01-1.mtx --C ClusterASDvHCComparison10-1.mtx --C ClusterASDvHCComparison1-10.mtx --cortex --glmdir rh.ClusterASDvHCComparison.thickness.10.glmdir

mri_glmfit --y lh.ClusterASDvHCComparison.area.10.mgh --fsgd ClusterASDvHCComparison.fsgd dods --surf fsaverage lh --C ClusterASDvHCComparison01-1.mtx --C ClusterASDvHCComparison10-1.mtx --C ClusterASDvHCComparison1-10.mtx --cortex --glmdir lh.ClusterASDvHCComparison.area.10.glmdir --sim perm 10 4 abs

mri_glmfit-sim --glmdir lh.ClusterASDvHCComparison.area.10.glmdir --cwp 0.05 --2spaces --perm 1000 3 abs
mri_glmfit-sim --glmdir rh.ClusterASDvHCComparison.area.10.glmdir --cwp 0.05 --2spaces --perm 1000 3 abs
mri_glmfit-sim --glmdir lh.ClusterASDvHCComparison.thickness.10.glmdir --cwp 0.05 --2spaces --perm 1000 3 abs
mri_glmfit-sim --glmdir rh.ClusterASDvHCComparison.thickness.10.glmdir --cwp 0.05 --2spaces --perm 1000 3 abs
