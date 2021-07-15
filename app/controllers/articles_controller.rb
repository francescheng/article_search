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
        @short_link = get_short_link(@article.link)
        raise
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
        @article = Article.find(params[:id])
        @article.destroy
        redirect_to articles_path
    end

    private

    def get_short_link(long_link)
        # url = URI("https://api-ssl.bitly.com/v4/shorten")

        # https = Net::HTTP.new(url.host, url.port)
        # https.use_ssl = true
        
        # request = Net::HTTP::Post.new(url)
        # request["Content-Type"] = "application/json"
        # request["Authorization"] = ENV['TOKEN']
        # request.body = JSON.dump({
        #   "long_url": long_link
        # })
        
        # response = https.request(request)
        # return response.body.id
        url = "https://api-ssl.bitly.com/v4/shorten"
        headers = {"Content-Type": "application/json", "Authorization": ENV['TOKEN']}
        body = {"long_url": long_link}.to_json
        response = HTTParty.post(url, body: body, headers: headers)
        p response.body
        return response.body
    end
    
    def article_params
        params.require(:article).permit(:title, :link, :body, :reading_time)
    end

end
