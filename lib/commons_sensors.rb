module CommonsSensors
  def convert(x, in_min, in_max, out_min, out_max)
    ((x - in_min) * (out_max - out_min)) / ((in_max - in_min) + out_min)
  end

  def luminosity_percent(value)
    ((value.to_f / 1023) * 100).round(2)
  end
end
