class Vendor::DashboardController < ApplicationController
	before_action :authorize_vendor

    layout 'vendormaster'	

	def index
		@page_title 	= VendorConstant::VENDOR_PANEL_TITLE + ' Dashboard'
		path_segments   = request.fullpath.split("/")
		@segment        = path_segments[-1]
		#logger.debug "Output content goes here #{@segment}"
	end

	def logout
        session[:vendor_id] =  nil
        flash[:success]   = "You\'ve successfully logged out!"
  	 	redirect_to vendor_login_path
	end

end
