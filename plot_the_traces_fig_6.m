function plot_the_traces_fig_5(stimulus_type,first_threshold,second_threshold)
global j;

global adamts2_emx_sites_mismatch;
global adamts2_emx_sites_running;
global adamts2_emx_sites_gratings;

global agmat_sites_mismatch;
global agmat_sites_running;
global agmat_sites_gratings;


global baz1a_emx_sites_mismatch;
global baz1a_emx_sites_running;
global baz1a_emx_sites_gratings;

global control_baseline;

blsub = @(snp,bl) bsxfun(@minus,snp,mean(snp(:,bl),2));

p_thresh = 0.05;

if ~exist('second_threshold','var')
    second_threshold = 0;
end

if strcmp(stimulus_type,'Mismatch')
    [adamts2_snps,adamts2_velM,adamts2_velP,adamts2_cell_cnt,adamts2_site_count,adamts2_grt] = get_snps_flg(adamts2_emx_sites_mismatch,stimulus_type,first_threshold,second_threshold);
    [agmat_snps,agmat_velM,agmat_velP,agmat_cell_cnt,agmat_site_count,agmat_grt] = get_snps_flg(agmat_sites_mismatch,stimulus_type,first_threshold,second_threshold);
    [baz1a_snps,baz1a_velM,baz1a_velP,baz1a_cell_cnt,baz1a_site_count,baz1a_grt] = get_snps_flg(baz1a_emx_sites_mismatch,stimulus_type,first_threshold,second_threshold);
end

if strcmp(stimulus_type,'Running')
    [adamts2_snps,adamts2_velM,adamts2_velP,adamts2_cell_cnt,adamts2_site_count,adamts2_grt] = get_snps_flg(adamts2_emx_sites_running,stimulus_type,first_threshold,second_threshold);
    [agmat_snps,agmat_velM,agmat_velP,agmat_cell_cnt,agmat_site_count,agmat_grt] = get_snps_flg(agmat_sites_running,stimulus_type,first_threshold,second_threshold);
    [baz1a_snps,baz1a_velM,baz1a_velP,baz1a_cell_cnt,baz1a_site_count,baz1a_grt] = get_snps_flg(baz1a_emx_sites_running,stimulus_type,first_threshold,second_threshold);
end

if strcmp(stimulus_type,'Gratings')
    [adamts2_snps,adamts2_velM,adamts2_velP,adamts2_cell_cnt,adamts2_site_count,adamts2_grt] = get_snps_flg(adamts2_emx_sites_gratings,stimulus_type,first_threshold,second_threshold);
    [agmat_snps,agmat_velM,agmat_velP,agmat_cell_cnt,agmat_site_count,agmat_grt] = get_snps_flg(agmat_sites_gratings,stimulus_type,first_threshold,second_threshold);
    [baz1a_snps,baz1a_velM,baz1a_velP,baz1a_cell_cnt,baz1a_site_count,baz1a_grt] = get_snps_flg(baz1a_emx_sites_gratings,stimulus_type,first_threshold,second_threshold);
end

no_bl_adamts2_snps = adamts2_snps;
no_bl_agmat_snps = agmat_snps;
no_bl_baz1a_snps = baz1a_snps;

j = j + 1;
subplot(4,3,j);
hold on;
agmat_bl = mean(mean(agmat_snps(:,control_baseline)));
plotSEM(no_bl_agmat_snps'-agmat_bl,'color','green','LineWidth',1.5,'Displayname','Agmat');
agmat_snps = blsub(agmat_snps,control_baseline);

adamts2_bl = mean(mean(adamts2_snps(:,control_baseline)));
plotSEM(no_bl_adamts2_snps'-adamts2_bl,'color','red','LineWidth',1.5,'Displayname','Adamts2');
adamts2_snps = blsub(adamts2_snps,control_baseline);

baz1a_bl = mean(mean(baz1a_snps(:,control_baseline)));
plotSEM(no_bl_baz1a_snps'-baz1a_bl,'color','blue','LineWidth',1.5,'Displayname','Baz1a');
baz1a_snps = blsub(baz1a_snps,control_baseline);

xline(100)
yline(0)
title(stimulus_type)
legend(sprintf('Baz1a %d neurons',length(baz1a_snps)), sprintf('Agmat %d neurons',length(agmat_snps)),sprintf('Adamts2 %d neurons',length(adamts2_snps)));

xlim([92 145]);
ylim([-0.04 0.06]);
set(gca,...
    'XTickLabel',{'0','1','2','3'},...
    'XTick',[100 100+15 100+30 100+45]);
set(gca,...
    'YTickLabel',{'-4','-2','0','2','4','6'},...
    'YTick',[-0.04 -0.02 0 0.02 0.04 0.06]);
hold off;

if strcmp(stimulus_type,'Mismatch')
    agmat_indices = get_site_indices_for_bootstrap(agmat_sites_mismatch,100);
    adam_indices = get_site_indices_for_bootstrap(adamts2_emx_sites_mismatch,100);
    baz_indices = get_site_indices_for_bootstrap(baz1a_emx_sites_mismatch,100);
end

if strcmp(stimulus_type,'Running')
    adam_indices = get_site_indices_for_bootstrap(adamts2_emx_sites_running,100);
    agmat_indices = get_site_indices_for_bootstrap(agmat_sites_running,100);
    baz_indices = get_site_indices_for_bootstrap(baz1a_emx_sites_running,100);
end

if strcmp(stimulus_type,'Gratings')
    adam_indices = get_site_indices_for_bootstrap(adamts2_emx_sites_gratings,100);
    agmat_indices = get_site_indices_for_bootstrap(agmat_sites_gratings,100);
    baz_indices = get_site_indices_for_bootstrap(baz1a_emx_sites_gratings,100);
end

[Pval_Adam_v_Agmat_1, Pval_Adam_v_Baz_1, Pval_Agmat_v_Baz_1, Pval_Adam_v_Agmat_2, Pval_Adam_v_Baz_2, Pval_Agmat_v_Baz_2] = deal(ones(201,1));

for i=1:201;
    nIters = 100000;
    adam_est = nbstrp(adamts2_snps(:,i),adam_indices,nIters);
    agmat_est = nbstrp(agmat_snps(:,i),agmat_indices,nIters);
    baz_est = nbstrp(baz1a_snps(:,i),baz_indices,nIters);
    Pval_Adam_v_Agmat_1(i) = sum(adam_est<agmat_est)/nIters;
    Pval_Adam_v_Baz_1(i) = sum(adam_est<baz_est)/nIters;
    Pval_Agmat_v_Baz_1(i) = sum(agmat_est<baz_est)/nIters;
    Pval_Adam_v_Agmat_2(i) = sum(adam_est>agmat_est)/nIters;
    Pval_Adam_v_Baz_2(i) = sum(adam_est>baz_est)/nIters;
    Pval_Agmat_v_Baz_2(i) = sum(agmat_est>baz_est)/nIters;
end 

%filter the P-values (window size is 3)
Pval_Adam_v_Agmat_1 = filter_pval_array(Pval_Adam_v_Agmat_1);
Pval_Adam_v_Baz_1 = filter_pval_array(Pval_Adam_v_Baz_1);
Pval_Agmat_v_Baz_1 = filter_pval_array(Pval_Agmat_v_Baz_1);
Pval_Adam_v_Agmat_2 = filter_pval_array(Pval_Adam_v_Agmat_2);
Pval_Adam_v_Baz_2 = filter_pval_array(Pval_Adam_v_Baz_2);
Pval_Agmat_v_Baz_2 = filter_pval_array(Pval_Agmat_v_Baz_2);

assignin('base','Pval_Adam_v_Agmat_1',Pval_Adam_v_Agmat_1);

%first tail
subplot(4,3,(j+3));
hold on;
plot((Pval_Adam_v_Agmat_1<p_thresh)/1, 'r');
plot((Pval_Adam_v_Baz_1<p_thresh)/2, 'b');
plot((Pval_Agmat_v_Baz_1<p_thresh)/3, 'k');
xlim([92 145]);
ylim([0 1]);
set(gca,...
    'XTickLabel',{'0','1','2','3'},...
    'XTick',[100 100+15 100+30 100+45]);
plot([0 0], ylim, 'k--');
plot([10 10], ylim, 'k--');
title('test stats 1st tail');
legend('Adam > Agmat', 'Adam > Baz','Agmat > Baz');
hold off;

%second tail
subplot(4,3,(j+6));
hold on;
plot((Pval_Adam_v_Agmat_2<p_thresh)/1, 'r');
plot((Pval_Adam_v_Baz_2<p_thresh)/2, 'b');
plot((Pval_Agmat_v_Baz_2<p_thresh)/3, 'k');
xlim([92 145]);
ylim([0 1]);
set(gca,...
    'XTickLabel',{'0','1','2','3'},...
    'XTick',[100 100+15 100+30 100+45]);
plot([0 0], ylim, 'k--');
plot([10 10], ylim, 'k--');
title('test stats 2nd tail');
legend('Adam < Agmat', 'Adam < Baz','Agmat < Baz');
hold off;

subplot(4,3,(j+9));
hold on;
plot(nanmean(agmat_velM,1),'green','LineStyle','-')
plot(nanmean(adamts2_velM,1),'red','LineStyle','-')
plot(nanmean(baz1a_velM,1),'blue','LineStyle','-')
if strcmp(stimulus_type,'Gratings')
    plot(nanmean(agmat_grt,1),'green','LineStyle','--')
    plot(nanmean(adamts2_grt,1),'red','LineStyle','--')
    plot(nanmean(baz1a_grt,1),'blue','LineStyle','--')
else
    plot(nanmean(agmat_velP,1),'green','LineStyle','--')
    plot(nanmean(adamts2_velP,1),'red','LineStyle','--')
    plot(nanmean(baz1a_velP,1),'blue','LineStyle','--')
end
xlim([92 145]);
set(gca,...
    'XTickLabel',{'0','1','2','3'},...
    'XTick',[100 100+15 100+30 100+45]);
plot([0 0], ylim, 'k--');
plot([10 10], ylim, 'k--');
ylim([-0.005,0.06]);
title('Running/visual');
legend('Adam Run', 'Adam Vis','Agmat Run','Agmat Vis','Adamts2 Vis','Baz1a Vis');
hold off;
end