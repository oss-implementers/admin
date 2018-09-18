class Admin::DashboardController < ApplicationController
	before_action :authorize

    layout 'master'	

	def index
		@page_title 	= AdminConstant::ADMIN_TITLE + ' Dashboard'
		path_segments   = request.fullpath.split("/")
		@segment        = path_segments[-1]
		#logger.debug "Output content goes here #{@segment}"
	end

	def logout
        session[:user_id] =  nil
        flash[:success]   = "You\'ve successfully logged out!"
  	 	redirect_to admin_login_path
	end

end
