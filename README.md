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
├── XXX.m                                           : XXX
├── XXX.m                                           : XXX
├── XXX.m                                           : XXX
├── XXX.m                                           : XXX
├── XXX.m                                           : XXX
├── XXX.m                                           : XXX
├── XXX.m                                           : XXX
├── images/                                         : contains example images used for explanations within the README
│   └── XXX.png
│   └── XXX.png
├── ca.m                                            : clears all currently open figures (not my code)
├── act2mat.m/                                      : converts all z-layers for one imaging site and time point into to a matrix (not my code)
├── LICENSE.md                                      : license
└── README.md                                       : project description

```

<p align="center">
            <img src="https://github.com/sean-otoole/2p_neural_activity_otoole_2023/blob/main/images/figure_1.png" width = "600" align = "middle">
</p>

<p align="center">
            <img src="https://github.com/sean-otoole/2p_neural_activity_otoole_2023/blob/main/images/figure_6.png" width = "600" align = "middle">
</p>

