module Builders
  class On
    def self.match?(topic)
      topic =~ /^lights\/[0-9]*\/on$/
    end

    def process(message)
      { on: on?(message) }
    end

    def on?(message)
      message == 'true'
    end
  end
end
