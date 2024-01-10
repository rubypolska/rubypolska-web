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
class Post < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: [:slugged]

  # Scope
  scope :by_title, ->(title) { where('title LIKE ?', "%#{title}%") }
  scope :by_tag, ->(tag) { where('tags LIKE ?', "%#{tag}%") }

  scope :featured, -> { where(featured: true) }
  scope :published, -> { where(published: true) }
  scope :draft, -> { where(published: false) }

  # Uploader
  has_one_attached :thumbnail

  # Validations
  validates :title, presence: true
  validates :body, presence: true

  # Relationships
  belongs_to :category
  belongs_to :user

  # Methods
  def calculate_reading_time
    words_per_minute = 200
    words = body.split.size
    (words / words_per_minute.to_f).ceil
  end

  def reading_time
    minutes = calculate_reading_time
    "#{minutes} #{'minute'.pluralize(minutes)} read"
  end
end
