# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NewsletterSignup, type: :interactor do
  describe '.call' do
    subject(:context) { described_class.call(newsletter: newsletter) }

    let(:newsletter) { create(:newsletter, status: :disabled) }

    context 'when the signup is successfull' do
      it 'enables the newsletter and sets a token', :aggregate_failures do
        expect(context).to be_a_success
        expect(newsletter.reload.status).to eq('enabled')
        expect(newsletter.token).not_to be_nil
      end
    end

    context 'when the signup fails due to validation errors' do
      subject(:context) { described_class.call(newsletter: newsletter) }

      let(:newsletter) { build(:newsletter, status: :disabled, email: nil) }

      it 'fails and sets the error message', :aggregate_failures do
        expect(context).to be_a_failure
        expect(context.error).to be_present
      end
    end

    context 'when a standard error occurs' do
      subject(:context) { described_class.call(newsletter: newsletter) }

      let(:error_message) { 'Something went wrong' }

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
