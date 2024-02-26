function [snps,velM_snps,velP_snps,grt_snps]=trig2snps2(proj_meta,siteID,tp,trigs,win)
% calculate snps matrix of trig responses per cell
% usage snps=get_trig_response(proj_meta,1,1,trigs,[-50 200]);
% GK 04.11.2016
if nargin<5
    win=[-100 100];
end
trigs=trigs(:)';
act=act2mat(proj_meta,siteID,tp);
if isempty(act)
    disp('No actvity? Probably dead.')
    snps=[];
    velM_snps=[];
    velP_snps=[];
    grt_snps = [];
    return
end
% remove any trigger too close to start, finish, or stack transition
trigs(find(sum(abs(bsxfun(@minus,[0 cumsum(proj_meta(siteID).rd(1,tp).nbr_frames)]',trigs))<max(abs(win)+1))))=[];
% catch for data where aux is shorter than frames
try
    if isfield(proj_meta(siteID).rd(1,tp),'velM')
        trigs(trigs>size(proj_meta(siteID).rd(1,tp).velP,2)-win(2))=[];
    else
        trigs(trigs>size(proj_meta(siteID).rd(1,tp).frame_times,2)-win(2))=[];
    end
catch
    disp('you have issues...')
    disp('fix them')
end
snps=reshape(act(:,[win(1):win(2)]'*ones(length(trigs),1)'+ones(sum(abs(win))+1,1)*trigs),[size(act,1),sum(abs(win))+1,length(trigs)]);
try
    velM_snps=proj_meta(siteID).rd(1,tp).velM([win(1):win(2)]'*ones(length(trigs),1)'+ones(sum(abs(win))+1,1)*trigs);
    velP_snps=proj_meta(siteID).rd(1,tp).velP([win(1):win(2)]'*ones(length(trigs),1)'+ones(sum(abs(win))+1,1)*trigs);
    if isfield(proj_meta(siteID).rd(1),'StimulusID') == 1
            grt_snps=proj_meta(siteID).rd(1,tp).StimulusID([win(1):win(2)]'*ones(length(trigs),1)'+ones(sum(abs(win))+1,1)*trigs);
        elseif isfield(proj_meta(siteID).rd(1),'GratingID') == 1
            grt_snps=proj_meta(siteID).rd(1,tp).GratingID([win(1):win(2)]'*ones(length(trigs),1)'+ones(sum(abs(win))+1,1)*trigs);
        else
            grt_snps=proj_meta(siteID).rd(1,tp).gratings([win(1):win(2)]'*ones(length(trigs),1)'+ones(sum(abs(win))+1,1)*trigs);
    end
    if siteID > 19 && siteID < 31
        velM_snps = velM_snps * 10;
        velP_snps = velP_snps * 10;
    end
    if siteID >30
        velM_snps = velM_snps / 5;
        velP_snps = velP_snps / 5;
    end
catch
    velM_snps=[];
    velP_snps=[];
    grt_snps=[];
end
end   
