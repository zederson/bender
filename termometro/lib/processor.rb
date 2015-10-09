class Processor
  def self.process(topic, value)
    Sender.new.send topic, value.to_f
  end
end
