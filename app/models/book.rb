class Book < ApplicationRecord
  has_one_attached :avatar
  
  belongs_to :library
  
  validates :title, presence: true
  validates :isbn, presence: true, uniqueness: true, numericality: { only_integer: true }
  validates :number_of_copies, presence: true, numericality: { only_integer: true }
  validates :authors, presence: true
  validates :language, presence: true
  validates :published_date, presence: true
  validates :edition, presence: true, numericality: { only_integer: true }
  validates :subject, presence: true
  validates :summary, presence: true
  validates :library, presence: true
  
  before_create :init
  before_create :set_available_books

  enum active_status: [:active, :inactive]

  def self.search(search)
    books = Book.active

    if search[:title].present?
      books = books.where("title LIKE ?",  "%" + search[:title] + "%" )
    end

    if search[:authors].present?
      books = books.where("authors LIKE ?",  "%" + search[:authors] + "%" )
    end

    if search[:published_date].present?
      books = books.where(published_date: search[:published_date])
    end

    if search[:special_collection].present?
      books = books.where(special_collection: search[:special_collection])
    end

    books
  end

  def can_order_by?(user)
    available? && !special_collection? && !user.limit_reached?
  end

  def can_accept_for?(user)
    available? && !user.limit_reached?
  end

  def available?
    self.available_books > 0
  end
  
  private
    def init
      self.book_status = true
    end

    def set_available_books
      self.available_books = self.number_of_copies
    end
end
