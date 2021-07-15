class ArticlesController < ApplicationController
    def index
        @articles = Article.all

    end

    def show
    end

    def new
        @article = Article.new
    end

    def scrape
        @page = MetaInspector.new(params[:url])
        @article = Article.new
        # if params[:commit] == "Link Preview"
        #     render :new
        headings = []
        # page = MetaInspector.new(link)
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
        @article = Article.find(params[:article_id])
        @article.destroy
        redirect_to articles_path
    end

    private

    def article_params
        params.require(:article).permit(:title, :link, :body, :reading_time)
    end

end
