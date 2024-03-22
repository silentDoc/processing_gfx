function noise = perlinNoise1D(num_points, persistence, num_octaves)
    % Initialize variables
    noise = zeros(1, num_points);
    frequency = 1;
    amplitude = 1;
    total_amplitude = 0;

    % Generate each octave
    for octave = 1:num_octaves
        % Generate random gradient vectors
        gradients = 2 * rand(1, num_points) - 1;

        % Generate noise for this octave
        for i = 1:num_points
            % Calculate the current position within the gradient cell
            x0 = mod(i * frequency, num_points) + 1;
            x1 = mod(x0, num_points) + 1;
            t = rem(i * frequency, 1);

            % Calculate the contribution from the gradient vectors
            dot0 = gradients(x0) * (x0 - i * frequency);
            dot1 = gradients(x1) * (x1 - i * frequency);
            weight = t^3 * (t * (t * 6 - 15) + 10);
            noise(i) = noise(i) + amplitude * (dot0 + weight * (dot1 - dot0));
        end

        % Update frequency, amplitude, and total amplitude for the next octave
        frequency = frequency * 2;
        total_amplitude = total_amplitude + amplitude;
        amplitude = amplitude * persistence;
    end

    % Normalize the noise
    noise = noise / total_amplitude;
end
