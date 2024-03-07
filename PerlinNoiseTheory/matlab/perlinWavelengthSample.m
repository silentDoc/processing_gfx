xs = [1:2000];
ys = perlin1D(2000, 40, 500);      % wavelength 500
y2s = perlin1D(2000, 40, 250);     % wavelength 250
y3s = perlin1D(2000, 40, 125);     %  wavelength 125
figure; plot(xs, ys, 'r');
hold on; plot(xs, y2s, 'b');
hold on; plot(xs, y3s, 'g');
set(gca,'xtick',[0:125:2000])
%set (gca, "xminorgrid", "on");
set (gca, "xgrid", "on");


