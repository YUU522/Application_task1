class FavoritesController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: @book.id)
    if favorite.save
      respond_to do |format|
      format.html { redirect_to @book }
      format.js   # create.js.erb を実行
      end
    else
      # エラーハンドリング
    end
    
  end

  def destroy
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: @book.id)
    favorite.destroy
    
  end
end
