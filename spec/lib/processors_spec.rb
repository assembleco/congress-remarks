require "processors/congress/xml"
require "processors/congress/txt"

RSpec.describe "congressional bill processors" do
  describe "on 117th HR 1; 'For the People'" do
    it "is processed equally, whether as XML or TXT" do
      xml_processor = Processor::Congress::XML.new \
        File.read \
        File.expand_path("../../uploads/BILLS-117hr1eh.xml", __FILE__)
      txt_processor = Processor::Congress::TXT.new \
        File.read \
        File.expand_path( "../../uploads/BILLS-117hr1eh.txt", __FILE__)

      processed_a = xml_processor.process
      processed_b = txt_processor.process

      expect(processed_a.to_s).to eq processed_b.to_s
    end

    it "Pulls ten titles, using roman numerals" do
      xml_processor = Processor::Congress::XML.new \
        File.read \
        File.expand_path( "../../uploads/BILLS-117hr1eh.txt", __FILE__)

      processed = xml_processor.process

      expect(processed.measures("title")).to include(
        ["X", "Presidential and Vice Presidential tax transparency".upcase]
      )
    end
  end
end
