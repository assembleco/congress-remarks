require "rails_helper"

RSpec.describe "Remarks address" do
  it "renders remarks" do
    remark = create :remark
    get "/remarks"

    expect(JSON.parse(
      Remark.all.includes(:person).map do |r|
        r.slice(:place, :body).merge(person: r.person.slice(:handle))
      end
    .to_json)
    ).to eq([
      {
        "place" => remark.place,
        "body" => remark.body,
        "person" => {
          "handle" => remark.person.handle,
        }
      }
    ])


    expect(JSON.parse(response.body)).to eq([
      {
        "place" => remark.place,
        "body" => remark.body,
        "person" => {
          "handle" => remark.person.handle,
        }
      }
    ])
  end
end
