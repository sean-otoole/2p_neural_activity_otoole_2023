function [unique_animals] = get_unique_animals(sites)
current_animals = {};
proj_meta = evalin('base','proj_meta');
i = 1;
for siteID = sites
    animal = proj_meta(siteID).animal;
    current_animals{i} = animal;
    i = i + 1;
end
unique_animals = unique(current_animals);
end