load('FLG_26_meta.mat');

clearvars -except proj_meta expLog
load('expLog.mat')

global min_trig;  % deprecated

global adamts2_emx_sites_mismatch;
global adamts2_emx_sites_running;
global adamts2_emx_sites_gratings;

global agmat_sites_mismatch;
global agmat_sites_gratings;
global agmat_sites_running;

global baz1a_emx_sites_mismatch;
global baz1a_emx_sites_running;
global baz1a_emx_sites_gratings;

global control_baseline;
global j;

min_trig = 1; %deprecated

adamts2_emx_sites_mismatch = [13,14,16,17,21,22,26,29,30];
adamts2_emx_sites_running = [13,14,16,17,21,22,26,29,30];
adamts2_emx_sites_gratings = [17,21,22,26,29,30];

agmat_sites_mismatch =  [1:6,7:9,10:12,31:40];
agmat_sites_running = [1:6,7:9,10:12,31:40];
agmat_sites_gratings = [1:5,7:9,10:12,32:35,38:40];

baz1a_emx_sites_mismatch = [15,18:20,23:25,27,28];
baz1a_emx_sites_running = [15,18:20,23:25,27,28];
baz1a_emx_sites_gratings = [15,18:20,24:25,27,28];

control_baseline = 95:99;

j = 0;

mismatch_run_thresh = 0.01;  %1 cm/s  
run_threshold_high = 0.005;  %0.5 cm/s 
run_threshold_low = 0.0003; %deprecated
gratings_sitting_threshold =  0.01; %1 cm/s

plot_the_traces_fig_6('Mismatch',mismatch_run_thresh);
plot_the_traces_fig_6('Running',run_threshold_high,run_threshold_low);
plot_the_traces_fig_6('Gratings',gratings_sitting_threshold);

countString = "%s has %d animals, %d sites and %d neurons";

disp('Mismatch animal and site counts:')
disp(sprintf(countString,'Adamts2',length(get_unique_animals(adamts2_emx_sites_mismatch)),length(adamts2_emx_sites_mismatch),sum(get_the_roi_counts(adamts2_emx_sites_mismatch,proj_meta))))
disp(sprintf(countString,'Agmat',length(get_unique_animals(agmat_sites_mismatch)),length(agmat_sites_mismatch),sum(get_the_roi_counts(agmat_sites_mismatch,proj_meta))))
disp(sprintf(countString,'Baz1a',length(get_unique_animals(baz1a_emx_sites_mismatch)),length(baz1a_emx_sites_mismatch),sum(get_the_roi_counts(baz1a_emx_sites_mismatch,proj_meta))))

disp('Running animal and site counts:')
disp(sprintf(countString,'Adamts2',length(get_unique_animals(adamts2_emx_sites_running)),length(adamts2_emx_sites_running),sum(get_the_roi_counts(adamts2_emx_sites_running,proj_meta))))
disp(sprintf(countString,'Agmat',length(get_unique_animals(agmat_sites_running)),length(agmat_sites_running),sum(get_the_roi_counts(agmat_sites_running,proj_meta))))
disp(sprintf(countString,'Baz1a',length(get_unique_animals(baz1a_emx_sites_running)),length(baz1a_emx_sites_running),sum(get_the_roi_counts(baz1a_emx_sites_running,proj_meta))))

disp('Gratings animal and site counts:')
disp(sprintf(countString,'Adamts2',length(get_unique_animals(adamts2_emx_sites_gratings)),length(adamts2_emx_sites_gratings),sum(get_the_roi_counts(adamts2_emx_sites_gratings,proj_meta))))
disp(sprintf(countString,'Agmat',length(get_unique_animals(agmat_sites_gratings)),length(agmat_sites_gratings),sum(get_the_roi_counts(agmat_sites_gratings,proj_meta))))
disp(sprintf(countString,'Baz1a',length(get_unique_animals(baz1a_emx_sites_gratings)),length(baz1a_emx_sites_gratings),sum(get_the_roi_counts(baz1a_emx_sites_gratings,proj_meta))))
