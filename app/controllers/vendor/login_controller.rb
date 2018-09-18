class Vendor::LoginController < ApplicationController
  before_action :redirect_vendor_home

  layout 'vendortemplate'	

  def index
     @vendor = Vendor.new
  end

  def account

     @vendor = Vendor.new(vendor_params)
     @vendor.validate_login_form_req = true
     if @vendor.valid?

        	 @vendor = Vendor.find_by(email: params[:vendor][:email].downcase)

        	 if @vendor and @vendor.authenticate(params[:vendor][:password]) 
        	 	session[:vendor_id] = @vendor.id
        	 	redirect_to vendor_home_path
        	 else
        	 	#flash.now.alert = "Incorrect email or password, try again."
            #render :index
        	 	#render partial: 'new', locals: {user: @user}
            flash[:danger] = "Incorrect email or password, try again."
        	 	redirect_to vendor_login_path
            
          end
      else
            render 'index'
  	 end
  end

  private
	  def vendor_params
	      params.require(:vendor).permit(:email, :password)
	  end
 
end
