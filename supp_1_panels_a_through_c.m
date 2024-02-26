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

% get the values for mismatch

[mm_trigs,mm_snps_all,mm_velM_all,cell_cnt] = get_the_snps_fig_1(1,proj_meta,sites);
mm_onsets_bl=blsub(mm_snps_all,baseline);
mm_deltas = delta_calc(mm_onsets_bl,baseline,mean_after);

% get the values for running

[run_trigs,run_snps_all,run_velM_all,cell_cnt] = get_the_snps_fig_1(2,proj_meta,sites);
run_onsets_bl=blsub(run_snps_all,baseline);
run_deltas = delta_calc(run_onsets_bl,baseline,mean_after);    

% get the values for gratings

[grating_trigs,grating_snps_all,grating_velM_all,cell_cnt] = get_the_snps_fig_1(3,proj_meta,sites);
grating_onsets_bl=blsub(grating_snps_all,baseline);
grating_deltas = delta_calc(grating_onsets_bl,baseline,mean_after);

%get the color vector for coloring by site
color_array = {'red','blue','green','black',};
color_vector = {};
for siteID=sites        % get's the ratio values
    cell_count = 0;
    for piezo = 1:4
        cell_count = cell_count + size(proj_meta(siteID).rd(piezo,1).ROIinfo,2);
    end
    current_color = color_array{siteID};
    start = size(color_vector,1)+1;
    ending = start + cell_count-1;
    color_vector = vertcat(color_vector,repmat({current_color},1,cell_count)');
end

% graph mismatch delta vs photoconversion

figure('Renderer', 'painters', 'Position', [10 10 975 325])
subplot(1,3,1);
hold on;
for i = 1:length(ratio_all)
    scatter(ratio_all(i),mm_deltas(i),20,color_vector{i})
end
xlabel('red/green fluorescence');
ylabel('average mismatch delta');
ylim([-0.03 0.03])
xlim([0.1 0.5])
plot_linear_models(ratio_all,mm_deltas,color_vector)
set(gca, 'YDir','reverse')
title('Mismatch delta vs photconversion')
hold off;

% graph run delta vs photoconversion

subplot(1,3,2);
hold on;
for i = 1:length(ratio_all)
    scatter(ratio_all(i),run_deltas(i),20,color_vector{i})
end
xlabel('red/green fluorescence');
ylabel('average running delta');
ylim([-0.03 0.03])
xlim([0.1 0.5])
plot_linear_models(ratio_all,run_deltas,color_vector)
set(gca, 'YDir','reverse')
title('Running delta vs photconversion')
hold off;

% graph grating delta vs photoconversion

subplot(1,3,3);
hold on;
for i = 1:length(ratio_all)
    scatter(ratio_all(i),grating_deltas(i),20,color_vector{i})
end
xlabel('red/green fluorescence');
ylabel('average running delta');
ylim([-0.03 0.03])
xlim([0.1 0.5])
plot_linear_models(ratio_all,grating_deltas,color_vector)
set(gca, 'YDir','reverse')
title('Grating delta vs photconversion')
hold off;