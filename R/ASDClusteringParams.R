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
  ParcellationReferenceFile = "ParcellationReference.csv",
  
  # MRI specific params
  Sites = list(RU = "RU", SI = "SI", CBIC =  "CBIC", CUNY = "CUNY"),
  Protocols = list(HCP = "HCP", VNav = "VNav", Other = "Not Specified"),
  
  # Subject filtering
  Sex = 0, # male is 0, female 1
  EHQCutoff = 40,
  MaxDiagnosisCount = 10,
  VID = "lh.aparc.thickness",
  
  ## Params clustering and analysis
  # z-Scoring
  zScoringAgeRange = 1,
  zScoringMinGroupSize = 10,
  zScoringBySite = F,
  
  # Clustering
  kList = list(default = 3, silhouette = 2, db = 2),
  kCriterionToUse = list(default = F, silhouette = F, DB = T),
  k = kToUse,
  Distance = "euclidean",
  ClusterMethod = "ward.D",
  
  
  #GLM parameters
  GLMCacheValue = 3, #significance as 10^(-x)
  GLMCacheKernel = 10,
  GLMSigLevel = "0.05",
  GLMDirections = list(absolute = "abs", positive = "pos", negative = "neg"),
  ComparisonSubject = "fsaverage",
  
  #bootstrapping values
  BootCount = 100
)
