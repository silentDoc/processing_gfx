lattice_xs = [1 5  10 15 20 22 24 25 26]
lattice_ys = [3 -2 5  8  0 7 -7 8 -5]

x = min(lattice_xs):0.01:max(lattice_xs);
y_linear = zeros(size(x));
y_cosine = zeros(size(x));
y_perlin = zeros(size(x));
y_perlinImproved = zeros(size(x));

num_lattice_points = numel(lattice_xs);

%y_p = linearInterpolator(x_0, x_1, y_0, y_1, x_p)
acum = 0;

for segment = 1:num_lattice_points-1
  points_to_calculate = lattice_xs(segment):0.01:lattice_xs(segment+1);
  for pos = 1:numel(points_to_calculate)
    x_p = points_to_calculate(pos);
    y_linear(pos + acum) = linearInterpolator( lattice_xs(segment), lattice_xs(segment+1), lattice_ys(segment), lattice_ys(segment+1), x_p);
    y_cosine(pos + acum) = cosineInterpolator( lattice_xs(segment), lattice_xs(segment+1), lattice_ys(segment), lattice_ys(segment+1), x_p);
    y_perlin(pos + acum) = perlinFade( lattice_xs(segment), lattice_xs(segment+1), lattice_ys(segment), lattice_ys(segment+1), x_p);
    y_perlinImproved(pos + acum) = perlinImprovedFade( lattice_xs(segment), lattice_xs(segment+1), lattice_ys(segment), lattice_ys(segment+1), x_p);
  endfor;
  acum = acum + numel(points_to_calculate)-1;
endfor;

figure; hold on;
for p = 1:num_lattice_points
  plot([lattice_xs(p) lattice_xs(p)], [0 lattice_ys(p)], 'b', 'linewidth', 2);
  plot(lattice_xs(p), lattice_ys(p), 'ok', 'markersize', 2);
endfor;
set(gca, 'XAxisLocation', 'origin')


figure; hold on;
plot(x, y_linear, 'g', 'linewidth',2);
plot(x, y_cosine, 'c', 'linewidth',2);
plot(x, y_perlin, 'b', 'linewidth',2);
plot(x, y_perlinImproved, 'r', 'linewidth',2);
for p = 1:num_lattice_points
  plot([lattice_xs(p) lattice_xs(p)], [0 lattice_ys(p)], 'k', 'linewidth', 1);
  plot(lattice_xs(p), lattice_ys(p), 'ok', 'markersize', 2);
endfor;

h = legend ("Linear", "Cosine", "Perlin", "Perlin Imp", "location", "northwest");
set (h, "fontsize", 15);
set(gca, 'XAxisLocation', 'origin')
hold off;

figure; hold on;
subplot(3,1,1); plot(x, y_cosine, 'r', 'linewidth',2);
subplot(3,1,2); plot(x, y_perlin, 'r', 'linewidth',2);
subplot(3,1,3); plot(x, y_perlinImproved, 'r', 'linewidth',2);



