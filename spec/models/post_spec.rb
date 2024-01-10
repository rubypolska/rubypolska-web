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
require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { FactoryBot.build(:post) }

  describe 'valid object' do
    it 'should be valid with attributes' do
      expect(post).to be_valid
    end
  end

  describe 'scopes' do
    describe '.featured' do
      let!(:featured_posts) { FactoryBot.create_list(:post, 3, featured: true) }
      let!(:common_posts) { FactoryBot.create_list(:post, 2, featured: false) }

      it 'returns only featured posts' do
        expect(described_class.featured).to match_array(featured_posts)
      end

      it 'does not return non-featured posts' do
        expect(described_class.featured).to_not match_array(common_posts)
      end
    end
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:body) }
  end

  describe 'relationships' do
    it { should belong_to(:category) }
    it { should belong_to(:user) }
  end

  describe '.methods' do
    describe '#calculate_reading_time' do
      it 'calculates reading time based on word count' do
        post.body = "This post has ten words in total."
        expect(post.calculate_reading_time).to eq(1)
      end
    end

    describe '#reading_time' do
      it 'return reading time in minutes' do
        post.body = "This post has ten words in total."
        expect(post.reading_time).to eq('1 minute read')
      end
    end
  end
end
