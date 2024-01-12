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
require 'rails_helper'

RSpec.describe Newsletter, type: :model do
  let(:newsletter) { FactoryBot.build(:newsletter) }

  describe 'valid object' do
    it 'should be valid with valid attributes' do
      expect(newsletter).to be_valid
    end
  end

  describe 'scopes' do
    describe '.by_token' do
      let!(:newsletter) { FactoryBot.create(:newsletter, :enabled) }
      let!(:newsletter_2) { FactoryBot.create(:newsletter, :enabled) }

      it 'returns the newsletter with the matching token' do
        expect(described_class.by_token(newsletter.token)).to eq(newsletter)
      end

      it 'does not return the newsletter with a different token' do
        expect(described_class.by_token(newsletter_2.token)).not_to eq(newsletter)
      end

      it 'returns nil if no newsletter matches the token' do
        expect(described_class.by_token(nil)).to be_nil
      end
    end
  end

  describe 'validations', :aggregate_failures do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }

    describe 'token uniqueness' do
      let!(:newsletter) { FactoryBot.create(:newsletter, :enabled) }
      let(:token) { newsletter.token }

      let(:newsletter_2) { FactoryBot.build(:newsletter, token: token) }

      it 'validates case-insensitive uniqueness of token', :aggregate_failures do
        expect(newsletter_2).not_to be_valid
        expect(newsletter_2.errors[:token]).to include('has already been taken')
      end
    end
  end

  describe 'enums' do
    it 'has a status enum' do
      expect(described_class.statuses.keys).to include('enabled', 'disabled')
    end
  end

  describe 'callbacks' do
    let(:newsletter) { FactoryBot.create(:newsletter) }

    it 'calls signup after creation' do
      expect(newsletter).to be_enabled
      expect(newsletter.token).not_to be_nil
    end
  end

  describe 'traits' do
    describe '.disabled' do
      let(:newsletter) { FactoryBot.create(:newsletter, :disabled) }

      it 'create a newsletter already disabled by default', :aggregate_failures do
        expect(newsletter).to be_disabled
        expect(newsletter.token).to be_nil
      end
    end
  end

  describe '.methods' do
    describe '#signup' do
      before { newsletter.signup }

      it 'enables the newsletter and generate a token', :aggregate_failures do
        expect(newsletter).to be_enabled
        expect(newsletter.token).not_to be_nil
      end
    end

    describe '#cancel' do
      let(:newsletter) { FactoryBot.create(:newsletter, :enabled) }

      before { newsletter.cancel }

      it 'disables the newsletter and clears the token', :aggregate_failures do
        expect(newsletter).to be_disabled
        expect(newsletter.token).to be_nil
      end
    end
  end
end
