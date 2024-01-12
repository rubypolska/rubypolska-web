# frozen_string_literal: true

class NewsletterCancel
  include Interactor

  delegate :newsletter, to: :context

  def call
    newsletter.update(status: :disabled, token: nil)
  rescue ActiveRecord::RecordInvalid => e
    context.fail!(error: e.record.errors.full_messages.to_sentence)
  rescue StandardError => e
    context.fail!(error: e.message)
  end
end
