%plot linear model for each site and color accordingly

function [] = plot_linear_models(ratios,deltas,color_vector)
    [colors,first_occurrences]= unique(color_vector,'first');
    first_occurrences = sort(first_occurrences);
    first_animal = [first_occurrences(1):(first_occurrences(2)-1)];
    second_animal = [first_occurrences(2):(first_occurrences(3)-1)];
    third_animal = [first_occurrences(3):(first_occurrences(4)-1)];
    fourth_animal = [first_occurrences(4):size(color_vector,1)];
    d1 = LinearModel.fit(ratios(first_animal),deltas(first_animal));
    animal_1_plot = plot(d1,'Color','Blue','Marker','none','MarkerEdgeColor','none','MarkerFaceColor','none')
    fitHandle_1 = findobj(animal_1_plot,'DisplayName','Fit');
    fitHandle_1.Color = char(unique(color_vector(first_animal)));
    cbHandles = findobj(animal_1_plot,'DisplayName','Confidence bounds');
    set(cbHandles, 'Color', char(unique(color_vector(first_animal))), 'LineWidth', 1)
    d2 = LinearModel.fit(ratios(second_animal),deltas(second_animal))
    animal_2_plot = plot(d2,'Marker','none','MarkerEdgeColor','none','MarkerFaceColor','none')
    fitHandle_2 = findobj(animal_2_plot,'DisplayName','Fit');
    fitHandle_2.Color = char(unique(color_vector(second_animal)));
    cbHandles = findobj(animal_2_plot,'DisplayName','Confidence bounds');
    set(cbHandles, 'Color', char(unique(color_vector(second_animal))), 'LineWidth', 1)
    d3 = LinearModel.fit(ratios(third_animal),deltas(third_animal))
    animal_3_plot = plot(d3,'Marker','none','MarkerEdgeColor','none','MarkerFaceColor','none')
    fitHandle_3 = findobj(animal_3_plot,'DisplayName','Fit');
    fitHandle_3.Color = char(unique(color_vector(third_animal)));
    cbHandles = findobj(animal_3_plot,'DisplayName','Confidence bounds');
    set(cbHandles, 'Color', char(unique(color_vector(third_animal))), 'LineWidth', 1)
    d4 = LinearModel.fit(ratios(fourth_animal),deltas(fourth_animal))
    animal_4_plot = plot(d4,'Marker','none','MarkerEdgeColor','none','MarkerFaceColor','none')
    fitHandle_4 = findobj(animal_4_plot,'DisplayName','Fit');
    fitHandle_4.Color = char(unique(color_vector(fourth_animal)));
    cbHandles = findobj(animal_4_plot,'DisplayName','Confidence bounds');
    set(cbHandles, 'Color', char(unique(color_vector(fourth_animal))), 'LineWidth', 1)
end