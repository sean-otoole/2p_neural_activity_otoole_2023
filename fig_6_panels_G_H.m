load('FLG_26_meta.mat');

clearvars -except proj_meta
load('expLog.mat')
running_threshold = 0.001;
percent_threshold = 0.2;

agmat_sites = [1,2,3,5,6,7:9,10:12];
adamts2_emx_sites = [13,14,16,17,21,22,30];
baz1a_emx_sites = [15,18,20,23:25,27]; 

[vis_adamts2,run_adamts2] = get_run_vis_correlations_flg(adamts2_emx_sites,running_threshold,percent_threshold);
[vis_agmat, run_agmat] = get_run_vis_correlations_flg(agmat_sites,running_threshold,percent_threshold);
[vis_baz1a,run_baz1a] = get_run_vis_correlations_flg(baz1a_emx_sites,running_threshold,percent_threshold);

categories = [1,2,3];

vis_means = [mean(vis_adamts2),mean(vis_agmat),mean(vis_baz1a)];
run_means = [mean(run_adamts2),mean(run_agmat),mean(run_baz1a)];

vis_adamts2_error = std(vis_adamts2)/sqrt(length(vis_adamts2));
vis_baz1a_error = std(vis_baz1a)/sqrt(length(vis_baz1a));
vis_agmat_error = std(vis_agmat)/sqrt(length(vis_agmat));
vis_err = [vis_adamts2_error, vis_baz1a_error,vis_agmat_error];

run_adamts2_error = std(run_adamts2)/sqrt(length(run_adamts2));
run_baz1a_error = std(run_baz1a)/sqrt(length(run_baz1a));
run_agmat_error = std(run_agmat)/sqrt(length(run_agmat));
run_err = [run_adamts2_error, run_baz1a_error,run_agmat_error];

% bootstrap code
Adam_indices = get_site_indices_for_bootstrap(adamts2_emx_sites,100);
Agmat_indices = get_site_indices_for_bootstrap(agmat_sites,100);
Baz_indices = get_site_indices_for_bootstrap(baz1a_emx_sites,100);

nIters = 100000;
Adam_est_vis = nbstrp(vis_adamts2,Adam_indices,nIters);
Adam_est_run = nbstrp(run_adamts2,Adam_indices,nIters);
Agmat_est_vis = nbstrp(vis_agmat,Agmat_indices,nIters);
Agmat_est_run = nbstrp(run_agmat,Agmat_indices,nIters);
Baz_est_vis = nbstrp(vis_baz1a,Baz_indices,nIters);
Baz_est_run = nbstrp(run_baz1a,Baz_indices,nIters);
PvalAdamAgmat_vis = sum(Adam_est_vis>Agmat_est_vis)/nIters;
PvalAdamBaz_vis = sum(Adam_est_vis>Baz_est_vis)/nIters;
PvalAgmatBaz_vis = sum(Agmat_est_vis>Baz_est_vis)/nIters;
PvalAdamAgmat_run = sum(Adam_est_run>Agmat_est_run)/nIters;
PvalAdamBaz_run = sum(Adam_est_run<Baz_est_run)/nIters;
PvalAgmatBaz_run = sum(Agmat_est_run<Baz_est_run)/nIters;

figure()
errorbar(categories,vis_means,vis_err,'o');
xlim([0.5 3.5]);ylim([-0.04 0.03]); hold on;
xticks([1 2 3]);
yticks([-0.04 -0.03 -0.02 -0.01 0 0.01 0.02 0.03]);
yline(0,'--');
xticklabels({'Adamts2','Agmat','Baz1a'});
title('correlation with visual flow');
hold off;

figure()
errorbar(categories,run_means,run_err,'o');
xlim([0.5 3.5]);ylim([-0.04 0.03]); hold on;
xticks([1 2 3]);
yticks([-0.04 -0.03 -0.02 -0.01 0 0.01 0.02 0.03]);
yline(0,'--');
xticklabels({'Adamts2','Agmat','Baz1a'});
title('correlation with running');
hold off;

disp('visual correlation comparison results')
disp('Adamts2 Vs Agmat Visual')
disp(PvalAdamAgmat_vis)
disp('Adamts2 Vs Baz1a Visual')
disp(PvalAdamBaz_vis)
disp('Agmat Vs Baz1a Visual')
disp(PvalAgmatBaz_vis)
disp('running correlation comparison results')
disp('Adamts2 Vs Agmat Running')
disp(PvalAdamAgmat_run)
disp('Adamts2 Vs Baz1a Running')
disp(PvalAdamBaz_run)
disp('Agmat Vs Baz1a Running')
disp(PvalAgmatBaz_run)

disp('current_animal_counts')
disp('adamts2 animals')
get_unique_animals(adamts2_emx_sites)
disp('agmat animals')
get_unique_animals(agmat_sites)
disp('baz1a animals')
get_unique_animals(baz1a_emx_sites)