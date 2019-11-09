class Order < ApplicationRecord
  belongs_to :book
  belongs_to :user
  belongs_to :library

  scope :non_returned_order_for, ->(user) { where(user_id: user.id, returned_on: nil).count }

  def self.create_order(book, user)
    ActiveRecord::Base.transaction do
      Order.create!(book_id: book.id, user_id: user.id, library_id: book.library_id)
      book.decrement!(:available_books, by = 1)
    end
  end

  def overdue_fine
    if self.returned_on.present?
      return 0
    end

    amount = (((Date.today - self.created_at.to_date).to_i) - self.book.library.max_borrow_days) * self.book.library.fine.to_i

    amount > 0 ? amount : 0
  end
end
