class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise  :omniauthable, omniauth_providers: [:facebook]
  has_many :bookmarks
  enum user_type: [:student, :librerian, :admin]
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  validates :first_name, presence: true
  #validates :last_name, presence: true
  validates :user_type, presence: true

  enum education_level: [:bachelor, :master, :phd]
  enum status: [:unverified, :verified]

  scope :librarians, -> {
    where(user_type: :librerian, status: :verified)
  }

  scope :unverfied_librarians, -> {
    where(user_type: :librerian, status: [:unverified, nil])
  }

  enum active_status: [:active, :inactive]

  before_save :validate_user_type

  def self.from_omniauth(auth, current_user=nil)
    authorization = Authorization.where(:provider => auth.provider, :uid => auth.uid.to_s, :token => auth.credentials.token, :secret => auth.credentials.secret).first_or_initialize
    if authorization.user.blank?
      user = current_user || User.where('email = ?', auth["info"]["email"]).first
      if user.blank?
        user = User.new
        user.password = Devise.friendly_token[0,10]
        user.email = auth.info.email
        user.first_name = auth.info.name
        user.university_id = University.first.id
        user.save!
      end
      authorization.user_id = user.id
      authorization.save
    end
    authorization.user
  end

  def verified_librarian?
    self.librerian? && self.verified?
  end

  def name
    first_name.to_s + " " + last_name.to_s
  end

  def numbers_of_books_user_can_borrow
    if self.bachelor?
      2
    elsif self.master?
      4
    else
      6
    end
  end

  def limit_reached?
    self.numbers_of_books_user_can_borrow <= Order.non_returned_order_for(self)
  end

  private

    def validate_user_type
      if self.student?
        self.library_id = nil
        self.status = :unverified
      elsif self.librerian?
        self.university_id = nil
        self.education_level = nil
      else
      end
    end
end
