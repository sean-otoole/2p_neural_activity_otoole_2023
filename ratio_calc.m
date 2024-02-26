function ratios = ratio_calc(sites, proj_meta)

    ratios = [];

    for siteID=sites        % get's the ratio values
        for tp = 2
            for piezo = 1:4
                for rois = 1:size(proj_meta(siteID).rd(piezo,tp).ROIinfo,2);
                    roi = proj_meta(siteID).rd(piezo, tp).ROIinfo(rois).indices;
                    green_template = proj_meta(siteID).rd(piezo, tp).template;
                    red_template = proj_meta(siteID).rd(piezo, tp).template_sec;
                    green_mean = mean(green_template(roi));
                    red_mean = mean(red_template(roi));
                    ratio = red_mean/green_mean;
                    ratios = vertcat(ratios,ratio);
                end
            end
        end
    end
end