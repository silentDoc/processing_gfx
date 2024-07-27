% linear interpolator
y_p = linearInterpolator(x_0, x_1, y_0, y_1, x_p)
  y_p = y_0 + (y_1 - y_0) * ((x_p - x_0)/(x_1 -x_0));
end;
