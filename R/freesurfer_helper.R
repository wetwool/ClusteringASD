

generateFSGDPerSite <- function(asd, all, sites, variables, title, directory) {
  source("FSGD_helper.R")
  cmds <- list()
  for (site in sites) {
    class1 <- c("Cluster1", "C1", "blue")
    class2 <- c("Cluster2", "C2", "green")
    class3 <- c("Cluster3", "C3", "orange")
    
    if (length(variables)>0) {
      fsGLMdata <- asd[asd$site == site,][,c("lh.aparc.thickness", variables, "clust")]
      # fsGLMdata$clust = 2
      hcSubs <- all[all$site == site & all$Subject == 0,][,c("lh.aparc.thickness", variables)]
    } else {
      fsGLMdata <- asd[asd$site == site,][,c("lh.aparc.thickness", "clust")]
      # fsGLMdata$clust = 2
      hcSubs <- all[all$site == site & all$Subject == 0,][,c("lh.aparc.thickness")]
      hcSubs <- data.frame(lh.aparc.thickness = hcSubs)
    }
    hcSubs$clust <- 3
    fsGLMdata <- rbind(hcSubs, fsGLMdata)
    fsGLMdata$class <- "Cluster1"
    fsGLMdata$class[fsGLMdata$clust == 2] <- "Cluster2"
    fsGLMdata$class[fsGLMdata$clust == 3] <- "Cluster3"
    if (length(variables)>0) {
      fsGLMdata <- na.omit(fsGLMdata[, c(1,ncol(fsGLMdata),2:(ncol(fsGLMdata)-1))])#[1:5,]
    } else {
      fsGLMdata <- na.omit(fsGLMdata[, c(1,ncol(fsGLMdata))])#[1:5,]
    }
    fsgdFile = paste(directory,"ASDanatomy_all_",site,"_",title,".fsgd",sep = "")
    
    generateFSGD(title, list(class1,class2,class3), variables, fsGLMdata, fsgdFile)
  }
}
generateFSGDASD <- function(asd, variables, title, directory) {
  source("FSGD_helper.R")
  cmds <- list()
    class1 <- c("Cluster1", "C1", "blue")
    class2 <- c("Cluster2", "C2", "green")
    
    if (length(variables)>0) {
      fsGLMdata <- asd[,c("lh.aparc.thickness", variables, "clust")]
    } else {
      fsGLMdata <- asd[,c("lh.aparc.thickness", "clust")]
    }
    fsGLMdata$class <- "Cluster1"
    fsGLMdata$class[fsGLMdata$clust == 2] <- "Cluster2"
    if (length(variables)>0) {
      fsGLMdata <- na.omit(fsGLMdata[, c(1,ncol(fsGLMdata),2:(ncol(fsGLMdata)-1))])#[1:5,]
    } else {
      fsGLMdata <- na.omit(fsGLMdata[, c(1,ncol(fsGLMdata))])#[1:5,]
    }
    fsgdFile = paste(directory,"ASDanatomy_",title,".fsgd",sep = "")
    
    generateFSGD(title, list(class1,class2), variables, fsGLMdata, fsgdFile)
  
}

generateGLMPerSite <- function(sites, features, title, directory) {
  source("GLM_helper.R")
  cmds <- list()
  hemis <- c("lh", "rh")
  for (site in sites) {
    for (hemi in hemis) {
      for (feature in features) {
        glmCommandFile = paste(directory,"GLM_all_",site,"_",hemi,"_",feature,".sh",sep = "")
        cmd <- generateGroupComparisonCommands(
        subjectDir = paste("/mnt/methlab-drive/methlab_data/HBN/MRI/Site-",site,"_Derivatives_UZH",sep=""),
        analysis = title,
        hemi = hemi,
        fsgdFile = paste("ASDanatomy_all_",site,"_",title,".fsgd",sep = ""),
        mtx = "clustComparison.mtx",
        gd2mtx ="dods", comparisonTarget = "fsaverage",
        cacheFeature = feature,
        cacheKernel = "10",
        cacheValue = 3,
        cacheDirection = "abs",
        cwp = "0.05", path = glmCommandFile)
      cmds <- rbind(cmds, cmd)
      }
    }
  }
  return(cmds)
}

generateGLMASD <- function(features, title, directory) {
  source("GLM_helper.R")
  cmds <- list()
  hemis <- c("lh", "rh")
    for (hemi in hemis) {
      for (feature in features) {
        glmCommandFile = paste(directory,"GLM_ASD_",hemi,"_",feature,"_",title,".sh",sep = "")
        cmd <- generateGroupComparisonCommands(
          subjectDir = "/mnt/methlab-drive/methlab-analysis/anpapa/AllSubjects",
          analysis = title,
          hemi = hemi,
          fsgdFile = paste("ASDanatomy_",title,".fsgd",sep = ""),
          mtx = "clustComparison.mtx",
          gd2mtx ="dods", comparisonTarget = "fsaverage",
          cacheFeature = feature,
          cacheKernel = "10",
          cacheValue = 3,
          cacheDirection = "abs",
          cwp = "0.05", path = glmCommandFile)
        cmds <- rbind(cmds, cmd)
      }
    }
  return(cmds)
}


generateSimLinkCMD <- function(asd, all, sites) {
  cmds <- c("#!/bin/bash",
            "ln -s /home/ubuntu/freesurfer/subjects/fsaverage fsaverage")
 # browser()
    subj <- asd[,"lh.aparc.thickness"]
    hcSubs <- all[all$Subject == 0,][,"lh.aparc.thickness"]
    
    subj <- append(hcSubs, subj)
  
  for (site in sites) {
    subj <- asd[asd$site == site,][,"lh.aparc.thickness"]
    hcSubs <- all[all$site== site,][all$Subject == 0,][,"lh.aparc.thickness"]
    
    subj <- append(hcSubs, subj)
    subj <- na.omit(subj)
    for (sub in subj) {
      cmds <- append(cmds, paste("ln -s /mnt/methlab-drive/methlab_data/HBN/MRI/Site-",site,"_Derivatives_UZH/",sub," ", sub, sep=""))
    }
  }
  fileConn <- file("simLinkSubj.sh", "wb")
  writeLines(cmds, fileConn, sep = "\n")
  close(fileConn)
}