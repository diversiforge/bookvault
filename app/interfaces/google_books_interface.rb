class GoogleBooksInterface
  def by_isbn(term)
    # queries Google Books by isbn, then queries again by volume ID
    # to ensure we get all info
    # (we may get a partial response from the isbn query)
    isbn = term.gsub(/\D/, '')
    volume_id = HTTParty.get('https://www.googleapis.com/books/v1/volumes?q=isbn:' + isbn).parsed_response['items'].try(:first).try(:[], 'id')
    return false if volume_id.nil?
    HTTParty.get('https://www.googleapis.com/books/v1/volumes/' + volume_id).parsed_response
  end
end