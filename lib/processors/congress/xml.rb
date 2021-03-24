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

        lookup = {}
        body.traverse do |node|
          chain = node.ancestors.map(&:name).reverse + [node.name]
          next if chain.include? "quoted-block"

          upper = node.ancestors[0]
          recognized_measures = %w[
          division
          title
          subtitle
          part
          subpart
          section
          subsection
          paragraph
          subparagraph
          item
          subitem
          ]

          unless \
              recognized_measures.include?(node.name) &&
              recognized_measures.include?(upper.name)
            next
          end

          measure = Measure.new(
            node.name.to_sym,
            node.search("enum")[0].text,
            (node.search("header")[0].text rescue nil),
            node.text,
            [],
            node.attr("id"),
          )

          lookup[upper] ||= Measure.new(
            upper.name.to_sym,
            upper.search("enum")[0].text,
            (upper.search("header")[0].text rescue nil),
            nil,
            [],
            upper.attr("id"),
          )

          lookup[upper].add_submeasure(lookup[node] || measure)
        end

        division_measures = body.search("division").map{|dn| lookup[dn] }

        # puts division_measures.map(&:submeasures)
        Measure.new(
          :act,
          nil,
          "For the People Act of 2021",
          source,
          division_measures,
          nil,
        )
      end
    end
  end
end
