class FriendshipsController < ApplicationController
  def index
  	@user= User.find(session[:user_id])
    @friends= Friendship.where(user: @user,status: "accepted")
  end
  def update
  	user= User.find(session[:user_id])
	friend = User.find(params[:id])
	myself= Friendship.where(user:user, friend:friend, status: "invited")
	  	request= Friendship.where(user:friend, friend:user, status: "sent_invite")
  	if params[:friend_request] == "accept"
  		puts "accepted"
		myself.first.update(user: user, friend: friend, status: "accepted")
		request.first.update(user: friend, friend: user, status: "accepted")
		flash[:error] = ["#{friend.first_name} has been accepted"]
	elsif
		myself.first.update(user: user, friend: friend, status: "pending")
		request.first.update(user: friend, friend: user, status: "pending")
		flash[:error] = ["#{friend.first_name} has been declined"]	
	end	
	redirect_to(:back)
  
  end
  def show
  end
  def create
  	user= User.find(session[:user_id])
  	friend = User.find(params[:id])
  	check= Friendship.where(user:user, friend:friend)
  	if defined? check.first.id
			flash[:error]= ["already friends"]
		else
			Friendship.create(user: user, friend: friend, status: "sent_invite")
			Friendship.create(user: friend, friend: user, status: "invited")
		end	
	redirect_to(:back)	
  end
end
