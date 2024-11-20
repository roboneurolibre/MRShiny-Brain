---
numbering:
  heading_2: false
  figure:
    template: Fig. %s
---

+++ { "part": "abstract" }

The utilization of structural, functional, and biochemical data from the human brain has grown in addressing inquiries related to neurodegenerative and neuropsychiatric conditions. However, the normal variability within these measures has not been systematically reported. In this work, a database comprising these outcome measures in a healthy population (`n=51`) was established to potentially serve as a comparative reference. Healthy individuals underwent standardized procedures to ensure consistent collection of magnetic resonance imaging (`MRI`) and spectroscopy data. The MR data was acquired using a 3T scanner with various sequences, including MPRAGE 3D T1w, pseudo-continuous arterial spin labelling (`pCASL`), and single voxel proton magnetic resonance spectroscopy (`1H-MRS`). Established and custom software tools were employed to analyze outcome measures such as tissue segmentation, cortical thickness, cerebral blood flow, metabolite levels, and temperature estimated using MRS. This study provides a comprehensive overview of the data analysis process, aiming to facilitate future utilization of the collected data through an [interactive dashboard](#intdashboard) developed in [R](https://en.wikipedia.org/wiki/R_(programming_language)#:~:text=R%20is%20a%20programming%20language,%2C%20bioinformatics%2C%20and%20data%20analysis.) using the [Shiny](https://en.wikipedia.org/wiki/Shiny_(software)) framework.

+++

## INTRODUCTION

:::{figure} #fig1cell
:label: fig3

An example of a figure generated from a Jupyter Notebook that lives in the `content` folder of this repository. Check `content/figure_1.ipynb` to see how this figure was generated and where the label `#fig1cell` is defined.
:::

The pursuit to understand the biological foundations of neurodegenerative and neuropsychiatric conditions has led to an extensive exploration of brain imaging and neurophysiological tools. Integrating various magnetic resonance imaging (MRI) modalities has emerged as an essential approach to obtain a comprehensive understanding of these conditions. By combining morphological, functional, and biochemical data, researchers gain valuable insights into the intricate mechanisms underlying neurological diseases. These insights extend to identifying potential biomarkers and therapeutic targets, thereby paving the way for improved treatment strategies for neurological disorders.

A notable challenge in understanding the brain’s behaviour in disease lies in the incomplete comprehension of its state within a healthy population at rest. In the field of brain imaging, the importance of considering variability between individuals and across different brain regions is high. Therefore, creating a comprehensive database that includes information from multiple brain regions, and multiple modalities in a healthy population is invaluable for guiding future research and clinical use. Such a database can be utilized as a reference, allowing researchers to measure deviations, potentially enabling early disease detection and monitoring progression across different populations. Furthermore, it enables a focused analysis of specific subsets of groups, for example, examining outcomes-based factors like sex or age that allow for matched comparisons.

Our study provides a description of the meticulous methodology that ensures consistency of the data acquisition and analysis methods. Standardized procedures have been followed to maximize the precision of the data gathered. The outcomes available include morphological measures such as brain tissue volume (gray matter, white matter, and cerebral spinal fluid) and cortical thickness. Additionally, we have included blood perfusion levels, biochemical profiles, and temperature of different brain regions assessed through MR spectroscopy (MRS).

The MRShiny Brain application has been developed as a normative live database, designed to facilitate user-friendly access to a wide spectrum of morphological, perfusion, biochemical, and temperature brain data. Our core objective revolves around presenting a normative representation of the healthy brain during rest with the intent of empowering the scientific community to formulate a priori hypotheses. Recognizing that the analysis of MRI/MRS data can be a time-consuming and expertise-demanding task, we aim to provide these data and the analysis scripts in an accessible format.

As we examine brain function, it becomes evident that understanding the brain in a healthy state is pivotal to understanding it in pathological states. The challenge of understanding the brain’s intricacies in various states, particularly during rest, underscores the importance of our study. By building a comprehensive foundation of knowledge through the integration of diverse brain outcome measures, into a user-friendly database we aim to drive advancements in our understanding of brain function.


## METHODS

### Demographics

This is a live database that undergoes continuous updates, resulting in changes to the following information. At the time of this report, 51 healthy participants have been recruited for this experiment (24M, mean age = 27.4 years, SD = 6.16 years, range = 19 - 47 years). Participants were asked to arrive at the laboratory in a fasting state, and were given one muffin to eat about one hour prior to the MRI scan to account for food intake effects [@kubota2021dynamic]. The timing of the scan was kept consistent (11:30am-12:30pm) across participants, to account for circadian rhythm effects of metabolites [@eckelmahan2013metabolism]. Regarding female participants, their testing was based on self-reported information regarding the phase of their menstrual cycle, specifically targeting the follicular phase [@hjelmervik2018sex]. [](#fig1) illustrates the study design. 

```{figure} images/fig1.png
:label: fig1
:align: center


Study design. MR scans included an anatomical 3DT1, a pseudo-continuous arterial spin labelling (pCASL) sequence, and an MR Spectroscopy (MRS) sequence sLASER. MRS data were collected at 4 different voxel locations (periungual anterior cingulate cortex [pACC], anterior mid-cingulate cortex [aMCC], posterior mid-cingulate cortex [pMCC], and the posterior cingulate cortex [PCC]) The order of the MRS acquisition from each voxel was randomized for each participant. Figure modified with text, markings, and colour after adaptation of “Nervous System & Medical Equipment” from Servier Medical Art by Servier, licensed under a Creative Commons Attribution 3.0 Unported License.
```

### MR Acquisition Protocol

MRI data were collected using a _3T Philips Ingenia Elition X_ with a 32-channel _SENSE head coil_, and the sequences included:

::::{tab-set}
:::{tab-item} 3D MPRAGE
:sync: tab1
An MPRAGE 3D T1 weighted scan (`TE/TR/TI`=`4.3/9.3/950ms`, `shot interval`=`2400ms`, `+0.8mm³ isotropic` resolution, `FOV` (`ap/rl/fh`)=`256/256/180mm³`, `scan time`=`5:49 min`).
:::
:::{tab-item} pCASL
:sync: tab2
A pseudo-continuous arterial spin labelling (pCASL) sequence was used to assess CBF. The sequence consisted of four pairs of perfusion-weighted and control scans (`TE/TR=12/4174ms`, `post-labelling duration`=`2000ms`, `labelling duration`=`1800ms`, `total scan duration`=`5.59 min`).
:::
:::{tab-item} 1H-MRS
:sync: tab3
Four cingulate cortex single voxel 1H-MRS scans (semi-adiabatic Localization by Adiabatic SElective Refocusing: sLASER, `TE/TR`=`32/5000 ms`, `NSA`=`64`, `voxel size`=`24/22/15 mm³ =7.9mL`, `automated 2nd order shimming`, `32-step phase cycle`, `water suppression using the frequency selective Excitation option`). The order of the four cingulate cortex voxels was randomized for each participant, including the periungual anterior cingulate cortex (pACC), the anterior and posterior mid-cingulate cortex (aMCC, pMCC) and the posterior cingulate cortex (PCC) [@vogt2019cingulate].
:::
::::

### MR Analysis

#### Structural Measures:

Image Segmentation was performed in FSL (`v6.05`) using default options, ROI segmentation was performed using in-house MATLAB scripts. ROI Cortical Thickness was performed in native space for each subject using Freesurfer (v 7.2.0) [Code Availability ](https://github.com/arcj-hub/Freesurfer-CT-native-space).

#### Arterial Spin-Labeled MRI Preprocessing and Cerebral Blood Flow Computation:

Arterial spin-labeled MRI images were preprocessed using ASLPrep `0.6.0rc` [@adebimpe2022aslprep;@salo2023aslprep], which is based on fMRIPrep [@esteban2019fmriprep;@esteban2020analysis] and Nipype `1.8.6s`.

#### Anatomical data preprocessing

A total of 50 T1-weighted (T1w) images were found within the input BIDS dataset. The T1-weighted (T1w) image was corrected for intensity non-uniformity (INU) with `N4BiasFieldCorrection` [@avants2014ants], distributed with ANTs `2.3.3` [@avants2008symmetric], and used as T1w-reference throughout the workflow. The T1w-reference was then skull-stripped with a Nipype implementation of the `antsBrainExtraction.sh` workflow (from ANTs), using OASIS30ANTs as target template. Brain tissue segmentation of cerebrospinal fluid (CSF), white-matter (WM) and gray-matter (GM) was performed on the brain extracted T1w using `fast` (FSL `6.0.7.1`) [@jenkinson2002improved].

#### ASL data preprocessing

For the 1 ASL run obtained per subject, the following preprocessing was performed:

First, the second volume of the ASL timeseries was selected as the reference volume and brain extracted using Nipype's custom brain extraction workflow. First, the middle M0 volume of the ASL timeseries was selected as the reference volume and brain extracted using Nipype’s custom brain extraction workflow. Susceptibility distortion correction (SDC) was omitted. Head-motion parameters were estimated for the ASL data using FSL's `mcflirt` [@wang2008empirical]. Motion correction was performed separately for each of the volume types in order to account for intensity differences between different contrasts, which, when motion corrected together, can conflate intensity differences with head motions [@jenkinson2001global]. Next, ASLPrep concatenated the motion parameters across volume types and re-calculated relative root mean-squared deviation. ASLPrep co-registered the ASL reference to the T1w reference using FSL’s `flirt` [@greve2009accurate], which implemented the boundary-based registration cost-function [@power2014methods]. Co-registration used 6 degrees of freedom. The quality of co-registration and normalization to template was quantified using the Dice and Jaccard indices, the cross-correlation with the reference image, and the overlap between the ASL and reference images (e.g., image coverage). Several confounding timeseries were calculated, including both framewise displacement (FD) and temporal derivative of variance over runs (DVARS). FD and DVARS are calculated using the implementations in Nipype (following the definition by [@buxton1998general]) for each ASL run. ASLPrep summarizes in-scanner motion as the mean FD and relative root-mean square displacement.

#### Cerebral blood flow computation and denoising

ASLPrep calculated cerebral blood flow (CBF) from the single-delayPCASL using a single-compartment general kinetic model [@abraham2014machine]. Calibration (M0) volumes associated with the ASL scan were smoothed with a Gaussian kernel (FWHM=5 mm) and the average calibration image was calculated and scaled by 1.

#### ROI CBF estimates

ROI perfusion levels were extracted in native space using each ROI’s mask. Firstly the images were co-registered using `flirt` [@greve2009accurate], the resampled mask was then binarized, and ROI CBF was calculated using fslstats `cbf_extraction.sh` ([code Availability](https://github.com/arcj-hub/ASLprep-CBF-Analysis)).

#### Quality Evaluation Index (QEI)

The QEI was computed for each CBF map [@dolui2017structural]. QEI is based on the similarity between the CBF and the structural images, the spatial variability of the CBF image, and the percentage of grey matter voxels containing negative CBF values ‘Quality_aslprep.sh` ([code Availability](https://github.com/arcj-hub/ASLprep-CBF-Analysis)). For more details of the pipeline, see [ASLPrep-Documentation](https://aslprep.readthedocs.io/en/latest/).

#### MR Spectroscopy:

MRS analysis was performed following the recent expert guideline recommendations [@near2021preprocessing]. MRS data was pre-processed (e.g., `frequency alignment`, and `eddy-current correction`) and quantified using in-house MATLAB scripts. Spectral fitting was performed in LCModel (`6.3`). The basis set was simulated using the FID-A `run-simLaserShapted_fast.m` [@simpson2017advanced] function- [Code Availability](https://github.com/arcj-hub/BasisSetSimulation). The simulation included the following metabolites: PE, Asc, Scyllo, Glu, Gln, Cre, NAA, NAAG, PCr, GSH, Gly, Glc, GPC, Ala, Asp, GABA, Ins, Lac, and Tau. The LCModel fit was performed in the range of 0.5 to 4.0 ppm.

#### MRS thermometry:

MRS thermometry exploits the temperature dependence of the location of the water peak on the frequency axis (-0.01 ppm/°C), whereas that at the reference metabolite [e.g., N-acetylasparteate (NAA)] is not temperature dependent [@cady1995estimation;@thrippleton2014reliability]. After data pre-processing (i.e., frequency alignment, eddy current correction), local brain temperature (TB) was estimated by calculating the chemical shift difference between water and NAA measured in parts per million (ppm) using equation [](#equation1):

```{math}
:label: equation1
TB(\degree{C}) = 100 \times [\Delta(NAA_{ppm} - water_{ppm}) + 2.665] + 37
```

NAAppm and waterppm values were defined as the mid-point of the full width half max (FWHM) for both the NAA and water peaks, respectively. TB was estimated for each voxel separately (i.e., pACC, aMCC, pMCC, PCC).[Code Availability ](https://github.com/psscheuren).

### DASHBOARD

To facilitate the reuse and exploration of the data, we have developed an interactive web application using R Shiny. This application provides an intuitive and user-friendly interface for accessing and analyzing the dataset. The application allows users to interact with the data in a dynamic manner, enabling exploration, visualization, and integration with other datasets. The dataset is composed of different types of data structural, perfusion, and biochemical. These data can all be downloaded directly via the [MRShiny Brain web-application](https://shinybrain.db.neurolibre.org) deployed on NeuroLibre [@karakuzu2022nl].

:::: {admonition} Interact with the dashboard here!
:class: tip
:::{iframe} https://shinybrain.db.neurolibre.org
:width: 100%
:label: intdashboard
:align: center

MRShiny Brain interactive dashboard at [https://shinybrain.db.neurolibre.org](https://shinybrain.db.neurolibre.org)
:::
::::

#### Structural

1. GM: gray matter fraction in each region of interest.
2. WM: white matter fraction in each region of interest.
3. CSF: cerebrospinal fluid fraction in each region of interest.
4. CT: Cortical thickness in mm in each region of interest.

#### Perfusion

1. CBF: cerebral blood flow (`mL/gr/min`) in each region of interest.

#### Biochemical

1. Metabolites available: N-Acetyl aspartic acid (NAA), total creatine (tCr), total choline (tCho), myoinositol (mI), glutamate (Glu), glutamine (Gln), and glutamate+glutamine (Glx).
2. Quality Measures signal-to-noise-ration (SNR), linewidth of the water spectrum (LW), and Cramer-Rao Lower Bounds of each metabolite (CRLB).

#### Thermometry

1. Temperature: Temperature in Celcius {math}`\degree C` in each brain region of interest.


## RESULTS

The quality metrics of the spectra can be seen in the application directly, while [](#fig2) illustrates the pre-processed and baseline corrected spectra.

```{figure} images/fig2.png
:label: fig2
:align: center

MRS Average Spectra at each brain location. Averaged participant spectra are illustrated in gray, and the group mean in black. MRS data were collected at 4 different voxel locations (periungual anterior cingulate cortex [pACC], anterior mid-cingulate cortex [aMCC], posterior mid-cingulate cortex [pMCC], and the posterior cingulate cortex [PCC]).
```

```{admonition} Missing Data
:class: warning

MRS and CBF data (1 M) were unable to be included since the individual transients, and pCASL data were not properly saved, but CT data was viable. For three participants we excluded metabolites from one location (i.e., pACC (n=1), aMCC (n=1), and PCC (n=1)), due to linewidth of the water being >10Hz. The MRS data quality from the remaining participants are illustrated in app. The mean ± std.dev of the quality evaluation index (QEI)25 for ASL CBF maps for the 50 subjects is  0.794 ± 0.032.
```

## CONCLUSION

In summary, this work provides a database containing structural, functional, and biochemical data from the brains of 51 healthy participants. This resource serves as a valuable reference for researchers exploring neurodegenerative and neuropsychiatric conditions. The interplay of structural, functional, and biochemical measures within a healthy population may provide an understanding of normal variability, laying the groundwork for more nuanced investigations into neurological conditions.

+++ { "part": "acknowledgements" }

The UBC MRI technologists are sincerely thanked for their valuable assistance and support throughout the study. The following funding sources are also acknowledged: J. Archibald's research scholarship from the National Council of Science and Technology (CONACYT), GSD-NSERC, and the Friedman Foundation. P.S. Scheuren is supported by the International Foundation for Research in Paraplegia (P 198 F), the Swiss National Science Foundation (P500PB_214416), and Michael Smith Health Research BC (RT-2023-3173). E.L. MacMillan’s salary support from Philips Canada; and J. Kramer’s funding from an NSERC Discovery Grant.

+++


+++ { "part": "data_availability" }

An interactive NeuroLibre dashboard has been deployed at https://shinybrain.db.neurolibre.org. The data is downloadable within the application. The analysis scripts are available on github, with the exception of the MRS preprocessing MRS MATLAB code, this can be accessed by reaching out to ELM directly `erin.macmillan@ubc.ca`.

+++
