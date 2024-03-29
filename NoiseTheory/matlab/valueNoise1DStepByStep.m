function ys = valueNoise1DStepByStep(num_points, wavelength, amplitude)
  xs = [1:num_points];
  ys = zeros(1, num_points);

  rng(0, 'twister');   % Makes the pseudo random sequence repeatable, seed could be passed as param
  % rng("shuffle")     % Uncomment to make it variable over time

  % Step 1 - Lattice Point Generation.
  %          We will only need num_points/wavelength + 1  lattice points
  %          We assign a random value to each lattice point
  num_lattice_points = num_points / wavelength + 1;
  lattice_points = rand(num_lattice_points, 1).*amplitude;
  lattice_points = lattice_points-(amplitude/2);

  % Display lattice_points
  figure;
  for p=1:num_points+1
    if mod(p-1, wavelength) == 0
      lattice_index = ((p-1) / wavelength) +1 ;
      plot([p-1 p-1],[0 lattice_points(lattice_index)], 'color', 'r', 'linewidth', 3); hold on;
      plot(p-1,lattice_points(lattice_index),'o','MarkerSize',5); hold on;
    endif
  endfor


  set(gca,'xtick',[0:wavelength:num_points])
  set (gca, "xgrid", "on");

  xlim([-5 num_points+5]);

##    plot(xs,ys, 'color', 'b', 'linewidth', 3); hold on; % Step 1 display
##    return;


  % Step 2 - Show how 2 lattice points are used to interpolate all the points in between
  % Pick the first two lattice points
  v_lattice_start = lattice_points(1);
  v_lattice_end = lattice_points(2);

  % Assign the lattice values at the bounds of the lattice points
  ys(1) = v_lattice_start;
  ys(wavelength+1) = v_lattice_end;

  % Interpolate the points in between. We use the cosine interpolator now
  for i=2:wavelength
    ys(i) = interpCos(i-1, wavelength, v_lattice_start, v_lattice_end);
  endfor

##    plot(xs,ys, 'color', 'b', 'linewidth', 3); hold on; % Step 2 display
##    return;

  % Step 2b, let's do some more points

  v_lattice_start  = 0;
  v_lattice_end    = 0;

  for i=wavelength+1:wavelength*4
    if mod(i-1, wavelength) == 0
      index_lattice = ((i-1)/wavelength) +1;
      v_lattice_start = lattice_points(index_lattice);
      v_lattice_end = lattice_points(index_lattice+1);
      ys(i) = v_lattice_start;
    else
      ys(i) = interpCos(i-1, wavelength, v_lattice_start, v_lattice_end);
    endif
  endfor

##    plot(xs,ys, 'color', 'b', 'linewidth', 3); hold on; % Step 2b display
##    return;


 % Step 2c, let's do the remaining points
 for i=wavelength*4+1:num_points
    if mod(i-1, wavelength) == 0
      index_lattice = ((i-1)/wavelength) +1;
      v_lattice_start = lattice_points(index_lattice);
      v_lattice_end = lattice_points(index_lattice+1);
      ys(i) = v_lattice_start;
    else
      ys(i) = interpCos(i-1, wavelength, v_lattice_start, v_lattice_end);
    endif
  endfor

  plot(xs,ys, 'color', 'b', 'linewidth', 3); hold on;  % Step 2c - final


end;

% Octave does not have the Cosine interpolator, so we code it ourselves
function y = interpCos(x, wavelength, y1, y2)
  position = mod(x, wavelength) / wavelength;
  ft = position * pi;
  f = (1 - cos(ft)) * 0.5;
  y = y1 * (1 - f) + y2 * f;
end;

