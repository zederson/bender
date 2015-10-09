class Builder

  PARSERS = [
    ::Builders::Color,
    ::Builders::Bri,
    ::Builders::On,
    ::Builders::Off,
    ::Builders::LuminosityController,
    ::Builders::Luminosity
  ]

  def self.build(topic)
    PARSERS.each { |p| return p if p.match? topic }
    nil
  end
end
