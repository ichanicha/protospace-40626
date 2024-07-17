class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @prototype = @comment.prototype
    @comments = @prototype.comments.includes(:user)
    ##エラー
      if @comment.save
        redirect_to "/prototypes/#{@comment.prototype.id}", notice: 'Post was successfully created.'
      else
        render "prototypes/show", status: :unprocessable_entity
      end
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end
