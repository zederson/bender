module BulbUtil
  include ::CommonsSensors

  def on?(value)
    value > 5
  end

  def value(message)
    val = convert message.to_i, 0, 1023, 0, 254
    255 - val
  end

  def change_light_all(params)
    hue = Huey::Bulb.all
    return if hue.nil? || params.empty?
    params.each { |k,v| hue.send("#{k.to_s}=", v) }
    hue.commit
  end
end
