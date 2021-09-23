#!/bin/bash
# This file is not intended to be run. It just holds templates for the commands that could be run to create statsfiles through freesurfer

SUBJECTS_DIR=/mnt/methlab_data/HBN/MRI/Site-CBIC_Derivatives_UZH
tree -dai -L 1 /mnt/methlab_data/HBN/MRI/Site-CBIC_Derivatives_UZH | head -n -3 | tail -n +2 > /mnt/exchange/CBICIDs.txt
aparcstats2table --subjectsfile=/mnt/exchange/CBICIDs.txt --hemi=lh --tablefile=/mnt/exchange/CBIC/aparc_stats_CBIC_area_LH.txt --meas area -v --skip
aparcstats2table --subjectsfile=/mnt/exchange/CBICIDs.txt --hemi=rh --tablefile=/mnt/exchange/CBIC/aparc_stats_CBIC_area_RH.txt --meas area -v --skip
aparcstats2table --subjectsfile=/mnt/exchange/CBICIDs.txt --hemi=lh --tablefile=/mnt/exchange/CBIC/aparc_stats_CBIC_thickness_LH.txt --meas thickness -v --skip
aparcstats2table --subjectsfile=/mnt/exchange/CBICIDs.txt --hemi=rh --tablefile=/mnt/exchange/CBIC/aparc_stats_CBIC_thickness_RH.txt --meas thickness -v --skip
SUBJECTS_DIR=/mnt/methlab_data/HBN/MRI/Site-RU_Derivatives_UZH
tree -dai -L 1 /mnt/methlab_data/HBN/MRI/Site-RU_Derivatives_UZH | head -n -3 | tail -n +2 > /mnt/exchange/RUIDs.txt
aparcstats2table --subjectsfile=/mnt/exchange/RUIDs.txt --hemi=lh --tablefile=/mnt/exchange/RU/aparc_stats_RU_area_LH.txt --meas area -v --skip
aparcstats2table --subjectsfile=/mnt/exchange/RUIDs.txt --hemi=rh --tablefile=/mnt/exchange/RU/aparc_stats_RU_area_RH.txt --meas area -v --skip
aparcstats2table --subjectsfile=/mnt/exchange/RUIDs.txt --hemi=lh --tablefile=/mnt/exchange/RU/aparc_stats_RU_thickness_LH.txt --meas thickness -v --skip
aparcstats2table --subjectsfile=/mnt/exchange/RUIDs.txt --hemi=rh --tablefile=/mnt/exchange/RU/aparc_stats_RU_thickness_RH.txt --meas thickness -v --skip
SUBJECTS_DIR=/mnt/methlab_data/HBN/MRI/Site-SI_Derivatives_UZH
tree -dai -L 1 /mnt/methlab_data/HBN/MRI/Site-SI_Derivatives_UZH | head -n -3 | tail -n +2 > /mnt/exchange/SIIDs.txt
aparcstats2table --subjectsfile=/mnt/exchange/SIIDs.txt --hemi=lh --tablefile=/mnt/exchange/SI/aparc_stats_SI_area_LH.txt --meas area -v --skip
aparcstats2table --subjectsfile=/mnt/exchange/SIIDs.txt --hemi=rh --tablefile=/mnt/exchange/SI/aparc_stats_SI_area_RH.txt --meas area -v --skip
aparcstats2table --subjectsfile=/mnt/exchange/SIIDs.txt --hemi=lh --tablefile=/mnt/exchange/SI/aparc_stats_SI_thickness_LH.txt --meas thickness -v --skip
aparcstats2table --subjectsfile=/mnt/exchange/SIIDs.txt --hemi=rh --tablefile=/mnt/exchange/SI/aparc_stats_SI_thickness_RH.txt --meas thickness -v --skip


SUBJECTS_DIR=/mnt/methlabdata/HBN/MRI/Site-CBIC_Derivatives_UZH
tree -dai -L 1 /mnt/methlabdata/HBN/MRI/Site-CBIC_Derivatives_UZH | head -n -3 | tail -n +2 > /mnt/exchange/CBICIDs.txt
asegstats2table --subjectsfile=/mnt/exchange/CBICIDs.txt --tablefile=/mnt/exchange/CBIC/aseg_stats_CBIC_area.txt --meas volume -v --skip
aparcstats2table --subjectsfile=/mnt/exchange/CBICIDs.txt --hemi=lh --tablefile=/mnt/exchange/CBIC/aparc_stats_CBIC_area_LH.txt --meas area -v --skip
aparcstats2table --subjectsfile=/mnt/exchange/CBICIDs.txt --hemi=rh --tablefile=/mnt/exchange/CBIC/aparc_stats_CBIC_area_RH.txt --meas area -v --skip
aparcstats2table --subjectsfile=/mnt/exchange/CBICIDs.txt --hemi=lh --tablefile=/mnt/exchange/CBIC/aparc_stats_CBIC_thickness_LH.txt --meas thickness -v --skip
aparcstats2table --subjectsfile=/mnt/exchange/CBICIDs.txt --hemi=rh --tablefile=/mnt/exchange/CBIC/aparc_stats_CBIC_thickness_RH.txt --meas thickness -v --skip
SUBJECTS_DIR=/mnt/methlabdata/HBN/MRI/Site-RU_Derivatives_UZH
tree -dai -L 1 /mnt/methlabdata/HBN/MRI/Site-RU_Derivatives_UZH | head -n -3 | tail -n +2 > /mnt/exchange/RUIDs.txt
asegstats2table --subjectsfile=/mnt/exchange/RUIDs.txt --tablefile=/mnt/exchange/RU/aseg_stats_CBIC_area.txt --meas volume -v --skip
aparcstats2table --subjectsfile=/mnt/exchange/RUIDs.txt --hemi=lh --tablefile=/mnt/exchange/RU/aparc_stats_RU_area_LH.txt --meas area -v --skip
aparcstats2table --subjectsfile=/mnt/exchange/RUIDs.txt --hemi=rh --tablefile=/mnt/exchange/RU/aparc_stats_RU_area_RH.txt --meas area -v --skip
aparcstats2table --subjectsfile=/mnt/exchange/RUIDs.txt --hemi=lh --tablefile=/mnt/exchange/RU/aparc_stats_RU_thickness_LH.txt --meas thickness -v --skip
aparcstats2table --subjectsfile=/mnt/exchange/RUIDs.txt --hemi=rh --tablefile=/mnt/exchange/RU/aparc_stats_RU_thickness_RH.txt --meas thickness -v --skip
SUBJECTS_DIR=/mnt/methlabdata/HBN/MRI/Site-SI_Derivatives_UZH
tree -dai -L 1 /mnt/methlabdata/HBN/MRI/Site-SI_Derivatives_UZH | head -n -3 | tail -n +2 > /mnt/exchange/SIIDs.txt
asegstats2table --subjectsfile=/mnt/exchange/SIIDs.txt --tablefile=/mnt/exchange/SI/aseg_stats_CBIC_area.txt --meas volume -v --skip
aparcstats2table --subjectsfile=/mnt/exchange/SIIDs.txt --hemi=lh --tablefile=/mnt/exchange/SI/aparc_stats_SI_area_LH.txt --meas area -v --skip
aparcstats2table --subjectsfile=/mnt/exchange/SIIDs.txt --hemi=rh --tablefile=/mnt/exchange/SI/aparc_stats_SI_area_RH.txt --meas area -v --skip
aparcstats2table --subjectsfile=/mnt/exchange/SIIDs.txt --hemi=lh --tablefile=/mnt/exchange/SI/aparc_stats_SI_thickness_LH.txt --meas thickness -v --skip
aparcstats2table --subjectsfile=/mnt/exchange/SIIDs.txt --hemi=rh --tablefile=/mnt/exchange/SI/aparc_stats_SI_thickness_RH.txt --meas thickness -v --skip
SUBJECTS_DIR=/mnt/methlabdata/HBN/MRI/Site-CUNY_Derivatives_UZH
tree -dai -L 1 /mnt/methlabdata/HBN/MRI/Site-CUNY_Derivatives_UZH | head -n -3 | tail -n +2 > /mnt/exchange/CUNYIDs.txt
asegstats2table --subjectsfile=/mnt/exchange/CUNYIDs.txt --tablefile=/mnt/exchange/CUNY/aseg_stats_CUNY_area.txt --meas volume -v --skip
aparcstats2table --subjectsfile=/mnt/exchange/CUNYIDs.txt --hemi=lh --tablefile=/mnt/exchange/CUNY/aparc_stats_CUNY_area_LH.txt --meas area -v --skip
aparcstats2table --subjectsfile=/mnt/exchange/CUNYIDs.txt --hemi=rh --tablefile=/mnt/exchange/CUNY/aparc_stats_CUNY_area_RH.txt --meas area -v --skip
aparcstats2table --subjectsfile=/mnt/exchange/CUNYIDs.txt --hemi=lh --tablefile=/mnt/exchange/CUNY/aparc_stats_CUNY_thickness_LH.txt --meas thickness -v --skip
aparcstats2table --subjectsfile=/mnt/exchange/CUNYIDs.txt --hemi=rh --tablefile=/mnt/exchange/CUNY/aparc_stats_CUNY_thickness_RH.txt --meas thickness -v --skip