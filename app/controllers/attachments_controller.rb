class AttachmentsController < ApplicationController
  def create
    @attachment = current_user.attachments.create params.require(:attachment).permit(:file)
    
    render json: { url: @attachment.file.url }
  end
end
