#!/bin/bash
cd /mnt/methlab-drive/methlab-analysis/anpapa/GLM
SUBJECTS_DIR=/mnt/methlab-drive/methlab-analysis/anpapa/AllSubjects
echo "======================== mris_preproc ========================"
echo "_-_-__-_-__-_-_ lh area _-_-__-_-__-_-_"
mris_preproc --fsgd ClusterASDvHCComparison.fsgd --cache-in area.fwhm10.fsaverage --target fsaverage --hemi lh --out lh.ClusterASDvHCComparison.area.10.mgh
echo "_-_-__-_-__-_-_ lh thickness _-_-__-_-__-_-_"
mris_preproc --fsgd ClusterASDvHCComparison.fsgd --cache-in thickness.fwhm10.fsaverage --target fsaverage --hemi lh --out lh.ClusterASDvHCComparison.thickness.10.mgh
echo "_-_-__-_-__-_-_ rh area _-_-__-_-__-_-_"
mris_preproc --fsgd ClusterASDvHCComparison.fsgd --cache-in area.fwhm10.fsaverage --target fsaverage --hemi rh --out rh.ClusterASDvHCComparison.area.10.mgh
echo "_-_-__-_-__-_-_ rh thickness _-_-__-_-__-_-_"
mris_preproc --fsgd ClusterASDvHCComparison.fsgd --cache-in thickness.fwhm10.fsaverage --target fsaverage --hemi rh --out rh.ClusterASDvHCComparison.thickness.10.mgh

echo "======================== mri_glmfit ========================"
echo "_-_-__-_-__-_-_ lh area _-_-__-_-__-_-_"
mri_glmfit --y lh.ClusterASDvHCComparison.area.10.mgh --fsgd ClusterASDvHCComparison.fsgd dods --surf fsaverage lh --C ClusterASDvHCComparison01-1.mtx --C ClusterASDvHCComparison10-1.mtx --C ClusterASDvHCComparison1-10.mtx --cortex --glmdir lh.ClusterASDvHCComparison.area.10.glmdir
echo "_-_-__-_-__-_-_ lh thickness _-_-__-_-__-_-_"
mri_glmfit --y lh.ClusterASDvHCComparison.thickness.10.mgh --fsgd ClusterASDvHCComparison.fsgd dods --surf fsaverage lh --C ClusterASDvHCComparison01-1.mtx --C ClusterASDvHCComparison10-1.mtx --C ClusterASDvHCComparison1-10.mtx --cortex --glmdir lh.ClusterASDvHCComparison.thickness.10.glmdir
echo "_-_-__-_-__-_-_ rh area _-_-__-_-__-_-_"
mri_glmfit --y rh.ClusterASDvHCComparison.area.10.mgh --fsgd ClusterASDvHCComparison.fsgd dods --surf fsaverage rh --C ClusterASDvHCComparison01-1.mtx --C ClusterASDvHCComparison10-1.mtx --C ClusterASDvHCComparison1-10.mtx --cortex --glmdir rh.ClusterASDvHCComparison.area.10.glmdir
echo "_-_-__-_-__-_-_ rh thickness _-_-__-_-__-_-_"
mri_glmfit --y rh.ClusterASDvHCComparison.thickness.10.mgh --fsgd ClusterASDvHCComparison.fsgd dods --surf fsaverage rh --C ClusterASDvHCComparison01-1.mtx --C ClusterASDvHCComparison10-1.mtx --C ClusterASDvHCComparison1-10.mtx --cortex --glmdir rh.ClusterASDvHCComparison.thickness.10.glmdir

echo "======================== mri_glmfit-sim ========================"
echo "_-_-__-_-__-_-_ lh area _-_-__-_-__-_-_"
mri_glmfit-sim --glmdir lh.ClusterASDvHCComparison.area.10.glmdir --cwp 0.05 --2spaces --perm 5000 3 abs
touch lh.area.sim
echo "_-_-__-_-__-_-_ rh area _-_-__-_-__-_-_"
mri_glmfit-sim --glmdir rh.ClusterASDvHCComparison.area.10.glmdir --cwp 0.05 --2spaces --perm 5000 3 abs
touch rh.area.sim
echo "_-_-__-_-__-_-_ lh thickness _-_-__-_-__-_-_"
mri_glmfit-sim --glmdir lh.ClusterASDvHCComparison.thickness.10.glmdir --cwp 0.05 --2spaces --perm 5000 3 abs
touch lh.thickness.sim
echo "_-_-__-_-__-_-_ rh thickness _-_-__-_-__-_-_"
mri_glmfit-sim --glmdir rh.ClusterASDvHCComparison.thickness.10.glmdir --cwp 0.05 --2spaces --perm 5000 3 abs
touch rh.thickness.sim