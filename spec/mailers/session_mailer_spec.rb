require "rails_helper"

RSpec.describe SessionMailer do
  describe "claim" do
    let(:session) { create(:session) }
    let(:mail) { SessionMailer.with(session: session).claim }

    xit "renders the headers" do
      expect(mail.subject).to eq("Signup")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["session@#{ENV["APPLICATION_HOST"]}"])
    end

    xit "renders the body" do
      expect(mail.body.encoded).to match("Please sign in on Assemled")
    end
  end
end
