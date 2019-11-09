class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book_for_request, except: [:index]

  before_action :set_books_to_serach, only: [:index]

  before_action :authorize_user

  def index
    @orders = Order.all
    if params[:book_id].present?
      @orders = @orders.where(book_id: params[:book_id])
    end

    if params[:overdue] == "1"
      @orders = @orders.select {|x| (Date.today - x["created_at"].to_date).to_i > x.library.max_borrow_days && x.returned_on == nil }
      @orders = Order.where(id: @orders.map(&:id))
    end

    if current_user.student?
      @orders = @orders.where(user_id: current_user.id)
    elsif current_user.librerian?
      @orders = @orders.where(library_id: current_user.library_id)
    end
  end

  def create_order
    message = if is_book_available? && is_user_reached_limit? && non_special_book? && !already_taken?
                  Order.create_order(@book, current_user)
                  send_message(current_user)
                  "Order placed successfully"
              else
                  "Sorry we can not take your order right now"
              end

    respond_to do |format|
      format.html { redirect_to books_path, notice: message }
    end
  end

  def return_order
    message = if book_belongs_to_user?
    ActiveRecord::Base.transaction do
      @checkout_book.update_attributes(returned_on: Date.today, paid_fine: get_paid_fine)
      @book.increment!(:available_books, by = 1)
      unless no_hold_request?
        order_to_first_hold_user
      end
    end
    "Order return successfully"
    else
      "Sorry we can not take your order right now"
    end
    respond_to do |format|
      format.html { redirect_to books_path, notice: message }
    end
  end

  private
    def set_book_for_request
      @book = Book.find(params[:book_id])
    end

    def authorize_user
      authorize Order
    end

    def is_book_available?
      @book.available_books > 0
    end

    def is_user_reached_limit?
      Order.where(user_id: current_user.id, returned_on: nil).count < current_user.numbers_of_books_user_can_borrow
    end

    def non_special_book?
      !@book.special_collection?
    end

    def book_belongs_to_user?
      @checkout_book = Order.where(user_id: current_user.id, book_id: @book.id, returned_on: nil).first
      @checkout_book.present?
    end

    def get_paid_fine
      (Date.today - @checkout_book.created_at.to_date).to_i * @book.library.fine.to_i
    end

    def no_hold_request?
      HoldRequest.where(book_id: @book.id).blank?
    end

    def order_to_first_hold_user
      user_id = first_hold_user

      if user_id.present?
        Order.create_order(@book, User.find(user_id))
        HoldRequest.find_by(user_id: user_id, book_id: @book.id).delete
        send_message(User.find(user_id))
      end
    end

    def first_hold_user
      holdrequests = HoldRequest.where(book_id: @book.id).order(:created_at)

      user_id = nil

      holdrequests.each do |req|
        if req.user.limit_reached?
          next
        else
          user_id = req.user_id
          break
        end
      end

      user_id
    end

    def send_message(user)
      mail_command = "echo 'Order Confirmed' | mail -a FROM:lib@bibliotheca.com -s 'Book Alloted' #{user.email}"
      system(mail_command)
      # ApplicationMailer.confirmation_email(user)
    end

    def set_books_to_serach
      if current_user.student?
        university = University.find(current_user.university_id)
        @libraries = Library.where(university_id: university)
        @books = Book.where(library_id: @libraries)
      elsif current_user.librerian?
         @books = Book.where(library_id: current_user.library_id)
       else
        @books = Book.all
      end
    end

    def already_taken?
      Order.exists?(user_id: current_user.id, book_id: params[:book_id])
    end
  end
