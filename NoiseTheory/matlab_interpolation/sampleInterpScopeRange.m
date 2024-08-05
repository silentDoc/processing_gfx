
% Following the same notation we have in the artice, we have a pair of lattice
% points x0,y0 and x1,y1 --> (0, 8) and (5,15)
% We want to find the value y_p at x_p = 2 --> (2, ??)

x0 = 0;
x1 = 5;

y0 = 8;
y1 = 15;

x = 2;

y = perlinFade(x0,x1,y0,y1,x);

xs = x0:0.1:x1;
ys = zeros(size(xs));

for pos = 1:numel(xs)
  p = xs(pos);
  ys(pos) = cosineInterpolator(x0,x1,y0,y1,p);
endfor;

figure; hold on;
axis([-0.5 6 0 20])
plot(xs, ys, 'r', 'linewidth',2);
plot([x x],[0 y], 'color', 'c', 'linewidth', 3);
plot([x0 x0],[0 y0], 'color', 'y', 'linewidth', 3);
plot([x1 x1],[0 y1], 'color', 'y', 'linewidth', 3);
plot(x1, y1,'ok','MarkerSize',5);
plot(x0, y0,'ok','MarkerSize',5);
plot(x, y,'ok','MarkerSize',5);

txt = ["x = 2 , y = ", num2str(y)];
text(2.1, y-0.5,txt);


txt = ["x = 2"];
text(2.1, 0.5,txt);
txt = ["x0 = 0, y0 = 8"];
text(0.1, 7.5,txt);
txt = ["x1 = 5, y1 = 15"];
text(5, 15.5,txt);

x
y

% We can see that x = 2 between the segment 0,5 defined by the lattice points
% means that we would have xp = (2 / (5-0)) as the value to be used in the fade
% function.

xp = x / (x1-x0)

% w = 3xp^2 - 2xp^3

w = (3 * xp^2) - 2 * (xp^3)

% How does this w influence our final result? Consider it like a weight system.
% Our normalized position to estimate is at 0.2 (the middle would be 0.5), it is
% closer to the first lattice point (x0,y0), therefore, this firt point should have
% more influence to the final result

% Perlin fade function goes by = yp = x0 * (1-w) + y1 * w

influece_of_y0 = 1-w
influece_of_y1 = w
value = (1-w) * y0 + w * y1
value_comp = influece_of_y0 * y0 + influece_of_y1 * y1
