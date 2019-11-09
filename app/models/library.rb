class Library < ApplicationRecord
  belongs_to :university
  has_many :books
  validates :name, presence: true
  validates :location, presence: true
  validates :fine, presence: true, numericality: true
  validates :university_id, presence: true
  validates :max_borrow_days, presence: true, numericality: { only_integer: true }
  # validates :overdue_fines #, presence: true, numericality: true
  before_create :init

  enum active_status: [:active, :inactive]

  after_save :inactive_books, if: :saved_change_to_active_status?

  private

    def inactive_books
      if self.inactive?
        self.books.each do |book|
          book.inactive!
        end
      end
    end
  
    def init
      self.library_status = true
    end
end
