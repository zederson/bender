class Sender

  @@on  = 0
  @@off = 0

  def send(topic, value)
    change?(value) ? on : off
  end

  def on
    increase_on

    if can_on?
      Fan.on!
      @@on = 0
    end
    @@off = 0
  end

  def off
    increase_off

    if can_off?
      Fan.off!
      @@off = 0
    end
    @on = 0
  end

  def increase_on
    @@on = @@on + 1
  end

  def increase_off
    @@off = @@off + 1
  end

  def decrease_on
    @@on = @@on - 1
    @@on = 0 if @@on < 0
  end

  def decrease_off
    @@off = @@off - 1
    @@off = 0 if @@off < 0
  end

  def change?(value)
    value >= Sender.max
  end

  def can_on?
    @@on > buffer
  end

  def can_off?
    @@off > buffer
  end
  private

  def self.max
    @@max ||= Configuration.load['termometro']['max']
  end

  def buffer
    @@buffer ||= Configuration.load['termometro']['buffer']
  end
end
