class Book < ApplicationRecord
  belongs_to :category
  belongs_to :author
  has_one_attached :cover_image
  has_one_attached :file
end
