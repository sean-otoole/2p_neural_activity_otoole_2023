function normVector = normalizeVector(inputVector)
    % Check if the input vector is a vector
    if ~isvector(inputVector)
        error('Input must be a vector');
    end
    
    % Sum of all elements in the vector
    total = sum(inputVector);
    
    % Divide each element in the vector by the total sum to normalize
    normVector = inputVector / total;
end