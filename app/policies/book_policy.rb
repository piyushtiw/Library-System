class BookPolicy < ApplicationPolicy

  def edit_book?
    user.admin? || user.librerian?
  end

  def create_book_any_library?
    user.admin?
  end

  def create_book_in_his_library?
    user.librerian?
  end

  def edit?
    user.admin? || (user.verified_librarian? && record.library_id == user.library_id)
  end
end
