class Author < ApplicationRecord
  has_many :books
  has_one_attached :avatar
end
