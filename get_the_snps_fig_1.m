function [trigs,snps_all,velM_all,cell_cnt] = get_the_snps_fig_1(onset_type,proj_meta,sites)   %1 is mismatch, 2 is running, 3 is grating
    cell_cnt = 0;
    tp = 1;
    trigs = [];
    
    velM_threshold = 0.0001; % for running
    velocity_cutoff = 0.01; %for gratings
    
    if onset_type == 1;
    
        for siteID=sites
            trigs=(find(diff(proj_meta(siteID).rd(1,tp).PS>0.1)==1)+1);
            trigs=intersect(trigs,[1:7500]);
            trigs(proj_meta(siteID).rd(1,tp).velM_smoothed(trigs)<0.01)=[];
    
            trigs_to_exclude = [];
    
            for trigger = 1:length(trigs)   %selects for triggers where the mouse was consistently running prior to mismatch
            
                pre_onset_speed = mean(proj_meta(siteID).rd(1,tp).velM_smoothed((trigs(trigger)-50):(trigs(trigger)-10)));
                post_onset_speed = mean(proj_meta(siteID).rd(1,tp).velM_smoothed((trigs(trigger)+1):(trigs(trigger)+30)));
                speed_ratio = pre_onset_speed/post_onset_speed;
                
                if speed_ratio > 1.5 | speed_ratio < 0.1;
                    trigger_index = find(trigs==trigs(trigger));
                    trigs_to_exclude = horzcat(trigs_to_exclude, trigger_index);
                end
            end
    
            trigs(trigs_to_exclude)= [];
            
            [snps,velM_snps,velP_snps]=trig2snps_(proj_meta,siteID,tp,trigs);

    
            velM_all(siteID,:)=mean(velM_snps,2);
            n_cells=size(snps,1);
            snps_all(cell_cnt+1:cell_cnt+n_cells,:) = mean(snps,3);
            cell_cnt=cell_cnt+n_cells;
        end
    
    elseif onset_type == 2;
    
        for siteID=sites
            
            trigs=find(diff(proj_meta(siteID).rd(1,tp).velM_smoothed>velM_threshold)==1);
            trigs=intersect(trigs,[7501:15000]);

            trigs_to_exclude = [];
            [snps,velM_snps,velP_snps]=trig2snps_(proj_meta,siteID,tp,trigs);
        
    
            velM_all(siteID,:)=mean(velM_snps,2);
            n_cells=size(snps,1);
            snps_all(cell_cnt+1:cell_cnt+n_cells,:) = mean(snps,3);
            cell_cnt=cell_cnt+n_cells;
        end
           
    else onset_type == 3;
        
        for siteID=sites       
        
            grat_frames=[15000:22500];
            trigs=find(diff(proj_meta(siteID).rd(1,tp).gratings>1.3)==1);
            trigs=intersect(trigs,grat_frames);            
            trigs_to_exclude = [];
 
            for trigger = 1:length(trigs)   %selects for triggers where the mouse is sitting just before and after the onset
                
                onset_baseline = max(proj_meta(siteID).rd(1,tp).velM_smoothed((trigs(trigger)-5):(trigs(trigger)+40)));
            
                if onset_baseline > velocity_cutoff;
                    trigger_index = find(trigs==trigs(trigger));
                    trigs_to_exclude = horzcat(trigs_to_exclude, trigger_index);
                end
            end
        
            trigs(trigs_to_exclude)= [];
            [snps,velM_snps,velP_snps]=trig2snps_(proj_meta,siteID,tp,trigs);
        
    
            velM_all(siteID,:)=mean(velM_snps,2);
            n_cells=size(snps,1);
            snps_all(cell_cnt+1:cell_cnt+n_cells,:) = mean(snps,3);
            cell_cnt=cell_cnt+n_cells;
        end
    
    end
    
end