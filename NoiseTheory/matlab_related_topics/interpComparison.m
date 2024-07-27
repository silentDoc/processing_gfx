lattice_xs = [1 5  10 15 20]
lattice_ys = [3 -2 5  8  0]

x = min(lattice_xs):0.01:max(lattice_xs);

num_lattice_points = numel(lattice_xs);

for segment = 1:num_lattice_points-1
  for p_x = lattice_xs(segment):lattice_xs(segment+1)


  endfor
endfor;



