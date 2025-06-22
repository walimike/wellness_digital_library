class Book < ApplicationRecord
  belongs_to :category
  belongs_to :author
  has_one_attached :cover_image
  has_one_attached :file
  has_many :book_purchases, dependent: :destroy
  has_many :purchasing_users, through: :book_purchases, source: :user
end
