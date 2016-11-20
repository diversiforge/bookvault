class AuthorExporter
  OUTPUT_PATH = File.join(Rails.root, 'output')
  attr_reader :authors

  def initialize(authors)
    @authors = authors
  end

  def export
    names = []
    authors.each do |author|
      outfile = File.open(File.join(OUTPUT_PATH, 'authors', author.name.parameterize + '.txt'), 'w')
      outfile.write(AuthorsTemplate.new(author).to_dokuwiki)
      outfile.close

      names << "  * #{author.to_dokuwiki_link}"
    end

    name_file = File.open(File.join(OUTPUT_PATH, 'authors.txt'), 'w')
    name_file.write(names.join("\n"))
    name_file.close
  end
end
