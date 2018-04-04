function similarity = calculateSimilarity(data_uav, data_cam)
    len = min(length(data_uav), length(data_cam));
    same = 0;
    for i = 1 : len
        if data_uav(i) == data_cam(i)
            same = same + 1;
        end
    end
    similarity = same / len;
end