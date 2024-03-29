function noise = valueNoise2D(num_points, wavelength, amplitude)
    % Generate random values for lattice points
    lattice_points = rand(num_points/wavelength + 2, num_points/wavelength+2);
    lattice_points = lattice_points * amplitude;
    lattice_points = lattice_points - (amplitude/2);

    grid_size = [num_points, num_points];

    % Initialize noise matrix
    noise = zeros(grid_size);

    f = waitbar(0, 'Generating noise'); % Adding some UI since this can take some time
    % Generate noise
    for i = 1:grid_size(1)
        waitbar(i/num_points);
        for j = 1:grid_size(2)

            % Get the 4 control points that enclose our point to interpolate
            % (x0,y0) - (x0,y1) - (x1,y0) - (x1,y1)
            x0 = floor(i / wavelength) +1;
            x1 = x0 +1;
            y0 = floor(j / wavelength) +1;
            y1 = y0 +1;

            % Bilinear interpolation - but using cosine interpolation as we did with 1D
            % This could be accelerated because we're calculating nx0 and nx1 every time
            % for any element in the middle (memoize - lookup tables)
            nx0 = interpCos(i, wavelength, lattice_points(y0, x0), lattice_points(y0, x1));
            nx1 = interpCos(i, wavelength, lattice_points(y1, x0), lattice_points(y1, x1));
            noise(i, j) = interpCos(j, wavelength, nx0, nx1);
        end
    end
    close(f);
end

% Octave does not have the Cosine interpolator, so we code it ourselves
function y = interpCos(x, wavelength, y1, y2)
  position = mod(x, wavelength) / wavelength;
  ft = position * pi;
  f = (1 - cos(ft)) * 0.5;
  y = y1 * (1 - f) + y2 * f;
end;


