class BookExporter
  OUTPUT_PATH = File.join(Rails.root, 'output')
  attr_reader :books

  def initialize(books)
    @books = books
  end

  def export
    titles = []

    books.each do |book|
      outfile = File.open(File.join(OUTPUT_PATH, 'books', book.title.parameterize + '.txt'), 'w')
      outfile.write(BooksTemplate.new(book).to_dokuwiki)
      outfile.close

      titles << "  * #{book.to_dokuwiki_title}"
    end

    title_file = File.open(File.join(OUTPUT_PATH, 'books.txt'), 'w')
    title_file.write(titles.join("\n"))
    title_file.close
  end
end
