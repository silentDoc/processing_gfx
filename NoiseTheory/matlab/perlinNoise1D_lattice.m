function perlinNoise1D_lattice(num_points, lattice_distance)

    % Generate lattice points
    lattice_points = (0:lattice_distance:num_points);

    % Generate random gradients for lattice points
    gradients = 2 * rand(size(lattice_points)) - 1;

    % Generate Perlin noise
    x = linspace(0, num_points, 1000); % Generate points for smooth plot
    noise = zeros(size(x));
    for i = 1:length(x)
        % Find the nearest lattice points
        lattice_index = floor(x(i) / lattice_distance) + 1;
        x0 = max(lattice_index - 1, 1);
        x1 = min(lattice_index, length(lattice_points));

        % Interpolate noise using gradients
        t = (x(i) - lattice_points(x0)) / lattice_distance;
        noise(i) = interpolate(gradients(x0), gradients(x1), t);
    end

    % Plot Perlin noise and gradient lines
    plot(x, noise, '-');
    hold on;
    plot(lattice_points, zeros(size(lattice_points)), 'ro'); % Plot lattice points
    for i = 1:length(lattice_points)
        quiver(lattice_points(i), 0, gradients(i), 0, 'b'); % Plot gradient slopes
    end
    hold off;

    xlabel('Position');
    ylabel('Noise Value');
    title('1D Perlin Noise with Gradient Lines');
    legend('Perlin Noise', 'Lattice Points', 'Gradients');
end

function interpolated_value = interpolate(a, b, t)
    % Linear interpolation between values a and b
    interpolated_value = a * (1 - t) + b * t;
end

