function [vis_values,run_values] = get_run_vis_correlations_flg(sites,running_threshold,percent_threshold,per_site)
shift = 0;
proj_meta = evalin('base','proj_meta');
tp = 1;
smooth_window = 1;
activity_shift = 0;
if ~exist('per_site','var')
    per_site = 0;
end
run_values = [];
vis_values = [];
if per_site == 0;
    for siteID = [sites]
        pb_frames = determine_frameset_with_running_thresh(siteID,running_threshold,percent_threshold);
        for piezo = 1:4
            y = smooth2(proj_meta(siteID).rd(piezo,tp).velP(pb_frames),smooth_window);
            z = smooth2(proj_meta(siteID).rd(piezo,tp).velM(pb_frames),smooth_window);
            z = max(z,0);
            for cell = 1:size(proj_meta(siteID).rd(piezo,tp).act,1)
                act_vis = circshift(smooth2(proj_meta(siteID).rd(piezo,tp).act(cell,pb_frames),smooth_window),activity_shift);
                act_run = circshift(smooth2(proj_meta(siteID).rd(piezo,tp).act(cell,pb_frames),smooth_window),activity_shift);
                vis = corrcoef(act_vis,y);
                run = corrcoef(act_run,circshift(z,-1));
                vis = vis(2);
                run = run(2);
                run_values = vertcat(run_values, run);
                vis_values = vertcat(vis_values, vis);
            end
        end
    end
else
    for siteID = [sites]
        pb_frames = determine_frameset_with_running_thresh(siteID,running_threshold,percent_threshold);
        run_site_values = [];
        vis_site_values = [];
        for piezo = 1:4
            y = smooth2(proj_meta(siteID).rd(piezo,tp).velP(pb_frames),smooth_window);
            z = smooth2(proj_meta(siteID).rd(piezo,tp).velM(pb_frames),smooth_window);
            y = max(y,0);
            z = max(z,0);
            for cell = 1:size(proj_meta(siteID).rd(piezo,tp).act,1)
                act_vis = circshift(smooth2(proj_meta(siteID).rd(piezo,tp).act(cell,pb_frames),smooth_window),activity_shift);
                act_run = circshift(smooth2(proj_meta(siteID).rd(piezo,tp).act(cell,pb_frames),smooth_window),activity_shift);
                vis = corrcoef(act_vis,circshift(y,0));
                run = corrcoef(act_run,circshift(z,-1));
                vis = vis(2);
                run = run(2);
                run_site_values = vertcat(run_site_values,run);
                vis_site_values = vertcat(vis_site_values,vis);
            end
        end
        run_values = vertcat(run_values, mean(run_site_values));
        vis_values = vertcat(vis_values, mean(vis_site_values));
    end
end
end