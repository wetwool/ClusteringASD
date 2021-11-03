library(rjson)
kToUse <- function() {
  trueFound = F
  for (p in params$kCriterionToUse){
    if (p & trueFound) {
      print("Can't have multiple k criteria enabled")
      return(NULL)
    } else if (p) {
      trueFound = T
    }
  }
  if (!trueFound){
    print("need to define at least one k criteria")
    return(NULL)
  }
  for (i in 1:length(params$kList)) {
    if (unlist(params$kCriterionToUse[i])){
      return(params$kList[i])
    }
  }
}

params <- list(
  ## Params for preprocessing & import
  # Files and paths
  WorkingDirectory = "E:/Box Sync/Arbeit/UZH/MasterArbeit/ClusteringASD/R",
  AllDataCSV = "U:/HBN/BehavioralData/Data_Download_22_02_2021_LORIS/BD.csv",
  StatsTablesFolder = "E:/Box Sync/Arbeit/UZH/MasterArbeit/ScienceCloud/",
  FinishiedStatesFile = "../Python/fsFinishedTable.csv",
  CompleteSubjectsFile = "../Python/filesFound.csv",
  FilteredDataFile = "filteredASD.Rda",
  zScoredASDDataFile = "zScoredASD.Rda",
  zScoredHCDataFile = "zScoredHC.Rda",
  zScoredASDDataFile2 = "zScoredASD2.Rda",
  zScoredHCDataFile2 = "zScoredHC2.Rda",
  ParcellationReferenceFile = "ParcellationReference.csv",
  GLMFolder = "E:/Box Sync/Arbeit/UZH/MasterArbeit/ScienceCloud/GLM/",

  # MRI specific params
  Sites = list(RU = "RU", SI = "SI", CBIC =  "CBIC", CUNY = "CUNY"),
  Protocols = list(HCP = "HCP", VNav = "VNav", VNavN = "VNavNorm", Other = "Not Specified"),
  Hemis = c("lh", "rh"),
  Features = c("area", "thickness"),

  # Subject filtering
  Sex = 0, # male is 0, female 1
  EHQCutoff = 50,
  MaxDiagnosisCount = 0,
  VID = "lh.aparc.thickness",
  EHQInResidualCalc = F,

  ## Params clustering and analysis
  # z-Scoring
  zScoringAgeRange = 1.5,
  zScoringMinGroupSize = 10,
  zScoringBySite = F,

  # Clustering
  UsePreclusteredData = T,
  kList = list(default = 3, silhouette = 2, db = 2),
  kCriterionToUse = list(default = F, silhouette = T, DB = F),
  k = kToUse,
  Distance = "euclidean",
  ClusterMethod = "ward.D",                                # See hclust docs

  #Post-Hoc test parameters
  PosthocTestScales = list(# Behavioral Measures
                            CIS_P = "CIS_P_Score",         # The Columbia Impairment Scale (Parental Report)
                            CIS_SR = "CIS_SR_Total",       # The Columbia Impairment Scale (Self Report)
                            DTS = "DTS_Total",             # Distress Tolerance Index (Parental Self Report)
                            RBS = "RBS_Total",             # Repetitive Behavior Scale
                            SCQ = "SCQ_Total",             # Social Communication Questionnaire 
                            PSI = "PSI_Total",             # Parental Stress Index IV
                            SCARED_P = "SCARED_P_Total",   # Screen for Child Anxiety Related Disorders (Parental Report)
                            SCARED_SR = "SCARED_SR_Total"  # Screen for Child Anxiety Related Disorders (Self Report)
                            ),

  #GLM parameters
  GLMCacheValue = 4, #significance as 10^(-x)
  GLMCacheKernel = 10,
  GLMSigLevel = "0.05",
  GLMDirections = list(absolute = "abs", positive = "pos", negative = "neg"),
  ComparisonSubject = "fsaverage",
  GLMFolder = "E:/Box Sync/Arbeit/UZH/MasterArbeit/ScienceCloud/GLM/",
  GLMProjects = list(
    # ClusteredASD = list(Title = "ClusterASDComparison", Contrasts = c("-1", "+1")),
    # ClusteredASDvHC = list(Title = "ClusterASDvHCComparison", Contrasts = c("-1", "+1", "0"), ContrastPerms = c("01-1", "10-1")),
    # ClusteredASDvtHC = list(Title = "ClusteredASDvtHC", Contrasts = c("noVars","Vars"), ContrastPerms = c("noVars","Vars")),
    # ClusteredASDvtHCControlled = list(Title = "ClusteredASDvtHCControlled", Contrasts = c("Vars"), ContrastPerms = c("Vars")),
    # ClusteredASDvtHCSRS = list(Title = "ClusteredASDvtHCtoHCSRS", Contrasts = c("ClusterASDvHCComparisonVars"), ContrastPerms = c("ClusterASDvHCComparisonVars")),
    # ASDvHC = list(Title = "rawASDvHCComparison", Contrasts = c("-1", "+1"))
    ClusteredASD = list(Title = "ASDComparison", Contrasts = c("ASD1vsASD2.mtx", "ASD1vsHC.mtx", "ASD2vsHC.mtx"), Variables = c()),
    ClusteredASDSNR = list(Title = "ASDComparisonSNR", Contrasts = c("ASD1vsASD2COV.mtx", "ASD1vsHCCOV.mtx", "ASD2vsHCCOV.mtx"), Variables = c("SNR")),
    DiagASD = list(Title = "DiagComparison", Contrasts = c("DiagDifferences.mtx"), Variables = c())
    ),
  fsaverageFolder = "/home/ubuntu/freesurfer/subjects/fsaverage",
  MRIFoldersPrefix = "/mnt/methlab-drive/methlab_data/HBN/MRI/Site-",
  MRIFolderSuffix = "_Derivatives_UZH/",

  #bootstrapping values
  BootCount = 100
)

loadParams <- function(json = "params.json") {
  fileConn <- file(json, "r")
  params <- fromJSON(readLines(fileConn))
  close(fileConn)
  params <- append(params, list(k = kToUse))
  return(params)
}


saveParams<- function(params, json = "params.json") {
  fileConn <- file(json, "wb")
  json <- toJSON(params[names(params) != "k"])
  writeLines(json, fileConn)
  close(fileConn)
}

# params <- loadParams()
