function [mean_est]=nbstrp(Samples,GroupIndex,nbss)
% implements hierarchical bootstrapping
% usage:
% mean_est=nbstrp(Data,GroupIndex,nbss)
% Data: all data - e.g. mismatch responses from all neurons of all animals
% GroupIndex: a vector of the same lenght as data, that has an index
% (starting at 1) for all animals, e.g. [1 1 1 2 2 2 2 2] if the first 3
% neruons are from mouse 1 and the next 5 from mouse 2
% nbss: Number of bootstrap samples (10000)
% mean_est: the means of all bootstrapped samples
% 
% application:
% e.g. test whether grating response are larger than 0:
% p = sum(mean_est<0)/nbss
% 
% e.g. test whether MM response is higher than PBH response:
% p = sum(mean_estMM<mean_estPBH)/nbss
%
% the logic is always to ask what fraction of bootstrap sample means
% violate my hypothesis, this is your p-value


if nargin~=3
    disp(wtf);
    disp('usage: mean_est=nbstrp(Data,GroupIndex,nbss)');
    return;
end


Groups=unique(GroupIndex);
nbrGroups=length(Groups);
GroupBSinds=randi(nbrGroups,nbrGroups,nbss);

mean_est=nan(nbss,1);
for ind=1:nbss
    bss=[];
    for knd=1:nbrGroups
        current_group=GroupBSinds(knd,ind);
        curr_samps=Samples(GroupIndex==current_group);
        n_samps=length(curr_samps);
        bss(end+1:end+n_samps)=curr_samps(randi(n_samps,n_samps,1));
    end
    mean_est(ind)=mean(bss);
end

