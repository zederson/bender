module Builders
  class Off
    include BulbUtil

    def self.match?(topic)
      topic == 'lights/off'
    end

    def process(message)
      change_light_all(on: false)
      nil
    end
  end
end
