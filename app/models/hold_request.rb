class HoldRequest < ApplicationRecord
  belongs_to :user
  belongs_to :book
  belongs_to :library
  validates :user_id, presence: true
  validates :book_id, presence: true
  validates :library_id, presence: true

  validates_uniqueness_of :user_id, :scope => [:book_id, :permission]

  enum permission: [:unseen, :accepted, :denied]
  enum request_type: {
    book_not_available: "Book unavailable",
    special_book: "Book is special",
    student_limit_exceeded: "Student limit exceeded"
  }
  
  before_validation :set_default_request_type

  after_save :make_order, if: :saved_change_to_permission?
  
  protected
    def set_default_request_type
      return if self.id.present?

      if user.limit_reached?
        self.request_type = :student_limit_exceeded
      elsif !book.available?
        self.request_type = :book_not_available
      else
        self.request_type = :special_book
      end

      self.permission = :unseen
    end

    def make_order
      if permission == "accepted" && self.special_book?
        Order.create_order(book, user)
      end
    end
end
