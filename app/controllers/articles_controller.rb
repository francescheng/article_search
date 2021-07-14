class ArticlesController < ApplicationController
    def index
        @articles = Article.all
    end

    def show
    end

    def new
        @article = Article.new
    end

    def create
        @article = Article.new(article_params)
        if params[:commit] == "Link Preview"
            render :new
        else
            if @article.save 
                redirect_to article_path(@article)
            else
                render :new
            end
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
