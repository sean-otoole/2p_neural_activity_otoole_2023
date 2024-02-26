%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%figure S1 panels

photoConverted = 'photo_converted_not_from_resort.fcs';
negative = 'negative_control_population.fcs';
infected = 'no_photo_conversion_control.fcs';
pc1 = 'resort_001_exclude_dead_cells.fcs';
pc2 = 'resort_002_exclude_dead_cells.fcs';
pc3 = 'resort_003_exclude_dead_cells.fcs';
pc4 = 'resort_004_exclude_dead_cells.fcs';
initial = 'initial_with_gate.fcs';
initial_no_filter = 'initial_no_gating.fcs';

[photoConverted_groups, fcshdr_photoConverted, fcsdatscaled_photoConverted, fcsdat_comp_photoConverted] = fca_readfcs(photoConverted);
[neg_groups, fcshdr_neg, fcsdatscaled_neg, fcsdat_comp_neg] = fca_readfcs(negative);
[inf_groups, fcshdr_inf, fcsdatscaled_inf, fcsdat_comp_inf] = fca_readfcs(infected);
[initial_groups, fcshdr_initial, fcsdatscaled_initial, fcsdat_comp_initial] = fca_readfcs(initial);
[initial_unfilt_groups, fcshdr_initial_unfilt, fcsdatscaled_initial_unfilt, fcsdat_comp_initial_unfilt] = fca_readfcs(initial_no_filter);

[group_1, fcshdr_group_1, fcsdatscaled_group_1, fcsdat_comp_group_1] = fca_readfcs(pc1);
[group_2, fcshdr_group_2, fcsdatscaled_group_2, fcsdat_comp_group_2] = fca_readfcs(pc2);
[group_3, fcshdr_group_3, fcsdatscaled_group_3, fcsdat_comp_group_3] = fca_readfcs(pc3);
[group_4, fcshdr_group_4, fcsdatscaled_group_4, fcsdat_comp_group_4] = fca_readfcs(pc4);

group_1_color = [0/255;255/255;27/255];
group_2_color = [199/255;255/255;0/255];
group_3_color = [255/255;126/255;0/255];
group_4_color = [255/255;0/255;0/255];

figure()

subplot(2,3,1)
scatter(neg_groups(:,10),neg_groups(:,13),10,'.','black');
set(gca,'XScale','log','YScale','log');
axis([10 5E5 10 5E5]);
yticks([10e1 10e2 10e3 10e4 10e5]);
xticks([10e1 10e2 10e3 10e4 10e5]);


subplot(2,3,2)
scatter(inf_groups(:,10),inf_groups(:,13),10,'.','black');
set(gca,'XScale','log','YScale','log');
axis([10 5E5 10 5E5]);
yticks([10e1 10e2 10e3 10e4 10e5]);
xticks([10e1 10e2 10e3 10e4 10e5]);

subplot(2,3,3)
scatter(photoConverted_groups(:,10),photoConverted_groups(:,13),10,'.','black');
set(gca,'XScale','log','YScale','log');
caxis([0 1.5])
axis([10 5E5 10 5E5]);
yticks([10e1 10e2 10e3 10e4 10e5]);
xticks([10e1 10e2 10e3 10e4 10e5]);

%scatter violin 2
color_set = [repmat({group_1_color},height(group_1),1)' repmat({group_2_color},height(group_2),1)' repmat({group_3_color},height(group_3),1)' repmat({group_4_color},height(group_4),1)'];
color_set_2 = cell2mat(color_set')'; 
color_set_3 = reshape(color_set_2, 3, []).';
ratio_1 = group_1(:,13)./group_1(:,10); 
ratio_2 = group_2(:,13)./group_2(:,10); 
ratio_3 = group_3(:,13)./group_3(:,10); 
ratio_4 = group_4(:,13)./group_4(:,10);
box_array = {ratio_1,ratio_2,ratio_3,ratio_4};

box_array = box_array';
sizesRow=cellfun(@(x) size(x,1),box_array);
addition=max(sizesRow)-sizesRow;
for i=1:size(box_array,1)
    box_array{i}(sizesRow(i)+1:sizesRow(i)+addition(i),:)=NaN;
end
box_array = cell2mat(box_array');
% box_array = quantile_filter(box_array,0);

subplot(2,3,6)
boxplot(box_array,'labels',{'PC1','PC2','PC3','PC4'},'Symbol',''); 
hold on;
ylim([0 1]);
x = [5*ones(1,height(group_1)) 6*ones(1,height(group_2)) 7*ones(1,height(group_3)),8*ones(1,height(group_4))];
y = [(group_1(:,13)./group_1(:,10))' (group_2(:,13)./group_2(:,10))' (group_3(:,13)./group_3(:,10))' (group_4(:,13)./group_4(:,10))'];
jitter_plot = scatter(x,y,20,'.','CData',color_set_3,'jitter', 'on', 'jitterAmount', 0.3);
xlim([0 9]);
hold off;

%scatter violin 1
first_quantile = initial_groups((initial_groups(:,15)) < quantile(initial_groups(:,15),[0.25]),:);
second_quantile = initial_groups((initial_groups(:,15) < quantile(initial_groups(:,15),[0.5])) & (initial_groups(:,15) > quantile(initial_groups(:,15),[0.25])), :);
third_quantile = initial_groups((initial_groups(:,15) < quantile(initial_groups(:,15),[0.75])) & (initial_groups(:,15) > quantile(initial_groups(:,15),[0.5])),:);
fourth_quantile = initial_groups((initial_groups(:,15) > quantile(initial_groups(:,15),[0.75])),:);
color_set = [repmat({group_1_color},height(first_quantile),1)' repmat({group_2_color},height(second_quantile),1)' repmat({group_3_color},height(third_quantile),1)' repmat({group_4_color},height(fourth_quantile),1)'];
color_set_2 = cell2mat(color_set')'; 
color_set_3 = reshape(color_set_2, 3, []).';
ratio_1 = first_quantile(:,13)./first_quantile(:,10); 
ratio_2 = second_quantile(:,13)./second_quantile(:,10); 
ratio_3 = third_quantile(:,13)./third_quantile(:,10); 
ratio_4 = fourth_quantile(:,13)./fourth_quantile(:,10); 
box_array = {ratio_1,ratio_2,ratio_3,ratio_4};

box_array = box_array';
sizesRow=cellfun(@(x) size(x,1),box_array);
addition=max(sizesRow)-sizesRow;
for i=1:size(box_array,1)
    box_array{i}(sizesRow(i)+1:sizesRow(i)+addition(i),:)=NaN;
end
box_array = cell2mat(box_array');
% box_array = quantile_filter(box_array,0);

subplot(2,3,5)
boxplot(box_array,'labels',{'PC1','PC2','PC3','PC4'},'Symbol',''); 
hold on;
ylim([0 1]);
x = [5*ones(1,height(first_quantile)) 6*ones(1,height(second_quantile)) 7*ones(1,height(third_quantile)),8*ones(1,height(fourth_quantile))];
y = [(first_quantile(:,13)./first_quantile(:,10))' (second_quantile(:,13)./second_quantile(:,10))' (third_quantile(:,13)./third_quantile(:,10))' (fourth_quantile(:,13)./fourth_quantile(:,10))'];
jitter_plot = scatter(x,y,20,'.','CData',color_set_3,'jitter', 'on', 'jitterAmount', 0.3);
xlim([0 9]);
hold off;

subplot(2,3,4)
scatter(initial_unfilt_groups(:,9),initial_unfilt_groups(:,12),10,'.','black');
set(gca,'XScale','log','YScale','log');
axis([10 5E5 10 5E5]);
hold on;
scatter(first_quantile(:,9),first_quantile(:,12),20,group_1_color','.');
scatter(second_quantile(:,9),second_quantile(:,12),20,group_2_color','.');
scatter(third_quantile(:,9),third_quantile(:,12),20,group_3_color','.');
scatter(fourth_quantile(:,9),fourth_quantile(:,12),20,group_4_color','.');
uline = refline(1,0);
uline.Color = 'black';
xticks([10e1 10e2 10e3 10e4 10e5]);
yticks([10e1 10e2 10e3 10e4 10e5]);
hold off

first_pc = first_quantile(:,13)./first_quantile(:,10); 
second_pc = second_quantile(:,13)./second_quantile(:,10); 
third_pc = third_quantile(:,13)./third_quantile(:,10); 
fourth_pc = fourth_quantile(:,13)./fourth_quantile(:,10); 

first_pc_resort = (group_1(:,13)./group_1(:,10))';
second_pc_resort = (group_2(:,13)./group_2(:,10))';
third_pc_resort = (group_3(:,13)./group_3(:,10))';
fourth_pc_resort = (group_4(:,13)./group_4(:,10))';

sort_medians = [median(first_pc),median(second_pc),median(third_pc),median(fourth_pc)];
resort_medians = [median(first_pc_resort),median(second_pc_resort),median(third_pc_resort),median(fourth_pc_resort)];

sort_se_pos = [quantile(first_pc,0.75)-median(first_pc),quantile(second_pc,0.75)-median(second_pc),quantile(third_pc,0.75)-median(third_pc),quantile(fourth_pc,0.75)-median(fourth_pc)];
sort_se_neg = [abs(quantile(first_pc,0.25)-median(first_pc)),abs(quantile(second_pc,0.25)-median(second_pc)),abs(quantile(third_pc,0.25)-median(third_pc)),abs(quantile(fourth_pc,0.25)-median(fourth_pc))];

resort_se_pos = [quantile(first_pc_resort,0.75)-median(first_pc_resort),quantile(second_pc_resort,0.75)-median(second_pc_resort),quantile(third_pc_resort,0.75)-median(third_pc_resort),quantile(fourth_pc_resort,0.75)-median(fourth_pc_resort)];
resort_se_neg = [abs(quantile(first_pc_resort,0.25)-median(first_pc_resort)),abs(quantile(second_pc_resort,0.25)-median(second_pc_resort)),abs(quantile(third_pc_resort,0.25)-median(third_pc_resort)),abs(quantile(fourth_pc_resort,0.25)-median(fourth_pc_resort))];

figure()
hold on;
scatter(sort_medians,resort_medians,40,'black');
errorbar(sort_medians,resort_medians,resort_se_neg,resort_se_pos,sort_se_neg,sort_se_pos,'LineStyle','none')
axis([0 0.25 0 0.25]);
ylabel('resort means')
xlabel('sort means')
lou = refline(1,0);
lou.Color = 'black';
xticks([0 0.25]);
yticks([0 0.25]);
hold off;