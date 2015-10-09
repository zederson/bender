module Builders
  class LuminosityController
    class << self
      attr_accessor :on

      def match?(topic)
        topic == 'lights/sensor/luminosity'
      end

      def on?
        LuminosityController.on ||= false
      end
    end

    def process(message)
      LuminosityController.on = (message == 'true')
      nil
    end
  end
end
