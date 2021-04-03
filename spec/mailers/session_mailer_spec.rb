require "rails_helper"

RSpec.describe SessionMailer do
  describe "claim" do
    let(:session) { create(:session) }
    let(:mail) { SessionMailer.with(session: session).claim }

    it "renders the headers" do
      expect(mail.subject).to eq("Assembled: sign in.")
      expect(mail.to).to eq([session.person.email])
      expect(mail.from).to eq("session@#{ENV["APPLICATION_HOST"]}")
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Please sign in on Assemled")
    end
  end
end
