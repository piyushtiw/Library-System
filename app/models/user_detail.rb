class UserDetail < ApplicationRecord
  belongs_to :user

  enum education_level: {
    under_grad: "Bachelor",
    grad: "Master",
    phd: "Phd"
  }
end
