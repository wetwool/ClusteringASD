# -*- coding: utf-8 -*-
# """
# Created on Mon Oct 11 16:02:03 2021

# @author: andre

# import pandas as pd
# from nilearn import plotting
# from nilearn.datasets import fetch_localizer_contrasts
# import matplotlib.pyplot as plt
# import numpy as np
# from nilearn.plotting import plot_design_matrix
# from nilearn.glm.second_level import SecondLevelModel

# n_subjects = 16
# sample_vertical = fetch_localizer_contrasts(
#     ["vertical checkerboard"], n_subjects, get_tmaps=True)
# sample_horizontal = fetch_localizer_contrasts(
#     ["horizontal checkerboard"], n_subjects, get_tmaps=True)

# second_level_input = sample_vertical['cmaps'] + sample_horizontal['cmaps']
# condition_effect = np.hstack(([1] * n_subjects, [- 1] * n_subjects))

# subject_effect = np.vstack((np.eye(n_subjects), np.eye(n_subjects)))
# subjects = [f'S{i:02d}' for i in range(1, n_subjects + 1)]

# unpaired_design_matrix = pd.DataFrame(
#     condition_effect[:, np.newaxis],
#     columns=['vertical vs horizontal'])

# paired_design_matrix = pd.DataFrame(
#     np.hstack((condition_effect[:, np.newaxis], subject_effect)),
#     columns=['vertical vs horizontal'] + subjects)

# _, (ax_unpaired, ax_paired) = plt.subplots(1,2, gridspec_kw={'width_ratios': [1, 17]})
# plot_design_matrix(unpaired_design_matrix, rescale=False, ax=ax_unpaired)
# plot_design_matrix(paired_design_matrix, rescale=False, ax=ax_paired)
# ax_unpaired.set_title('unpaired design', fontsize=12)
# ax_paired.set_title('paired design', fontsize=12)
# plt.tight_layout()
# plotting.show()

# second_level_model_unpaired = SecondLevelModel().fit(
#     second_level_input, design_matrix=unpaired_design_matrix)

# second_level_model_paired = SecondLevelModel().fit(
#     second_level_input, design_matrix=paired_design_matrix)

# stat_maps_unpaired = second_level_model_unpaired.compute_contrast(
#                                                     'vertical vs horizontal',
#                                                     output_type='all')

# stat_maps_paired = second_level_model_paired.compute_contrast(
#                                                 'vertical vs horizontal',
#                                                 output_type='all')



# from os.path import join as opj
# import numpy as np
# from nipype.interfaces.spm import SliceTiming, Realign, Smooth
# from nipype.interfaces.utility import IdentityInterface
# from nipype.interfaces.io import SelectFiles, DataSink
# from nipype.algorithms.rapidart import ArtifactDetect
# from nipype.algorithms.misc import Gunzip
# from nipype.pipeline.engine import Workflow, Node
# from nibabel.freesurfer.io import read_morph_data, read_geometry, read_annot
# from nibabel.freesurfer import mghformat
# from brainstat.stats.terms import FixedEffect
# from brainstat.datasets import fetch_template_surface, fetch_mask
# from brainstat.stats.SLM import SLM

# mgh = mghformat.load("E:/Box Sync/Arbeit/UZH/MasterArbeit/ScienceCloud/GLM/rh.ClusterASDvHCComparison.thickness.10.mgh")
# sub_1 = read_annot("E:/Linux/Exchange/Site-SI_Derivatives_UZH/sub-NDARAA075AMK_T1w/surf/rh.thickness.fwhm10.fsaverage.mgh")
# sub_2 = read_morph_data("E:/Box Sync/Arbeit/UZH/MasterArbeit/ScienceCloud/GLM/rh.ClusterASDvHCComparison.thickness.10.mgh")
# sub_3 = read_morph_data("E:/Linux/Exchange/Site-SI_Derivatives_UZH/sub-NDARAD481FXF_T1w/surf/rh.thickness")
# sub_4 = read_morph_data("E:/Linux/Exchange/Site-SI_Derivatives_UZH/sub-NDARAE199TDD_T1w/surf/rh.thickness")

# thicknesses  = np.empty((0,138289))
# thicknesses = np.vstack([thicknesses, sub_1])
# thicknesses = np.vstack([thicknesses, sub_2])
# thicknesses = np.vstack([thicknesses, sub_3])
# thicknesses = np.vstack([thicknesses, sub_4])
# groups = FixedEffect([1,1,0,0])


# dat = mgh.dataobj
# reshaped = np.transpose(dat)
# reshaped.shape
# smallset = reshaped[1:5]

# pial_left, pial_right = fetch_template_surface("civet41k", join=False)
# # pial_left, pial_right = fetch_template_surface("civet41k", join=False)
# pial_combined = fetch_template_surface("civet41k", join=True)

# pial_combined = fetch_template_surface("civet41k", join=True)
# mask = fetch_mask("civet41k")
# slm_age = SLM(groups, [1,1,0,0],surf=pial_combined, correction="rft")
# slm_age.fit(smallset)


import numpy as np
import pandas as pd
from brainspace.plotting import plot_hemispheres
from brainstat.datasets import fetch_template_surface, fetch_mask
from brainstat.tutorial.utils import fetch_abide_data
from brainstat.stats.terms import FixedEffect
from brainstat.stats.SLM import SLM
import brainstat as bs


# import os

# os.chdir("E:/Linux/Exchange/Site-SI_Derivatives_UZH")
fsa = fetch_template_surface("fsaverage")

# mask = fetch_mask("E:/Box Sync/Arbeit/UZH/MasterArbeit/ScienceCloud/GLM/lh.ClusterASDComparison.thickness.10.glmdir/ClusterASDComparison/cache.th30.abs.sig.cluster.mgh")
# fetch_mask()
sites = ("PITT", "OLIN", "OHSU")
thickness, demographics = fetch_abide_data(sites=sites, overwrite=False)
pial_left, pial_right = fetch_template_surface("civet41k", join=False)
pial_combined = fetch_template_surface("civet41k", join=True)
mask = fetch_mask("civet41k")

plot_hemispheres(
    pial_left,
    pial_right,
    np.mean(thickness, axis=0),
    color_bar=True,
    color_range=(1.5, 3.5),
    label_text=["Cortical Thickness"],
    embed_nb=True,
    size=(1400, 200),
    zoom=1.45,
    cb__labelTextProperty={"fontSize": 12},
)

term_age = FixedEffect(demographics.AGE_AT_SCAN)
# Subtract 1 from DX_GROUP so patient == 0 and healthy == 1.
term_patient = FixedEffect(demographics.DX_GROUP - 1)
model = term_age + term_patient
term_age_2 = FixedEffect(demographics.AGE_AT_SCAN.to_numpy(), "AGE_AT_SCAN")

contrast_age = model.AGE_AT_SCAN
slm_age = SLM(model, contrast_age, surf=pial_combined, mask=mask, correction="rft")
slm_age.fit(thickness)
from freesurfer_surface import Surface, Annotation
surf = Surface.read_triangular("E:/Linux/Exchange/Site-SI_Derivatives_UZH/sub-NDARAA075AMK_T1w/surf/lh.sphere.reg")

surf2 = Surface.read_triangular("E:/Box Sync/Arbeit/UZH/MasterArbeit/ScienceCloud/GLM/rh.ClusterASDvHCComparison.thickness.10.mgh")
annot = Annotation.read("E:/Linux/Exchange/Site-SI_Derivatives_UZH/sub-NDARAD481FXF_T1w/surf/rh.thickness.fwhm10.fsaverage.mgh")
len(surf.vertices)
len(surf2.vertices)
