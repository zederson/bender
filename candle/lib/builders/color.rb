module Builders
  class Color
    def self.match?(topic)
      topic =~ /^lights\/[0-9]*\/color$/
    end

    def process(message)
      { on: true, rgb: message }
    end
  end
end
