function value_noise_demo2D()

    % Define parameters
    num = 300; % Width of the noise grid
    freq = 0.1; % Scale of the noise pattern

    % Generate value noise
    noise = valueNoise2D(num, 0.05, 200);



    % Plot the noise
    figure;
    mesh(1:num, 1:num, noise);
    xlabel('X');
    ylabel('Y');
    zlabel('Noise Value');
    title('2D Value Noise');

end

function noise = valueNoise2D(num_points, frequency, amplitude)
    % Generate random values for control points
    control_points = rand(num_points*frequency+2, num_points*frequency+2);
    control_points = control_points * amplitude;
    grid_size = [num_points, num_points]

    % Initialize noise matrix
    noise = zeros(grid_size);

    % Generate noise
    for i = 1:grid_size(1)
      i
        for j = 1:grid_size(2)

            x0 = floor( i * frequency) +1;
            x1 = x0 +1;
            y0 = floor( j * frequency) +1;
            y1 = y0 +1;

            X = (i+1)*frequency - x0;
            Y = (j+1)*frequency - y0;

            sx = (X - x0);
            u = fade(sx);
            nx0 = interpolate(control_points(y0, x0), control_points(y0, x1), u);
            nx1 = interpolate(control_points(y1, x0), control_points(y1, x1), u);
             % Interpolate along y-axis
            sy = (Y - y0);
            noise(i, j) = interpolate(nx0, nx1, fade(sy));
        end
    end
end


function t = fade(t)
    % Fade function to smooth the interpolation
    t3 = t^3;
    t2 = t^2;
    t;
    t = 6*t^5 - 15*t^4 + 10*t^3;
end

function interp_val = interpolate(a, b, t)
    % Linear interpolation function
    interp_val = a + t * (b - a);
end
