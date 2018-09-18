class Admin::LoginController < ApplicationController
  before_action :redirect_home

  layout 'template'	

  def index
     @user = User.new
  end

  def account

     @user = User.new(user_params)
     @user.skip_confirm_password = true
     if @user.valid?

        	 @user = User.find_by(email: params[:user][:email].downcase)

        	 if @user and @user.authenticate(params[:user][:password]) 
        	 	session[:user_id] = @user.id
        	 	redirect_to admin_home_path
        	 else
        	 	#flash.now.alert = "Incorrect email or password, try again."
            #render :index
        	 	#render partial: 'new', locals: {user: @user}
            flash[:danger] = "Incorrect email or password, try again."
        	 	redirect_to admin_login_path
          end
      else
            render 'index'
  	 end
  end

  private
	  def user_params
	      params.require(:user).permit(:email, :password)
	  end
 
end
