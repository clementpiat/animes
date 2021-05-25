class User < ApplicationRecord
  has_secure_password

  before_create :confirmation_token

  validates :email, presence: true, uniqueness: true
  validates :character, presence: true

  has_many :playlists

  as_enum :character, {naruto: 0, lee: 1, kirua: 2, tanjiro: 3}

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end

  private

  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end
end
