class PostsController < ApplicationController
  def index
  	@posts= Post.all
  end
  def create
  	user= User.find(session[:user_id])
  	@post= Post.create(user:user, content: params[:content])
  	flash[:error]= ["Your post have been created!"]
  	redirect_to (:back)
  end
end
