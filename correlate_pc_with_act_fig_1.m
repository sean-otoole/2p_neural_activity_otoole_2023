function pc_correlations = correlate_pc_with_act_fig_1(site_roi_indices, deltas, ratios)
    pc_correlations = [];
    for indices = 1:size(site_roi_indices,1)
        site_indices = site_roi_indices(indices,:);
        start_point = site_indices(1);
        end_point = site_indices(2);
        animal_ratio = ratios(start_point:end_point);
        animal_delta = deltas(start_point:end_point);
        correlation_values = corrcoef(animal_ratio,animal_delta);
        mm_corr = correlation_values(2);
        pc_correlations = vertcat(pc_correlations, mm_corr);
    end
end