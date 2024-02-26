function [snps,velM_snps,velP_snps,pupil_pos_snps,popil_diam_smps]=trig2snps_(proj_meta,siteID,tp,trigs,win,do_eye)
% calculate snps matrix of trig responses per cell
% usage snps=get_trig_response(proj_meta,1,1,trigs,[-50 200]);
% GK 04.11.2016

if nargin<5
    win=[-100 100];
end

if nargin<6
    do_eye=0;
end

trigs=trigs(:)';

act=act2mat(proj_meta,siteID,tp);

if isempty(act)
    disp('No actvity? Probably dead.')
    snps=[];
    velM_snps=[];
    velP_snps=[];
    return
end

% remove any trigger too close to start, finish, or stack transition
trigs(find(sum(abs(bsxfun(@minus,[0 cumsum(proj_meta(siteID).rd(1,tp).nbr_frames)]',trigs))<max(abs(win)+1))))=[];

% catch for data where aux is shorter than frames
try
    if isfield(proj_meta(siteID).rd(1,tp),'velM')
        trigs(trigs>size(proj_meta(siteID).rd(1,tp).velM,2)-win(2))=[];
    else
        trigs(trigs>size(proj_meta(siteID).rd(1,tp).frame_times,2)-win(2))=[];
    end
catch
    disp('you have issues...')
    disp('fix them')
end

snps=reshape(act(:,[win(1):win(2)]'*ones(length(trigs),1)'+ones(sum(abs(win))+1,1)*trigs),[size(act,1),sum(abs(win))+1,length(trigs)]);

try
    velM_snps=proj_meta(siteID).rd(1,tp).velM_smoothed([win(1):win(2)]'*ones(length(trigs),1)'+ones(sum(abs(win))+1,1)*trigs);
    velP_snps=proj_meta(siteID).rd(1,tp).velP_smoothed([win(1):win(2)]'*ones(length(trigs),1)'+ones(sum(abs(win))+1,1)*trigs);
catch
    velM_snps=[];
    velP_snps=[];
end

if do_eye
    pupil_pos_snps=[];
    popil_diam_smps=[];
 try
    pupil_pos_snps=proj_meta(siteID).rd(1,tp).velM_smoothed([win(1):win(2)]'*ones(length(trigs),1)'+ones(sum(abs(win))+1,1)*trigs);
    popil_diam_smps=proj_meta(siteID).rd(1,tp).velP_smoothed([win(1):win(2)]'*ones(length(trigs),1)'+ones(sum(abs(win))+1,1)*trigs);
catch
    pupil_pos_snps=[];
    popil_diam_smps=[];
end   
    
end