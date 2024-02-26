function deltas = delta_calc(onsets_input,baseline_period,peak_period)
    deltas = [];
    for neuron = 1:size(onsets_input,1)
        neuron_of_interest = onsets_input(neuron,:);
        neuron_delta = mean(neuron_of_interest(peak_period))-mean(neuron_of_interest(baseline_period));
        deltas = vertcat(deltas,neuron_delta);
    end
end