require 'mqtt'
require '../lib/string'
require '../lib/configuration'
require '../lib/commons_sensors'

require './lib/statistics'
require './lib/http_client'

config    = Configuration.load
path      = config['bender']['broker']
queues    = config['hermes']['queues']
client    = MQTT::Client.connect path
statistic = Statistics.new

queues.each { |queue| client.subscribe queue }
puts "start: #{path} - queues: #{queues}".italic.cyan

begin
  client.get do |topic, message|
    statistic.processing topic, message
  end
rescue Exception => e
  puts "Error: #{e.message}".bg_red unless e.message.empty?
  client.disconnect
end

Statistics.flush_all
puts "\nHermes Stoped".red
