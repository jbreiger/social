class UsersController < ApplicationController
  def login
  	render "login.html.erb"
  end	
  def index
  	@users=User.all
    # @user= User.find(session[:user_id])
   #  @friends= Friendship.where(user: @user,status: "accepted")
  end

  def show
  	@myself= User.find(session[:user_id])
  	@user= User.find(params[:id])
    @friend_requests= Friendship.where(user: @myself, status: "invited")
    puts @friend_requests
  end
  def create
  	user=User.new(user_params)
  	user.password_digest
  	if user.valid?
  		user.save
  		session[:user_id]= user.id
  		flash[:message]= "registered user"
  		redirect_to "/users/#{session[:user_id]}"
  	else
  		puts "not valid"
  		flash[:error]= user.errors.full_messages
      puts flash[:error]
      redirect_to "/"
  	end		
  end
  def user_params
  params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :birthday)
	end
end
