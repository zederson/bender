class Bulb
  def process(topic, message)
    begin
      lamp   = id topic
      values = params topic, message
      return if values.nil?
      change_light lamp, values
    rescue => e
      puts "fail: #{e.inspect}"
    end
  end

  def id(topic)
    match = topic.match /^lights\/([0-9]*)\/.*?$/
    match[1] if match
  end

  def params(topic, message)
    parse = parser topic
    parse.process message if parse
  end

  def parser(topic)
    parse = Builder.build topic
    parse.new if parse
  end

  def change_light(id, params)
    hue = Huey::Bulb.find(id.to_i)
    return if hue.nil? || params.empty?
    puts "process: #{id} - #{params}"
    params.each { |k,v| hue.send("#{k.to_s}=", v) }
    hue.commit
  end
end
