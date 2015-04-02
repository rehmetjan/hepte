class BooksController < ApplicationController
  before_action :find_book, only: [:new, :show, :edit, :update]
  before_action :login_required, :email_confirmed_required, :no_locked_required, only: [:new]
  
  def index
    @books = Book.unlocked.includes(:category).order(id: :desc).page(params[:page])
    
    if params[:category_id]
      @category = Category.where('lower(slug) = ?', params[:category_id].downcase).first!
      @books = @books.where(category: @category)
    end
  end
  
  def home
    @books = Book.unlocked.order(id: :desc).page(params[:page])
    
    if params[:category_id]
      @category = Category.where('lower(slug) = ?', params[:category_id].downcase).first!
      @books = @books.where(category: @category)
    end
  end
  
  def search
    @books = Book.unlocked.search(
    query: {
      multi_match: {
        query: params[:q].to_s,
        fields: ['name', 'author']
      }
    }
    ).page(params[:page]).records
  end
  
  def new
    @category = Category.where('lower(slug) = ?', params[:category_id].downcase).first if params[:category_id].present?
    @book = Book.new category: @category
  end
  
  def create
    @book = current_user.books.create book_params
    if @book.save
      flash[:success] = I18n.t('.books.create.new_book_submitted')
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
      flash[:success] = I18n.t('.books.update.book_updated')
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
