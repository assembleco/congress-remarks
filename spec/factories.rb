require "securerandom"

FactoryBot.define do
  factory :person do
    handle { "someone" }
    email  { "someone@example.com" }
  end

  factory :session do
    person
    expires { 3.days.from_now }
    code { SecureRandom.uuid }
  end
end
