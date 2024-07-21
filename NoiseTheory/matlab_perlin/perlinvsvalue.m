graphics_toolkit qt
gca

rng(0, 'twister');

num_lattice = 5;
wavelength = 10;

xy = [1:num_lattice] * wavelength;
[X Y] = meshgrid(xy);

inside = (wavelength*2):(20+wavelength);
[Xi Yi] = meshgrid(inside);

% Value noise
rand_values = [23 -12 8 16];  % Lattice point random values (4 values that define the square)
% Perlin noise
gradient_vector_x = [3 -2 -4  2];
gradient_vector_y = [-2 5  -3 3];



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Value noise lattice
valuefig = scatter(Xi, Yi,2);
hold on;
scatter(X, Y,5);              % lattice

plot(X(2,2), Y(2, 2), 'or');
text(2*wavelength -2, 2*wavelength-1, [num2str(rand_values(1))], 'FontSize', 14);
plot(X(2,3), Y(2, 3), 'or');
text(2*wavelength-3, 3*wavelength+1, [num2str(rand_values(2))], 'FontSize', 14);
plot(X(3,2), Y(3, 2), 'or');
text(3*wavelength+1, 2*wavelength-1, [num2str(rand_values(3))], 'FontSize', 14);
plot(X(3,3), Y(3, 3), 'or');
text(3*wavelength+1, 3*wavelength+1, [num2str(rand_values(4))], 'FontSize', 14);
%plot(24, 27, 'squarer');
grid on;
title('2D Value noise lattice');
% Value noise interpolation values
plot(24, 27, 'squarer');
axis square;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Perlin noise lattice
perlinfig = figure;
scatter(Xi, Yi,2);   % inside
hold on;
scatter(X, Y,5);              % lattice
plot(X(2,2), Y(2, 2), 'or');  % lattice points
plot(X(2,3), Y(2, 3), 'or');
plot(X(3,2), Y(3, 2), 'or');
plot(X(3,3), Y(3, 3), 'or');

% Gradient vectors
dArrow(X(2,2), Y(2,2), X(2,2) + gradient_vector_x(1), Y(2,2) + gradient_vector_y(1), 2, 'red');
dArrow(X(2,3), Y(2,3), X(2,3) + gradient_vector_x(2), Y(2,3) + gradient_vector_y(2), 2, 'red');
dArrow(X(3,2), Y(3,2), X(3,2) + gradient_vector_x(3), Y(3,2) + gradient_vector_y(3), 2, 'red');
dArrow(X(3,3), Y(3,3), X(3,3) + gradient_vector_x(4), Y(3,3) + gradient_vector_y(4), 2, 'red');

grid on;
title('2D Perlin noise lattice');
axis square;
% Perlin noise interpolation values
interp_point = [24 27];
plot(interp_point(1), interp_point(2), 'squarek', "linewidth", 3); % Point to interpolate

% Distance vectors
dArrow(X(2,2), Y(2,2), interp_point(1), interp_point(2), 2, 'magenta');
dArrow(X(2,3), Y(2,3), interp_point(1), interp_point(2), 2, 'magenta');
dArrow(X(3,2), Y(3,2), interp_point(1), interp_point(2), 2, 'magenta');
dArrow(X(3,3), Y(3,3), interp_point(1), interp_point(2), 2, 'magenta');

plot(interp_point(1), interp_point(2), 'squarek', "linewidth", 3); % Point to interpolate
