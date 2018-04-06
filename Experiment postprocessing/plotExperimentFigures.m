data = loadRealExperimentData(struct('datetime',{'2017-10-02 11-45-57'}, 'ch','80'), [], 2, 13, 30);
UAVgravityFactor = 9.81;
for strAxCell = {'Y', 'Z'}
	strAx = strAxCell{:};
	figure; plot(data.a_UAV.(strAx).t, UAVgravityFactor.*data.a_UAV.(strAx).measured, 'r', 'LineWidth',2); hold on; plot(data.a_cam.(strAx).t, data.a_cam.(strAx).measured, 'b', 'LineWidth',2); legend('a_{UAV},filt', 'a_{cam}');
end