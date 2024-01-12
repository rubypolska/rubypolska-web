# frozen_string_literal: true

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

RSpec.describe Category do
  let(:category) { build(:category) }

  describe 'valid object' do
    it 'is valid with valid attributes' do
      expect(category).to be_valid
    end
  end

  describe 'relationships' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:posts) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end
end
