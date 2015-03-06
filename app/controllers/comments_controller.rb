class CommentsController < ApplicationController
  before_action :login_required, :no_locked_required
  before_action :find_comment, only: [:edit, :cancel, :update]
  
  def create
    resource, id = request.path.split('/')[1, 2]
    @commentable = resource.singularize.classify.constantize.find(id)
    @comment = @commentable.comments.new params.require(:comment).permit(:body).merge(user: current_user)
    @comment.save
    #to-do implement notification
  end
  
  def edit
  end
  
  def cancel
  end
  
  def update
    @comment.update_attributes params.require(:comment).permit(:body)
  end
  
  private
  
  def find_comment
    @comment = current_user.comments.find params[:id]
  end
end