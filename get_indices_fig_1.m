function site_roi_indices = get_indices_fig_1(sites,proj_meta)

    roi_number = 0;
    site_roi_indices =[];

    for siteID = sites
        for tp = 1
            start_index = roi_number+1;
            for piezo = 1:4
                rois_in_layer = size(proj_meta(siteID).rd(piezo,tp).ROIinfo,2);
                roi_number = roi_number + rois_in_layer;
            end
            end_index = roi_number;
            new_roi_indices = [start_index,end_index];
            site_roi_indices = vertcat(site_roi_indices,new_roi_indices);
        end
    end
end