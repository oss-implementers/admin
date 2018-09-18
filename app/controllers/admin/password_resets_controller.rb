class Admin::PasswordResetsController < ApplicationController

	layout 'template'	

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    def new

    end

	def create
		if valid_email(params[:email])

			  user = User.find_by_email(params[:email])

			  user.skip_confirm_password = true
			  
			  if user
			  	user.send_password_reset 
			    flash[:success] = "Email sent with password reset instructions."
			    redirect_to new_admin_password_reset_path
			  else
				flash[:danger] = "The email #{params[:email]} you entered does not belong to admin account!"
			    redirect_to new_admin_password_reset_path
			  end
		else
			  flash[:danger] = "Email contain a valid email address"
			  redirect_to new_admin_password_reset_path
		end

	end

	def edit
	  @page_title = 'Reset Password'
	  @user = User.find_by_password_reset_token!(params[:id])
	end

	def update
	  @user = User.new(update_params)
	  @user.skip_email_reset_password = true
	  if @user.valid?	
			  @user = User.find_by_password_reset_token!(params[:id])
			  if @user.password_reset_sent_at < 2.hours.ago
			  	flash[:danger] = "Your Password reset link has been expired!"
			    redirect_to new_admin_password_reset_path
			  elsif @user.update_attributes(update_params)
			  	flash[:success] = "Your Password has been successfully reset!"
			    redirect_to admin_login_path
			  else
			    render :edit
			  end
	 else
	 	  render 'edit'
	 end
	end

	def update_params
  		params.require(:user).permit(:password, :password_confirmation)
	end

	private
		  def valid_email(email)
		    email.present? && (email =~ VALID_EMAIL_REGEX)
		  end

end
