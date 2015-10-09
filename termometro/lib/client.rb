class Client
  @@client = nil

  def initialize
    if @@client.nil?
      config   = Configuration.load
      path     = config['bender']['broker']
      @@client = MQTT::Client.connect path
      puts "Connected: #{path}".brown
    end
  end

  def self.build
    new
    @@client
  end
end
