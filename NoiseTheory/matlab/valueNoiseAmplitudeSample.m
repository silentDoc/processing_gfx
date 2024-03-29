xs = [1:2000];
y2s = valueNoise1D(2000, 120,500);  % amplitude 120
y3s = valueNoise1D(2000, 80,500);   % amplitude 80
ys = valueNoise1D(2000, 40,500);   % amplitude 40

figure; plot(xs, ys, 'r', 'linewidth', 4);
hold on; plot(xs, y2s, 'b', 'linewidth', 3);
hold on; plot(xs, y3s, 'g', 'linewidth', 2);
axis on;

