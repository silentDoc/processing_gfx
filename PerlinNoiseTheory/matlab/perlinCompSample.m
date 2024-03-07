xs = [1:2000];
ys = perlin1D(2000, 120, 500);      % wavelength 500, amp 120
y2s = perlin1D(2000, 60, 250);     % wavelength 250, amp 30
y3s = perlin1D(2000, 40, 125);     %  wavelength 125, amp 10

comp = ys .+ y2s;
comp = comp .+ y3s;

figure; subplot(2,1, 1);
plot(xs, ys, 'r');
hold on; plot(xs, y2s, 'b');
hold on; plot(xs, y3s, 'g');
set(gca,'xtick',[0:125:2000])
set (gca, "xgrid", "on");
subplot(2,1, 2);
plot(xs, comp, 'k');
hold on;
set(gca,'xtick',[0:125:2000])
set (gca, "xgrid", "on");
