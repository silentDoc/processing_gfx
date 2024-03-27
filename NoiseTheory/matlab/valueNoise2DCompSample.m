% Perlin like noise composition in 1D

num_points = 400;
layer_1 = valueNoise2D(num_points, 100, 100);      % Layer 1 - wavelength 100, amp 100
layer_2 = valueNoise2D(num_points, 50, 25);        % Layer 2 - wavelength 50, amp 25
layer_3 = valueNoise2D(num_points, 20, 10);        % Layer 3 - wavelength 20, amp 10
layer_4 = valueNoise2D(num_points, 5, 5);          % Layer 4 - wavelength 5, amp 5

comp = layer_1 + layer_2 + layer_3 + layer_4;

figure; imagesc(comp); colormap(bone);
figure; mesh(comp);

