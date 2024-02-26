function [actmat,indROIinlayer,indlayer,spksmat,fissamat]=act2mat(proj_meta,siteID,tp)
% converts all zls of one site and tp to a matrix
% GK 14.10.2014

% intialize actmat to size
for ind=1:size(proj_meta(siteID).rd,1) % for number of piezo layers
    ncells(ind)=size(proj_meta(siteID).rd(ind,tp).act,1);
    if ncells(ind)>0
        nframes=size(proj_meta(siteID).rd(ind,tp).act,2);
    end
end
try
    actmat=zeros(sum(ncells),nframes);
    spksmat=zeros(sum(ncells),nframes);
    fissamat=zeros(sum(ncells),nframes);
catch
    disp(['ERROR - no activity found in site: ' num2str(siteID) ' tp: ' num2str(tp)])
    return
end



indROIinlayer = [];
indlayer = [];
cell_cnt=0;
for ind=1:size(proj_meta(siteID).rd,1)
    ncells=size(proj_meta(siteID).rd(ind,tp).act,1);
    actmat(cell_cnt+1:cell_cnt+ncells,:)=proj_meta(siteID).rd(ind,tp).act;
    cell_cnt=cell_cnt+ncells;
    indROIinlayer = [indROIinlayer 1:size(proj_meta(siteID).rd(ind,tp).act,1)];
    indlayer = [indlayer ones(1,size(proj_meta(siteID).rd(ind,tp).act,1)) * ind];
end
