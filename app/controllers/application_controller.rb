class ApplicationController < ActionController::Base

	protected
	 def authorize
        unless User.find_by id: session[:user_id]
        	flash[:warning] = "Please login to continue."
        	redirect_to admin_login_path
        end
	 end

	protected
	 def redirect_home
        if (session[:user_id])
          redirect_to admin_home_path
        end
	end

    protected
     def authorize_vendor
        unless Vendor.find_by id: session[:vendor_id]
            flash[:warning] = "Please login to continue."
            redirect_to vendor_login_path
        end
     end

    protected
     def redirect_vendor_home
        if (session[:vendor_id])
          redirect_to vendor_home_path
        end
    end



end
