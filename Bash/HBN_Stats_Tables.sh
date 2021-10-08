#!/bin/bash
# This file is not intended to be run. It just holds templates for the commands that could be run to create statsfiles through freesurfer

SUBJECTS_DIR=/mnt/methlab-drive/methlab_data/HBN/MRI/Site-CBIC_Derivatives_UZH/
tree -dai -L 1 /mnt/methlab-drive/methlab_data/HBN/MRI/Site-CBIC_Derivatives_UZH/ | head -n -3 | tail -n +3 > /mnt/methlab-drive/methlab-analysis/anpapa/CBICIDs.txt
aparcstats2table --subjectsfile=/mnt/methlab-drive/methlab-analysis/anpapa//CBICIDs.txt --hemi=lh --tablefile=/mnt/methlab-drive/methlab-analysis/anpapa/CBIC/aparc_stats_CBIC_area_LH.txt --meas area -v --skip
aparcstats2table --subjectsfile=/mnt/methlab-drive/methlab-analysis/anpapa//CBICIDs.txt --hemi=rh --tablefile=/mnt/methlab-drive/methlab-analysis/anpapa/CBIC/aparc_stats_CBIC_area_RH.txt --meas area -v --skip
aparcstats2table --subjectsfile=/mnt/methlab-drive/methlab-analysis/anpapa//CBICIDs.txt --hemi=lh --tablefile=/mnt/methlab-drive/methlab-analysis/anpapa/CBIC/aparc_stats_CBIC_thickness_LH.txt --meas thickness -v --skip
aparcstats2table --subjectsfile=/mnt/methlab-drive/methlab-analysis/anpapa//CBICIDs.txt --hemi=rh --tablefile=/mnt/methlab-drive/methlab-analysis/anpapa/CBIC/aparc_stats_CBIC_thickness_RH.txt --meas thickness -v --skip
SUBJECTS_DIR=/mnt/methlab-drive/methlab_data/HBN/MRI/Site-RU_Derivatives_UZH/
tree -dai -L 1 /mnt/methlab-drive/methlab_data/HBN/MRI/Site-RU_Derivatives_UZH/ | head -n -3 | tail -n +3 > /mnt/methlab-drive/methlab-analysis/anpapa/RUIDs.txt
aparcstats2table --subjectsfile=/mnt/methlab-drive/methlab-analysis/anpapa//RUIDs.txt --hemi=lh --tablefile=/mnt/methlab-drive/methlab-analysis/anpapa/RU/aparc_stats_RU_area_LH.txt --meas area -v --skip
aparcstats2table --subjectsfile=/mnt/methlab-drive/methlab-analysis/anpapa//RUIDs.txt --hemi=rh --tablefile=/mnt/methlab-drive/methlab-analysis/anpapa/RU/aparc_stats_RU_area_RH.txt --meas area -v --skip
aparcstats2table --subjectsfile=/mnt/methlab-drive/methlab-analysis/anpapa//RUIDs.txt --hemi=lh --tablefile=/mnt/methlab-drive/methlab-analysis/anpapa/RU/aparc_stats_RU_thickness_LH.txt --meas thickness -v --skip
aparcstats2table --subjectsfile=/mnt/methlab-drive/methlab-analysis/anpapa//RUIDs.txt --hemi=rh --tablefile=/mnt/methlab-drive/methlab-analysis/anpapa/RU/aparc_stats_RU_thickness_RH.txt --meas thickness -v --skip
SUBJECTS_DIR=/mnt/methlab-drive/methlab_data/HBN/MRI/Site-SI_Derivatives_UZH/
tree -dai -L 1 /mnt/methlab-drive/methlab_data/HBN/MRI/Site-SI_Derivatives_UZH/ | head -n -3 | tail -n +3 > /mnt/methlab-drive/methlab-analysis/anpapa/SIIDs.txt
aparcstats2table --subjectsfile=/mnt/methlab-drive/methlab-analysis/anpapa/SIIDs.txt --hemi=lh --tablefile=/mnt/methlab-drive/methlab-analysis/anpapa/SI/aparc_stats_SI_area_LH.txt --meas area -v --skip
aparcstats2table --subjectsfile=/mnt/methlab-drive/methlab-analysis/anpapa/SIIDs.txt --hemi=rh --tablefile=/mnt/methlab-drive/methlab-analysis/anpapa/SI/aparc_stats_SI_area_RH.txt --meas area -v --skip
aparcstats2table --subjectsfile=/mnt/methlab-drive/methlab-analysis/anpapa/SIIDs.txt --hemi=lh --tablefile=/mnt/methlab-drive/methlab-analysis/anpapa/SI/aparc_stats_SI_thickness_LH.txt --meas thickness -v --skip
aparcstats2table --subjectsfile=/mnt/methlab-drive/methlab-analysis/anpapa/SIIDs.txt --hemi=rh --tablefile=/mnt/methlab-drive/methlab-analysis/anpapa/SI/aparc_stats_SI_thickness_RH.txt --meas thickness -v --skip
SUBJECTS_DIR=/mnt/methlab-drive/methlab_data/HBN/MRI/Site-CUNY_Derivatives_UZH/
tree -dai -L 1 /mnt/methlab-drive/methlab_data/HBN/MRI/Site-CUNY_Derivatives_UZH/ | head -n -3 | tail -n +3 > /mnt/methlab-drive/methlab-analysis/anpapa/CUNYIDs.txt
aparcstats2table --subjectsfile=/mnt/methlab-drive/methlab-analysis/anpapa/CUNYIDs.txt --hemi=lh --tablefile=/mnt/methlab-drive/methlab-analysis/anpapa/CUNY/aparc_stats_CUNY_area_LH.txt --meas area -v --skip
aparcstats2table --subjectsfile=/mnt/methlab-drive/methlab-analysis/anpapa/CUNYIDs.txt --hemi=rh --tablefile=/mnt/methlab-drive/methlab-analysis/anpapa/CUNY/aparc_stats_CUNY_area_RH.txt --meas area -v --skip
aparcstats2table --subjectsfile=/mnt/methlab-drive/methlab-analysis/anpapa/CUNYIDs.txt --hemi=lh --tablefile=/mnt/methlab-drive/methlab-analysis/anpapa/CUNY/aparc_stats_CUNY_thickness_LH.txt --meas thickness -v --skip
aparcstats2table --subjectsfile=/mnt/methlab-drive/methlab-analysis/anpapa/CUNYIDs.txt --hemi=rh --tablefile=/mnt/methlab-drive/methlab-analysis/anpapa/CUNY/aparc_stats_CUNY_thickness_RH.txt --meas thickness -v --skip


SUBJECTS_DIR=/mnt/methlab-drive/methlab_data/HBN/MRI/Site-CBIC_Derivatives_UZH/
asegstats2table --subjectsfile=/mnt/methlab-drive/methlab-analysis/anpapa/CBICIDs.txt --tablefile=/mnt/methlab-drive/methlab-analysis/anpapa//CBIC/aseg_stats_CBIC_area.txt --meas volume -v --skip
SUBJECTS_DIR=/mnt/methlab-drive/methlab_data/HBN/MRI/Site-RU_Derivatives_UZH/
asegstats2table --subjectsfile=/mnt/methlab-drive/methlab-analysis/anpapa/RUIDs.txt --tablefile=/mnt/methlab-drive/methlab-analysis/anpapa//RU/aseg_stats_CBIC_area.txt --meas volume -v --skip
SUBJECTS_DIR=/mnt/methlab-drive/methlab_data/HBN/MRI/Site-SI_Derivatives_UZH/
asegstats2table --subjectsfile=/mnt/methlab-drive/methlab-analysis/anpapa/SIIDs.txt --tablefile=/mnt/methlab-drive/methlab-analysis/anpapa//SI/aseg_stats_CBIC_area.txt --meas volume -v --skip
SUBJECTS_DIR=/mnt/methlab-drive/methlab_data/HBN/MRI/Site-CUNY_Derivatives_UZH/
asegstats2table --subjectsfile=/mnt/methlab-drive/methlab-analysis/anpapa/CUNYIDs.txt --tablefile=/mnt/methlab-drive/methlab-analysis/anpapa//CUNY/aseg_stats_CUNY_area.txt --meas volume -v --skip
