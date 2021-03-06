class Author < ApplicationRecord
  has_many :authors_books, dependent: :destroy, inverse_of: :author
  has_many :books, -> { distinct }, through: :authors_books

  def to_dokuwiki_link
    "[[authors:#{name.parameterize}|#{name}]]"
  end
end
