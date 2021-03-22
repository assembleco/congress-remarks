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
        divisions = xml.
          search("division").
          map{|d| [
            d.search("enum")[0].text,
            d.search("header")[0].text,
        ] }
        titles = xml.
          search("title").
          map{|d| [
            d.search("enum")[0].text,
            d.search("header")[0].text,
        ] }

        binding.pry
        Measure.new(source)
      end
    end
  end
end
