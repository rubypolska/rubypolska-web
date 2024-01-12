# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NewsletterSignup, type: :interactor do
  describe '.call' do
    subject(:context) { NewsletterSignup.call(newsletter: newsletter) }

    context 'when the signup is successfull' do
      let(:newsletter) { FactoryBot.create(:newsletter, status: :disabled) }

      it 'enables the newsletter and sets a token', :aggregate_failures do
        expect(context).to be_a_success
        expect(newsletter.reload.status).to eq('enabled')
        expect(newsletter.token).not_to be_nil
      end
    end

    context 'When the signup fails due to validation errors' do
      let(:newsletter) { FactoryBot.build(:newsletter, status: :disabled, email: nil) }

      subject(:context) { NewsletterSignup.call(newsletter: newsletter) }

      it 'fails and sets the error message', :aggregate_failures do
        expect(context).to be_a_failure
        expect(context.error).to be_present
      end
    end

    context 'When a standard error occurs' do
      let(:newsletter) { FactoryBot.create(:newsletter, status: :disabled) }
      let(:error_message) { 'Something went wrong' }

      subject(:context) { NewsletterSignup.call(newsletter: newsletter) }

      before do
        allow(newsletter).to receive(:update!)
          .and_raise(StandardError, error_message)
      end

      it 'fails and sets the error message', :aggregate_failures do
        expect(context).to be_a_failure
        expect(context.error).to eq(error_message)
      end
    end
  end
end
