% Improved Perlin Nose 2D, step by step
% Original (not improved) perlin noise implementation, step by step, with comments
% The computation efficiency techniques (permutation table, hash) are skipped to focus on
% the noise algorithm only. This version is slow but it is not a

% numpoints specify the number of points on the grid side, not overall
function noise = perlinNoiseImproved2DStepByStep(num_points, frequency, amplitude)

  rng(0, 'twister');   % Makes the pseudo random sequence repeatable, seed could be passed as param
  % rng("shuffle")     % Uncomment to make it variable over time

  noise = zeros(num_points, num_points);

  % Step 1, creation of lattice points and random gradient vectors
  num_lattice = floor(num_points * frequency) + 2


  % Improved perlin noise - we will only have 4 possible gradient vectors
  % (1,1), (1,-1), (-1,1), (-1,-1). This will be resolved in the GetGradient function

  random_idx = randperm(512);

  % Step 2 -  Now we calculate our noise
  for i=1:num_points
    for j=1:num_points

      % We find the current point to calculate the noise for, using the frequency
      x = i*frequency;
      y = j*frequency;

      % Find the lattice point that surrounds our point [x0 y0], [x0 y1], [x1 y0], [x1 y1]
      x0 = floor(x) +1;
      x1 = x0 + 1;
      y0 = floor(y) +1;
      y1 = y0 + 1;

      % Get the gradient vector of the 4 lattice points surronding our point
      % This is one change in relation to the naive perlin noise implementation, since we
      % can only obtain 4 possible gradient vectors.

      grad00 = getImprovedGradientVector(random_idx, x0, y0);
      grad01 = getImprovedGradientVector(random_idx, x0, y1);
      grad10 = getImprovedGradientVector(random_idx, x1, y0);
      grad11 = getImprovedGradientVector(random_idx, x1, y1);

      % Get the distance vectors from each lattice point to our point of interest
      dist00 = [(x - floor(x))   (y - floor(y))];
      dist01 = [(x - floor(x))   (y - floor(y) - 1)];
      dist10 = [(x - floor(x) - 1) (y - floor(y))];
      dist11 = [(x - floor(x) - 1) (y-floor(y) - 1)];

      % Find the 4 values to be interpolated, that we get by calculating the
      % dot product between the gradient vector and the distance vector
      val00 = dot(grad00, dist00);
      val01 = dot(grad01, dist01);
      val10 = dot(grad10, dist10);
      val11 = dot(grad11, dist11);

      % Finally, interpolate the values

      % U and V are x and Y relative coordinates of the point inside the lattice
      % They are also smoothed by the fade function to achieve smoothness and continuity
      u = fade(x - floor(x));
      v = fade(y - floor(y));

      x1Interp = basiclerp(u, val00, val10);
      x2Interp = basiclerp(u, val01, val11);

      noise(i,j) = basiclerp(v, x1Interp, x2Interp);
    endfor
  endfor
  noise = noise * amplitude;
end;

function res = getImprovedGradientVector(rnd_indices, x, y)
  gradient_vec_x = [1;  1; -1; -1];
  gradient_vec_y = [1; -1;  1; -1];

  index = x + rnd_indices(mod(y, 256));
  index = mod(index, 4) +1;
  res = [gradient_vec_x(index) gradient_vec_y(index)];
end;


function v = fade(t)
  % Smoothing step function proposed by Perlin (improved)
  % 6t5-15t4+10t3
  v = (6 * t^5) - (15*t^4) + (10 * t^3);
end;

function v = basiclerp(amount, v0, v1)
    % This is just the basic linear interpolation.
		v = ((1 - amount) * v0) + (amount * v1);
end;

