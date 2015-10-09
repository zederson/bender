module Builders
  class Luminosity
    include BulbUtil

    class << self
      attr_accessor :value

      def match?(topic)
        topic == 'sensors/luminosity'
      end
    end

    def process(message)
      return unless LuminosityController.on?
      set_value message
      nil
    end

    def set_value(message)
      return unless change?(message)
      Builders::Luminosity.value = message.to_i
      change_light_all all_bulb
    end

    def all_bulb
      val = value Builders::Luminosity.value
      on = on?(val)
      return { on: false } unless on
      { on: true, bri: val }
    end

    def change?(message)
      val = message.to_i
      old = Builders::Luminosity.value || 0
      (old - val).abs > 5
    end
  end
end
