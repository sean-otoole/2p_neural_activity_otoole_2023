function [rois_per_site] = get_the_roi_counts(sites,proj_meta)
    rois_per_site = [];
    for siteID=sites
        current_sum = 0;
        for piezo = 1:4
            current_sum = current_sum + length(proj_meta(siteID).rd(piezo).ROIinfo);  
        end
        rois_per_site = [rois_per_site, current_sum];
    end
end