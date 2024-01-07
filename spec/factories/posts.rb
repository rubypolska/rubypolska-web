# == Schema Information
#
# Table name: posts
#
#  id          :integer          not null, primary key
#  body        :text
#  featured    :boolean          default(FALSE)
#  published   :boolean          default(FALSE)
#  slug        :string
#  tags        :string
#  thumbnail   :string
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer
#  user_id     :integer
#
# Indexes
#
#  index_posts_on_category_id  (category_id)
#  index_posts_on_user_id      (user_id)
#
require 'open-uri'

FactoryBot.define do
  factory :post do
    title { FFaker::Lorem.sentence }
    body { FFaker::Lorem.paragraphs(rand(15..18)).join("<br/><br/>") }
    tags { FFaker::Lorem.words.join(', ') }
    user

    trait :published do
      published { true }
    end

    trait :draft do
      published { false }
    end

    after(:build) do |post, _evaluator|
      image_url = FFaker::Image.url
      file = URI.open(image_url)
      post.thumbnail.attach(io: file, filename: 'temp_image.jpg', content_type: 'image/jpeg')
    end
  end
end
