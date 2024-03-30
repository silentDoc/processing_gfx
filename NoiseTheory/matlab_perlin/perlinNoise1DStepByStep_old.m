function ys = perlinNoise1DStepByStep(num_points, wavelength, amplitude)
  xs = [1:num_points];
  ys = zeros(1, num_points);

  gradient_line_length = 2;

  %rng(0, 'twister');   % Makes the pseudo random sequence repeatable, seed could be passed as param
  rng("shuffle")     % Uncomment to make it variable over time

  % Step 1 - Lattice Point Generation.
  %          We will only need num_points/wavelength + 1  lattice points
  %          The lattice points will provide the GRADIENT of the function at that points
  %          In perlin noise, the value of the function at a lattice point is always 0
  num_gradient_points = num_points / wavelength + 1;
  gradients = rand(num_gradient_points, 1); % The gradient will vary from -5 to 5
  gradients = gradients * 10;                % 10 = 5 - (-5)
  gradients = gradients - 5;

  cs = zeros(size(gradients));

  % Display gradients on lattice_points
  figure;
  %plot(ys); hold on;
  for p=1:num_points+1
    if mod(p-1, wavelength) == 0
      % Slope intercept form : y = gradient * x + c
      gradient_index = ((p-1) / wavelength) +1 ;
      gradient = gradients(gradient_index);
      % plot the gradient
      % Find c
      c = -1 * (p-1) * gradient;
      cs(gradient_index) = c;
      x_grad_s = max(p-1-gradient_line_length, 0);
      y_grad_s = gradient * x_grad_s + c;
      x_grad_e = min(p-1+gradient_line_length, num_points);
      y_grad_e = gradient * x_grad_e + c;
      plot( [x_grad_s x_grad_e], [y_grad_s y_grad_e], 'red'); hold on;
    endif
  endfor
  set(gca,'xtick',[0:wavelength:num_points])
  set (gca, "xgrid", "on");
  axis([-5 num_points+5 -1*(amplitude/2) (amplitude/2)]);

 % Step 2 - Show how 2 lattice points are used to interpolate all the points in between
 % Pick the first two lattice points
  gradient_start = gradients(1);
  gradient_end   = gradients(2);
  c_start = cs(1);
  c_end = cs(2);


  % Assign 0 to both start and end of the lattice
  ys(1) = 0;
  ys(wavelength+1) = 0;

  for i=2:wavelength
    factor = i/wavelength;
    weight = factor^3 * (factor * (factor * 6 - 15) + 10);

    comp_y_start = gradient_start * i + c_start;
    comp_y_end   = gradient_end * i + c_end;

    ys(i) = comp_y_start - weight * (comp_y_end - comp_y_start);
  endfor;
  plot(xs,ys, 'blue'); hold on;

##  % Interpolate the points in between. We use the cosine interpolator now
##  for i=2:wavelength
##    ys(i) = interpCos(i-1, wavelength, v_lattice_start, v_lattice_end);
##  endfor
##
##  % plot(xs,ys, 'blue'); hold on;
##
##  % Step 2b, let's do some more points
##
##  v_lattice_start  = 0;
##  v_lattice_end    = 0;
##
##  for i=wavelength+1:wavelength*4
##    if mod(i-1, wavelength) == 0
##      index_lattice = ((i-1)/wavelength) +1;
##      v_lattice_start = lattice_points(index_lattice);
##      v_lattice_end = lattice_points(index_lattice+1);
##      ys(i) = v_lattice_start;
##    else
##      ys(i) = interpCos(i-1, wavelength, v_lattice_start, v_lattice_end);
##    endif
##  endfor
##
## % plot(xs,ys, 'blue'); hold on;
## % Step 2c, let's do the remaining points
## for i=wavelength*4+1:num_points
##    if mod(i-1, wavelength) == 0
##      index_lattice = ((i-1)/wavelength) +1;
##      v_lattice_start = lattice_points(index_lattice);
##      v_lattice_end = lattice_points(index_lattice+1);
##      ys(i) = v_lattice_start;
##    else
##      ys(i) = interpCos(i-1, wavelength, v_lattice_start, v_lattice_end);
##    endif
##  endfor
##  plot(xs,ys, 'blue'); hold on;
end;

% Octave does not have the Cosine interpolator, so we code it ourselves
function y = interpCos(x, wavelength, y1, y2)
  position = mod(x, wavelength) / wavelength;
  ft = position * pi;
  f = (1 - cos(ft)) * 0.5;
  y = y1 * (1 - f) + y2 * f;
end;

