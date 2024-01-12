# frozen_string_literal: true

# == Schema Information
#
# Table name: newsletters
#
#  id         :bigint           not null, primary key
#  cancel_at  :datetime
#  email      :string
#  name       :string
#  status     :integer
#  token      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_newsletters_on_email  (email) UNIQUE
#  index_newsletters_on_token  (token) UNIQUE
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
