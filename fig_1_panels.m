%% Velocity scale and photoconversoin examples

% Get the velocity scale

set(gcf,'renderer','Painters')

rotations = 13;
smooth_factor = 3000;
ach_file = "S1-T177173.ach";
lvd_file = "S1-T177173.lvd";

ach_names = load_ach_chans(ach_file);
aux_channels = load_lvd(lvd_file);

vel_data = aux_channels(5,:);

scalefactor = 10;
sample_rate = 1000;

vel=diff(vel_data);
vel(vel>scalefactor)=vel(vel>scalefactor)-(scalefactor*2);
vel(vel<-scalefactor)=vel(vel<-scalefactor)+(scalefactor*2);
vel_raw=vel;
vel=ftfil(vel,sample_rate,0,10);
vel_smoothed=smooth2(vel,sample_rate);

voltage_velocity = mean(vel);
distance= rotations * 20;
time = length(vel)/1000;
real_world_velocity = distance/time;
conversion_factor = real_world_velocity/voltage_velocity;

%% Running in darkness

ach_file = "S1-T125223.ach";
lvd_file = "S1-T125223.lvd";

ach_names = load_ach_chans(ach_file);
aux_channels = load_lvd(lvd_file);

vel_data = aux_channels(2,:);
laser_shutter = aux_channels(6,:);

scalefactor = 10;
sample_rate = 1000;

vel_data(vel_data> scalefactor) = scalefactor;
vel_data(vel_data< -scalefactor) = -scalefactor;

vel=diff(-vel_data);
vel(vel>scalefactor)=vel(vel>scalefactor)-(scalefactor*2);
vel(vel<-scalefactor)=vel(vel<-scalefactor)+(scalefactor*2);
vel_raw=vel;
vel=ftfil(vel,sample_rate,0,10);
vel_smoothed=smooth2(vel,smooth_factor);

vel_smoothed = vel_smoothed * conversion_factor;

sample_rate = 1000;
%shift = 4347.5; old trigger
shift = 4701.0;

start_point = (shift) * sample_rate;
end_point = (20+shift) * sample_rate;
time_points = [1 (10*sample_rate) (20*sample_rate)];
time_labels = {'0','10','20'};
subplot(1,3,1);
plot((vel_smoothed(start_point:end_point)));
hold on;
xticks(time_points);
xticklabels(time_labels);
ylim([(-0.01*conversion_factor) (0.04*conversion_factor)])
plot(laser_shutter(start_point:end_point)*2);
title("running in darkness labelling example");
ylabel("cm per s")
hold off;

%% Mismatch

ach_file = 'S1-T125228.ach';
lvd_file = 'S1-T125228.lvd';

ach_names = load_ach_chans(ach_file);
aux_channels = load_lvd(lvd_file);

vel_data = aux_channels(2,:);
laser_shutter = aux_channels(6,:);

vel_data(vel_data> scalefactor) = scalefactor;
vel_data(vel_data< -scalefactor) = -scalefactor;

vel=diff(-vel_data);
vel(vel>scalefactor)=vel(vel>scalefactor)-(scalefactor*2);
vel(vel<-scalefactor)=vel(vel<-scalefactor)+(scalefactor*2);
vel_raw=vel;
vel=ftfil(vel,sample_rate,0,10);
vel_smoothed=smooth2(vel,3500);
vel_smoothed=smooth2(vel,3000);
vel_smoothed = vel_smoothed * conversion_factor;

vis_flow = vel_smoothed;
vis_flow = vis_flow.*(laser_shutter(1:length(vis_flow))<1);

sample_rate = 1000;
shift = 353;

start_point = (shift) * sample_rate;
end_point = (20+shift) * sample_rate;
time_points = [1 (10*sample_rate) (20*sample_rate)];
time_labels = {'0','10','20'};
subplot(1,3,2);
plot((vel_smoothed(start_point:end_point)));
hold on;
plot((vis_flow(start_point:end_point)));
xticks(time_points);
xticklabels(time_labels);
ylim([(-0.01*conversion_factor) (0.04*conversion_factor)])
plot(laser_shutter(start_point:end_point)*2);
title("mismatch labelling example");
ylabel("cm per s")
hold off;


%% vis example

ach_file = "S1-T124293.ach";
lvd_file = "S1-T124293.lvd";

ach_names = load_ach_chans(ach_file);
aux_channels = load_lvd(lvd_file);

vel_data = aux_channels(2,:);
laser_shutter = aux_channels(6,:);
gratings = aux_channels(5,:);


scalefactor = 10;
sample_rate = 1000;

vel_data(vel_data> scalefactor) = scalefactor;
vel_data(vel_data< -scalefactor) = -scalefactor;

vel=diff(-vel_data);
vel(vel>scalefactor)=vel(vel>scalefactor)-(scalefactor*2);
vel(vel<-scalefactor)=vel(vel<-scalefactor)+(scalefactor*2);
vel_raw=vel;
vel=ftfil(vel,sample_rate,0,10);
vel_smoothed=smooth2(vel,smooth_factor);

vel_smoothed = vel_smoothed * conversion_factor;

sample_rate = 1000;
shift = 626;

start_point = (shift) * sample_rate;
end_point = (20+shift) * sample_rate;
time_points = [1 (10*sample_rate) (20*sample_rate)];
time_labels = {'0','10','20'};
subplot(1,3,3);
plot((vel_smoothed(start_point:end_point)));
hold on;
plot((gratings(start_point:end_point)));
xticks(time_points);
xticklabels(time_labels);
ylim([(-0.01*conversion_factor) (0.04*conversion_factor)])
plot(laser_shutter(start_point:end_point)*2);
title("gratings labelling example");
ylabel("cm per s")
hold off;

%% Figure 1 panels D, E and F

% Meta is FLG_10
load('FLG_10_meta.mat');

%anonomous functions

blsub=@(snp,bl) bsxfun(@minus,snp,mean(snp(:,bl),2));

% Variable assignment/reset

deltas =[];
site_roi_indices =[];

%parameters

mean_after=110:130;
baseline= 80:99;

sites = [1 2 3 4];

% get's the roi and ratio information (will be same for all onset types)

ratio_all = ratio_calc(sites, proj_meta);
site_roi_indices = get_indices_fig_1(sites,proj_meta);

% gedelta_calct the values for mismatch

[mm_trigs,mm_snps_all,mm_velM_all,cell_cnt] = get_the_snps_fig_1(1,proj_meta,sites);
mm_onsets_bl=blsub(mm_snps_all,baseline);
mm_deltas = delta_calc(mm_onsets_bl,baseline,mean_after);
mm_correlations = correlate_pc_with_act_fig_1(site_roi_indices, mm_deltas, ratio_all);

% get the values for running

[run_trigs,run_snps_all,run_velM_all,cell_cnt] = get_the_snps_fig_1(2,proj_meta,sites);
run_onsets_bl=blsub(run_snps_all,baseline);
run_deltas = delta_calc(run_onsets_bl,baseline,mean_after);    
run_correlations = correlate_pc_with_act_fig_1(site_roi_indices, run_deltas, ratio_all);

% get the values for gratings

[grating_trigs,grating_snps_all,grating_velM_all,cell_cnt] = get_the_snps_fig_1(3,proj_meta,sites);
grating_onsets_bl=blsub(grating_snps_all,baseline);
grating_deltas = delta_calc(grating_onsets_bl,baseline,mean_after);    
grating_correlations = correlate_pc_with_act_fig_1(site_roi_indices, grating_deltas, ratio_all);

% plot the heatmap response - for mismatch

all_onsets_bl = mm_onsets_bl;

a = 1;
n=10;
b = ones(n,1)/n;
y = filter(b,a,all_onsets_bl')';

[~,sort_ind]=sort(mean(all_onsets_bl(:,mean_after),2)-mean(all_onsets_bl(:,baseline),2));

figure();imagesc(-y(sort_ind,:));
hold on;
colorbar;
caxis([-0.01 0.03]);
xlim([84 170]);
colormap(bone);
time_points = [86 (86+(16*1)) (86+(16*2)) (86+(16*3)) (86+(16*4)) (86+(16*5))];
time_labels = {'-1','0','1','2','3','4'};
xticks(time_points);
xticklabels(time_labels);

% graph mismatch delta vs photoconversion

figure()
scatter(ratio_all,mm_deltas, 20, 'black', 'filled','o')
hold on;
xlabel('red/green fluorescence');
ylabel('average mismatch delta');
ylim([-0.03 0.03])
xlim([0.1 0.5])
d = LinearModel.fit(ratio_all,mm_deltas)
plot(d,'Marker','o','MarkerEdgeColor',[0 0 0],'MarkerFaceColor',[0 0 0])
set(gca, 'YDir','reverse')
hold off;

%graph the correlation data

error_positions = [1 2 3];

mm_average = mean(mm_correlations);
running_average = mean(run_correlations);
grating_average = mean(grating_correlations);
correlation_averages = horzcat(mm_average, running_average, grating_average);

mm_error = std(mm_correlations)/sqrt(length(mm_correlations));
running_error = std(run_correlations)/sqrt(length(run_correlations));
grating_error = std(grating_correlations)/sqrt(length(grating_correlations));
error_values = vertcat(mm_error, running_error, grating_error);

mm_pos = [0.9 1 1.1 1];
run_pos = [1.9 2 2.1 2];
vis_pos = [2.9 3 3.1 3];

figure()
mm_points = scatter(mm_pos,mm_correlations,'o');
hold on
run_points = scatter(run_pos,run_correlations,'o');
vis_points = scatter(vis_pos,grating_correlations,'o');
errorbar(error_positions, correlation_averages, [0 0 0],'CapSize',40,'LineStyle','none');           
xlim([0 4]);
set(gca, 'YDir','reverse')
hold off

figure();
all_averages_graph = [mm_correlations,run_correlations,grating_correlations];
all_averages_stats = [mm_correlations',run_correlations',grating_correlations'];
boxplot(all_averages_graph);
hold on;
ylim([-0.4 0.4])
set(gca,...
    'YTick',[-0.4 0 0.4]);
set(gca, 'YDir','reverse')
hold off;

groups = repelem([{'mm'}, {'run'}, {'vis'}], [4 4 4]);

[p,t,stats] = anova1(all_averages_stats,groups);

stats

[results,~,~,gnames] = multcompare(stats);

tbl = array2table(results,"VariableNames", ...
    ["Group","Control Group","Lower Limit","Difference","Upper Limit","P-value"]);
tbl.("Group") = gnames(tbl.("Group"));
tbl.("Control Group") = gnames(tbl.("Control Group"))