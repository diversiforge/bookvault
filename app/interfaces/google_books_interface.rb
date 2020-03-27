class GoogleBooksInterface
  def by_isbn(term)
    # queries Google Books by isbn, then queries again by volume ID
    # to ensure we get all info
    # (we may get a partial response from the isbn query)
    #isbn = term.gsub(/\D/, '')
    isbn = term
    Rails.logger.info(isbn)

    request = "https://www.googleapis.com/books/v1/volumes?q=isbn:#{isbn}"
    Rails.logger.info(request)

    isbn_response = HTTParty.get(request).parsed_response
    Rails.logger.info(isbn_response.inspect)

    volume_id = isbn_response['items'].try(:first).try(:[], 'id')
    Rails.logger.info(volume_id)

    return false if volume_id.nil?
    response = HTTParty.get('https://www.googleapis.com/books/v1/volumes/' + volume_id).parsed_response
    Rails.logger.info response.inspect
    response
  end
end
