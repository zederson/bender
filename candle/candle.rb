require 'mqtt'
require 'huey'
require '../lib/string'
require '../lib/configuration'
require '../lib/commons_sensors'

require './lib/bulb_util'
require './lib/bulb'
require './lib/builders/color'
require './lib/builders/bri'
require './lib/builders/on'
require './lib/builders/off'
require './lib/builders/luminosity_controller'
require './lib/builders/luminosity'
require './lib/builder'

config = Configuration.load
path   = config['bender']['broker']
queues = config['candle']['queues']

client = MQTT::Client.connect path
queues.each { |queue| client.subscribe queue }

puts "start: #{path} - queues: #{queues}".italic.cyan

begin
  client.get do |topic, message|
    Bulb.new.process topic, message
  end
rescue Exception => e
  puts "Error: #{e.message}" unless e.message.empty?
  client.disconnect
end
puts "\nCandle Stoped".red
