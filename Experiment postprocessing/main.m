clc
dateTimes = allDateTime();
for i = 1 : length(dateTimes)
    dateTime = dateTimes(i);
    data = loadRealExperimentData(struct('datetime',{dateTime{1,1}}, 'ch','80'), [], 2, 13, 30);
    UAVgravityFactor = 9.81;
    max_similarity = 0;
    for strAxCell = {'Y', 'Z'}
        strAx = strAxCell{:};
        t = data.a_UAV.(strAx).t;
        data_uav = UAVgravityFactor.*data.a_UAV.(strAx).measured - mean(UAVgravityFactor.*data.a_UAV.(strAx).measured);
        data_cam = data.a_cam.(strAx).measured - mean(data.a_cam.(strAx).measured);
        timeDiff = calculateTimeDiff(data_uav, data_cam);
        data_uav_delayed = delayseq(data_uav, -timeDiff, 30);
        fp_uav = generateFingerPrint(data_uav_delayed);
        fp_cam = generateFingerPrint(data_cam);
        similarity = calculateSimilarity(fp_uav, fp_cam);
        max_similarity = max(max_similarity, similarity)
    end
end
