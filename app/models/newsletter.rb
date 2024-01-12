# frozen_string_literal: true

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
class Newsletter < ApplicationRecord
  # Enum
  enum status: { enabled: 0, disabled: 1 }

  # Callbacks
  after_create :signup

  # Validations
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :token, uniqueness: { case_sensitive: true }

  # Methods
  def self.by_token(token)
    find_by(token: token)
  end

  def signup
    NewsletterSignup.call(newsletter: self)
  end

  def cancel
    NewsletterCancel.call(newsletter: self)
  end
end
