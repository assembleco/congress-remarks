require "rails_helper"

RSpec.describe "Remarks address" do
  it "renders remarks" do
    remark = create :remark
    get "/remarks"

    expect(JSON.parse(response.body)).to eq([
      {
        "place" => remark.place,
        "body" => remark.body,
        "person" => {
          "handle" => remark.person.handle,
          "badges" => [],
        }
      }
    ])
  end
end
