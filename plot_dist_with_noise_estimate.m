function[] = plot_dist_with_noise_estimate(stim)
y_max = 1;
global adamts2_emx_sites;
global agmat_sites;
global baz1a_emx_sites;
global min_trig;
if strcmp(stim,'Mismatch')
    adamts2_emx_sites = [13,14,16,17,21,22,26,29,30];
    agmat_sites = [1:6,7:9,10:12,31:40];
    baz1a_emx_sites = [15,18:20,23:25,27,28];
elseif strcmp(stim,'Running')
    adamts2_emx_sites = [13,14,16,17,21,22,26,29,30];
    agmat_sites = [1:6,7:9,10:12,31:40];
    baz1a_emx_sites = [15,18:20,23:25,27,28];
else
    adamts2_emx_sites = [17,21,22,26,29,30];
    agmat_sites = [1:5,7:9,10:12,32:35,38:40];
    baz1a_emx_sites = [15,18:20,24:25,27,28];
end
min_hist = -0.15;
max_hist = 0.15;
min_trig = 0;
adam_deltas = get_the_deltas(adamts2_emx_sites,stim,'standard');
adam_std = estimate_noise_std(adam_deltas);
% adam_std = std(adam_deltas);

adam_noise = get_the_deltas(adamts2_emx_sites,stim,'measurement_noise');
adam_noise_std = estimate_noise_std(adam_noise)/sqrt(2);

agmat_deltas = get_the_deltas(agmat_sites,stim,'standard');
agmat_std = estimate_noise_std(agmat_deltas);
% agmat_std = std(agmat_deltas);

agmat_noise = get_the_deltas(agmat_sites,stim,'measurement_noise');
agmat_noise_std = estimate_noise_std(agmat_noise)/sqrt(2);

baz_deltas = get_the_deltas(baz1a_emx_sites,stim,'standard');
baz_std = estimate_noise_std(baz_deltas);
% baz_std = std(baz_deltas);

baz_noise = get_the_deltas(baz1a_emx_sites,stim,'measurement_noise');
baz_noise_std = estimate_noise_std(baz_noise)/sqrt(2);

fit_type = 'normal';

current_function = 'pdf';
y_max = 0.10;
points = linspace(-1,1,1000); % points to evaluate the estimator
sample = 1000;

figure()
hold on;
[adam_f,adam_xi] = ksdensity(adam_deltas,points,'function',current_function);
adam_f = adam_f/sum(adam_f);
plot(adam_xi,adam_f,'red')
xline(mean(adam_deltas),'red')

[agmat_f,agmat_xi] = ksdensity(agmat_deltas,points,'function',current_function);
agmat_f = agmat_f/sum(agmat_f);
plot(agmat_xi,agmat_f,'green')
xline(mean(agmat_deltas),'green')

[baz_f,baz_xi] = ksdensity(baz_deltas,points,'function',current_function);
baz_f = baz_f/sum(baz_f);
plot(baz_xi,baz_f,'blue')
xline(mean(baz_deltas),'blue')

xlim([min_hist max_hist])
adamts2_str = sprintf('Adamts2, std: %.3f, noise std: %.3f',adam_std,adam_noise_std);
agmat_str = sprintf('Agmat, std: %.3f, noise std: %.3f',agmat_std,agmat_noise_std);
baz1a_str = sprintf('Baz1a, std: %.3f, noise std: %.3f',baz_std,baz_noise_std);
% legend(adamts2_str,agmat_str,baz1a_str,'location','northwest')
legend boxoff
ylim([0 y_max])
title(stim)

set(gcf, 'Position',  [100, 100, 1200, 400])

% Define your line lengths. Here, 6 example lengths are given
line_lengths = [2*adam_std 2*adam_noise_std 2*agmat_std 2*agmat_noise_std 2*baz_std 2*baz_noise_std]; 
% Define y-coordinate for lines. Adjust if necessary
y_values = [0.055 0.05 0.045 0.04 0.035 0.03]; 
% Line colours and styles
colours = {'r', 'r','b', 'b', 'g','g'}; 
styles = {'-', '--'};
for i = 1:6
    colour = colours{i}; % Choose colour
    style = styles{mod(i-1,2)+1}; % Choose style
    line([0 line_lengths(i)], [y_values(i) y_values(i)], 'Color', colour, 'LineStyle', style);
end
% To place the lines in the top right corner, you need to adjust axes limits

%xlim([0 max(line_lengths)+1]);
%ylim([0 max(y_values)+1]);

lgd = legend;
lgd.NumColumns = 1;
legend('off')

hold off;

end