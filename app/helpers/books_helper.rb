module BooksHelper
  def author_list_links(book)
    book.authors.map{|a| link_to a.name, author_path(a)}.join(', ').html_safe
  end

  def fancy_tag_list(book)
    book.all_tags_list.map{|b| content_tag(:span, sanitize(b), class: 'label label-primary')}.join(' ').html_safe
  end

  def show_library_status(book)
    if book.in_library
      "<span class='happy-green'><span class='glyphicon glyphicon-ok' aria-hidden='true'></span> In library</span>".html_safe
    else
      "<span class='sad-red'><span class='glyphicon glyphicon-remove' aria-hidden='true'></span> Not in library</span>".html_safe
    end
  end
end
