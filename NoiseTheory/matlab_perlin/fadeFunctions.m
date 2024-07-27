x = 0:0.01:1;

y_linearIntepr = x;

y_cosineInterp = (1 - cos(x.*pi)) * 0.5;
% 3x2-2x3 (0<x<1)
y_perlinFadeOriginal = (3 * x.^2) -  (2 * x.^3);
% 6t5-15t4+10t3
y_perlinFadeImproved = (6 * x.^5) -  (15 * x.^4) +  (10 * x.^3);


%figure;
%plot(x, y_perlinFadeOriginal, 'r', 'linewidth', 3); title('Perlin Fade Function'); axis square;


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

hold off;




