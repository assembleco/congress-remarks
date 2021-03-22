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

        title_nodes.each do |node|
          measure = Measure.new(
            :title,
            node.search("enum")[0].text,
            node.search("header")[0].text,
            node.text,
            [],
          )

          division = node.ancestors[0]

          if(divisions[-1] == division)
            # puts "Aha!"
            # puts divisions[-1].search("header")[0].text

            division_measures[-1].add_submeasure(measure)
          else
            # puts "Oho."
            # puts division.search("header")[0].text

            divisions << division
            division_measures << Measure.new(
              :division,
              division.search("enum")[0].text,
              division.search("header")[0].text,
              division.text,
              [measure],
            )
          end
        end

        # puts division_measures.map(&:submeasures)
        Measure.new(
          :act,
          nil,
          "For the People Act of 2021",
          source,
          division_measures,
        )
      end
    end
  end
end
