require "measure"
require "nokogiri"

module Processor
  module Congress
    class XML
      def initialize(source)
        @source = source
      end

      attr_reader :source

      def process
        xml = Nokogiri::XML(source)
        body = xml.search("legis-body")[0]

        divisions = body.
          search("division").
          map{|d| [
            d.search("enum")[0].text,
            d.search("header")[0].text,
        ] }

        titles = body.
          search(":not(quoted-block) > title").
          map{|d| [
            d.search("enum")[0].text,
            d.search("header")[0].text,
        ] }

        measures = titles.map {|t|
          Measure.new(:title, t[0], t[1], nil, [])
        } + divisions.map {|d|
          Measure.new(:division, d[0], d[1], nil, [])
        }

        Measure.new(:act, nil, nil, source, measures)
      end
    end
  end
end
