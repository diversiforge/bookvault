class OpenLibraryInterface
  def by_isbn(term)
    isbn = term.gsub(/\D/, '')
    Rails.logger.info(isbn)

    request = "https://openlibrary.org/api/books?bibkeys=ISBN:#{isbn}&format=json&jscmd=data"
    Rails.logger.info(request)

    isbn_response = HTTParty.get(request).parsed_response
    Rails.logger.info(isbn_response.inspect)
    _k, v = isbn_response.first
    v
  end
end
