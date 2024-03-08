---

title: Integrating Structural, Functional, and Biochemical Brain Imaging Data with MRShiny Brain - An Interactive Web Application.
subject: NRP 
subtitle: 
tags:
  - Preprint
  - Reproducible article
  - Neuroscience
authors:
  - name: Jessica Archibald
    orcid: 
    #equal-contrib: true
    affiliation: "1, 2 "
  - name: Alexander Mark Weber
    orcid: 
    affiliation: " 3 "
  - name: Paulina Scheuren
    orcid: 
    affiliation: " 1, 9 "
  - name: Oscar Ortiz
    orcid: 
    affiliation: " 1 "
 - name: Cassandra Choles
    orcid: 
    affiliation: " 1, 9 "
 - name: Jaime Lee
    orcid: 
    affiliation: " 1, 9 "
 - name: Niklaus Zölch
    orcid: 
    affiliation: " 5 "
  - name: Erin L. MacMillan
    orcid: 
    equal-contrib: true
    affiliation: " * 6,8,7 "
  - name: John L.K Kramer
    orcid: 
    equal-contrib: true
    affiliation: * 1,2,9

affiliations:
  - name: International Collaboration on Repair Discoveries (ICORD), University of British Columbia, Vancouver, Canada.
    index: 1
  - name: Department of Experimental Medicine, University of British Columbia, Vancouver, Canada.
    index: 2
  - name: Department of Pediatrics, University of British Columbia, Vancouver, Canada.
    index: 3
  - name: BC Children Hospital Research Institute, Vancouver, Canada. 
    index: 4
  - name: Forensic Medicine, Universität Zürich, Zürich, Switzerland.
    index: 5
  - name: Department of Radiology, University of British Columbia, Vancouver, Canada.
    index: 6
  - name: Image Tech Lab, Simon Fraser University, Surrey, Canada.
    index: 7
  - name: Philips Healthcare Canada, Markham, Canada.
    index: 8
  - name: Department of Anesthesiology, Pharmacology and Therapeutics, Faculty of Medicine, University of British Columbia, Vancouver, Canada.
    index: 9
    
date: 7 March 2024
bibliography: paper.bib

export:
---

# Abstract

The utilization of structural, functional, and biochemical data from the human brain has grown in addressing inquiries related to neurodegenerative and neuropsychiatric conditions. However, the normal variability within these measures has not been systematically reported. In this work, a database comprising these outcome measures in a healthy population (n=51) was established to potentially serve as a comparative reference. Healthy individuals underwent standardized procedures to ensure consistent collection of magnetic resonance imaging (MRI) and spectroscopy data. The MRI data was acquired using a 3T scanner with various sequences, including MPRAGE 3D T1w, pseudo-continuous arterial spin labelling (pCASL), and single voxel proton magnetic resonance spectroscopy (1H-MRS). Established and custom software tools were employed to analyze outcome measures such as tissue segmentation, cortical thickness, cerebral blood flow, and metabolite levels measured by MRS. This study provides a comprehensive overview of the data analysis process, aiming to facilitate future utilization of the collected data.


1     |     INTRODUCTION
========================


The pursuit to understand the biological foundations of neurodegenerative conditions has led to an extensive exploration of brain imaging data. Integrating various forms of brain imaging data and neurophysiological techniques such as magnetic resonance spectroscopy (MRS) has emerged as an essential approach to obtain a comprehensive understanding of these intricate conditions. By combining morphological, functional, and biochemical data, researchers gain invaluable insights into the intricate mechanisms underlying neurodegenerative diseases. These insights extend to identifying potential biomarkers and therapeutic targets, thereby paving the way for improved treatment strategies. A notable challenge in understanding the brain’s behaviour in disease lies in the incomplete comprehension of its state within a healthy population at rest.
 In the field of brain imaging, the importance of considering variability between individuals and across different brain regions is high. Creating a comprehensive database that includes data from multiple brain regions, and multiple modalities in a healthy population is invaluable for guiding future research and clinical use. This database acts as an important reference point, allowing researchers to measure deviations from the average, enabling early disease detection and monitoring progression across diverse populations. Furthermore, it enables a focused analysis of specific subsets of groups, for example, examining outcomes-based factors like sex or age that allow for matched comparisons.
Our study provides a description of the meticulous methodology that ensures consistency the data acquisition and analysis. Standardized procedures have been followed to guarantee the accuracy and reliability of the data gathered. This multi-modal approach encompasses a range of outcomes, including morphological measures such as brain tissue volume (gray matter, white matter, and cerebral spinal fluid) and cortical thickness. Additionally, we have included blood perfusion levels, biochemical profiles of different brain regions assessed through MRS, and temperature via MRS thermometry.
The MRShiny Brain application has been developed as a normative live database, designed to facilitate user-friendly access to a wide spectrum of morphological, perfusion, and biochemical brain data. Our core objective revolves around presenting a normative representation of the healthy brain during rest with the intent of empowering the scientific community to formulate a priori hypotheses. Recognizing that the analysis of MRI/MRS data can be a time-consuming and expertise-demanding task, we aim to provide this data in an accessible format, offering an informative overview of key measures for those seeking valuable insights.
As we examine the complex interplay brain function, it becomes evident that understanding the brain in a healthy state is pivotal to understanding it in pathological states. The challenge of understanding the brain's intricacies in various states, particularly during rest, underscores the importance of our study. By building a comprehensive foundation of knowledge through the integration of diverse imaging data, into a user-friendly database we aspire to drive advancements in our understanding of neurodegenerative conditions, leading to enhanced diagnostic precision and targeted therapeutic interventions.

2     |     METHODS
===================

2.1     |     Demographics
------------------------------------

This is a live database that undergoes continuous updates, resulting in changes to the following information. At the time of this report, 51 healthy participants have been recruited for this experiment (24M, mean age = 27.4 years, SD = 6.16 years, range = 19 - 47 years). Participants were asked to arrive at the laboratory in a fasting state to account for food intake effects[@kubota2021dynamic]. The timing of the scan was kept consistent (11:30am-12:30pm) across participants, in order to account for circadian rhythm effects of metabolites2. Regarding female participants, their testing was based on self-reported information regarding the phase of their menstrual cycle, specifically targeting the follicular phase. Figure 1 illustrates the study design. 

2.2     |     MR Acquisition Protocol
--------------------------------------
MRI data were collected using a 3T Philips Ingenia Elition X with a 32-channel SENSE head coil, and the sequences included:
1.	A MPRAGE 3D T1 weighted scan (TE/TR/TI=4.3/9.3/950ms, shot interval=2400ms, +0.8mm³ isotropic resolution, FOV (ap/rl/fh)=256/256/180mm³, scan time=5:49).
2.	A pseudo-continuous arterial spin labelling (pCASL) sequence was used to assess CBF. The sequence consisted of four pairs of perfusion-weighted and control scans (TE/TR=12/4174ms, post-labelling duration=2000ms, labelling duration=1800, total scan duration=5.59 min).
3.	Cingulate Cortex single voxel 1H-MRS scans (sLASER, TE/TR=32/5000ms, NSA=64, voxel size=24/22/15mm³ =7.9mL, automated 2nd order shimming, 32-step phase cycle, water suppression using the frequency selective Excitation option). The order of the four cingulate cortex voxels was randomized for each participant, including the periungual anterior cingulate cortex (pACC), the anterior and posterior mid-cingulate cortex (aMCC, pMCC) and the posterior cingulate cortex (PCC)4.


2.3     |     MR Analysis
--------------------------------------

**Structural Measures:** Image Segmentation was performed in FSL (v 6.05) using default options, ROI segmentation was performed using in-house MATLAB scripts. ROI Cortical Thickness was performed in native space for each subject using Freesurfer (v 7.2.0) - Code availability .
**Arterial Spin-Labeled MRI Preprocessing and Cerebral Blood Flow Computation:**
Arterial spin-labeled MRI images were preprocessed using ASLPrep 0.6.0rc15,6, which is based on fMRIPrep7,8 and Nipype 1.8.6s.
_Anatomical data preprocessing_
 A total of 50 T1-weighted (T1w) images were found within the input BIDS dataset. The T1-weighted (T1w) image was corrected for intensity non-uniformity (INU) with `N4BiasFieldCorrection`9, distributed with ANTs 2.3.310,11, and used as T1w-reference throughout the workflow. The T1w-reference was then skull-stripped with a Nipype implementation of the `antsBrainExtraction.sh` workflow (from ANTs), using OASIS30ANTs as target template. Brain tissue segmentation of cerebrospinal fluid (CSF), white-matter (WM) and gray-matter (GM) was performed on the brain extracted T1w using `fast` [FSL 6.0.7.1]12.
_ASL data preprocessing_
For the 1 ASL run found per subject, the following preprocessing was performed.
First, the middle volume of the ASL timeseries was selected as the reference volume and brain extracted using Nipype's custom brain extraction workflow. First, the middle M0 volume of the ASL timeseries was selected as the reference volume and brain extracted using Nipype’s custom brain extraction workflow. Susceptibility distortion correction (SDC) was omitted. Head-motion parameters were estimated for the ASL data using FSL's `mcflirt`13. Motion correction was performed separately for each of the volume types in order to account for intensity differences between different contrasts, which, when motion corrected together, can conflate intensity differences with head motions14. Next, ASLPrep concatenated the motion parameters across volume types and re-calculated relative root mean-squared deviation. ASLPrep co-registered the ASL reference to the T1w reference using FSL’s `flirt`15, which implemented the boundary-based registration cost-function16. Co-registration used 6 degrees of freedom. The quality of co-registration and normalization to template was quantified using the Dice and Jaccard indices, the cross-correlation with the reference image, and the overlap between the ASL and reference images (e.g., image coverage). Several confounding timeseries were calculated, including both framewise displacement (FD) and DVARS. FD and DVARS are calculated using the implementations in Nipype (following the definition by17) for each ASL run.  ASLPrep summarizes in-scanner motion as the mean framewise displacement and relative root-mean square displacement.
_Cerebral blood flow computation and denoising_
ASLPrep calculated cerebral blood flow (CBF) from the single-delayPCASL using a single-compartment general kinetic model18. Calibration (M0) volumes associated with the ASL scan were smoothed with a Gaussian kernel (FWHM=5 mm) and the average calibration image was calculated and scaled by 1. First, the middle volume of the ASL timeseries was selected as the reference volume and brain extracted using Nipype's custom brain extraction workflow.
_ROI CBF estimates_
ROI perfusion levels were extracted in native space using each ROI’s mask. Firstly the images were co-registered using ‘flirt’15, the resampled mask was then binarized, and ROI CBF was calculated using fslstats `cbf_extraction.sh`  - Code availability.
_Quality Evaluation Index (QEI)_
The QEI was computed for each CBF map [@dolui2017automated]. QEI is based on the similarity between the CBF and the structural images, the spatial variability of the CBF image, and the percentage of grey matter voxels containing negative CBF values ‘Quality_aslprep.sh`  - Code availability.
Many internal operations of ASLPrep use Nilearn 0.10.019, NumPy20, and SciPy21. For more details of the pipeline, see [ASLPrep-Documentation].
**MR Spectroscopy:** MRS analysis was performed following the recent expert guideline recommendations22–24. MRS data was pre-processed (e.g., frequency alignment, and eddy-current correction) and quantified using in-house MATLAB scripts. Spectral fitting was performed in LCModel (6.3). The basis set was simulated using he FID-A run-simLaserShapted_fast.m function- (Link code-). The simulation included the following metabolites: PE, Asc, Scyllo, Glu, Gln, Cre, NAA, NAAG, PCr, GSH, Gly, Glc, GPC, Ala, Asp, GABA, Ins, Lac, and Tau. The LCModel fit was performed in the range of 0.5 to 4.0 ppm.

2.4     |     Dashboard
--------------------------------------
To facilitate the reuse and exploration of the data, we have developed an interactive web application using R Shiny. This application provides an intuitive and user-friendly interface for accessing and analyzing the dataset. The application allows users to interact with the data in a dynamic manner, enabling exploration, visualization, and integration with other datasets.The dataset is composed of four types of data structural, perfusion, and biochemical,  which have been included in the MRShiny web-application and are described below. These data can all be downloaded directly via the MRShiny web-application.
_Structural_
1.	GM: gray matter fraction in each region of interest. 
2.	WM: white matter fraction in each region of interest.
3.	CSF: cerebrospinal fluid fraction in each region of interest.
4.	CT: Cortical thickness in mm in each region of interest.
_Perfusion_
1.	CBF: cerebral blood flow (mL/gr/min) in each region of interest.
_Biochemical_ 
1.	Metabolites available: N-Acetyl aspartic acid (NAA), total creatine (tCr), total choline (tCho), myoinositol (mI), glutamate (Glu), glutamine (Gln), and glutamate+glutamine (Glx).
2.	Quality Measures signal-to-noise-ration (SNR), linewidth of the water spectrum (LW), and Cramer-Rao Lower Bounds of each metabolite (CRLB).

3     |     RESULTS
-------------------

The quality metrics of the spectra can be seen in the application directly, while Figure 3 illustrates the pre-processed and baseline corrected spectra. 

**Missing data:** MRS and CBF data (1 M) were unable to be included since the individual transients, and pCASL data were not properly saved, but CT data was viable. For three participants we excluded metabolites from one location (i.e., pACC (n=1), aMCC (n=1), and PCC (n=1)), due to linewidth of the water being >10Hz. The MRS data quality from the remaining participants are illustrated in app. The mean  std.dev of the quality evaluation index (QEI)25 for ASL CBF maps for the 50 subjects is  0.794 0.032.

4     |     CONCLUSION
----------------------

## References


# Mathematics

Single dollars ($) are required for inline mathematics e.g. $f(x) = e^{\pi/x}$

Double dollars make self-standing equations:

$$\Theta(x) = \left\{\begin{array}{l}
0\textrm{ if } x < 0\cr
1\textrm{ else}
\end{array}\right.$$

You can also use plain \LaTeX for equations
\begin{equation}\label{eq:fourier}
\hat f(\omega) = \int_{-\infty}^{\infty} f(x) e^{i\omega x} dx
\end{equation}
and refer to \autoref{eq:fourier} from text.

# Citations

Citations to entries in `preprint.bib` should be in
[rMarkdown](http://rmarkdown.rstudio.com/authoring_bibliographies_and_citations.html)
format.

For a quick reference, the following citation commands can be used:
* `@author:2021`  ->  "Author et al. (2021)"
* `[@author:2021]` -> "(Author et al., 2021)"
* `[@author1:2021; @author2:2001]` -> "(Author1 et al., 2021; Author2 et al., 2021)"

This is an example citation [@neurolibre:2021].




# Figures

Figures can be included like this:

![Caption for example figure.\label{fig:example}](images/example_figure.png)

You can reference figure from text using \autoref{fig:example}.

Figure sizes can be customized by adding an optional second parameter:

![Caption for example figure.](images/example_figure.png){ width=20% }

# Acknowledgements

NeuroLibre is sponsored by Canadian Open Neuroscience Platform (CONP), Brain Canada, Quebec Bioimaging Network, Cancer Computing and Healthy Brains & Healthy Life. 



## Features of MyST

MyST is focused on scientific writing, and ensuring that citations are first class both for writing and for reading (see Figure 1).

![](./images/citations.png)
**Figure 1**: Citations are rendered with a popup directly inline.

MyST aims to show as much information in context as possible, for example, Figure 2 shows a reading experience for a referenced equation: you can immediately **click on the reference**, see the equation, all without loosing any context -- ultimately saving you time. Head _et al._ (2021) found that these ideas both improved the overall reading experience of articles as well as allowed researchers to answer questions about an article **26% faster** when compared to a traditional PDF!

![](./images/equations.gif)
**Figure 2**: In context cross-references improve the reading experience.

One of the important underlying goals of practicing reproducibility, sharing more of the methods and data behind a scientific work so that other researchers can both verify as well as build upon your findings. One of the exciting ways to pull for reproducibility is to make documents directly linked to data and computation! In Figure 3, we are showing outputs from a Jupyter Notebook directly part of the published scientific narrative.

![](./images/interactive.gif)
**Figure 3**: Embedding data, interactivity and computation into a MyST article.

To drive all of these features, the contents of a MyST document needs to be well defined. This is critical for powering interactive hovers, linked citations, and compatibility with scientific publishing standards like the Journal Article Metadata Tag Suite (JATS). We have an emerging specification for MyST, [`myst-spec`](https://spec.myst.tools), that aims to capture this information and transform it between many different formats, like PDF, Word, JSON, and JATS XML (Figure 4). This specification is arrived at through a community-centric MyST Enhancement Proposal ([MEP](https://compass.executablebooks.org/en/latest/meps.html)) process.

![](./images/structured-data.gif)
**Figure 4**: The data behind MyST is **structured**, which means we can transform it into many different document types and use it to power all sorts of exciting features!

One of the common forms of scientific communication today is through PDF documents. MyST has excellent support for creating PDF documents, using a data-driven templating library called `jtex`. The document in Figure 5 was created using MyST!

![](./images/pdf-two-column.png)
**Figure 5**: A PDF rendering through MyST.



