class ArticlesController < ApplicationController
    def index
        if params[:query].present?
            @articles = Article.search_by_title_and_body(params[:query])
        else
            @articles = Article.all
        end

    end

    def show
        @article = Article.find(params[:id])
    end

    def new
        @article = Article.new
    end

    def scrape
        @page = MetaInspector.new(params[:url])
        @article = Article.new
        headings = []
        headings << @page.h1
        headings << @page.h2
        headings << @page.h3
        @body = headings.join(", ")
    end

    def create
        @article = Article.new(article_params)
        if @article.save 
            redirect_to article_path(@article)
        else
            render :new
        end

    end

    def destroy
        @article = Article.find(params[:id])
        @article.destroy
        redirect_to articles_path
    end

    private


    def article_params
        params.require(:article).permit(:title, :link, :body, :reading_time)
    end

end
