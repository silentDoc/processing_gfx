% Perlin like noise composition in 1D

num_points = 400;
layer_1 = valueNoise2D(num_points, 100, 100);      % Layer 1 - wavelength 100, amp 100
figure; imagesc(layer_1); colormap(bone); title('Layer 1 - W100, A100');
figure; mesh(layer_1);title('Layer 1 - W100, A100');

layer_2 = valueNoise2D(num_points, 50, 25);        % Layer 2 - wavelength 50, amp 25
figure; imagesc(layer_2); colormap(bone); title('Layer 2 - W50, A25');
figure; mesh(layer_2);title('Layer 2 - W50, A25');

layer_3 = valueNoise2D(num_points, 20, 10);        % Layer 3 - wavelength 20, amp 10
figure; imagesc(layer_3); colormap(bone); title('Layer 3 - W20, A10');
figure; mesh(layer_3);title('Layer 3 - W20, A10');

layer_4 = valueNoise2D(num_points, 5, 5);          % Layer 4 - wavelength 5, amp 5
figure; imagesc(layer_3); colormap(bone); title('Layer 4 - W5, A5');
figure; mesh(layer_3);title('Layer 4 - W5, A5');


comp = layer_1 + layer_2 + layer_3 + layer_4;

figure; imagesc(comp); colormap(bone); title('Composition of layers');
figure; mesh(comp); title('Composition of layers');

