class BooksController < ApplicationController

  # ユーザーIDと一致
  before_action :is_matching_login_user, only: [:edit, :update]

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @user = current_user
    @user_image = current_user
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      render :index
    end
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
    @user_image = @user.get_user_image(100, 100)
  end

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @user = @book.user
    @user_image =  @user.get_user_image(100, 100)
  end

  def edit
    @book = Book.find(params[:id])
    @user = current_user
    
  end

  def update
    @book = Book.find(params[:id])
    @book.user_id = current_user.id
    if @book.update(book_params)
      flash[:notice] = "Book was successfully update"
      redirect_to book_path
    else
     render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  # edit、updateにおいて、URLのユーザidとログインidが一致していなかった場合、 投稿一覧にリダイレクトする
  def is_matching_login_user
    @book = Book.find(params[:id])
    unless @book.user.id == current_user.id
     redirect_to books_path
    end
  end
  
end
