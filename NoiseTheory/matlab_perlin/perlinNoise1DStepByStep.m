% NAIVE Perlin Nose 1D, step by step
% Extrapolation of the 2D case to the 1D case

% numpoints specify the number of points on the grid side, not overall
function noise = perlinNoise1DStepByStep(num_points, frequency, amplitude)

  rng(0, 'twister');   % Makes the pseudo random sequence repeatable, seed could be passed as param
  % rng("shuffle")     % Uncomment to make it variable over time

  noise = zeros(num_points, 1);

  % Step 1, creation of lattice points and random gradient values
  num_lattice = floor(num_points * frequency) + 2

  % We will keep our gradient values in array gradient
  gradient = zeros(num_lattice, 1);

  for i=1:num_lattice
      gradient(i) = getRandomGradient();
  endfor

  % Step 2 -  Now we calculate our noise
  for i=1:num_points

      % We find the current point to calculate the noise for, using the frequency
      x = i*frequency;

      % Find the lattice point that surrounds our point x0 and x1
      x0 = floor(x) +1;
      x1 = x0 + 1;

      % Get the gradient value of the lattice points surronding our point
      grad0 = gradient(x0);
      grad1 = gradient(x1);

      % Get the distance vectors from each lattice point to our point of interest
      dist0 = (x - floor(x));
      dist1 = (x - floor(x))-1;


      %n(p) = (1 - F(p-p0))g(p0)(p-p0) + F(p-p0)g(p1)(p-p1)
      u = fade(x - floor(x));

      % (1 - u) * grad0 + u * grad1
      %noise(i) = basiclerp(u, grad0, grad1);
      noise(i) = (1 - u) * grad0 * dist0 + u * grad1 * dist1;
  endfor

  noise = noise * amplitude;
end;

% Generates a random gradient vector of module 1
function res = getRandomGradient()
    rand_coords = (rand(1) * 2) -1;  % yields a random value ranging from -1 to 1
    %res = rand_coords / abs(rand_coords);
    res = rand_coords;
end;

function v = fade(t)
  % Smoothing step function proposed by Perlin
  % 6t5-15t4+10t3
  v = (6 * t^5) - (15*t^4) + (10 * t^3);
  % F(t) = t3(t(t-15)+10) -- this would be more efficient
end;

function v = basiclerp(amount, v0, v1)
    % This is just the basic linear interpolation.
		v = ((1 - amount) * v0) + (amount * v1);
end;

