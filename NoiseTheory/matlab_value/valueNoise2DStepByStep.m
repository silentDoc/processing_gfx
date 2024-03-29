function noise = valueNoise2DStepByStep(num_points, wavelength, amplitude)
  grid_size = [num_points+1, num_points+1];
  noise = zeros(grid_size);

  %rng(5675, 'twister');   % Makes the pseudo random sequence repeatable, seed could be passed as param
  rng(564475, 'twister');   % Makes the pseudo random sequence repeatable, seed could be passed as param
  % rng("shuffle")     % Uncomment to make it variable over time

  % Step 1 - Lattice Point Generation.
  %          We will only need num_points/wavelength + 1  lattice points per each axis
  %          We assign a random value to each lattice point

  num_lattice_points = floor(grid_size(1) / wavelength) + 1;                 % Only for 1 axis

  % Notice than now, opposite to 2D, we have a matrix with numLatticePoints x numLatticePoints elements
  lattice_points = rand(num_lattice_points, num_lattice_points) * amplitude;
  %lattice_points = lattice_points - (amplitude/2);

  figure;
  grid = zeros(grid_size);

  % Paint the grid and the lattice point random values
  mesh(grid, "facecolor", "none", "edgecolor", "#c9c9c9");  hold on;

  % Display lattice_points
  for i=1:num_points+1
    for j=1:num_points+1
      if mod(i-1, wavelength) == 0 && mod(j-1, wavelength) == 0
        lattice_index_x = floor((i-1) / wavelength) +1;
        lattice_index_y = floor((j-1) / wavelength) +1;

        plot3([i i], [j j], [0 lattice_points(lattice_index_x,lattice_index_y)], 'red'); hold on;
        plot3(i, j, lattice_points(lattice_index_x,lattice_index_y),'o','MarkerSize',5); hold on;
        coords = [num2str(i) "," num2str(j)];
        text(i, j, lattice_points(lattice_index_x,lattice_index_y),coords)
      endif
    endfor
  endfor

  % Step 2 - Process the first lattice
  for i=1:wavelength+1  % coord X
    for j=1:wavelength+1 % coord Y
      if mod(i-1, wavelength) == 0 && mod(j-1, wavelength) == 0
        lattice_index_x = floor((i-1) / wavelength) +1;
        lattice_index_y = floor((j-1) / wavelength) +1;
        noise(i,j) = lattice_points(lattice_index_x,lattice_index_y);
      else
        % Get the 4 control points that enclose our point to interpolate
        % (x0,y0) - (x0,y1) - (x1,y0) - (x1,y1)
        x0 = floor((i-1) / wavelength) +1;
        x1 = x0 +1;
        y0 = floor((j-1) / wavelength) +1;
        y1 = y0 +1;

        % Bilinear interpolation - but using cosine interpolation as we did with 1D
        % This could be accelerated because we're calculating nx0 and nx1 every time
        % for any element in the middle (memoize - lookup tables)
        nx0 = interpCos(j-1, wavelength, lattice_points(x0, y0), lattice_points(x0, y1));
        nx1 = interpCos(j-1, wavelength, lattice_points(x1, y0), lattice_points(x1, y1));
        noise(i, j) = interpCos(i-1, wavelength, nx0, nx1);
      endif
    endfor
  endfor

##    mesh(noise.');   % need to transpose this one ?? wtf
##  axis off; box off;


   % Step 2b - Process 4 lattices
  for i=wavelength+1:num_points  % coord X
    for j=1:wavelength+1 % coord Y
      if mod(i-1, wavelength) == 0 && mod(j-1, wavelength) == 0
        lattice_index_x = floor((i-1) / wavelength) +1;
        lattice_index_y = floor((j-1) / wavelength) +1;
        noise(i,j) = lattice_points(lattice_index_x,lattice_index_y);
      else
        % Get the 4 control points that enclose our point to interpolate
        % (x0,y0) - (x0,y1) - (x1,y0) - (x1,y1)
        x0 = floor((i-1) / wavelength) +1;
        x1 = x0 +1;
        y0 = floor((j-1) / wavelength) +1;
        y1 = y0 +1;

        % Bilinear interpolation - but using cosine interpolation as we did with 1D
        % This could be accelerated because we're calculating nx0 and nx1 every time
        % for any element in the middle (memoize - lookup tables)
        nx0 = interpCos(j-1, wavelength, lattice_points(x0, y0), lattice_points(x0, y1));
        nx1 = interpCos(j-1, wavelength, lattice_points(x1, y0), lattice_points(x1, y1));
        noise(i, j) = interpCos(i-1, wavelength, nx0, nx1);
      endif
    endfor
  endfor

##  mesh(noise.');   % need to transpose this one ?? wtf
##  axis off; box off;

   % Step 3 - Process the rest
  for i=1:num_points  % coord X
    for j=wavelength+1:num_points % coord Y
      if mod(i-1, wavelength) == 0 && mod(j-1, wavelength) == 0
        lattice_index_x = floor((i-1) / wavelength) +1;
        lattice_index_y = floor((j-1) / wavelength) +1;
        noise(i,j) = lattice_points(lattice_index_x,lattice_index_y);
      else
        % Get the 4 control points that enclose our point to interpolate
        % (x0,y0) - (x0,y1) - (x1,y0) - (x1,y1)
        x0 = floor((i-1) / wavelength) +1;
        x1 = x0 +1;
        y0 = floor((j-1) / wavelength) +1;
        y1 = y0 +1;

        % Bilinear interpolation - but using cosine interpolation as we did with 1D
        % This could be accelerated because we're calculating nx0 and nx1 every time
        % for any element in the middle (memoize - lookup tables)
        nx0 = interpCos(j-1, wavelength, lattice_points(x0, y0), lattice_points(x0, y1));
        nx1 = interpCos(j-1, wavelength, lattice_points(x1, y0), lattice_points(x1, y1));
        noise(i, j) = interpCos(i-1, wavelength, nx0, nx1);
      endif
    endfor
  endfor

   mesh(noise.');   % need to transpose this one ?? wtf
  axis off; box off;


end;

% Octave does not have the Cosine interpolator, so we code it ourselves
function y = interpCos(x, wavelength, y1, y2)
  position = mod(x, wavelength) / wavelength;
  ft = position * pi;
  f = (1 - cos(ft)) * 0.5;
  y = y1 * (1 - f) + y2 * f;
end;

