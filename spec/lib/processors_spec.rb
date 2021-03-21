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

    pending "Pulls ten titles, labeled using roman numerals" do
      xml_processor = Processor::Congress::XML.new \
        File.read \
        File.expand_path( "../../uploads/BILLS-117hr1eh.xml", __FILE__)

      processed = xml_processor.process

      expect(processed.measures("title").map{|t| [t.label, t.heading]}).to eq([
        ["I", "ELECTION ACCESS"],
        ["II", "ELECTION INTEGRITY"],
        ["III", "ELECTION SECURITY"],
        ["IV", "CAMPAIGN FINANCE TRANSPARENCY"],
        ["V", "SMALL DOLLAR FINANCING OF CONGRESSIONAL ELECTION CAMPAIGNS"],
        ["VI", "CAMPAIGN FINANCE OVERSIGHT"],
        ["VII", "ETHICAL STANDARDS"],
        ["VIII", "ETHICAL REFORMS FOR THE PRESIDENT, VICE PRESIDENT, AND FEDERAL OFFICERS AND EMPLOYEES"],
        ["IX", "CONGRESSIONAL ETHICS REFORM"],
        ["X", "PRESIDENTIAL AND VICE pRESIDENTIAL TAX TRANSPARENCY"],
      ])
    end
  end
end
