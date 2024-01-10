# == Schema Information
#
# Table name: newsletters
#
#  id         :integer          not null, primary key
#  cancel_at  :datetime
#  email      :string
#  name       :string
#  status     :integer
#  token      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :newsletter do
    name { FFaker::Name.name }
    email { FFaker::Internet.email }

    trait :enabled do
      status { :enabled }

      after(:create) do |newsletter, _evaluator|
        newsletter.signup
      end
    end

    trait :disabled do
      status { :disabled }

      after(:create) do |newsletter, _evaluator|
        newsletter.cancel
      end
    end
  end
end
