# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostDecorator, type: :decorator do
  let(:user) { FactoryBot.create(:user, :admin) }

  let(:post) do
    PostDecorator.new(
      FactoryBot.build(:post, body: 'This post has ten words in total.', user: user)
    )
  end

  describe '#calculate_reading_time' do
    it 'calculates reading time based on word count' do
      expect(post.calculate_reading_time).to eq(1)
    end
  end

  describe '#reading_time' do
    it 'returns reading time in minutes' do
      expect(post.reading_time).to eq('1 minute read')
    end
  end
end
