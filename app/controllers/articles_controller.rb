class ArticlesController < ApplicationController
  
  def index
   @articles = Article.all
  end

  def new
   @article = Article.new
  end

  def create
    @user = current_user
    @article = @user.articles.create(article_params)
    if @article.save
      redirect_to publisher_article_path(current_user)
    else
      render 'new'
    end
  end
  
  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
   if @article.update(article_params)
      flash[:success] = "Successfully updated."
      redirect_to publisher_article_path
    else
      render 'edit'
    end
  end
 
  def publisher
    @articles = Article.all
  end
  
  def show
    @article = Article.find(params[:id])
  end

  def like
    @article = Article.find(params[:id])
    @article.liked_by current_user
    redirect_to user_articles_path(current_user)
  end

  def dislike
    @article = Article.find(params[:id])
    @article.disliked_by current_user
    redirect_to user_articles_path(current_user)
  end

  def destroy
    #@user=User.find(params[:user_id])
    @article = Article.find(params[:id])
    @article.destroy
    flash[:success] = "Article deleted"
    redirect_to publisher_article_path(current_user)
  end
 
private
  def article_params
    params.require(:article).permit(:title, :text)
  end
end


