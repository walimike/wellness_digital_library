class User < ApplicationRecord
  belongs_to :organization, optional: true
  has_many :book_purchases, dependent: :destroy
  has_many :purchased_books, through: :book_purchases, source: :book

  validates :role, inclusion: { in: %w[admin member author], message: "%{value} is not a valid role" }, allow_nil: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
      user.avatar_url = auth.info.image
    end 
  end
end
