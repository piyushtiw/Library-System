class OrderPolicy < ApplicationPolicy

  def create_order?
    user.student?
  end

  def return_order?
    user.student?
  end
end
