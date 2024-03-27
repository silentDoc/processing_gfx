% Define the range of x values
x_sin = linspace(0, 2*pi, 1000); % Range from 0 to 2*pi with 1000 points

% Calculate the corresponding y values using the sine function
y_sin = sin(x_sin)*256; % ranging from -256 to 256

y_noise = valueNoise1D(1000, 20, 10);        % Wavelength 10, amp 5, ranging from -5 to 5
y_sin_noise = y_sin + y_noise.';

figure; subplot(3,1, 1);
plot(x_sin, y_sin);
xlabel('x');
ylabel('sin(x)');
title('Plot of Sinusoidal Function');
subplot(3,1, 2);
plot(x_sin, y_noise);
xlabel('x');
ylabel('Value Noise');
title('Value Noise Function');
subplot(3,1, 3);
plot(x_sin, y_sin_noise);
xlabel('x');
ylabel('Sin with noise');
title('Plot of Sinusoidal Function with noise');
