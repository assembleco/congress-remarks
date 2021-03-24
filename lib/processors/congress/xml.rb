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

          if(node.name == "quote")
            node.replace("&lquot;#{node.text}&rquot;")
          end

          recognized_measures = %w[
          legis-body
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

          next unless recognized_measures.include?(node.name)

          measure = process_measure(node)
          node.replace("{place \"#{measure.key}\"}")

          lookup[measure.key] ||= measure

          submeasure_keys = node.text.scan(/\{place +\"([A-H0-9]+)\"\}/).flatten

          submeasure_keys.each do |sm_key|
            lookup[measure.key].add_submeasure(lookup[sm_key])
          end
        end

        lookup[body.attr('id')]
      end


      def process_measure(node)
        label = node.search("enum")[0]
        heading = node.search("header")[0]

        label.replace('') rescue nil
        heading.replace('') rescue nil

        Measure.new(
          node.name.to_sym,
          (label.text rescue nil),
          (heading.text rescue nil),
          node.text,
          [],
          node.attr("id"),
        )
      end
    end
  end
end
