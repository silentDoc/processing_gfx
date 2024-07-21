x = 0:0.01:1;

y_cosineInterp = (1 - cos(x.*pi)) * 0.5;
% 3x2-2x3 (0<x<1)
y_perlinFadeOriginal = (3 * x.^2) -  (2 * x.^3);
% 6t5-15t4+10t3
y_perlinFadeImproved = (6 * x.^5) -  (15 * x.^4) +  (10 * x.^3);


figure;
subplot(2,2,1); plot(x, y_cosineInterp, 'k', 'markersize', 2); title('Cosine interpolation'); axis square;
subplot(2,2,2); plot(x, y_perlinFadeOriginal, 'k', 'markersize', 2); title('Original Fade Function'); axis square;
subplot(2,2,3); plot(x, y_perlinFadeImproved, 'k', 'markersize', 2); title('Improved Fade Function'); axis square;
subplot(2,2,4); hold on;
plot(x, y_cosineInterp, 'k', 'markersize', 2);
plot(x, y_perlinFadeOriginal, 'b', 'markersize', 2);
plot(x, y_perlinFadeImproved, 'r', 'markersize', 2);
title('Comparison'); axis square;

hold off;

