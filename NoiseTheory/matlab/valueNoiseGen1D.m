function ys = valueNoiseGen(num, amplitude_max, wavelength_max, layers, persistance)

 amp = amplitude_max;
 wave = wavelength_max;
 ys = zeros(num,1);

  for i=1:layers
    y_layer = valueNoise1D(num, amp, wave);
    amp = amp / persistance;
    wave = wave / persistance;
    ys = ys + y_layser;
  end
end
