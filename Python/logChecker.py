# -*- coding: utf-8 -*-
"""
Created on Mon Aug 16 13:50:15 2021

Script to crawl through given direcotries, looking for scripts/recon-all.log files
create table with results

@author: Andreas Papageorgiou
"""
import os.path
import os
import re
import timeit

## toplevel director[y/ies]
FSfolders =["T:/HBN/MRI/Site-CBIC_Derivatives_UZH/", "T:/HBN/MRI/Site-CUNY_Derivatives_UZH/", "T:/HBN/MRI/Site-RU_Derivatives_UZH/", "T:/HBN/MRI/Site-SI_Derivatives_UZH/"] 

## Path to logfile in subjects folders 
match = "scripts/recon-all.log"

# subjPattern = r'\w*sub-\w*'
# linePattern = r'^recon-all.*sub-.*finished without error'
# successPattern = r'([f]([a-zA-Z]+\s)+at)'
successString = "finished without error"

## Function to generate a progress bar of given length
def percentageString(perc, length):
    return "[" + "".join(["="*int(length*perc)]).ljust(length,"-") + "]"



##
# def gatherFSSuccess(filename, linePattern, successPattern, folder = "", folders = [], resume = False, outputFile = "fsSuccessTable.csv", resumeFile = "fsCrawlSave.tmp"):
def gatherFSSuccess(filename, successString, folder = "", folders = [], resume = False, outputFile = "fsSuccessTable.csv", resumeFile = "fsCrawlSave.tmp"):
    """
    Function to go through all given folders, list subjects and check their logs. 
    
    Parameters:
        filename :         path/file to log files
        successString:     string to look for in log files
        folder:            path to single folder containing FreeSurfer subject folders
        folders:           list of multiple paths to folders containing FreeSurfer subject folders
        outputFile:        path to write resulting .csv to
        resume:            should the operation be resumed, if possible. Default = False
        resumeFile:        path to save progress to, deleted on successfull execution
    """
    ## Logic to resume incomplete executions since I/O over network/VPN is a bit fickle
    resumeTop = False
    resumeSubj = False
    resumeFolder = ""
    resumeIndex = ""
    if resume and os.path.exists(resumeFile):
        resumeTop = True
        resumeSubj = True
        with open(resumeFile, "r") as rf:
            spl = rf.read().split(sep=";")
            resumeFolder = spl[0]
            resumeIndex = int(spl[1])
    elif os.path.exists(outputFile):
        os.remove(outputFile)
    
    ## Setup if a single path is given, overwriting the folders parameter
    if len(folder) > 0:
        print(f"single folder given: {folder}")
        folders = [folder]
    logList = list()
    print(f"Checking for {match} files searching for \"{successString}\"")
    ## Loop through every toplevel folder given
    for wd in folders:
        ## More resume logic
        if resumeTop: 
            if wd != resumeFolder:
                print(f"Resuming, ignoring folder: {wd}")
                continue
            else:
                resumeTop = False
        ## List all subdirectories and loop over them
        print(f"\r\nChecking folder: {wd}")
        subjFolders = next(os.walk(wd))[1]
        subjFolders.sort()
        subjCount = len(subjFolders)
        i = 0
        for subjFolder in subjFolders:
            i += 1
            if resumeSubj: 
                if i < resumeIndex:
                    continue
                else:
                    resumeSubj = False
            perc = i/subjCount
            print("\r" + percentageString(i/subjCount,55) + f" {round(perc*100,2)}%  | {i}/{subjCount}", end ="")       
            logFile = os.path.join(wd,subjFolder,filename)
            subj = subjFolder
            matches = 0
            ## trying and failing is faster than checking for existence. loading whole file and finding is faster than RegEx 
            # if os.path.exists(logFile):
            try:
                # for line in open(logFile,'r'):
                #     matches = matches if len(re.findall(linePattern, line)) == 0 else matches + 1
                with open(logFile,'r') as f:
                    contents = f.read()
                    foundIndex = 0
                    while (foundIndex := contents.find(successString, foundIndex + 23)) > -1:
                            matches = matches + 1
            except:
                pass
            logList.append(f"{wd},{subj},{matches}")
            ## Only write to csv every x iterations to not take up too much I/O bandwith, might not matter in comparison to network I/O
            if i%50 == 0:
                with open(resumeFile, "w") as f:
                    f.write(";".join([wd,str(i)]))
                with open(outputFile, "a") as save:
                    save.write("\n".join(logList))
                    save.write("\n")
                    logList =list()

        with open(outputFile, "a") as save:
            save.write("\n".join(logList))
                
        os.remove(resumeFile)                    

##
def gatherFSCompleted(filename, successStrings, endLinesToScan = 4, folder = "", folders = [], outputFile = "fsFinishedTable.csv"):
    """
    Function to go through all given folders, list subjects and check the last lines of the log for completion. 
    
    Parameters:
        filename :         path/file to log files
        successStrings:    list of strings that indicate completion
        folder:            path to single folder containing FreeSurfer subject folders
        folders:           list of multiple paths to folders containing FreeSurfer subject folders
        outputFile:        path to write resulting .csv to
        resume:            should the operation be resumed, if possible. Default = False
    """
    
    ## Setup if a single path is given, overwriting the folders parameter
    if len(folder) > 0:
        print(f"single folder given: {folder}")
        folders = [folder]
    logList = list()
    if os.path.exists(outputFile):
        os.remove(outputFile)
    print(f"Checking for {match} files searching for \"{successString}\"")
    ## Loop through every toplevel folder given
    for wd in folders:
        ## List all subdirectories and loop over them
        print(f"\r\nChecking folder: {wd}")
        subjFolders = next(os.walk(wd))[1]
        subjFolders.sort()
        subjCount = len(subjFolders)
        i = 0
        matches = 0
        for subjFolder in subjFolders:
            i += 1
            perc = i/subjCount
            ## Binary seeking is orders of magnitude quicker, 
            print("\r" + percentageString(i/subjCount,55) + f" {round(perc*100,2)}%  | {i}/{subjCount}", end ="")       
            logFile = os.path.join(wd,subjFolder,filename)
            subj = subjFolder
            matches = 0
            ## trying and failing is faster than checking for existence. loading whole file and finding is faster than RegEx 
            try:
                with open(logFile,'rb') as f:
                    f.seek(-2, os.SEEK_END)
                    linesFromEnd = 1
                    while linesFromEnd < endLinesToScan:
                        while f.read(1) != b'\n':
                            f.seek(-2, os.SEEK_CUR)
                        linesFromEnd += 1
                        f.seek(-2, os.SEEK_CUR)
                    
                    last_lines = ""
                    for j in range(linesFromEnd):
                        last_lines += f.readline().decode()
                    for s in successStrings :
                        if s in last_lines:
                            matches = matches + 1
            except:
                pass
            logList.append(f"{wd},{subj},{matches}")
            ## Only write to csv every x iterations to not take up too much I/O bandwith, might not matter in comparison to network I/O
            if i%50 == 0:
                with open(outputFile, "a") as save:
                    save.write("\n".join(logList))
                    save.write("\n")
                    logList =list()

        with open(outputFile, "a") as save:
            save.write("\n".join(logList))
            save.write("\n")
            
def checkFilesExist(filenames, folders = [], outputFile = "filesFound.csv"):
    """
    Function to go through all given folders, list subjects and check the last lines of the log for completion. 
    
    Parameters:
        filenames :        path to list of files to check
        folders:           list of multiple paths to folders containing FreeSurfer subject folders
        outputFile:        path to write resulting .csv to
    """
    
    ## Setup if a single path is given, overwriting the folders parameter

    logList = list()
    if os.path.exists(outputFile):
        os.remove(outputFile)
    print(f"Checking for {match} files searching for \"{successString}\"")
    ## Loop through every toplevel folder given
    for wd in folders:
        ## List all subdirectories and loop over them
        print(f"\r\nChecking folder: {wd}")
        subjFolders = next(os.walk(wd))[1]
        subjFolders.sort()
        subjCount = len(subjFolders)
        i = 0
        matches = 0
        for subjFolder in subjFolders:
            i += 1
            perc = i/subjCount
            ## Binary seeking is orders of magnitude quicker, 
            print("\r" + percentageString(i/subjCount,55) + f" {round(perc*100,2)}%  | {i}/{subjCount}", end ="")   
            filesExist = True
            for filename in filenames:
                pathToCheck = os.path.join(wd,subjFolder,filename)
                if (not os.path.exists(pathToCheck)):
                    filesExist = False
            
            logList.append(f"{wd},{subjFolder},{1 if filesExist else 0}")
            ## Only write to csv every x iterations to not take up too much I/O bandwith, might not matter in comparison to network I/O
            if i%50 == 0:
                with open(outputFile, "a") as save:
                    save.write("\n".join(logList))
                    save.write("\n")
                    logList =list()

        with open(outputFile, "a") as save:
            save.write("\n".join(logList))
            save.write("\n")
        
if __name__ == '__main__':
    # gatherFSSuccess(match, successString, folders = FSfolders, resume = False)
    # gatherFSCompleted(match, ["exited", "finished"], folders =FSfolders)
    checkFilesExist(["surf/lh.area.fwhm10.fsaverage.mgh"],folders = FSfolders)

# t = timeit.timeit("gatherFSSuccess(\"scripts/recon-all.log\", \'^recon-all.*sub-.*finished without error\', \'([f]([a-zA-Z]+\s)+at)\', folder = \"T:/HBN/MRI/Site-CUNY_Derivatives_UZH/\", resume = False)", setup= "from __main__ import gatherFSSuccess", number = 1)
