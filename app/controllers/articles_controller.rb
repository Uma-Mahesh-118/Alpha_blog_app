class ArticlesController < ApplicationController
    
    before_action :set_article, only: [:show, :edit, :update, :destroy]
    before_action :require_user, except: [:show, :index]
    before_action :req_same_user, only: [ :edit, :update, :destroy]
    
    def show
    end
    def index
        @articles= Article.paginate(page: params[:page], per_page: 3)
    end

    def new 

        @article= Article.new
    end

    def edit
    end

    def create
        binding.break
        @article= Article.new(article_params)
        @article.user = current_user
        if @article.save
            flash[:notice] = "Article created Succesfully"
            redirect_to article_path(@article)
        else
            render 'new'       
        end
    end
    
    
    def update
        if @article.update( article_params )
            flash[:notice]= 'Update Scuccesful'
            redirect_to article_path(@article)
        else
            render 'edit'
            
        end
    end

    def destroy
        @article = Article.find(params[:id])
        @article.destroy
        respond_to do |format|
            format.html { redirect_to articles_path notice: 'Article was successfully deleted.' }
            format.json { head :no_content }
        end
    end

    private

    def set_article
        @article = Article.find(params[:id])
    end

    def article_params
        params.require(:article).permit(:title, :description, category_ids: [])
    end
    def req_same_user
        if current_user != @article.user && !current_user.admin?
            flash[:alert] = "You can only edit or delete your own article"
            redirect_to @article
        end
    end

end