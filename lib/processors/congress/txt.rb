require "measure"

module Processor
  module Congress
    class TXT
      def initialize(source)
        @source = source
      end

      attr_reader :source

      def process
        Measure.new(source)
      end
    end
  end
end
