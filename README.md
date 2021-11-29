# ClusteringASD
Repository for the clustering of ASD subjects in HBN data. This Analysis is part of a Master Thesis in Psychology at the university of Zurich. 


# To recreate the analysis:
1. Create Stats-Tables with Bash/HBN_Stats_Tables.sh
2. Create tabels of successful and complete runs with Python/logChecker.py
3. Adjust analysis parameters in R/ASDClusteringParams.R
4. Pre-Process\* data with R/DataPreProc.Rmd
5. (optional) Overview data with R/DataExploration.RMD
6. Perform Clustering\* with R/Clusterin.Rmd
7. Generate analysis outputs\*\* and FreeSurfer GLM commands with R/ClusterinAnalysis.Rmd
8. Run generated bash files to perform FreeSurfer GLM, files and readme are here FSGroupComparisons/
9. Copy the GLM results into the folder specified in params.
10. Run R/GLMAnalysis.Rmd 

\* Results of steps 4 and 6 are saved to independent files. They are not dependent on R session and need only be recreated when parameters are changed.

\*\* Running chunks separateley enables copying tables directly into excel. 

# Folders
## R
R-Scripts for processing and analyzing data
## Bash
Bash scripts with the commands to interface with freesurfer, generate data tables, run GLM etc.
## Python 
Helper scripts for data management.
## FSGroupComparisons 
Resources to run FreeSurfer Group Comparisons: Differences between ASD (Clusters) and HC  
## misc
Analysis outputs and such

For any questions refer to [me on twitter](https://twitter.com/WetWoolPorridge)