function fingerPrint = generateFingerPrint(data)
    data_length = length(data);
    % adjust the data so that the average is 0
    data = abs(data - sum(data) ./ data_length);
%     data = abs(data);
    fingerPrint = zeros(1, data_length);
    threshold = 0.5;
    for i = 1 : length(data)
        if data(i) > threshold
            fingerPrint(i) = 1;
        else
            fingerPrint(i) = 0;
        end
    end
end
    
            
    