% Derivatives
x = 0:0.01:1;

y_linearIntepr = x;

y_cosine = (1 - cos(x.*pi)) * 0.5;
y_cosineFod = (pi * sin(x.*pi)) * 0.5;
y_cosineSod = (pi^2 * cos(x.*pi)) * 0.5;

% 3x2-2x3 (0<x<1)
y_perlin = (3 * x.^2) -  (2 * x.^3);
y_perlinFod = (6 * x) -  (6 * x.^2);
y_perlinSod = 6 -  (12 * x);


% 6t5-15t4+10t3
y_perlinImp = (6 * x.^5) -  (15 * x.^4) +  (10 * x.^3);
y_perlinImpFod = (30 * x.^4) -  (60 * x.^3) +  (30 * x.^2);
y_perlinImpSod = (120 * x.^4) -  (180 * x.^3) +  (60 * x.^2);

figure;
plot(x, y_cosine, 'r', 'linewidth', 3); title('Cosine Interpolator and derivatives'); axis square; hold on;
plot(x, y_cosineFod, 'c', 'linewidth', 3);
plot(x, y_cosineSod, 'g', 'linewidth', 3);
h = legend ("Cosine Interp.", "First Order Derivative", "Second Order Derivative", "location", "southwest");
set (h, "fontsize", 12);


figure;
plot(x, y_perlin, 'r', 'linewidth', 3); title('Perlin Fade Function and derivatives'); axis square; hold on;
plot(x, y_perlinFod, 'c', 'linewidth', 3);
plot(x, y_perlinSod, 'g', 'linewidth', 3);
h = legend ("Perlin Fade Function", "First Order Derivative", "Second Order Derivative", "location", "southwest");
set (h, "fontsize", 12);


figure;
plot(x, y_perlinImp, 'r', 'linewidth', 3); title('Perlin Improved Fade Function and derivatives'); axis square; hold on;
plot(x, y_perlinImpFod, 'c', 'linewidth', 3);
plot(x, y_perlinImpSod, 'g', 'linewidth', 3);
h = legend ("Perlin Fade Function", "First Order Derivative", "Second Order Derivative", "location", "southwest");
set (h, "fontsize", 12);
