# == Schema Information
#
# Table name: newsletters
#
#  id         :integer          not null, primary key
#  cancel_at  :datetime
#  email      :string
#  name       :string
#  status     :integer
#  token      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Newsletter < ApplicationRecord
  # Enum
  enum status: [:enabled, :disabled]

  # Callbacks
  after_create :signup

  # Validations
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :token, uniqueness: { case_sensitive: true }

  # Methods
  def self.by_token(token)
    find_by_token(token)
  end

  def signup
    update(status: :enabled, token: generate_token)
  end

  def cancel
    update(status: :disabled, token: nil)
  end

  private

  def generate_token
    SecureRandom.urlsafe_base64(8)
  end
end
