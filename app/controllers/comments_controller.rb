class CommentsController < ApplicationController
	def create
		user= User.find(session[:user_id])
		post= Post.find(params[:id])
		comment= Comment.create(user:user, post: post, content: params[:content])
	redirect_to (:back)	
	end
end
