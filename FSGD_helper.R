generateFSGDHeader <- function(title, classes, variables) {
  FSGD <- c("GroupDescriptorFile 1")
  FSGD <- cbind(FSGD, paste("Title", title))
  for (cls in classes) {
    print(paste("Class", paste(cls, collapse=" "), collapse = " "))
    FSGD <- cbind(FSGD, paste("Class", paste(cls, collapse=" "), collapse = " "))
  }
  print(paste("Variables", paste(variables, collapse=" "), collapse = " "))
  FSGD <- cbind(FSGD, paste("Variables", paste(variables, collapse=" "), collapse = " "))
  return(FSGD)
}

addSubjectsToFSGD <- function(FSGD, subjects) {
  for (i in 1:nrow(subjects)) {
    if (i <= 6 ) {print(paste("Input", paste(subjects[i,], collapse=" "), collapse = " "))}
    FSGD <- cbind(FSGD, paste("Input", paste(subjects[i,], collapse=" "), collapse = " "))
  } 
  if (nrow(subjects) > 6){
    print(noquote(paste("...Omitted ", nrow(subjects)-6, " rows from output")))
  }
  return(FSGD)
}

writeFSGD <- function(data, path) {
  fileConn<-file(path, "wb")
  # for (i in 1:length(data)){
  #   cat(paste(data[i],"\n",sep="" ),file = path,append = T)
  # }
  writeLines(data, fileConn, sep = "\n")
  close(fileConn)
  return(path)
}

#' Generate .fsgd file for FreeSurfer GLM group analysis.
#' see \url{https://surfer.nmr.mgh.harvard.edu/fswiki/FsTutorial/GroupAnalysis#ClusterwiseCorrectionforMultipleComparisons}
#' 
#' @param title string title to include in the file, will be displayed when running in FS.
#' @param classes Factors, each combination must be included separately (e.g. sex*handedness: MaleRight, MaleLeft, FemaleRight, FemaleLeft).
#' @param variables continuous variables to include in the model.
#' @param dataFrame data ordered as SUBJECTIDENTIFIER, CLASS, VAR1, VAR2 etc.
#' @return Vector containing the lines of the file.
#' add(1, 1)
#' add(10, 1)
generateFSGD <- function(title, classes, variables, dataFrame, path) {
  print(noquote("Generating FSGD:"))
  print(noquote("=============HEADER=============="))
  fsgd <- generateFSGDHeader(title, classes, variables)
  print(noquote("==============BODY==============="))
  fsgd <- addSubjectsToFSGD(fsgd, dataFrame)
  print(noquote("Writing to file:"))
  print(path)
  writeFSGD(fsgd, path)
  print(noquote("================================="))
  return(fsgd)
}
# 
# title <- "ASD anatomy GLM"
# class1 <- c("Cluster1", "C1", "blue")
# class2 <- c("Cluster2", "C2", "green")
# variables <- list("age", "ASDScore")
# 
# subjects <- c("AAAA", "AAAB", "AAAC")
# clusters <- c("Cluster1","Cluster2","Cluster1")
# ages <- c(14,12, 16)
# tDat <- data.frame(subjects,clusters, ages)
# 
# generateFSGD(title,list(class1, class2), variables, tDat, "tmp.fsgd")
