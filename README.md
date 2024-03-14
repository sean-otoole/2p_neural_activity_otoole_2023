# 2p_analyses_OToole_2023

Matlab code for the analysis of neural imaging data in awake behaving animals for the publication entitled: [Molecularly targetable cell types in mouse visual cortex have distinguishable prediction error responses](https://www.cell.com/neuron/pdf/S0896-6273(23)00626-8.pdf).

**Please note** that this repository, even with the appropriate libraries and packages installed, will not operate independently. Due to size limitations, the **original datasets** are not included. However, for those who are interested, the *original published dataset* as well as the code are available [elsewhere](https://doi.org/10.5281/zenodo.8229544).

At the moment this README is still under construction, more details to follow.


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

<p align="center">
            <img src="https://github.com/sean-otoole/2p_neural_activity_otoole_2023/blob/main/images/figure_1.png" width = "600" align = "middle">
</p>

<p align="center">
            <img src="https://github.com/sean-otoole/2p_neural_activity_otoole_2023/blob/main/images/figure_6.png" width = "600" align = "middle">
</p>

