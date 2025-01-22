class UsersController < ApplicationController
  # 下記is_matching_login_user参照
  before_action :is_matching_login_user, only: [:edit, :update]

  def index
    @users = User.all
    @book = Book.new
    @user = current_user
    @user_image =  @user.get_user_image(100, 100)
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
    flash[:notice] = "You have updated user successfully."
    redirect_to user_path
    else
      flash[:error] = @user.errors.full_messages.join(",")
      @error_count = @user.errors.count
      render :edit
    end
  end

  def create
    @user = User.new(user_params)
    @user_image = user_image.new(user_params)
    @user.user_id = current_user.id
    if @user.save
      flash[:notice] = "Welcome! You have signed up successfully."
      redirect_to user_path(@user.id)
    else
      flash.now[:error] = @user.errors.full_messages.join(",")
      @error_count = @user.errors.count
      @users = Users.all
      render :new_user_registration_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  # edit、updateにおいて、URLのユーザidとログインidが一致していなかった場合、 投稿一覧にリダイレクトする
  def is_matching_login_user
    user = User.find(params[:id])
      unless user.id == current_user.id
      redirect_to user_path(current_user)
      end
  end

end

