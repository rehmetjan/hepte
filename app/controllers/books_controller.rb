class BooksController < ApplicationController
  before_action :find_book, only: [:new, :show, :edit, :update]
  before_action :email_confirmed_required, only: [:new]
  
  def index
    @new_books = Book.last(12)
    @hot_books = Book.order(hot: :desc).limit(12)
  end
  
  def new
    @book = Book.new
  end
  
  def create
    @book = current_user.books.create book_params
    if @book.save
      flash.now[:success] = I18n.t('.new_book_saved')
      redirect_to @book
    else
      render :new
    end
  end
  
  def show
    @book = Book.find params[:id]
    @comments = @book.comments.includes(:user).order(id: :asc).page(params[:page])
    
    respond_to do |format|
      format.html
    end
  end
  
  def update
    if @book.update_attributes book_params
      flash.now[:success] = 'Book info updated'
      redirect_to @book
    else
      render :edit
    end
  end
  
  private
  
  def find_book
    @book = Book.find_by(id: params[:id])
  end
  
  def book_params
    params.require(:book).permit(:name, :author, :price, :picture, :description, :isbn)
  end
end
