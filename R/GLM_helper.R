generatePreprocCMD <- function(analysis, fsgdFile, hemi, cacheKernel, cacheFeature, target) {
  return(
    paste(
      "mris_preproc --fsgd ", fsgdFile,
      " --cache-in ",cacheFeature, ".fwhm",cacheKernel, ".fsaverage",
      " --target ", target,
      " --hemi ", hemi, 
      " --out ", paste(hemi,analysis,cacheFeature,cacheKernel,"mgh",sep="."),
      sep=""
      )
    )
}
writeContrasts <- function(path, analysis, contrasts) {
  fileConn<-file(paste(path, analysis, ".mtx" ,sep = ""), "wb")
  writeLines(paste(contrasts, sep = " ", collapse = " "), fileConn, sep = "\n")
  close(fileConn)
  return(paste(analysis, ".mtx" ,sep = ""))
}

generateGLMCMD <- function(analysis, fsgdFile, mtx, gd2mtx, target, hemi,cacheFeature,cacheKernel) {
  return(
    paste(
      "mri_glmfit --y ", paste(hemi,analysis,cacheFeature,cacheKernel,"mgh",sep="."),
      " --fsgd ", fsgdFile,
      " ", gd2mtx,
      " --surf ", target,
      " ", hemi,
      " --C ", mtx, 
      " --cortex",
      " --glmdir ", paste(hemi,analysis,cacheFeature,cacheKernel,"glmdir",sep="."),
      sep = ""
    )
  )
}
generateGLMSimCMD <- function(analysis, cacheValue, cacheDirection, cwp, hemi,cacheFeature,cacheKernel) {
  return(
    paste(
      "mri_glmfit-sim --glmdir ", paste(hemi,analysis,cacheFeature,cacheKernel,"glmdir",sep="."),
      " --cache ", paste(cacheValue, cacheDirection, sep = " "),
      " --cwp ", cwp,
      " --2spaces",
      sep = ""
    )
  )
}
generateSubDirCMD <- function(dir) {
  return(
    paste("SUBJECTS_DIR=",dir, sep="")
  )
}

#' Generate command line inputs to run a Freesurfer GLM.
#' see \url{https://surfer.nmr.mgh.harvard.edu/fswiki/FsTutorial/GroupAnalysis}
#' 
#' @param subjectDir path to subjects directory.
#' @param analysis name for the analysis, used to generate output directories and files
#' @param hemi hemisphere to analyze, either "lh" or "rh".
#' @param fsgdFile Group descriptor file containing group- and variable definitions as well as subjects, see \url{https://surfer.nmr.mgh.harvard.edu/fswiki/FsgdFormat} 
#' @param mtx contrasts file(s) see \url{https://surfer.nmr.mgh.harvard.edu/fswiki/FsTutorial/GroupAnalysis#Contrasts}.
#' @param gd2mtx DODS or DOSS, see \url{https://surfer.nmr.mgh.harvard.edu/fswiki/DodsDoss}
#' @param comparisonTarget subject to compare groups to, usually fsaverage.
#' @param cacheFeature feature to use for analysis, e.g. thickness, area, etc.
#' @param cacheKernel kernel size to use for analysis, e.g. 5, 10, 20, etc.
#' @param cacheValue vertex-wise threshold for cluster correction, see \url{https://andysbrainbook.readthedocs.io/en/latest/FreeSurfer/FS_ShortCourse/FS_09_ClusterCorrection.html}
#' @param cacheDirection significance testing direction "pos", "neg", or "abs"
#' @param cwp significance level for corrected clusters
#' @return string with commands separated by a new line.
generateGroupComparisonCommands <- function(subjectDir, analysis, hemi, fsgdFile, mtx, gd2mtx, comparisonTarget, cacheFeature, cacheKernel, cacheValue, cacheDirection, cwp, path) {
  subDir <- generateSubDirCMD(dir = subjectDir)
  preproc <- generatePreprocCMD(analysis, fsgdFile, hemi, cacheKernel, cacheFeature, target = comparisonTarget)
  GLM <- generateGLMCMD(analysis, fsgdFile, mtx, gd2mtx, target = comparisonTarget, hemi,cacheFeature,cacheKernel)
  sim <- generateGLMSimCMD(analysis, cacheValue, cacheDirection, cwp, hemi,cacheFeature,cacheKernel)
  cmds <- paste(subDir, preproc, GLM, sim, sep="\n")
  fileConn<-file(path, "wb")
  writeLines(cmds, fileConn, sep = "\n")
  close(fileConn)
  return(cmds)
}

#Typical output might be:
# SUBJECTS_DIR=/mnt/exchange/Site-SI_Derivatives_UZH
# mris_preproc --fsgd ASDanatomy_all_SI.fsgd --cache-in thickness.fwhm10.fsaverage --target fsaverage --hemi lh --out lh.DEMO.thickness.10.mgh
# mri_glmfit --y lh.DEMO.thickness.10.mgh --fsgd ASDanatomy_all_SI.fsgd dods --surf fsaverage lh --C clustComparison.mtx --cortex --glmdir lh.DEMO.thickness.10.glmdir
# mri_glmfit-sim --glmdir lh.DEMO.thickness.10.glmdir --cache 3 abs --cwp 0.05 --2spaces

# 
# b <- generateGroupComparisonCommands(
#   subjectDir = "SUBDIR",
#   analysis = "DEMO",
#   hemi = "lh",
#   fsgdFile = "tmp.fsgd",
#   mtx = "tmp.mtx",
#   gd2mtx ="dods", comparisonTarget = "fsaverage",
#   cacheFeature = "thickness",
#   cacheKernel = "10",
#   cacheValue = 4,
#   cacheDirection = "abs",
#   cwp = "0.05")
# b
