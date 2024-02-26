function[estimated_noise_std] = estimate_noise_std(current_deltas)
current_function = 'pdf';
points = linspace(-1,1,1000);
[current_y,current_x] = ksdensity(current_deltas,points,'function',current_function);
current_y = normalizeVector(current_y);
g1 = fit(current_x',current_y','gauss1');
estimated_noise_std = g1.c1/sqrt(2);
end