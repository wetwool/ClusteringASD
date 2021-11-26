# Freesurfer Group Comparisons and GLM
Freesurfer provides tools to fit surface-based glm models.  See [GroupAnalysis](https://surfer.nmr.mgh.harvard.edu/fswiki/FsTutorial/GroupAnalysis)

To do this it requires at least:
*FreeSurfer Group Descriptor [(.fsgd file)](https://surfer.nmr.mgh.harvard.edu/fswiki/FsgdFormat)
*Contrasts [(.mtx files)](https://surfer.nmr.mgh.harvard.edu/fswiki/FsTutorial/GroupAnalysis#Contrasts)

The .fsgd contains the subjects and variables to include. For this analysis this is limited to Cluster or Diagnosis and Signal-to-Noise ratio.
Contrasts define the glm model for example, when testing two groups against each other with a t-test, the contrasts would be 
```
+1 -1
```
For more information visit the corresponding [Freesurfer Examples](https://surfer.nmr.mgh.harvard.edu/fswiki/FsgdExamples)

# Running GLM Analysis
1. Check paths in all .sh files
2. Copy .sh files into the folder that they should run in
2. To link all subjects into one directory, run ./simLinkSubj.sh 
3. Run ./__Comparison.sh to start GLM