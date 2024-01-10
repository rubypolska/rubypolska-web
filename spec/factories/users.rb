# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  admin                  :boolean
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
FactoryBot.define do
  factory :user do
    email { FFaker::Internet.email }
    password { 'test123' }
    password_confirmation { 'test123' }

    trait :admin do
      admin { true }
    end

    trait :with_posts do
      after(:create) do |user, _evaluator|
        create_list(:post, 5, user: user)
      end
    end
  end
end
