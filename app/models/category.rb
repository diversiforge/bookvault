class Category < ApplicationRecord
  has_many :books, -> { distinct }, through: :books_categories
  has_many :books_categories, dependent: :destroy, inverse_of: :category
end
