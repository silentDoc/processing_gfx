function ys = genNoise(num, amplitude_max, wavelength_max, octaves)

 amp = amplitude_max;
 wave = wavelength_max;
 ys = zeros(num,1);

  for i=1:octaves
    y_oct = valueNoise1D(num, amp, wave);
    amp = amp / 2;
    wave = wave / 2;
    ys = ys + y_oct;
  end
end
