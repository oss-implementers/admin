class VendorController < ApplicationController
    #prepend_view_path 'app/views/vendor_account'

    def self.controller_path
      "vendor_account"
    end

	def new
		@vendor = Vendor.new
	end

	def create
		 @vendor = Vendor.new(vendor_params)
		 if @vendor.valid?
		 	email_exists = Vendor.where(:email => params[:vendor][:email]).exists?
		 	if !email_exists

				     if @vendor.save!
				      	 	redirect_to vendor_path
				     else
				         	flash[:danger] = "Error."
				            redirect_to vendor_path
			  	     end
			else
				     flash[:exist] = "The email #{params[:vendor][:email]} you entered is already exist."
				     render 'new'
		    end

	  	 else
	  	 			 render 'new'
	  	 end
  	end

    private
	  def vendor_params
	      params.require(:vendor).permit(:name, :email, :password, :business_name)
	  end

end
