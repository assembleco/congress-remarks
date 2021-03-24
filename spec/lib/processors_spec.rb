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

    it "pulls parts and sections" do
      xml_processor = Processor::Congress::XML.new \
        File.read \
        File.expand_path( "../../uploads/BILLS-117hr1eh.xml", __FILE__)

      processed = xml_processor.process

      sec_1001 = processed.
        measures(:subtitle)[0].
        measures(:part)[0].
        measures(:section)[0]

      sec_1001_second_approach = processed
        .measures(:part)[0]
        .measures(:section)[0]

      expect(sec_1001.label).to eq("1001.")
      expect(sec_1001.heading).to eq("Requiring availability of internet for voter registration")

      expect(sec_1001_second_approach.label).to eq("1001.")
      expect(sec_1001_second_approach.heading).to eq("Requiring availability of internet for voter registration")

      expect(sec_1001).to eq(sec_1001_second_approach)
    end

    it "assigns keys based on original record" do
      xml_processor = Processor::Congress::XML.new \
        File.read \
        File.expand_path( "../../uploads/BILLS-117hr1eh.xml", __FILE__)

      processed = xml_processor.process

      sec_3000 = processed.
        measure(:title, "III").
        measures(:section)[0]

      expect(sec_3000.label).to eq("3000.")
      expect(sec_3000.key).to eq("H98DB08A9CCC445A298F9018DAEEECDCF")
    end

    pending "replaces body text using handlebar code" do
      xml_processor = Processor::Congress::XML.new \
        File.read \
        File.expand_path( "../../uploads/BILLS-117hr1eh.xml", __FILE__)

      processed = xml_processor.process
      sec_3000 = processed.measure(:section, "3000.")

      expect(sec_3000.source).to eq(<<-END)
      {place "HC99BDC3F9DAD465DABF21DEA07A6C1C6"}
      {place "H4C77C311030D49C99E22123F45E810C5"}
      END

      expect(sec_3000.submeasures[0].source).to eq(<<-END.strip)
      This title may be cited as the <quote>Election Security Act</quote>.
      END
    end
  end
end
