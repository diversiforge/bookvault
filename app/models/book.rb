class Book < ApplicationRecord
  has_many :authors, -> { distinct }, through: :authors_books
  has_many :authors_books, dependent: :destroy, inverse_of: :book
  belongs_to :media_type, optional: true
  belongs_to :source, class_name: TransactingEntity, optional: true
  belongs_to :recipient, class_name: TransactingEntity, optional: true
  belongs_to :acquisition_type, optional: true
  belongs_to :publisher, optional: true
  acts_as_taggable

  accepts_nested_attributes_for :authors
  accepts_nested_attributes_for :authors_books
  accepts_nested_attributes_for :publisher

  def display_title
    title || "ISBN: #{isbn13}"
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
    # add published date here
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
  end
end
