class BooksTemplate
  attr_reader :book

  def initialize(book)
    @book = book
  end

  def to_dokuwiki
    <<~DOKUWIKI
      ===== #{book.display_title} =====
      ==== #{book.subtitle} ====
      by #{book.authors.map(&:to_dokuwiki_link).join(', ')}

      Tags: #{book.tags.join(', ')}

      Published by **#{book.publisher.try(:name) || 'Unknown'}** • **#{book.page_count}** pages • ISBN **#{book.isbn13}**

      ----

      <html>
      #{book.description}
      </html>
    DOKUWIKI
  end
end
