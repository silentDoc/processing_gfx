function y_p = perlinFade(x_0, x_1, y_0, y_1, x_p)
  % normalize between 0 and 1
  x_p_norm = (x_p- x_0) / (x_1-x_0);

  w = (3 * x_p_norm^2) - (2 * x_p_norm^3);

  y_p = y_0 * (1-w) + y_1 * w;
end;
