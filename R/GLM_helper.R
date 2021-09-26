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

generateGroupComparisonCommands <- function(subjectDir, analysis, hemi, fsgdFile, mtx, gd2mtx, comparisonTarget, cacheFeature, cacheKernel, cacheValue, cacheDirection, cwp) {
  subDir <- generateSubDirCMD(dir = subjectDir)
  preproc <- generatePreprocCMD(analysis, fsgdFile, hemi, cacheKernel, cacheFeature, target = comparisonTarget)
  GLM <- generateGLMCMD(analysis, fsgdFile, mtx, gd2mtx, target = comparisonTarget, hemi,cacheFeature,cacheKernel)
  sim <- generateGLMSimCMD(analysis, cacheValue, cacheDirection, cwp, hemi,cacheFeature,cacheKernel)
  return(paste(subDir, preproc, GLM, sim, sep="\n"))
}
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
