% Generate num Y-Values of perlin noise, that vary from -amplitude/2 to amplitude/2
% with octave set to wavelength

function ys = valueNoise1D(num, amplitude, wavelength)
  ys = zeros(num,1);

  rng(0, 'twister');   % Makes the pseudo random sequence repeatable, seed could be passed as param
  % rng("shuffle")     % Uncomment to make it variable over time

  rand_positions = rand(num + 1,1).*amplitude;
  rand_positions = rand_positions-(amplitude/2);

  v_wave_start  = 0;
  v_wave_end    = 0;

  for i=1:num
    if mod(i-1, wavelength) == 0
      v_wave_start = rand_positions(i,1);
      v_wave_end = rand_positions(i+wavelength);
      ys(i) = v_wave_start;
    else
      ys(i) = interpCos(i-1, wavelength, v_wave_start, v_wave_end);
    endif
  endfor
end

% Octave does not have the Cosine interpolator, so we code it ourselves
function y = interpCos(x, wavelength, y1, y2)
  position = mod(x, wavelength) / wavelength;
  ft = position * pi;
  f = (1 - cos(ft)) * 0.5;
  y = y1 * (1 - f) + y2 * f;
end;

% xs = [1:2000];
% ys = perlin1D(2000,40,500);
% figure; plot(xs, ys);
