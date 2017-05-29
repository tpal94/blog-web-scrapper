class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :check_history, only: [:index]


  # GET /articles
  # GET /articles.json
 def index
  #binding.pry 
    unless @articles.present?
      unless @result.present?
        medium = Medium.new
        result = medium.get_page_detail params[:search]
        process = Processor.new
        process.search_text = params[:search]
        process.page = 1
        process.insert_fetched_detail(result)

      end
    end
    @articles = @articles.paginate(page: params[:page], per_page: 10).order('created_at DESC')
    respond_to do |format|
      format.html
      format.js
    end

 end

 # GET /articles/1
  # GET /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def check_history
       @result = SearchHistory.where(search: params[:search]).first 
        if @result.present? 
          @articles = @result.get_blog_search params[:page]
       end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:tittle, :description, :link, :medium_id, :author_id, :date, :time_ago, :tag_id)
    end
end
