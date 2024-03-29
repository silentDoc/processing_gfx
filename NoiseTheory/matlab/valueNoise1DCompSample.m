% Perlin like noise composition in 1D

xs = [1:2000];
ys = valueNoise1D(2000, 120, 500);      % Layer 1 - wavelength 500, amp 120
y2s = valueNoise1D(2000, 60, 250);      % Layer 2 - wavelength 250, amp 60
y3s = valueNoise1D(2000, 40, 125);      % Layer 3 - wavelength 125, amp 40
y4s = valueNoise1D(2000, 5, 10);        % Layer 4 - wavelength 10, amp 5

comp = ys + y2s;
comp = comp + y3s;
comp = comp + y4s;                  % Comp holds the sum of all Layers

figure; subplot(2,1, 1);
plot(xs, ys, 'r', 'linewidth', 4);
hold on; plot(xs, y2s, 'b', 'linewidth', 3);
hold on; plot(xs, y3s, 'g', 'linewidth', 2);
hold on; plot(xs, y4s, 'magenta', 'linewidth', 2);
set(gca,'xtick',[0:125:2000])
set (gca, "xgrid", "on");
subplot(2,1, 2);
plot(xs, comp, 'k', 'linewidth', 2);
hold on;
set(gca,'xtick',[0:125:2000])
set (gca, "xgrid", "on");

xs2 = [1:2048];
genN = genValueNoise(2048,256,512, 6);

figure;
plot(xs2, genN, 'red');
hold on;
set(gca,'xtick',[0:128:2048])
set (gca, "xgrid", "on");

