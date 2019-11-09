class DashboardPolicy < Struct.new(:user, :dashboard)

  def can_go_to_libraries?
    user.admin? || user.librerian? || user.student?
  end

  def can_go_to_users?
    user.admin?
  end

  def can_go_to_librarians?
    user.admin? || user.librerian?
  end

  def can_go_to_universities?
    user.admin? || user.librerian?
  end

  def can_allow_permission?
    user.librerian?
  end

  def can_update_book?
    user.admin? || user.librerian?
  end

  def can_update_library?
    user.admin? || user.librerian?
  end

  def can_delete_library?
    user.admin?
  end

  def can_bookmark?
    user.student?
  end

  def can_change_library?
    user.librerian?
  end

  def can_create_hold_request?
    user.student?
  end

  def can_update_hold_request?
    user.student? || user.librerian?
  end
end
