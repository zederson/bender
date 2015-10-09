require 'httpclient'
require 'json'

class HttpClient

  attr_accessor :topic, :values

  def initialize(topic, values)
    @topic  = topic
    @values = values
  end

  def build_params
    current = values.delete_at -1
    base    = { version: conf_client['version'], datastreams: [] }
    datapoints = Array.new.tap do |data|
      values.each do |v|
        data << { at: format_date(v[:date]), value: v[:value] }
      end
    end
    sensor = { id: id , datapoints: (datapoints || []), current_value: current[:value] }
    base[:datastreams] << sensor
    base
  end

  def format_date(date)
    date.strftime '%FT%H:%M:%SZ'
  end

  def id
    config[topic]
  end

  def send
    path = uri
    put path, build_params, headers
  end

  def put(path, payload, headers)
    puts "send data - #{values.size}".brown
    begin
      response = HTTPClient.put(path, payload.to_json, headers)
      return true if response.status == 200
      puts "Error: #{response.status} : #{response.body}".gray
    rescue Exception => e
      puts "Error: #{e.message} ".gray
    end
    false
  end

  def uri
    base = conf_client['uri']
    feed = conf_client['feed']
    "#{base}/#{feed}"
  end

  def headers
    {
      'Content-Type' => 'application/json',
      'X-ApiKey' => conf_client['key']
    }
  end

  def conf_client
    config['xively']
  end

  def config
    Configuration.load['hermes']
  end

  def self.send(topic, values)
    client = new topic, values
    client.send
  end
end
