# Two-photon calcium imaging analysis of neuronal activity in functionally specific populations

Matlab code for the analysis of neural imaging data in awake behaving animals for the publication entitled: [Molecularly targetable cell types in mouse visual cortex have distinguishable prediction error responses](https://www.cell.com/neuron/pdf/S0896-6273(23)00626-8.pdf). This README contains modified excerpts from that study as well as descriptions for each individual piece of code.

**Please note** that this repository, even with the appropriate libraries and packages installed, will not operate independently. Due to size limitations, the **original datasets** are not included. However, for those who are interested, the *original published dataset* as well as the code are available [elsewhere](https://doi.org/10.5281/zenodo.8229544).


## Project Organization
```
┌── correlate_pc_with_act.m                         : funciton that returns a set of correlations given several inputs
|── delta_calc.m                                    : returns the delta values for a set of time points given a peak and baseline period
├── determine_frameset_fig_6.m                      : function which returns the indices of specific imaging frames relevant to a particular paradigm, ie only a subset of imaged frames contain a relevant behavioral paradigm or specific stimulus
├── determine_frameset_with_running_thresh.m        : similar to the previous function, except some framesets are excluded due to insufficient running values
├── estimate_noise_std.m                            : calculates the standard deviation of the of noise, as estimated by comparing odd to even behavioral triggers
├── fig_1_panels.m                                  : displays example behavioral auxillary images, example microscopy images, raster plots for calcium imaging traces, as well as regression and correlation plots
├── fig_6_panels_A_B_C.m                            : top level script for processing calcium imaging data and displaying average calcium imaging traces across specific paradigms and cell types
├── fig_6_panels_D_E_F.m                            : top level script for estimating the noise contributions to the signals examined in panels A,B and C.
├── fig_6_panels_G_H.m                              : top level script for calculating and and plotting the correlations between neural activity and either running or visual flow
├── filter_pval_array.m                             : funciton that remove significant p-values that are only briefly significant in a time series data set
├── ftfil.m                                         : high/low pass filter function (borrowed/not my code)
├── getExpLog.m                                     : function that retrieves experiment log data (borrowed/not my code)
├── get_deltas_per_site.m                           : function that calculates the average delta value per imaging site
├── get_file_size.m                                 : function that gets file size (borrowed/not my code)
├── get_indices_fig_1.m                             : retrieves the indices for a set of regions of interest (ROIs) used the calculate average fluorescence values for the photoconversion ratio analysis
├── get_run_vis_correlations_flg.m                  : function for calculating the correlaiton values per neuron between neural activity and either running speed or visual flow speed
├── get_site_indices_for_bootstrap.m                : function for acquiring frame indices for a particular set of sites
├── get_snps_flg.m                                  : function, that given a stimulus type, a set of imaging sites and threshold parameters, will return snippets of activity for the queried stimulus type across all neurons
├── get_snps_flg_odd_even.m                         : returns a subset of activity snippets, used for noise estimation
├── get_the_deltas.m                                : returns the calcium deltas for the CaMPARI data set
├── get_the_figs_matlab.m                           : master script for generating all matlab relevant figures for O'Toole, 2023 manuscript
├── get_the_roi_counts.m                            : returns the number of ROIs for a given set of imaging sites
├── get_the_snps_fig_1.m                            : function for acuuiring stimulus specific snippets of activity, specifically for the CaMPARI data set
├── get_unique_animals.m                            : funciton that returns the number of unique animals for a set of imaging sites
├── load_ach_chans.m                                : loads the auxilary channels (running, visual stimulus, etc.) for a given experimental id (borrowed/not my code)
├── load_lvd.m                                      : loads an auxilary data file (borrowed/not my code)
├── nan_sem.m                                       : calculates standard error of the mean while ignoring nans (borrowed/not my code)
├── nan_std.m                                       : calculates standard deviation of the mean while ignorning nans (borrowed/not my code)
├── nbstrp.m                                        : function that, given two or more groupings, an input data set, and a number of repetitions, performs a hierarchical bootstrap comparison (borrowed/not my code)
├── normalizeVector.m                               : funciton that normalizes an input to its peak value
├── plotSEM.m                                       : funciton that plots the average of time series data along with the standard error of the mean (borrowed/not my code)
├── plot_dist_with_noise_estimate.m                 : plotting code for displaying the distribution of noise estimates alongside the experimentally obtained value
├── plot_linear_models.m                            : plotting code for multiple linear regressions
├── plot_the_traces_fig_6.m                         : plotting code for calcium activity comparisons, outputs statistical comparisons, averaged traces as well as running and visual stimuli
├── ratio_calc.m                                    : for a set of sites returns the ratio of red to green fluorescence for all ROIs
├── smooth2.m                                       : smoothing function (borrowed/not my code)
├── supp_1_panels_a_through_c.m                     : plotting code for displaying multiple regressions across aniumals for comparing photoconversion to neural activity responses
├── supp_1_panels_d_through_j.m                     : facs data plotting code 
├── supp_6_all_panels.m                             : plots numerous supplemental panels related to calcium imaging experiments
├── trig2snps_.m                                    : given a set of triggers or indices returns calcium activity snippets around those indices (borrowed/not my code)
├── trig2snps2.m                                    : modified version of trig2nps, returns additional auxilary traces (modified from borrowed code)
├── images/                                         : contains example images used for explanations within the README
│   └── XXX.png
│   └── XXX.png
├── ca.m                                            : clears all currently open figures (borrowned/not my code)
├── act2mat.m/                                      : converts all z-layers for one imaging site and time point into to a matrix (borrowed/not my code)
├── LICENSE.md                                      : license
└── README.md                                       : project description

```

## Modified excerpts (figures and methods) from O'Toole et al. 2023 relevant to this repository

<p align="center">
            <img src="https://github.com/sean-otoole/2p_neural_activity_otoole_2023/blob/main/images/figure_1.png" width = "900" align = "middle">
</p>

### Functional tagging with CaMPARI2
**(A)** Schematic of the experimental approach: C57BL/6 mice that express CaMPARI2 in V1 were head-fixed on a spherical treadmill in a virtual reality environment.
A 405 nm laser was directed at V1 through a cranial window to trigger photoconversion of CaMPARI2. Tissue from granular and supragranular layers of V1 was
dissected, dissociated, sorted into different photoconversion groups using FACS (low photoconversion is green, intermediate photoconversion is pink, high
photoconversion is red), and single-cell RNA-sequenced with the 10x Genomics platform.
**(B)** Three separate experimental groups for functional tagging were used. In the first group of mice (left), photoconversion (purple shading) was triggered on
visuomotor mismatch events. In the second group of mice (middle), photoconversion was triggered on running onsets in darkness. In the third group of mice
(right), photoconversion was triggered on onsets of full-field drifting grating stimuli while the mouse was stationary.
**(C)** CaMPARI2 fluorescence after photoconversion during visuomotor mismatch in L2/3 neurons. Only a subset of expressing CaMPARI2 (top left, identified with
green fluorescence) showed red fluorescence (top right). Bottom image is a merge of the green and red images. Scale bars are 25 mm.
**(D)** Average CaMPARI2 responses in the green channel to visuomotor mismatch for 417 neurons recorded in 4 mice, sorted by the strength of visuomotor
mismatch response. Note, increases in calcium result in decreases in green fluorescence. Dashed white and pink boxes show to the baseline subtraction (BL) and
response windows used to calculate mismatch responses for (E) and (F).
**(E)** Scatterplot of the average fluorescence response to visuomotor mismatch plotted against the ratio of photoconversion. A ratio of red/green fluorescence (F red/
F green) was used as a measure of photoconversion. Plotted are neurons from 4 mice that underwent photoconversion during visuomotor mismatch. The red line is
a linear fit (r = 0.043). Shading indicates the 95% confidence bound for the linear fit. Here and elsewhere: p < 0.05; **p < 0.01; ***p < 0.001; n.s., not significant.
**(F)** Population vector correlation of the visuomotor mismatch, running onset, and grating onset response with photoconversion during mismatch (4 mice). Red
horizontal bars mark median. Note, the data and fit shown in (E) are aggregated over mice.

***

<p align="center">
            <img src="https://github.com/sean-otoole/2p_neural_activity_otoole_2023/blob/main/images/figure_6.png" width = "900" align = "middle">
</p>

### L2/3 neurons targeted by artificial promoters exhibited differential visuomotor responses
**(A)** The average response to visuomotor mismatch in the AP.Adamts2.1 labeled population (orange) was stronger than in the AP.Agmat.1 (dark gray) and the
AP.Baz1a.1 (blue) population. Orange shading indicates the duration of visuomotor mismatch; gray shading indicates the SEM over neurons. Response curves
were compared bin-by-bin and intervals of at least 2 significant consecutive bins (p < 0.05) are marked with a black bar. Each of the three comparisons is denoted
by a pair of line segments to the left, corresponding in color to the data being plotted.
**(B)** As in **A**, but for the response to running onsets.
**(C)** As in **A**, but for the response to the onset of randomized grating.
**(D)** Distribution (smoothed) of mismatch responses of all Adamts2 (orange), Agmat (black), and Baz1a (blue) neurons. Same data as in (A). Vertical lines mark
means. Dark horizontal lines mark standard deviation of the data. The light horizontal lines below are an estimated lower bound of the trial-to-trial measurement
noise of the calcium responses. Note, the response variance within a cell type can be fully explained by the trial-to-trial noise of the calcium
response measurement.
**(E)** As in **D**, but for the response to running onsets.
**(F)** As in **D**, but for the response to the onset of randomized grating.
**(G)** Average correlation of neuronal activity with visual flow speed during open-loop sessions for L2/3 Adamts2, Agmat, and Baz1a neurons. Error bars indicate
SEM over neurons. *p < 0.05; **p < 0.01; ***p < 0.001; n.s.: not significant.
**(H)** As in **D**, but for average correlation of neuronal activity with running during open-loop sessions. Error bars indicate SEM over neurons.
**(I)** Schematic of a model circuit that would explain the response properties of Adamts2 and Rrad L2/3 excitatory neuron types. Triangles indicate L2/3 excitatory
neuron types; circles indicate inhibitory interneurons. L2/3 Adamts2 neurons respond to visuomotor mismatch, and their activity is positively correlated with
running and negatively correlated with visual flow speed. This is consistent with the functional signature of a negative prediction error neuron. L2/3 Rrad neurons
show visually driven responses and are significantly less driven by running than the other cell types, suggesting that they function as positive prediction error
neurons. Previous work has suggested that negative prediction error neurons are bottom-up inhibited by Sst positive interneurons, while the source of top-
down inhibition on positive prediction error neurons remains unclear.

***

<p align="center">
            <img src="https://github.com/sean-otoole/2p_neural_activity_otoole_2023/blob/main/images/figure_s1.png" width = "900" align = "middle">
</p>

### CaMPARI2 labelled neurons display functional specificity and are suitable for FACS sorting.
**(A)** Scatter plot of the average fluorescence response to visuomotor mismatch plotted against the level of photoconversion per neuron, in mice that underwent photoconversion during visuomotor mismatch. Different colors mark data from different mice. Each line is an estimate of a fit to the data using linear regression for each of the 4 mice.
**(B)** As in **A**, but for the running onset response.
**(C)** As in **A**, but for the grating onset response.
**(D)** Scatter plot of green and red fluorescence after FACS of an example dissociated piece of dissociated cortical tissue without CaMPARI2 expression. Each dot corresponds to one putative cell. Cells were selected for size, filtered for doublets, and high Draq7 (dead) cells were excluded.
**(E)** As in **D**, but for an infected cortical preparation that expressed CaMPARI2 without photoconversion.
**(F)** As in **E**, but with photoconversion.
**(G)** An example FACS plot illustrating ratiometric sorting. FACS gates were set to exclude background fluorescence and to sort by red to green ratio. Cells were sorted into equally sized bins corresponding to the first (green), second (light blue), third (pink) and fourth (red) quantiles of the red to green fluorescence ratio distribution. The middle quartiles were later combined into the intermediate photoconversion group for single-cell RNA-sequencing analysis.
**(H)** The distribution of red to green ratios for cells shown in G, for the different photoconversion groups
separately (1 st photoconversion group, 1787 cells; 2 nd photoconversion group, 1786 cells; 3rd photoconversion group, 1786 cells; 4 th photoconversion group, 1787 cells). Box plots mark the median and quartiles, whiskers extend to cover data up to ± 1.5 inter quartile range past the 75th and 25th quartiles respectively. A small number of cells had ratios larger than 1 (not shown).
**(I)** To test for stability of FACS sorting, we measured the red to green ratio in the photoconversion groups shown in E separately by passing them through the FACS sorter again (1 st photoconversion group, 399 cells; 2nd photoconversion group, 539 cells; 3 rd photoconversion group, 504 cells; 4th photoconversion group, 458 cells). Shown is the distribution of red to green ratios measured in the second measurement. Box plots mark the median and quartiles, whiskers extend to cover data up to ±30 1.5 inter quartile range past the 75th and 25th quartiles respectively.
**(J)** The median red to green ratios for the sort and re-sort experiments in panels H and I. Error bars correspond to the 25th and 75th percentile.

***

### Methods

Image analysis was performed as previously described. In brief, acquired data were full-frame registered to correct for brain motion. In datasets with weaker signal, registration was performed on a running average over 5 to 10 frames. Raw fluorescence traces for individual neurons were calculated as the average signal in a region of interest (ROI) that was manually selected based on mean and maximum fluorescence images. To correct for slow drift in fluorescence, the raw fluorescence trace was first corrected with an 8th percentile filter over a window of 66 s (1000 frames) as described previously,65 and F0 was defined as the median fluorescence over the entire trace. To calculate the average response traces, we first calculated the average event-triggered fluorescence trace for each neuron. The responses of all neurons were averaged across triggers and baseline subtracted. The baseline window for the analysis of calcium responses with CaMPARI2 as an indicator was 1.26 s (19 frames) and for the analysis of calcium responses with GCaMP as an indicator it was 0.36 s (4 frames). We used different analysis windows for the two indicators due to the differences in signal to noise levels. For all onset types (mismatch, running and gratings) sessions with less than 3 triggers were excluded from the analyses (Figures 6A–6C). Visuomotor mismatch events were only included in the analysis if mice were running (speed >1 cm/s). Running onset events were defined as the running speed crossing a threshold of 0.5 cm/s, and grating onsets were included in the analysis only if the mice were stationary (speed <1 cm/s). For the response distributions related to these panels (Figures 6D–6F), smoothed probability density estimates were calculated with a Gaussian-kernel (0.28% ΔF/F width) smoothed version of the response distribution across all neurons (using the MATLAB function ksdensity). The standard deviation values shown for the data were based on a Gaussian fit to the smoothed probability density estimate. To estimate a lower bound of the trial-to-trial measurement noise we first calculated the average response differences on odd and even trials for each neuron. We then defined the lower bound on the trial-to-trial measurement noise as the standard deviation of these differences across the entire population of neurons divided by square root of 2 (to account for the sample size that is half as large). This is shown in Figures 6D–6F as “noise” standard deviation. For the correlation analysis (Figures 6G, 6H, S6E, and S6F) during open-loop sessions, sessions in which the mouse ran less than 20% of the time were excluded. This exclusion criterion resulted in the removal of 2 imaging sites (1 mouse) for the AP.Adamts2.1 dataset, 1 imaging site for the AP.Agmat.1 dataset, and 2 imaging sites (no mice were excluded) for the AP.Baz1a.1 dataset. Additionally, in Figure S6H one site was excluded, because we did not have grating data for this site. To quantify the difference of average calcium responses, for GCaMP based analyses (Figure 6), as a function of time, we used a hierarchical bootstrap test for every frame of the calcium trace (66 ms) and marked comparisons where responses were different (p < 0.05) in at least two consecutive frames. For the hierarchical bootstrap test we constructed bootstrap distributions by resampling across sites 100 000 times, for each AAV type, and then calculated the percentage overlap between these distributions.
