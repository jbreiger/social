class SessionsController < ApplicationController
def create
		user= User.find_by_email(params[:user][:email])
		if user && user.authenticate(params[:user][:password])
			flash[:message]= ["Good login"]
			session[:user_id]= user.id
			redirect_to "/users/#{session[:user_id]}"

		else 
			flash[:error]= ["bad login credentials"]
			redirect_to "/"
		end	
	end
	def destroy
	session[:user_id]= nil
	redirect_to '/'
	end
end
