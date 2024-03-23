function noise = pNoise1D(num_points, frequency)
% Generate random gradient vectors
    gradients = 2 * rand(1, num_points) - 1;

    % Initialize noise vector
    noise = zeros(1, num_points);

    % Generate noise
    for i = 1:num_points
        % Calculate the indices of the gradient vectors
        x0 = floor(i * frequency)+1;
        x1 = mod(x0, num_points) + 1;
        t = rem(i * frequency, 1);

        % Calculate the contribution from the gradient vectors
        dot0 = gradients(x0);
        dot1 = gradients(x1);
        weight = t^3 * (t * (t * 6 - 15) + 10);
        noise(i) = dot0 + weight * (dot1 - dot0);
    end
end
