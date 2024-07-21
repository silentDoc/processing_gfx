% Fast helper to draw lines
function dArrow(x0, y0, x1, y1, arrow_width, arrow_color)
  h = quiver( x0,y0,x1-x0,y1-y0,0,'linewidth',arrow_width,'color',arrow_color, "maxheadsize", 0.075, "AutoScale", "off");
end;

