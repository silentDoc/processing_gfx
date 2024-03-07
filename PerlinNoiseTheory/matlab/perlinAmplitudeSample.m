xs = [1:2000];
ys = perlin1D(2000, 120,500);     % amplitude 40
y2s = perlin1D(2000, 120,500);  % amplitude 120
y3s = perlin1D(2000, 80,500);   % amplitude 80
figure; plot(xs, ys, 'r');
hold on; plot(xs, y2s, 'b');
hold on; plot(xs, y3s, 'g');
axis on;

