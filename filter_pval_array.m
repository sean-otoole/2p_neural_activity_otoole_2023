function [altered_pval_array] =  filter_pval_array(input_array)
boolean_array = (input_array<0.05)';
indices_set = strfind(boolean_array,[0 1 0])+1;
input_array(indices_set)=1;
altered_pval_array = input_array;