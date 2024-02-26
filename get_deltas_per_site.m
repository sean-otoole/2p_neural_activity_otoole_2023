function [deltas_across_sites] = get_deltas_per_site(input_sites,stimulus_type,threshold,mean_after,baseline)
proj_meta = evalin('base','proj_meta');
deltas_across_sites = [];
tp = 1;
blsub = @(snp,bl) bsxfun(@minus,snp,mean(snp(:,bl),2));
global control_baseline;
for siteID=input_sites;    
        [current_snps] = get_snps_flg(siteID,stimulus_type,threshold);
        current_trace = mean(mean(current_snps,3),1);
        current_delta = mean(current_trace(mean_after))-mean(current_trace(baseline));
        deltas_across_sites = horzcat(deltas_across_sites,current_delta);
end    
end
  