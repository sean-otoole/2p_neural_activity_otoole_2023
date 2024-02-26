function [snps_all,velM_all,velP_all,cell_cnt,site_count,grt_all] = get_snps_flg_odd_even(input_sites,stimulus_type,first_threshold,odd_or_even)
proj_meta = evalin('base','proj_meta');
snps_all=[];
velM_all=[];
velP_all=[];
grt_all = [];
cell_cnt = 0;
trigs = [];
tp = 1;
site_count = 0;
global min_trig;
for siteID=input_sites;
    run_trace = proj_meta(siteID).rd(1,tp).velM_smoothed';
    vis_trace = proj_meta(siteID).rd(1,tp).velP;
    if siteID > 19 && siteID < 31
        run_trace = run_trace * 10;
        vis_trace = vis_trace * 10;
    end
    run_trace = max(run_trace,0);
    run_trace = smooth(run_trace,20);
    if strcmp(stimulus_type,'Gratings');
        frames = determine_frameset_fig_6(siteID,'GR');
        %include triggers for grating onsets where the mouse is running
        %below threshold at the onset
        if isfield(proj_meta(siteID).rd(1),'StimulusID') == 1
            trigs=find(diff(proj_meta(siteID).rd(1,tp).StimulusID>0.5)==1);
        elseif isfield(proj_meta(siteID).rd(1),'GratingID') == 1
            trigs=find(diff(proj_meta(siteID).rd(1,tp).GratingID>0.5)==1);
        else
            trigs=find(diff(proj_meta(siteID).rd(1,tp).gratings>0.5)==1);
        end
        trigs(run_trace(trigs)>first_threshold)=[];
        %exclude triggers that are too close to the end
        trigs_to_exclude = [];
        for trigger = trigs;
            if trigger+15 > size(run_trace)
                trigger_index = find(trigs==trigger);
                trigs_to_exclude = horzcat(trigs_to_exclude, trigger_index);
            end
        end
        trigs(trigs_to_exclude)= [];
        %exclude triggers where the mouse runs after the onset (1 second)
        trigs_to_exclude = [];
        for trigger = trigs
            if mean(run_trace((trigger):(trigger+15))) > first_threshold;
                trigger_index = find(trigs==trigger);
                trigs_to_exclude = horzcat(trigs_to_exclude, trigger_index);
            else
                % do nothing
            end
        end
        trigs(trigs_to_exclude)= [];
        trigs=intersect(trigs,frames);
        if strcmp(odd_or_even,'even');
            iseven = rem(trigs,2) == 0; 
            trigs = trigs(iseven);
        else
            isodd = rem(trigs,2) == 1; 
            trigs = trigs(isodd);
        end
    elseif strcmp(stimulus_type,'Mismatch');
        frames = determine_frameset_fig_6(siteID,'fb');
        trigs=find(diff(proj_meta(siteID).rd(1,tp).PS>0.5)==1);
        trigs=intersect(trigs,frames);
        trigs(run_trace(trigs)<first_threshold)=[];
        if strcmp(odd_or_even,'even');
            iseven = rem(trigs,2) == 0; 
            trigs = trigs(iseven);
        else
            isodd = rem(trigs,2) == 1; 
            trigs = trigs(isodd);
        end
    else strcmp(stimulus_type,'Running');
        frames = determine_frameset_fig_6(siteID,'all');   % was all            
        trigs=find(diff(run_trace>first_threshold)==1);
        trigs=intersect(trigs,frames);
        trigs((trigs)<(min(frames)+30))=[];
        if strcmp(odd_or_even,'even');
            iseven = rem(trigs,2) == 0; 
            trigs = trigs(iseven);
        else
            isodd = rem(trigs,2) == 1; 
            trigs = trigs(isodd);
        end
    end
    [snps,velM_snps,velP_snps,grt_snps]=trig2snps2(proj_meta,siteID,tp,trigs);
    if size(velM_snps,1) > 1;
        velM_snps = velM_snps'; velP_snps = velP_snps'; grt_snps = grt_snps';
    end
    grt_snps = grt_snps/100;
    if size(trigs) < min_trig
        continue
    end
    site_count = site_count + 1;
    velP_all(site_count,:)=mean(velP_snps',2);
    velM_all(site_count,:)=mean(velM_snps',2);
    grt_all(site_count,:)=mean(grt_snps',2);    
    n_cells=size(snps,1);
    snps_all(cell_cnt+1:cell_cnt+n_cells,:) = mean(snps,3);
    cell_cnt=cell_cnt+n_cells;
end
end