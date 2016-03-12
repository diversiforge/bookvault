class BooksCategory < ApplicationRecord
  belongs_to :book, inverse_of: :books_categories
  belongs_to :category, inverse_of: :books_categories
end
