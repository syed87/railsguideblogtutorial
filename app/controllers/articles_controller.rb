class ArticlesController < ApplicationController
  http_basic_authenticate_with name: "dhh", password: "secret", except: [ :index, :show ]

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      flash[:success] = "Your article has been created."
      redirect_to @article
    else
      flash.now[:success] = "Unable to create your article."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      flash[:success] = "Your article has been updated."
      redirect_to @article
    else
      flash.now[:success] = "Unable to update your article."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    flash[:success] = "Your article has been deleted."
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other
  end

  private
    def article_params
      params.expect(article: [ :title, :body, :status, :image ])
    end
end
