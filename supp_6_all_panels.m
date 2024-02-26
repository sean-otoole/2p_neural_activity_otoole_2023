%% supp 6 panels B, C, D, D, E, F
load('FLG_26_meta.mat');
clearvars -except proj_meta
load('expLog.mat')

% global variable definitions
% ...................................................................... %
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

global min_trig;


% various parameters and variables
% ...................................................................... %
adamts2_emx_sites_mismatch = [13,14,16,17,21,22,26,29,30];
adamts2_emx_sites_running = [13,14,16,17,21,22,26,29,30];
adamts2_emx_sites_gratings = [17,21,22,26,29,30];
adamts2_emx_sites_corr = [13,14,16,17,21,22,30];

agmat_sites_mismatch =  [1:6,7:9,10:12,31:40];
agmat_sites_running = [1:6,7:9,10:12,31:40];
agmat_sites_gratings = [1:5,7:9,10:12,32:35,38:40];
agmat_sites_corr = [1,2,3,5,6,7:9,10:12];

baz1a_emx_sites_mismatch = [15,18:20,23:25,27,28];
baz1a_emx_sites_running = [15,18:20,23:25,27,28];
baz1a_emx_sites_gratings = [15,18:20,24:25,27,28];
baz1a_emx_sites_corr = [15,18,20,23:25,27]; 

control_baseline = 95:99;

min_trig = 0;

% threshold values
% ...................................................................... %
mismatch_run_thresh = 0.01;  %1 cm/s  
run_threshold_high = 0.005;  %0.5 cm/s 
gratings_sitting_threshold =  0.01; %1 cm/s
running_threshold = 0.001;
percent_threshold = 0.2;

baseline= 90:99;
mean_after_mismatch=107:122;
mean_after_running=107:122;
mean_after_gratings=115:130;

% prepration code per site amplitudes
% ...................................................................... %

adamts2_mm = get_deltas_per_site(adamts2_emx_sites_mismatch,'Mismatch',mismatch_run_thresh,mean_after_mismatch,baseline);
adamts2_run = get_deltas_per_site(adamts2_emx_sites_running,'Running',run_threshold_high,mean_after_running,baseline);
adamts2_grt = get_deltas_per_site(adamts2_emx_sites_gratings,'Gratings',gratings_sitting_threshold,mean_after_gratings,baseline);

agmat_mm = get_deltas_per_site(agmat_sites_mismatch,'Mismatch',mismatch_run_thresh,mean_after_mismatch,baseline);
agmat_run = get_deltas_per_site(agmat_sites_running,'Running',run_threshold_high,mean_after_running,baseline);
agmat_grt = get_deltas_per_site(agmat_sites_gratings,'Gratings',gratings_sitting_threshold,mean_after_gratings,baseline);

baz1a_mm = get_deltas_per_site(baz1a_emx_sites_mismatch,'Mismatch',mismatch_run_thresh,mean_after_mismatch,baseline);
baz1a_run = get_deltas_per_site(baz1a_emx_sites_running,'Running',run_threshold_high,mean_after_running,baseline);
baz1a_grt = get_deltas_per_site(baz1a_emx_sites_gratings,'Gratings',gratings_sitting_threshold,mean_after_gratings,baseline);

% prepration code per site correlations
% ...................................................................... %

[vis_adamts2_corr,run_adamts2_corr] = get_run_vis_correlations_flg(adamts2_emx_sites_corr,running_threshold,percent_threshold,1);
[vis_agmat_corr, run_agmat_corr] = get_run_vis_correlations_flg(agmat_sites_corr,running_threshold,percent_threshold,1);
[vis_baz1a_corr,run_baz1a_corr] = get_run_vis_correlations_flg(baz1a_emx_sites_corr,running_threshold,percent_threshold,1);

% plotting code per site, supp 6
% ...................................................................... %

marker_size = 30;
m_weight = 1.5;
y_tic_vals = [-0.06,0, 0.1];
mean_mark_size = 20;
mean_weight = 2;

figure('Renderer', 'painters', 'Position', [10 10 1000 250])
subplot(1,5,1);
hold on;
xlim([0, 4]);
ylim([-0.06, 0.1]);
yticks(y_tic_vals);
yline(0)
ylabel('Change in \DeltaF/F [%]')
ax = gca;
ax.XTick = [1, 2, 3];
ax.XTickLabels = {'Adamts2','Agmat','Baz1a'};
title('Mismatch response per site')
scatter(ones(size(adamts2_mm)),adamts2_mm,marker_size,'linewidth',m_weight)
plot(1,mean(adamts2_mm), '_r','MarkerSize',mean_mark_size,'linewidth',mean_weight)
scatter(2*ones(size(agmat_mm)),agmat_mm,marker_size,'linewidth',m_weight)
plot(2,mean(agmat_mm), '_r','MarkerSize',mean_mark_size,'linewidth',mean_weight)
scatter(3*ones(size(baz1a_mm)),baz1a_mm,marker_size,'linewidth',m_weight)
plot(3,mean(baz1a_mm), '_r','MarkerSize',mean_mark_size,'linewidth',mean_weight)
hold off;

subplot(1,5,2);
hold on;
xlim([0, 4]);
ylim([-0.06, 0.1]);
yticks(y_tic_vals);
yline(0)
ylabel('Change in \DeltaF/F [%]')
ax = gca;
ax.XTick = [1, 2, 3];
ax.XTickLabels = {'Adamts2','Agmat','Baz1a'};
title('Running response per site')
scatter(ones(size(adamts2_run)),adamts2_run,marker_size,'linewidth',m_weight)
plot(1,mean(adamts2_run), '_r','MarkerSize',mean_mark_size,'linewidth',mean_weight)
scatter(2*ones(size(agmat_run)),agmat_run,marker_size,'linewidth',m_weight)
plot(2,mean(agmat_run), '_r','MarkerSize',mean_mark_size,'linewidth',mean_weight)
scatter(3*ones(size(baz1a_run)),baz1a_run,marker_size,'linewidth',m_weight)
plot(3,mean(baz1a_run), '_r','MarkerSize',mean_mark_size,'linewidth',mean_weight)
hold off;

subplot(1,5,3);
hold on;
xlim([0, 4]);
ylim([-0.06, 0.1]);
yticks(y_tic_vals);
yline(0)
ylabel('Change in \DeltaF/F [%]')
ax = gca;
ax.XTick = [1, 2, 3];
ax.XTickLabels = {'Adamts2','Agmat','Baz1a'};
title('Grating response per site')
scatter(ones(size(adamts2_grt)),adamts2_grt,marker_size,'linewidth',m_weight)
plot(1,mean(adamts2_grt), '_r','MarkerSize',mean_mark_size,'linewidth',mean_weight)
scatter(2*ones(size(agmat_grt)),agmat_grt,marker_size,'linewidth',m_weight)
plot(2,mean(agmat_grt), '_r','MarkerSize',mean_mark_size,'linewidth',mean_weight)
scatter(3*ones(size(baz1a_grt)),baz1a_grt,marker_size,'linewidth',m_weight)
plot(3,mean(baz1a_grt), '_r','MarkerSize',mean_mark_size,'linewidth',mean_weight)
hold off;

subplot(1,5,4);
hold on;
xlim([0, 4]);
ylim([-0.06, 0.1]);
yticks(y_tic_vals);
yline(0);
ylabel('Correlation of activity with running')
ax = gca;
ax.XTick = [1, 2, 3];
ax.XTickLabels = {'Adamts2','Agmat','Baz1a'};
title('Run correlations per site')
scatter(ones(size(run_adamts2_corr)),run_adamts2_corr,marker_size,'linewidth',m_weight)
plot(1,mean(run_adamts2_corr), '_r','MarkerSize',mean_mark_size,'linewidth',mean_weight)
scatter(2*ones(size(run_agmat_corr)),run_agmat_corr,marker_size,'linewidth',m_weight)
plot(2,mean(run_agmat_corr), '_r','MarkerSize',mean_mark_size,'linewidth',mean_weight)
scatter(3*ones(size(run_baz1a_corr)),run_baz1a_corr,marker_size,'linewidth',m_weight)
plot(3,mean(run_baz1a_corr), '_r','MarkerSize',mean_mark_size,'linewidth',mean_weight)
hold off;

subplot(1,5,5);
hold on;
xlim([0, 4]);
ylim([-0.06, 0.1]);
yticks(y_tic_vals);
yline(0);
ylabel('Correlation of activity with visual flow')
ax = gca;
ax.XTick = [1, 2, 3];
ax.XTickLabels = {'Adamts2','Agmat','Baz1a'};
title('Visual correlations per site')
scatter(ones(size(vis_adamts2_corr)),vis_adamts2_corr,marker_size,'linewidth',m_weight)
plot(1,mean(vis_adamts2_corr), '_r','MarkerSize',mean_mark_size,'linewidth',mean_weight)
scatter(2*ones(size(vis_agmat_corr)),vis_agmat_corr,marker_size,'linewidth',m_weight)
plot(2,mean(vis_agmat_corr), '_r','MarkerSize',mean_mark_size,'linewidth',mean_weight)
scatter(3*ones(size(vis_baz1a_corr)),vis_baz1a_corr,marker_size,'linewidth',m_weight)
plot(3,mean(vis_baz1a_corr), '_r','MarkerSize',mean_mark_size,'linewidth',mean_weight)
hold off;

%% supp 6 panel A

clearvars -except proj_meta

load('FLG_26_meta.mat');

adamts2_emx_sites = [13,14,16,17,21,22,26,29,30];
agmat_sites = [1:6,7:9,10:12,31:40];
baz1a_emx_sites = [15,18:20,23:25,27,28];

adamts2_rois = get_the_roi_counts(adamts2_emx_sites,proj_meta);
agmat_rois = get_the_roi_counts(agmat_sites,proj_meta);
baz1a_rois = get_the_roi_counts(baz1a_emx_sites,proj_meta);

load('ACC_3_meta.mat');

area_of_piezo = 375 * 300;

ef1a_sites = 1:length(proj_meta);
ef1a_rois = get_the_roi_counts(ef1a_sites,proj_meta);

adamts2_count_norm = mean(adamts2_rois)/area_of_piezo;
agmat_count_norm = mean(agmat_rois)/area_of_piezo;
baz1a_count_norm = mean(baz1a_rois)/area_of_piezo;
ef1a_count_norm = mean(ef1a_rois)/area_of_piezo;

adamts2_error = (std(adamts2_rois)/sqrt(length(adamts2_rois)))/area_of_piezo;;
agmat_error = (std(agmat_rois)/sqrt(length(agmat_rois)))/area_of_piezo;
baz1a_error = (std(baz1a_rois)/sqrt(length(baz1a_rois)))/area_of_piezo;;
ef1a_error = (std(ef1a_rois)/sqrt(length(ef1a_rois)))/area_of_piezo;;

x_vals = [1,2,3,4];
y_vals = [adamts2_count_norm,agmat_count_norm,baz1a_count_norm,ef1a_count_norm]*(1E6);
y_error = [adamts2_error,agmat_error,baz1a_error,ef1a_error]*(1E6);
figure();
hold on;
errorbar(x_vals,y_vals,y_error,y_error,"o")
ylim([0,3000])
yticks([0 1000 2000 3000])
xlim([0.5,4.5])
xticks([1 2 3 4])
xticklabels({'Adamts2','Agmat','Baz1a','Ef1a'})
ylabel('Cells per square mm')
hold off;

%% supp 6 panels G, H and I

load('FLG_26_meta.mat');

clearvars -except proj_meta
load('expLog.mat')

global adamts2_emx_sites;
global agmat_sites;
global baz1a_emx_sites;

% sites that have at least 3 triggers in each condition
adamts2_emx_sites = [17,21,22,26,29,30];
agmat_sites = [1:5,7:9,10:12,32:35,38:40];
baz1a_emx_sites = [15,18:20,24:25,27,28];

baseline= 90:99;
mean_after_mismatch=107:122;
mean_after_gratings=115:130;

% mean_after=107:122;
% baseline= 80:99;

mismatch_run_thresh = 0.01;  %1 cm/s  
run_threshold_high = 0.005;  %0.5 cm/s 
gratings_sitting_threshold =  0.01; %1 cm/s

[agmat_snps_mm] = get_snps_flg(agmat_sites,'Mismatch',mismatch_run_thresh);
[adamts2_snps_mm] = get_snps_flg(adamts2_emx_sites,'Mismatch',mismatch_run_thresh);
[baz1a_snps_mm] = get_snps_flg(baz1a_emx_sites,'Mismatch',mismatch_run_thresh);

[agmat_snps_vis] = get_snps_flg(agmat_sites,'Gratings',gratings_sitting_threshold);
[adamts2_snps_vis] = get_snps_flg(adamts2_emx_sites,'Gratings',gratings_sitting_threshold);
[baz1a_snps_vis] = get_snps_flg(baz1a_emx_sites,'Gratings',gratings_sitting_threshold);

adamts2_mm_deltas = delta_calc(adamts2_snps_mm,baseline,mean_after_mismatch);
adamts2_vis_deltas = delta_calc(adamts2_snps_vis,baseline,mean_after_gratings);

agmat_mm_deltas = delta_calc(agmat_snps_mm,baseline,mean_after_mismatch);
agmat_vis_deltas = delta_calc(agmat_snps_vis,baseline,mean_after_gratings);

baz1a_mm_deltas = delta_calc(baz1a_snps_mm,baseline,mean_after_mismatch);
baz1a_vis_deltas = delta_calc(baz1a_snps_vis,baseline,mean_after_gratings);

pointsize = 10;
fill_color = 'black';

figure('Renderer', 'painters', 'Position', [10 10 2000 500])
subplot(1,3,1);
hold on;
scatter(adamts2_vis_deltas,adamts2_mm_deltas,pointsize,'filled',fill_color)
x_vals = adamts2_vis_deltas;
y_vals = adamts2_mm_deltas;
xmean = mean(x_vals);
ymean = mean(y_vals);
scatter(xmean,ymean,20,'filled','red')
yline(0);
xline(0);
xlim([-0.5 0.5])
ylim([-0.5 0.5])
xticks([-0.5 0.5])
yticks([-0.5 0.5])
xlabel('grating onset response') 
ylabel('mismatch onset response') 
title('Adamts2')
rectangle('Position',[-0.05 -0.05 0.1 0.1],'LineStyle',"--",'Curvature',0.1)
hold off;

subplot(1,3,2);
hold on;
scatter(agmat_vis_deltas,agmat_mm_deltas,pointsize,'filled',fill_color)
x_vals = agmat_vis_deltas;
y_vals = agmat_mm_deltas;
xmean = mean(x_vals);
ymean = mean(y_vals);
scatter(xmean,ymean,20,'filled','red')
yline(0);
xline(0);
xlim([-0.5 0.5])
ylim([-0.5 0.5])
xticks([-0.5 0.5])
yticks([-0.5 0.5])
xlabel('grating onset response') 
ylabel('mismatch onset response') 
title('Agmat')
rectangle('Position',[-0.05 -0.05 0.1 0.1],'LineStyle',"--",'Curvature',0.1)
hold off;

subplot(1,3,3);
hold on;
scatter(baz1a_vis_deltas,baz1a_mm_deltas,pointsize,'filled',fill_color)
x_vals = baz1a_vis_deltas;
y_vals = baz1a_mm_deltas;
xmean = mean(x_vals);
ymean = mean(y_vals);
scatter(xmean,ymean,20,'filled','red')
yline(0);
xline(0);
xlim([-0.5 0.5])
ylim([-0.5 0.5])
xticks([-0.5 0.5])
yticks([-0.5 0.5])
xlabel('grating onset response') 
ylabel('mismatch onset response') 
title('Baz1a')
rectangle('Position',[-0.05 -0.05 0.1 0.1],'LineStyle',"--",'Curvature',0.1)
hold off;

inset_xlim = [-0.05 0.05];
inset_ylim = [-0.05 0.05];
xtick_vals = [-0.05 0.05];
ytick_vals = [-0.05 0.05];

figure('Renderer', 'painters', 'Position', [10 10 500 500])
hold on;
x_vals = adamts2_vis_deltas;
y_vals = adamts2_mm_deltas;
xmean = mean(x_vals);
ymean = mean(y_vals);
x_se = std(x_vals)/sqrt(length(x_vals));
y_se = std(y_vals)/sqrt(length(y_vals));
errorbar(xmean,ymean,y_se,y_se,x_se,x_se,'LineStyle','none')
x_vals = agmat_vis_deltas;
y_vals = agmat_mm_deltas;
xmean = mean(x_vals);
ymean = mean(y_vals);
x_se = std(x_vals)/sqrt(length(x_vals));
y_se = std(y_vals)/sqrt(length(y_vals));
errorbar(xmean,ymean,y_se,y_se,x_se,x_se,'LineStyle','none')
x_vals = baz1a_vis_deltas;
y_vals = baz1a_mm_deltas;
xmean = mean(x_vals);
ymean = mean(y_vals);
x_se = std(x_vals)/sqrt(length(x_vals));
y_se = std(y_vals)/sqrt(length(y_vals));
errorbar(xmean,ymean,y_se,y_se,x_se,x_se,'LineStyle','none')
yline(0);
xline(0);
xlim(inset_xlim)
ylim(inset_xlim)
xticks(xtick_vals)
yticks(xtick_vals)
hold off;

% bootsrap comparisons for inset panel H

adam_indices = get_site_indices_for_bootstrap(adamts2_emx_sites,11);
agmat_indices = get_site_indices_for_bootstrap(agmat_sites,100);
baz1a_indices = get_site_indices_for_bootstrap(baz1a_emx_sites,100);

nIters = 100000;
adam_est_vis = nbstrp(adamts2_vis_deltas,adam_indices,nIters);
adam_est_mm = nbstrp(adamts2_mm_deltas,adam_indices,nIters);
agmat_est_vis = nbstrp(agmat_vis_deltas,agmat_indices,nIters);
agmat_est_mm = nbstrp(agmat_vis_deltas,agmat_indices,nIters);
baz1a_est_vis = nbstrp(baz1a_vis_deltas,baz1a_indices,nIters);
baz1a_est_mm = nbstrp(baz1a_vis_deltas,baz1a_indices,nIters);
PvalAdamAgmat_vis = sum(adam_est_vis>agmat_est_vis)/nIters;
PvalAdamBaz1a_vis = sum(adam_est_vis>baz1a_est_vis)/nIters;
PvalAgmatBaz1a_vis = sum(agmat_est_vis>baz1a_est_vis)/nIters;
PvalAdamAgmat_mm = sum(adam_est_mm<agmat_est_mm)/nIters;
PvalAdamtBaz1a_mm = sum(adam_est_mm<baz1a_est_mm)/nIters;
PvalAgmatBaz1a_mm = sum(agmat_est_mm>baz1a_est_mm)/nIters;

disp('visual delta comparison results for panel H inset')
disp('Adamts2 Vs Agmat Visual')
disp(PvalAdamAgmat_vis)
disp('Adamts2 Vs Baz1a Visual')
disp(PvalAdamBaz1a_vis)
disp('Agmat Vs Baz1a Visual')
disp(PvalAgmatBaz1a_vis)
disp('mismatch delta comparison results for panel H inset')
disp('Adamts2 Vs Agmat Mismatch')
disp(PvalAdamAgmat_mm)
disp('Adamts2 Vs Baz1a Mismatch')
disp(PvalAdamtBaz1a_mm)
disp('Agmat Vs Baz1a Mismatch')
disp(PvalAgmatBaz1a_mm)

disp('current animal counts for panels G, H and I')
disp('adamts2 animals:')
length(get_unique_animals(adamts2_emx_sites))
disp('agmat animals:')
length(get_unique_animals(agmat_sites))
disp('baz1a animals:')
length(get_unique_animals(baz1a_emx_sites))

disp('neuron counts for panels G, H and I')
disp('adamts2 neuron count:')
length(adamts2_snps_mm)
disp('agmat neurons count:')
length(agmat_snps_mm)
disp('baz1a neurons counts:')
length(baz1a_snps_mm)