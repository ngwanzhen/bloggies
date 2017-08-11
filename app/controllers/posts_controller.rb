class PostsController < ApplicationController
  before_action :authenticate_user!,
                only: [:new, :edit]
# this means that if you don't login, you cannot see new and edit. but u can go to index, show
  def index
    news_url = 'https://newsapi.org/v1/articles?source=breitbart-news&sortBy=top&apiKey=51ff5e30d47f4063a25ca7f3c3cba6a8'
    response = HTTParty.get(news_url)
    @news_data = response

    q = params[:q]
    photo_url=
    "https://pixabay.com/api/?key=6144418-f9b2e4313d5eeb7cd0f166436&q=#{q}&image_type=photo"
    response = HTTParty.get(photo_url)
    @photodata = response

    @allposts = current_user.posts
    @new_post = Post.new
  end

  def show
    # render json: params
    @currentpost = Post.find(params[:id])
  end

  def create
    # render json: params
    Post.create(
    title: params[:post][:title],
    content: params[:post][:content],
    user_id: current_user.id
    )
    # creating_post = params.require(:post).permit(:title, :content, :user_id)
    # Post.create(creating_post)
    redirect_to '/posts/index'
  end

  def edit
    @currentpost = Post.find(params[:id])
  end

  def destroy
    Post.destroy(params[:id])
    redirect_to posts_path
  end

  def update
    currentpost = Post.find(params[:id])
    updating_post = params.require(:post).permit(:title, :content)
    redirect_to posts_path if currentpost.update(updating_post)
    # toupdate = Post.find(params[:id])
    # toupdate.title = params[:post][:title]
    # toupdate.content = params[:post][:content]
  end


end
