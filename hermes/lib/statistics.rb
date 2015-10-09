class Statistics
  include CommonsSensors
  @@cache = {}

  def processing(topic, message)
    put topic, message
  end

  def put(topic, message)
    set topic, message
    flush topic if full? topic
  end

  def set(topic, message)
    cache[topic] ||= []
    cache[topic] << { date: Time.now, value: parse_value(topic, message) }
  end

  def full?(topic)
    cache[topic].size > max
  end

  def max
    Configuration.load['hermes']['max_cache']
  end

  def flush(topic)
    values = cache[topic]
    cache[topic].clear if HttpClient.send topic, values
  end

  def parse_value(topic, value)
    luminosity?(topic) ? luminosity_percent(value) : value
  end

  def luminosity?(topic)
    topic == Configuration.load['hermes']['luminosity']
  end

  def cache
    @@cache
  end

  def self.flush_all
    return if @@cache.empty?
    @@cache.each { |k, v| HttpClient.send k, v }
    @@cache.clear
  end
end
