function fingerPrint = generateFingerPrint(data, threshold, len)
    data_length = length(data);
    % adjust the data so that the average is 0
    data = data - sum(data) ./ data_length;
    fp = zeros(1, data_length);
    for i = 1 : length(data)
        if data(i) > threshold
            fp(i) = 1;
        else
            fp(i) = 0;
        end
    end
    % choose 128 bits
    sample_length = length(fp);
    step = floor(sample_length / len);
    fingerPrint = zeros(1, len);
    for i = 1 : len
        fingerPrint(i) = fp(i * step);
    end
end
    
            
    