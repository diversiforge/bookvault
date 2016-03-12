class AuthorsBook < ApplicationRecord
  belongs_to :author, inverse_of: :authors_books
  belongs_to :book, inverse_of: :authors_books
end
