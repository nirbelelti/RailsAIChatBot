FactoryBot.define do
  factory :chat do
    association :user

    trait :with_history do
      history { { "massages": [{ "role": 'bot', "content": 'Hello' }] } }
    end
  end
end