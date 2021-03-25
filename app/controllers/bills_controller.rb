require "processors/congress/xml"

class BillsController < ApplicationController
  def show
    key = params[:id]

    xml_processor = Processor::Congress::XML.new \
      File.read \
      Rails.root.join("spec/uploads/BILLS-117hr1eh.xml")
    processed = xml_processor.process

    render json: { key: key, source: processed.as_json }
  end
end
