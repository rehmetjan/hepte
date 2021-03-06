class Admin::CategoriesController < Admin::ApplicationController
  before_action :find_category, only: [:show, :edit, :update, :destroy]
  
  def index
    @categories = Category.order(books_count: :desc)
  end
  
  def show
  end
  
  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new category_params
    if @category.save
      redirect_to admin_categories_path
    else
      render :edit
    end
  end
  
  def update
    if @category.update_attributes category_params
      flash[:success] = I18n.t('admin.categories.flashes.successfully_updated')
      redirect_to admin_category_path(@category)
    else
      render :edit
    end
  end
  
  def destroy
    @category.destroy
    flash[:success] = I18n.t('admin.categories.flashes.successfully_destroy')
    redirect_to admin_categories_path
  end
  
  private
  
  def category_params
    params.require(:category).permit(:name, :slug)
  end
  
  def find_category
    @category = Category.find params[:id]
  end
end
