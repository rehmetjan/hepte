class BooksController < ApplicationController
  before_action :find_book, only: [:new, :show, :edit, :update]
  before_action :email_confirmed_required, only: [:new]
  
  def index
    @books = Book.includes(:category).page(params[:page])
    
    if params[:category_id]
      @category = Category.where('lower(slug) = ?', params[:category_id].downcase).first!
      @books = @books.where(category: @category)
    end
  end
  
  def home
    if params[:category_id]
      @category = Category.where('lower(slug) = ?', params[:category_id].downcase).first!
    end
    
    @books = Book.order(id: :desc).page(params[:page])
  end
  
  def new
    @category = Category.where('lower(slug) = ?', params[:category_id].downcase).first if params[:category_id].present?
    @book = Book.new category: @category
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
    params.require(:book).permit(:name, :author, :price, :picture, :description, :isbn, :category_id)
  end
end
