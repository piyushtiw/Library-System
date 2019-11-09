class Bookmark < ApplicationRecord
  belongs_to :book
  belongs_to :user
  validates :user_id, presence: true
  validates :book_id, presence: true

  def self.search(search)
      book_bookmarks = Book.all
      book_bookmarks.where(id: search[:user_id])
  end
end
