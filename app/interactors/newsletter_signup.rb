# frozen_string_literal: true

class NewsletterSignup
  include Interactor

  delegate :newsletter, to: :context

  def call
    newsletter.update!(status: :enabled, token: generate_token)
  rescue ActiveRecord::RecordInvalid => e
    context.fail!(error: e.record.errors.full_messages.to_sentence)
  rescue StandardError => e
    context.fail!(error: e.message)
  end

  private

  def generate_token
    SecureRandom.urlsafe_base64(8)
  end
end
