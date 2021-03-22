require "processors/congress/xml"
require "processors/congress/txt"

RSpec.describe "congressional bill processors" do
  describe "on 117th HR 1; 'For the People'" do
    pending "is processed equally, whether as XML or TXT" do
      xml_processor = Processor::Congress::XML.new \
        File.read \
        File.expand_path("../../uploads/BILLS-117hr1eh.xml", __FILE__)
      txt_processor = Processor::Congress::TXT.new \
        File.read \
        File.expand_path( "../../uploads/BILLS-117hr1eh.txt", __FILE__)

      processed_a = xml_processor.process
      processed_b = txt_processor.process

      expect(processed_a.source).to eq processed_b.source
    end

    it "Pulls hierarchical divisions and titles, with labels and headings" do
      xml_processor = Processor::Congress::XML.new \
        File.read \
        File.expand_path( "../../uploads/BILLS-117hr1eh.xml", __FILE__)

      processed = xml_processor.process

      p processed.all_submeasures

      expect(processed.measures(:division).map{|t| [t.label, t.heading]}).
        to match_array([
          ["A", "Voting"],
          ["B", "Campaign Finance"],
          ["C", "Ethics"],
      ])

      expect(processed.measures(:title).map{|t| [t.label, t.heading]}).
        to match_array([
        ["I", "Election Access"],
        ["II", "Election Integrity"],
        ["III", "Election Security"],
        ["IV", "Campaign Finance Transparency"],
        ["V", "Campaign Finance Empowerment"],
        ["VI", "Campaign Finance Oversight"],
        ["VII", "Ethical Standards"],
        ["VIII", "Ethics Reforms for the President, Vice President, and Federal Officers and Employees"],
        ["IX", "Congressional Ethics Reform"],
        ["X", "Presidential and Vice Presidential Tax Transparency"],
      ])

      expect(
        processed.
        measures(:division)[0].
        measures(:title).
        map {|t| [t.label, t.heading] }
      ).to match_array([
        ["I", "Election Access"],
        ["II", "Election Integrity"],
        ["III", "Election Security"],
      ])
    end
  end
end
