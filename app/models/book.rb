class Book < ApplicationRecord
  has_many :authors_books, dependent: :destroy, inverse_of: :book
  has_many :authors, -> { distinct }, through: :authors_books
  belongs_to :media_type, optional: true
  belongs_to :source, class_name: 'TransactingEntity', optional: true
  belongs_to :recipient, class_name: 'TransactingEntity', optional: true
  belongs_to :acquisition_type, optional: true
  belongs_to :publisher, optional: true
  acts_as_taggable

  accepts_nested_attributes_for :authors
  accepts_nested_attributes_for :authors_books
  accepts_nested_attributes_for :publisher

  def display_title
    title || "Unknown title (ISBN: #{isbn13 || 'unknown'})"
  end

  def display_authors_list
    authors.map(&:name).join(',')
  end

  def build_from_google_books(google_book)
    self.google_volume_raw_data = google_book
    self.google_volume_id = google_book['id']
    self.title = google_book['volumeInfo']['title']
    self.subtitle = google_book['volumeInfo']['subtitle']
    self.description = google_book['volumeInfo']['description']
    self.page_count = google_book['volumeInfo']['pageCount']

    # we will more often get YYYY rather than YYYY-MM or YYYY-MM-DD
    # this is okay
    published_date = google_book['volumeInfo']['publishedDate'].split('-')
    self.published_year = published_date[0]
    self.published_month = published_date[1]
    self.published_day = published_date[2]

    self.publisher = Publisher.find_or_initialize_by(name: google_book['volumeInfo']['publisher'])
    unless google_book['volumeInfo']['categories'].blank?
      google_book['volumeInfo']['categories'].each do |c|
        self.tag_list.add c.split('/').map(&:strip)
      end
    end

    unless google_book['volumeInfo']['authors'].blank?
      google_book['volumeInfo']['authors'].each do |a|
        self.authors << Author.find_or_initialize_by(name: a)
      end
    end

    self
  end

  def build_from_open_library(open_library_book)
    olb = open_library_book
    self.title = olb['title']
    self.page_count = olb['number_of_pages']

    published_date = olb['publish_date'].split('-')
    self.published_year = published_date[0]
    self.published_month = published_date[1]
    self.published_day = published_date[2]

    self.publisher = Publisher.find_or_initialize_by(name: olb['publishers'][0]['name'])

    olb['subjects'].each do |sub|
      self.tag_list.add sub['name']
    end

    olb['authors'].each do |author|
      self.authors << Author.find_or_initialize_by(name: author['name'])
    end
  end

  def self.in_library
    where(in_library: true)
  end

  def self.newest(number_of_books)
    in_library.order(date_added: :desc).limit(number_of_books)
  end

  def published_on
    # :(
    on = published_year.to_s
    if published_month
      on << '-'
      on << (published_month.to_s.size == 1 ? "0#{published_month}" : published_month)
    end
    if published_day
      on << '-'
      on << (published_day.to_s.size == 1 ? "0#{published_day}" : published_day)
    end
    on
  end

  def to_dokuwiki_title
    "[[books:#{title.parameterize}|#{title}]]"
  end
end
