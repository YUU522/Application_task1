class BooksController < ApplicationController

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @new_book = Book.new
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def create
    @books = Book.all
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @user = current_user
    if  @book.save
      flash[:notice] = "You have created book successfully." 
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      flash.now[:alert] = "Failed to update book."
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private
  
  def is_matching_login_user
    book = Book.find(params[:id])
    unless book.user_id == current_user.id
      redirect_to books_path
    end
  end

  def book_params
    params.require(:book).permit(:title ,:body)
  end
end