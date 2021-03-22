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

        division_nodes = body.search("division")
        title_nodes = body.search(":not(quoted-block) > title")

        divisions = []
        division_measures = []

        measures = title_nodes.each {|node|
          # puts node.ancestors.map(&:name).reverse.inspect

          division = node.ancestors[0]
          prior_division = divisions[-1]

          if(prior_division == division)
            # puts "Aha!"
            # puts prior_division.search("header")[0].text

            division_measures[-1].add_submeasure(Measure.new(
              :title,
              node.search("enum")[0].text,
              node.search("header")[0].text,
              nil,
              [],
            ))
          else
            divisions << division
            division_measures << Measure.new(
              :division,
              division.search("enum")[0].text,
              division.search("header")[0].text,
              nil,
              [],
            )
          end

        }

        Measure.new(
          :act,
          nil,
          "For the People Act of 2021",
          source,
          division_measures,)
      end
    end
  end
end
