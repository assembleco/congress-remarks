require "measure"
require "nokogiri"
require "pry"

module Processor
  module Congress
    class XML
      def initialize(source)
        @source = source
      end

      attr_reader :source

      def process
        xml = Nokogiri::XML(source)
        binding.pry
        Measure.new(source)
      end
    end
  end
end
