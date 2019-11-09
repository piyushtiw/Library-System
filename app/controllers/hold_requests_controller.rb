class HoldRequestsController < ApplicationController
  before_action :authenticate_user!,
                :set_hold_request, only: [:show, :edit, :update, :destroy]

  before_action :books_and_library_for_request, only: [:new, :edit]

  def index
    @hold_requests = HoldRequest.unseen
    
    if current_user.admin?
    elsif current_user.verified_librarian?
      @hold_requests = @hold_requests.where(library_id: current_user.library_id)
    else
      @hold_requests = @hold_requests.where(user_id: current_user.id)
    end
  end

  def show
  end

  def new
    @hold_request = HoldRequest.new
  end

  # GET /hold_requests/1/edit
  def edit
  end

  # POST /hold_requests
  # POST /hold_requests.json
  def create
    @hold_request = HoldRequest.new(hold_request_params.merge({user_id: current_user.id}))

    respond_to do |format|
      if !already_taken? && @hold_request.save
        format.html { redirect_to @hold_request, notice: 'Request was successfully created.' }
        format.json { render :show, status: :created, location: @hold_request }
      else
        format.html { redirect_to new_hold_request_url , notice: 'Already added in your requests'}
        format.json { render json: @hold_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hold_requests/1
  # PATCH/PUT /hold_requests/1.json
  def update
    respond_to do |format|
      if can_grant_permission? && @hold_request.update(hold_request_params)
        format.html { redirect_to @hold_request, notice: 'Hold Request was successfully updated.' }
        format.json { render :show, status: :ok, location: @hold_request }
      else
        format.html { redirect_to hold_requests_url,
            notice: 'You can not approve hold request currently as book is not available or user has reached the limit'}
        format.json { render json: @hold_request.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @hold_request.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'Hold Request was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    def set_hold_request
      @hold_request = HoldRequest.find(params[:id])
    end
      # Never trust parameters from the scary internet, only allow the white list through.
    def hold_request_params
      params.require(:hold_request).permit(:book_id, :library_id, :permission);
    end

    def books_and_library_for_request
      if current_user.student?
        university = University.find(current_user.university_id)
        @libraries = Library.active.where(university_id: university)
        @books = Book.active.where(library_id: @libraries)
      elsif current_user.librerian?
        @libraries = Library.active.where(id: current_user.library_id)
        @books = Book.active.where(library_id: @libraries)
      end
    end

    def already_taken?
      Order.exists?(book_id: hold_request_params[:book_id], user_id: current_user.id, returned_on: nil)
    end

    def can_grant_permission?
      if hold_request_params[:permission] == "accepted"
        return false unless @hold_request.book.can_accept_for?(@hold_request.user)
      end

      true
    end
end
