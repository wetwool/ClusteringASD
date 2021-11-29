#' Call FSGD helper function with prepared parameters for 3 classes 
#' EXCPECTS allSubs TO CONTAIN A COLUMN clust TO USE AS CLASS
#' 
#' @param allSubs DataFrame of all subjects to include.
#' @param variables vector or list of (continuous) variables to include
#' @param title title to use for analysis/ name FSGD file
#' @param directory directory to save the file to.
generateFSGDALL <- function(allSubs, variables, title, directory) {
  source("FSGD_helper.R")
  cmds <- list()
  class1 <- c("Cluster1", "C1", "blue")
  class2 <- c("Cluster2", "C2", "green")
  class3 <- c("Cluster3", "C3", "orange")
  
  if (length(variables)>0) {
    fsGLMdata <- allSubs[,c(params$VID, variables, "clust")]
  } else {
    fsGLMdata <- allSubs[,c(params$VID, "clust")]
  }
  fsGLMdata$class <- "Cluster1"
  fsGLMdata$class[fsGLMdata$clust == 2] <- "Cluster2"
  fsGLMdata$class[fsGLMdata$clust == 3] <- "Cluster3"
  if (length(variables)>0) {
    fsGLMdata <- na.omit(fsGLMdata[, c(1,ncol(fsGLMdata),2:(ncol(fsGLMdata)-2))])#[1:5,]
  } else {
    fsGLMdata <- na.omit(fsGLMdata[, c(1,ncol(fsGLMdata))])#[1:5,]
  }
  fsgdFile = paste(directory,title,".fsgd",sep = "")
  
  generateFSGD(title, list(class1,class2,class3), variables, fsGLMdata, fsgdFile)
}

#' Call GLM helper function to generate GLM commands 
#' 
#' @param features Parcellation features to analyze (thickness, area, volume, etc.)
#' @param title title to use for analysis/ name FSGD file
#' @param contrasts lists of .mtx files to use
#' @param directory directory to save the file to.
generateGLMALL <- function(features, title, contrasts, directory) {
  source("GLM_helper.R")
  cmds <- list()
  for (hemi in params$Hemis) {
    for (feature in features) {
      glmCommandFile = paste(directory,"GLM_",hemi,"_",feature,"_",title,".sh",sep = "")
      cmd <- generateGroupComparisonCommands(
        subjectDir = "/mnt/methlab-drive/methlab-analysis/anpapa/AllSubjects",
        analysis = title,
        hemi = hemi,
        fsgdFile = paste(title,".fsgd",sep = ""),
        mtx = contrasts,
        gd2mtx ="dods", comparisonTarget = params$ComparisonSubject,
        cacheFeature = feature,
        cacheKernel = params$GLMCacheKernel,
        cacheValue = params$GLMCacheValue,
        cacheDirection = params$GLMDirections$absolute,
        cwp = params$GLMSigLevel, path = glmCommandFile)
      cmds <- rbind(cmds, cmd)
    }
  }
  fileConn<-file(paste(directory, "GLM", title, ".sh",sep =""), "wb")
  writeLines(paste(cmds, collapse ="\n"), fileConn, sep = "\n")
  close(fileConn)
  return(cmds)
}

#' Simlink helper function to generate a bash script that links all subjects into one directory
#' 
#' @param asd diagnosed subjects
#' @param all list of all subjects that will be filtered to only include Subject == 0
#' @param sites sites to generate links for
#' @param directory directory to save the file to.
generateSimLinkCMD <- function(asd, all, sites, directory) {
  cmds <- c("#!/bin/bash",
            paste("ln -s ", params$fsaverageFolder," fsaverage", sep = ""))
    subj <- asd[,params$VID]
    hcSubs <- all[all$Subject == 0,][,params$VID]
    
    subj <- append(hcSubs, subj)
  
  for (site in sites) {
    subj <- asd[asd$site == site,][,params$VID]
    hcSubs <- all[all$site== site,][all$Subject == 0,][,params$VID]
    
    subj <- append(hcSubs, subj)
    subj <- na.omit(subj)
    for (sub in subj) {
      cmds <- append(cmds, paste("ln -s ", params$MRIFoldersPrefix ,site, params$MRIFolderSuffix,sub," ", sub, sep=""))
    }
  }
  fileConn <- file(paste(directory, "simLinkSubj.sh", sep=""), "wb")
  writeLines(cmds, fileConn, sep = "\n")
  close(fileConn)
}