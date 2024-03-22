# perlSample
% Example usage:
num_points = 1000;
persistence = 25;
num_octaves = 1;

noise = perlinNoise1D(num_points, persistence, num_octaves);
plot(noise);
title('1D Perlin Noise');
xlabel('X');
ylabel('Noise Value');
