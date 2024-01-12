# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  name       :string
#  slug       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_categories_on_name     (name) UNIQUE
#  index_categories_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) { FactoryBot.build(:category) }

  describe 'valid object' do
    it 'is valid with valid attributes' do
      expect(category).to be_valid
    end
  end

  describe 'relationships' do
    it { should belong_to(:user) }
    it { should have_many(:posts) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end
end
