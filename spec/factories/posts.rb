# == Schema Information
#
# Table name: posts
#
#  id          :bigint           not null, primary key
#  body        :text
#  featured    :boolean          default(FALSE)
#  published   :boolean          default(FALSE)
#  slug        :string
#  tags        :string
#  thumbnail   :string
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint
#  user_id     :bigint
#
# Indexes
#
#  index_posts_on_category_id  (category_id)
#  index_posts_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (user_id => users.id)
#
require 'open-uri'

FactoryBot.define do
  factory :post do
    title { FFaker::Lorem.sentence }
    body { FFaker::Lorem.paragraphs(rand(15..18)).join("<br/><br/>") }
    tags { FFaker::Lorem.words.join(', ') }
    category
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
      post.thumbnail.attach(
        io: file, 
        filename: 'temp_image.jpg', 
        content_type: 'image/jpeg'
      )
    end
  end
end
