function[indices_vector] = get_site_indices_for_bootstrap(sites,excluded_site)
    indices_vector = [];
    j = 1;
    proj_meta = evalin('base','proj_meta');
    for site = sites
        if site == excluded_site;
            do nothing
        else
            for piezo = 1:4
                current_rois = j * ones(size(proj_meta(site).rd(piezo).ROIinfo,2),1);
                indices_vector = vertcat(indices_vector,current_rois);         
            end
            j = j + 1;
        end
    end 
end 