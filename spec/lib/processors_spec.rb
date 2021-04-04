require "processors/congress/xml"
require "processors/congress/txt"

RSpec.describe "congressional bill processors" do
  describe "on 117th HR 1; 'For the People'" do
    let(:xml_processor) {
      Processor::Congress::XML.new \
        File.read \
        File.expand_path("../../uploads/BILLS-117hr1eh.xml", __FILE__)
    }
    let(:processed) { xml_processor.process }

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
      expect(processed.measures(:division).map{|t| [t.label, t.heading]}).
        to match_array([
          ["A", "Voting"],
          ["B", "Campaign Finance"],
          ["C", "Ethics"],
      ])

      titles = processed.measures(:title).map{|t| [t.label, t.heading]}
      expect(titles).to include ["I", "Election Access"]
      expect(titles).to include ["II", "Election Integrity"]
      expect(titles).to include ["III", "Election Security"]
      expect(titles).to include ["IV", "Campaign Finance Transparency"]
      expect(titles).to include ["V", "Campaign Finance Empowerment"]
      expect(titles).to include ["VI", "Campaign Finance Oversight"]
      expect(titles).to include ["VII", "Ethical Standards"]
      expect(titles).to include ["VIII", "Ethics Reforms for the President, Vice President, and Federal Officers and Employees"]
      expect(titles).to include ["IX", "Congressional Ethics Reform"]
      expect(titles).to include ["X", "Presidential and Vice Presidential Tax Transparency"]

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
      sec_3000 = processed.
        measure(:title, "III").
        measures(:section)[0]

      expect(sec_3000.label).to eq("3000.")
      expect(sec_3000.key).to eq("H98DB08A9CCC445A298F9018DAEEECDCF")
    end

    it "replaces body text using handlebar code" do
      sec_3000 = processed.measure(:section, "3000.")

      submeasure_a = <<-END.strip
      This title may be cited as the "Election Security Act".
      END

      expect(sec_3000.submeasures[0].source).to eq(submeasure_a)
      expect(sec_3000.body).to include(submeasure_a)

      expect(sec_3000.source.lines.map(&:strip)).
        to eq(<<-END.lines.map(&:strip))
      {place "HC99BDC3F9DAD465DABF21DEA07A6C1C6"}
      {place "H4C77C311030D49C99E22123F45E810C5"}
      END
    end
  end
end
