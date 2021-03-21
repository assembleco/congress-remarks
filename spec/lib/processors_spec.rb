require "processors/congress/xml"
require "processors/congress/txt"

RSpec.describe "congressional bill processors" do
  describe "117th HR 1; 'For the People'" do
    pending "is processed equally, whether as XML or TXT" do
      xml_processor = Processor::Congress::XML.new \
        File.read \
        Rails.root.join "spec/uploads/BILLS-117hr1eh.xml"
      txt_processor = Processor::Congress::TXT.new \
        File.read \
        Rails.root.join "spec/uploads/BILLS-117hr1eh.txt"

      processed_a = xml_processor.process
      processed_b = txt_processor.process

      expect(processed_a.to_s).to eq processed_b.to_s
    end
  end
end
