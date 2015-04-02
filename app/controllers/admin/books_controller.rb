class Admin::BooksController < Admin::ApplicationController
  before_action :find_book, except: [:index, :locked]
  
  def index
    @books = Book.unlocked.order(id: :desc).page(params[:page])
  end
  
  def locked
    @books = Book.locked.order(id: :desc).page(params[:page])
    render :index
  end
  
  def lock
    @book.lock
    flash.now[:success] = I18n.t('admin.books.flashes.successfully_locked')
    redirect_to admin_book_path(@book)
  end
  
  def update
    if @book.update_attributes params.require(:book).permit(:name, :author, :price, :picture, :description, :isbn, :category_id)
      flash.now[:success] = I18n.t('admin.books.flashes.successfully_updated')
      redirect_to admin_book_path(@book)
    else
      render :show
    end
  end
  
  def destroy
    @book.destroy
    redirect_to admin_books_path
  end
  
  def unlock
    @book.unlock
    flash.now[:success] = I18n.t('admin.books.flashes.successfully_unlocked')
    redirect_to admin_book_path(@book)
  end
  
  private
  
  def find_book
    @book = Book.find params[:id]
  end

end
