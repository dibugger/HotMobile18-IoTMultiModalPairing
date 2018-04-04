function timeDiff = calculateTimeDiff(data_uav, data_cam)
    Fs = 30;
    [acor, lag] = xcorr(data_uav, data_cam);
    [~, I] = max(abs(acor));
    lagDiff = lag(I);
    timeDiff = lagDiff / Fs;
end