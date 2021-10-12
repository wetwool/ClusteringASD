library("fsbrain")
library("freesurferformats")
subj_dir = "E:/Linux/Exchange/Site-SI_Derivatives_UZH"
glm_dir = "E:/Linux/Exchange/lh.DEMO.thickness.10.glmdir"
fsaverage = "E:/Linux/Exchange/fsaverage"
subj_list = c("sub-NDARZW013RUH_T1w","sub-NDARZV766YXP_T1w")
sjl = read.md.subjects.from.fsgd("E:/Linux/Exchange/ASDanatomy_some_SI.fsgd")

groupdata_nat = group.morph.native(subj_dir, subj_list, "thickness", "lh");
cat(sprintf("Subject '%s' has %d vertices and the mean cortical thickness of the left hemi is %f./n", subj_list[1], length(groupdata_nat[[subj_list[1]]]), mean(groupdata_nat[[subj_list[1]]])));
groupdata_std = group.morph.standard(subj_dir, subj_list, "thickness", "lh", fwhm="10");
cat(sprintf("Data length is %d for subject1, %d for subject2./n", length(groupdata_std[subj_list[1]]), length(groupdata_std[subj_list[2]])));
vis.subject.annot(subj_dir, 'fsaverage', 'aparc', 'both', views=c('si'));

# lh_demo_cluster_file = system.file("extdata","E:/Linux/Exchange/lh.DEMO.thickness.10.glmdir/clustComparison/cache.th30.abs.sig.cluster.mgh", package = "fsbrain", mustWork = TRUE);
lh_clust = read.fs.morph ("E:/Box Sync/Arbeit/UZH/MasterArbeit/ScienceCloud/GLM/lh.ASD_anatomy_GLM.area.10.glmdir/clustComparison/cache.th30.abs.sig.cluster.mgh", "mgh")
rh_clust = read.fs.morph ("E:/Box Sync/Arbeit/UZH/MasterArbeit/ScienceCloud/GLM/rh.ASD_anatomy_GLM.area.10.glmdir/clustComparison/cache.th30.abs.sig.cluster.mgh", "mgh")

vis.data.on.fsaverage(subj_dir,morph_data_lh = lh_clust, morph_data_rh = rh_clust,bg="curv_light",views=c('si'))

lh_clust = read.fs.morph ("E:/Box Sync/Arbeit/UZH/MasterArbeit/ScienceCloud/GLM/lh.ASD_anatomy_GLM.thickness.10.glmdir/clustComparison/cache.th30.abs.sig.cluster.mgh", "mgh")
rh_clust = read.fs.morph ("E:/Box Sync/Arbeit/UZH/MasterArbeit/ScienceCloud/GLM/rh.ASD_anatomy_GLM.thickness.10.glmdir/clustComparison/cache.th30.abs.sig.cluster.mgh", "mgh")

vis.data.on.fsaverage(subj_dir, surface = "pial", morph_data_lh = lh_clust, morph_data_rh = rh_clust,bg="aparc", style ="default", views=c('t4'))

