clc
warning('off','all')
dateTimes = allDateTime();

UAVgravityFactor = 9.81;
threshold = 0;
match_index = [];
unmatch_index = [];
match_sim = [];
unmatch_sim = [];

for index = 1 : length(dateTimes)
    dateTime = dateTimes(index);
    data = loadRealExperimentData(struct('datetime',{dateTime{1,1}}, 'ch','80'), [], 2, 13, 30);
    for strAxCell = {'Y'}
        strAx = strAxCell{:};
        t = data.a_UAV.(strAx).t;
        data_uav = UAVgravityFactor.*data.a_UAV.(strAx).measured - mean(UAVgravityFactor.*data.a_UAV.(strAx).measured);
        data_cam = data.a_cam.(strAx).measured - mean(data.a_cam.(strAx).measured);
        timeDiff = calculateTimeDiff(data_uav, data_cam);
        data_uav_delayed = delayseq(data_uav, -timeDiff, 30);
        fp_uav = generateFingerPrint(data_uav_delayed, threshold, 128);
        fp_cam = generateFingerPrint(data_cam, threshold, 128);
        similarity = calculateSimilarity(fp_uav, fp_cam);
    %     max_similarity = max(max_similarity, similarity);
    %     cam_msg = gf(fp_cam, m);
    %     code = rsenc(cam_msg, n, k);
    %     pr = primpoly(m);
    %     code_dec = gf2dec(code, m, pr);
    %     uav_msg = gf([fp_uav, code_dec(129:end)], m);
    %     recovered_msg = rsdec(uav_msg, n, k);
    %     fp_cam == gf2dec(recovered_msg, m, pr)
        parity_symbol = generateParitySymbol(fp_cam);
        fp_restore = restoreFingerPrint(fp_uav, parity_symbol);
        is_matched = 1;
        for i = 1 : length(fp_restore)
            if fp_restore(i) ~= fp_cam(i)
                is_matched = 0;
                break;
            end
        end
        if is_matched == 1
            match_sim = [match_sim, similarity];
            match_index = [match_index, index];
        else
            unmatch_sim = [unmatch_sim, similarity];
            unmatch_index = [unmatch_index, index];
        end
    end
end
m = 8;
n = 152;
k = 128;
similarity = (k - (n / 8 - k / 8) / 2 * 8) / k;
figure; scatter(match_index, match_sim, 'filled'); 
hold on; scatter(unmatch_index, unmatch_sim);
hold on; plot([0, max(max(match_index), max(unmatch_index))], [similarity, similarity], 'k', 'LineWidth',1);
xlabel('Example', 'FontSize', 14);
ylabel('Similarity', 'FontSize', 14);
legend({'Matched', 'Unmatched'}, 'FontSize', 14, 'Location','southeast');

% msg = gf([0 1 0], m);
% code = rsenc(msg, n, k)
% 
% ori = rsdec(code, n, k)
% 
% pr = primpoly(m)
% 
% ori = gf2dec(code, m, pr)
% 
% code_with_error = gf([1 1 0 4 1 5 5], m)
% 
% ori2 = rsdec(code, n, k)