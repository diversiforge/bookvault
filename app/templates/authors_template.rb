class AuthorsTemplate
  attr_reader :author

  def initialize(author)
    @author = author
  end

  def to_dokuwiki
    booklist = author.books.map do |book|
      "  * #{book.to_dokuwiki_title}"
    end

    <<~DOKUWIKI
      ===== #{author.name} =====
      #{booklist.join("\n")}
    DOKUWIKI
  end
end
