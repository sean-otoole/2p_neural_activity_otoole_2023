function[deltas] = get_the_deltas(sites,stimulus_type,type)
proj_meta = evalin('base','proj_meta');
baseline= 90:99;
if strcmp(stimulus_type,'Mismatch')
    mean_after = 107:122;
    thresh = 0.01;  %1 cm/s  
elseif strcmp(stimulus_type,'Running')
    %mean_after = 110:118;
    mean_after = 107:122;
    thresh = 0.005;  %0.5 cm/s  
else
    mean_after=115:130;
    thresh = 0.01;  %1 cm/s  
end
if strcmp(type,'standard')
    [current_snps] = get_snps_flg(sites,stimulus_type,thresh);
    deltas = delta_calc(current_snps,baseline,mean_after);
elseif strcmp(type,'measurement_noise')
    [odd_snps] = get_snps_flg_odd_even(sites,stimulus_type,thresh,'odd');
    [even_snps] = get_snps_flg_odd_even(sites,stimulus_type,thresh,'even');
    odd_delta = delta_calc(odd_snps,baseline,mean_after);
    even_delta = delta_calc(even_snps,baseline,mean_after);
    deltas = odd_delta - even_delta;
end
end