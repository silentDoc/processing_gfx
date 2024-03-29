xs = [1:2000];
ys = valueNoise1D(2000, 40, 500);      % wavelength 500
y2s = valueNoise1D(2000, 40, 250);     % wavelength 250
y3s = valueNoise1D(2000, 40, 125);     %  wavelength 125
figure; plot(xs, ys, 'r', 'linewidth', 4);
hold on; plot(xs, y2s, 'b', 'linewidth', 3);
hold on; plot(xs, y3s, 'g', 'linewidth', 2);
set(gca,'xtick',[0:125:2000])
%set (gca, "xminorgrid", "on");
set (gca, "xgrid", "on");


