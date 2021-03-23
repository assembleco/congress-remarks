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
          next if lookup[node]
          chain = node.ancestors.map(&:name).reverse + [node.name]
          next if chain.include? "quoted-block"

          if node.name == "section"
            section = Measure.new(
              :section,
              node.search("enum")[0].text,
              node.search("header")[0].text,
              node.text,
              [],
            )

            under = section
            node.ancestors.each do |upper|
              unless %w[division title subtitle part subpart section].
                include? upper.name
                # puts "Skipping #{upper.name}"
                next
              end

              lookup[upper] ||= Measure.new(
                upper.name.to_sym,
                upper.search("enum")[0].text,
                upper.search("header")[0].text,
                nil,
                [],
              )
              lookup[upper].add_submeasure(under)

              under = lookup[upper]
            end
          end
        end

        division_measures = body.search("division").map{|dn| lookup[dn] }

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
