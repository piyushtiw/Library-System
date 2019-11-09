class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :show, :edit, :destroy]
  before_action :authorize_user!, except: [:edit]
  # GET /users
  # GET /users.json
  def index
    @users = User.active

    if params[:status].present?
      params[:status] = nil
      @users = User.active.unverfied_librarians
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    authorize @user
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if @user.admin?
      message = "Admin can not be deleted"
    else
      @user.inactive!
      message = "User was successfully deleted."
    end
    respond_to do |format|
      format.html { redirect_to users_url, notice: message }
      format.json { head :no_content }
    end
  end

  private
    def authorize_admin
      return unless !current_user.admin?
      redirect_to root_path, alert: 'Admins only!'
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :user_type, :password, :university_id, :library_id, :education_level, :status)
    end

    def authorize_user!
      authorize User
    end
end
