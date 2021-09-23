#!/bin/bash
# This file is not intended to be run. It just holds templates for the commands that could be run to do a surface based GLM with FreeSurfer 
# See https://surfer.nmr.mgh.harvard.edu/fswiki/FsTutorial/GroupAnalysis for more information 
echo "This file is not intended to be run"
make_average_subject --out RUaverage --sd-out /mnt/exchange/avg/ --fsgd /mnt/exchange/ASDanatomy_ALL_SI.fsgd --force --echo
mris_preproc --fsgd ASDanatomy_ALL_SI.fsgd   --cache-in thickness.fwhm10.fsaverage   --target sub-NDARAA306NT2_acq-HCP_T1w   --hemi lh   --out lh.ASD_ASSQ.thickness.10.mgh
mri_glmfit   --y lh.ASD_ASSQ.thickness.10.mgh   --fsgd ASDanatomy_ALL_SI.fsgd dods  --C lh-Avg-thickness-ASSQ.mtx   --surf sub-NDARAA948VFH_acq-HCP_T1w lh   --cortex   --glmdir lh.clust_ASSQ.glmdir

