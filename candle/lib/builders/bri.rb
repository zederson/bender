module Builders
  class Bri
    include BulbUtil

    def self.match?(topic)
      topic =~ /^lights\/[0-9]*\/bri$/
    end

    def process(message)
      val = value(message)
      on = on?(val)
      return { on: false } unless on
      { on: true, bri: val }
    end
  end
end
