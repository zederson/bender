require 'mqtt'
require '../lib/string'
require '../lib/configuration'

require './lib/fan'
require './lib/sender'
require './lib/processor'
require './lib/client'

client = Client.build
queues = Configuration.load['termometro']['queues']

queues.each { |queue| client.subscribe queue }

puts "start: queues: #{queues}".italic.cyan

begin
  client.get { |topic, message| Processor.process topic, message }
rescue Exception => e
  puts "Error: #{e.message}".bg_red unless e.message.empty?
  client.disconnect
end

puts "\nTermometro Stoped".red
