generateFSGDPerSite <- function(asd, all, sites, variables, title, directory) {
  source("FSGD_helper.R")
  cmds <- list()
  for (site in sites) {
    class1 <- c("Cluster1", "C1", "blue")
    class2 <- c("Cluster2", "C2", "green")
    class3 <- c("Cluster3", "C3", "orange")
    
    if (length(variables)>0) {
      fsGLMdata <- asd[asd$site == site,][,c(params$VID, variables, "clust")]
      # fsGLMdata$clust = 2
      hcSubs <- all[all$site == site & all$Subject == 0,][,c(params$VID, variables)]
    } else {
      fsGLMdata <- asd[asd$site == site,][,c(params$VID, "clust")]
      # fsGLMdata$clust = 2
      hcSubs <- all[all$site == site & all$Subject == 0,][,c(params$VID)]
      hcSubs <- data.frame(hcSubs)
      colnames(hcSubs) <- c(params$VID)
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
    fsgdFile = paste(directory, site,"_",title,".fsgd",sep = "")
    
    generateFSGD(title, list(class1,class2,class3), variables, fsGLMdata, fsgdFile)
  }
}

generateFSGDASD <- function(asd, variables, title, directory) {
  source("FSGD_helper.R")
  cmds <- list()
    class1 <- c("Cluster1", "C1", "blue")
    class2 <- c("Cluster2", "C2", "green")
    
    if (length(variables)>0) {
      fsGLMdata <- asd[,c(params$VID, variables, "clust")]
    } else {
      fsGLMdata <- asd[,c(params$VID, "clust")]
    }
    fsGLMdata$class <- "Cluster1"
    fsGLMdata$class[fsGLMdata$clust == 2] <- "Cluster2"
    if (length(variables)>0) {
      fsGLMdata <- na.omit(fsGLMdata[, c(1,ncol(fsGLMdata),2:(ncol(fsGLMdata)-1))])#[1:5,]
    } else {
      fsGLMdata <- na.omit(fsGLMdata[, c(1,ncol(fsGLMdata))])#[1:5,]
    }
    fsgdFile = paste(directory,title,".fsgd",sep = "")
    
    generateFSGD(title, list(class1,class2), variables, fsGLMdata, fsgdFile)
  
}

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


generateGLMPerSite <- function(sites, features, title, contrasts, directory) {
  source("GLM_helper.R")
  mtx <- writeContrasts(directory, title, contrasts)
  cmds <- list()
  for (site in sites) {
    for (hemi in params$Hemis) {
      for (feature in features) {
        glmCommandFile = paste(directory,"GLM_all_",site,"_",hemi,"_",feature,".sh",sep = "")
        cmd <- generateGroupComparisonCommands(
        subjectDir = paste("/mnt/methlab-drive/methlab_data/HBN/MRI/Site-",site,"_Derivatives_UZH",sep=""),
        analysis = title,
        hemi = hemi,
        fsgdFile = paste(site,"_",title,".fsgd",sep = ""),
        mtx = mtx,
        gd2mtx ="dods", comparisonTarget = params$ComparisonSubject,
        cacheFeature = feature,
        cacheKernel = params$GLMCacheKernel,
        cacheValue = params$GLMCacheValue,
        cacheDirection = params$GLMDirections$absolute,
        cwp = "0.05", path = glmCommandFile)
      cmds <- rbind(cmds, cmd)
      }
    }
  }
  return(cmds)
}

generateGLMASD <- function(features, title, contrasts, directory) {
  source("GLM_helper.R")
  # mtx <- writeContrasts(directory, title, contrasts)
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

generateGLMALL <- function(features, title, contrasts, directory) {
  source("GLM_helper.R")
  # mtx <- writeContrasts(directory, title, contrasts)
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

generateSimLinkCMD <- function(asd, all, sites, directory) {
  cmds <- c("#!/bin/bash",
            paste("ln -s ", params$fsaverageFolder," fsaverage", sep = ""))
 # browser()
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