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
        url = 'https://www.york.ac.uk/teaching/cws/wws/webpage1.html'
        response = Scraper.process(url)
        if response[:status] == :completed && response[:error].nil?
            flash[:notice] = "Scraped url"
        else
            flash[:alert] = response[:error]
        end

    rescue StandardError => e
        flash[:alert]= "Error: #{e}"
        
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
