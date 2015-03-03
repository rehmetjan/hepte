class BooksController < ApplicationController
  before_action :find_book, only: [:show, :edit, :update]
  
  def index
    @books = Book.all
  end
  
  def new
    @book = Book.new
  end
  
  def create
    @book = Book.new book_params
    if @book.save
      flash[:success] = 'New book saved!'
      redirect_to @book
    else
      render :new
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
    params.require(:book).permit(:name, :author, :price, :picture, :description)
  end
end
