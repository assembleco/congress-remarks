require "securerandom"

FactoryBot.define do
  factory :remark do
    person
    place { "HC5BBEC22F049435CB96653F6F225CFE8" }
    body { "Some remark." }
  end

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
