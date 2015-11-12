class Fan
  @@state = false

  def self.on!
    return true if on?
    @@state = true
    put_queue
  end

  def self.on?
    @@state
  end

  def self.off!
    return true unless on?
    @@state = false
    put_queue
  end

  def self.put_queue
    client = Client.build
    queue  = Configuration.load['termometro']['send_queue']
    notify client
    client.publish(queue, "#{on?}")
    puts " Ventilador: #{on?}".magenta
  end

  def self.notify(client)
    queue   = Configuration.load['jaiminho']['queue']
    message = Configuration.load['jaiminho']['message_fan']
    client.publish(queue, message)
  end
end
