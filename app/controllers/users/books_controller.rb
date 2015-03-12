class Users::BooksController < Users::ApplicationController
  def index
    @books = @user.like_books.order(id: :desc).page(params[:page])
  end
end
