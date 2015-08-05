  class CommentsController < ApplicationController


  def create
    @user = User.find(params[:user_id])
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    if @comment.save
      redirect_to user_article_path(current_user, @article)
    end
  end
 
  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to user_article_path(current_user, @article)
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
 end
