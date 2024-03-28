% 2D bilinear interpolation
% Showing what happens to interpolate a point of 1 lattice
function valueNoise2DInterpolationDemo()
  % Example
  % Lattice has wavelength of num_points
  num_points = 15;

  % Initialize noise matrix
  grid_size = [num_points, num_points];
  noise = zeros(grid_size);
  % Set random heights to lattice corners --- in this case we will hardcode them
  noise(1,1) = 15;
  noise(1,num_points) = 25;
  noise(num_points,1) = -10;
  noise(num_points,num_points) = 45;

  % How do we interpolate the value at position (7, 12), for example ?
  % - We first find the interpolation of coord X the "sides" of the lattice, nx0 and nx1

  poi = [7 12];

  % nx0 - from (1,1) to (num_points,1)
  nx0 = interpCos(poi(1), num_points, noise(1,1), noise(num_points,1));
  % nx1 - from (1,num_points) to (num_points,num_points)
  nx1 = interpCos(poi(1), num_points, noise(1,num_points), noise(num_points,num_points));
  % The result is also interpolated at the Y position
  nx1 = interpCos(poi(2), num_points, nx0, nx1);


  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %  Visual representation of what we have done

  % We will show the 1D interpolation first
  figure;
  side1D = zeros(1,num_points);
  for i=2:num_points-1
    side1D(i) = interpCos(i, num_points, noise(1,1), noise(num_points,1));
  endfor
  side1D(1) = noise(1,1);
  side1D(num_points) = noise(num_points,1);
  xs = 1:num_points;
  plot(xs, side1D, 'linewidth', 2, 'color','#4672eb'); hold on;
  plot([1 1], [0 side1D(1)], 'linewidth', 2, 'color', '#f2964b' );hold on;
  plot(1, side1D(1), 'o','MarkerSize',2);   hold on;
  plot([num_points num_points], [0 side1D(num_points)], 'linewidth', 2, 'color', '#f2964b' );hold on;
  plot(num_points, side1D(num_points), 'o','MarkerSize',2); hold on;

  poi1 = floor(num_points/3);
  plot([poi1 poi1], [0 side1D(poi1)], 'linewidth', 2, 'color', '#fc0015' );hold on;
  plot(poi1, side1D(poi1), 'o','MarkerSize',2); hold on;
  line ([0 num_points], [0 0], "linestyle", "--", "color", "k");
  axis off; box off;

  figure;
  grid = zeros(grid_size);

  % Paint the grid and the lattice point random values
  mesh(grid, "facecolor", "none", "edgecolor", "#a9a9a9");  hold on;
  % Paint the lattice points
  plot3([1 1],[1 1], [0 noise(1,1)], 'linewidth', 3, 'color', '#f2964b');   hold on;
  plot3([1],[1], [noise(1,1)], 'o','MarkerSize',3);   hold on;

  plot3([1 1],[num_points num_points], [0 noise(1,num_points)], 'linewidth', 3, 'color', '#f2964b');  hold on;
  plot3([1],[num_points], [noise(1,num_points)], 'o','MarkerSize',3);   hold on;

  plot3([num_points num_points],[1 1], [0 noise(num_points,1)], 'linewidth', 3 , 'color', '#f2964b');  hold on;
  plot3([num_points], [1], [noise(num_points,1)], 'o','MarkerSize',3);   hold on;

  plot3([num_points num_points],[num_points num_points], [0 noise(num_points,num_points)], 'linewidth', 3 , 'color', '#f2964b');  hold on;
  plot3([num_points], [num_points], [noise(num_points,num_points)], 'o','MarkerSize',3);   hold on;

  % Draw the linear interpolation of the first sides
  side = zeros(1,num_points);
  for i=2:num_points-1
    side(i) = interpCos(i, num_points, noise(1,1), noise(num_points,1));
  endfor
  side(1) = noise(1,1);
  side(num_points) = noise(num_points,1);
  xs = 1:num_points;
  ys = ones(1,num_points);
  plot3(xs, ys, side, 'linewidth', 3, 'color','#4672eb'); hold on;

  side2 = zeros(1,num_points);
  for i=2:num_points-1
    side2(i) = interpCos(i, num_points, noise(1,num_points), noise(num_points,num_points));
  endfor
  side2(1) = noise(1,num_points);
  side2(num_points) = noise(num_points,num_points);
  xs = 1:num_points;
  ys = ones(1,num_points) * num_points;
  plot3(xs, ys, side2, 'linewidth', 3, 'color','#4672eb'); hold on;

   % Plot the point of x = poi(1) on the sides (nx0 and nx1)
  plot3(poi(1), [1], side(poi(1)), 'o','MarkerSize',5, 'color', 'k');   hold on;
  plot3(poi(1), [num_points], side2(poi(1)), 'o','MarkerSize',5, 'color', 'k');   hold on;

  % Calc the interpolation between sides
  finalside = zeros(1, num_points);
  for i=2:num_points-1
    finalside(i) = interpCos(i, num_points, side(poi(1)), side2(poi(1)));
  endfor
  finalside(1) = side(poi(1));
  finalside(num_points) = side2(poi(1));
  xs = ones(1,num_points) * poi(1);
  ys = 1:num_points;
  plot3(xs, ys, finalside, 'linewidth', 3, 'color','#fc0015'); hold on;

  % Plot the interest point - the one interpolated
  plot3([poi(1) poi(1)],[poi(2) poi(2)], [0 finalside(poi(2))], 'linewidth', 3, 'color','#666460');   hold on;
  plot3(poi(1), poi(2), finalside(poi(2)), 'o','MarkerSize',7);   hold on;

  axis off; box off;
end;


function y = interpCos(x, wavelength, y1, y2)
  position = mod(x, wavelength) / wavelength;
  ft = position * pi;
  f = (1 - cos(ft)) * 0.5;
  y = y1 * (1 - f) + y2 * f;
end;



