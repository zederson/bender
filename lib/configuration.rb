require 'yaml'

class Configuration
  def self.load
    @@config ||= load_file
  end

  def self.load_file
    file = '../bender.yml'
    puts "Load #{file}".cyan
    YAML.load_file file
  end
end
