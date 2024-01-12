# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NewsletterCancel, type: :interactor do
  describe '.call' do
    subject(:context) { NewsletterCancel.call(newsletter: newsletter) }

    context 'when update is successfull' do
      let(:newsletter) { FactoryBot.create(:newsletter, status: :enabled) }

      it 'disables the newsletter', :aggregate_failures do
        expect(context).to be_a_success
        expect(newsletter.reload.status).to eq('disabled')
        expect(newsletter.token).to be_nil
      end
    end

    context 'when update fails' do
      let(:newsletter) { FactoryBot.create(:newsletter, status: :enabled) }

      before do
        newsletter.errors.add(:base, 'Record is invalid.')

        allow(newsletter).to receive(:update)
          .and_raise(ActiveRecord::RecordInvalid.new(newsletter))
      end

      it 'fails and sets the error message', :aggregate_failures do
        expect(context).to be_a_failure
        expect(context.error).to be_present
        expect(context.error).to include('Record is invalid.')
      end
    end

    context 'when a standard error is raised' do
      let(:newsletter) { FactoryBot.create(:newsletter, status: :enabled) }
      let(:error_message) { 'Something went wrong.' }

      before do
        allow(newsletter).to receive(:update)
          .and_raise(StandardError.new(error_message))
      end

      it 'fails and sets the error message', :aggregate_failures do
        expect(context).to be_a_failure
        expect(context.error).to eq(error_message)
      end
    end
  end
end
