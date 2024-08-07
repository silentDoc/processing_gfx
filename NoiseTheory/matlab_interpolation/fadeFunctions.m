x = 0:0.01:1;

time_start = time();
y_linearIntepr = x;
time_end = time();
printf("Linear interpolation = %f \n", time_end - time_start);

time_start = time();
y_cosineInterp = (1 - cos(x.*pi)) * 0.5;
time_end = time();
printf("Cosine interpolation = %f \n", time_end - time_start);

% 3x2-2x3 (0<x<1)
time_start = time();
y_perlinFadeOriginal = (3 * x.^2) -  (2 * x.^3);
time_end = time();
printf("Perlin Original Fade Function = %f \n", time_end - time_start);

% 6t5-15t4+10t3
time_start = time();
y_perlinFadeImproved = (6 * x.^5) -  (15 * x.^4) +  (10 * x.^3);
time_end = time();
printf("Perlin Improved Fade Function = %f \n", time_end - time_start);



figure;
%plot(x, y_perlinFadeImproved, 'r', 'linewidth', 3); title('Perlin Improved Fade Function'); axis square;


figure;
subplot(2,2,1); plot(x, y_linearIntepr, 'k', 'linewidth', 2); title('Linear Interpolation'); axis square;
subplot(2,2,2); plot(x, y_cosineInterp, 'c', 'linewidth', 2); title('Cosine interpolation'); axis square;
subplot(2,2,3); plot(x, y_perlinFadeOriginal, 'b', 'linewidth', 2); title('Original Perlin Fade Fn'); axis square;
subplot(2,2,4); plot(x, y_perlinFadeImproved, 'r', 'linewidth', 2); title('Improved Perlin Fade Fn'); axis square;


figure; hold on;
plot(x, y_linearIntepr, 'k', 'linewidth', 2);
plot(x, y_cosineInterp, 'c', 'linewidth', 2);
plot(x, y_perlinFadeOriginal, 'b', 'linewidth', 2);
plot(x, y_perlinFadeImproved, 'r', 'linewidth', 2);
title('Comparison'); axis square;
h = legend ("Linear", "Cosine", "Perlin", "Perlin Imp", "location", "southeast");
set (h, "fontsize", 15);


hold off;




