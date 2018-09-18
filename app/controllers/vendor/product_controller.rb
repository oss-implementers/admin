class Vendor::ProductController < ApplicationController

	before_action :authorize_vendor
	before_action :set_product, only: [:edit, :update, :destroy]
	skip_before_action :verify_authenticity_token, only: [:destroy]

    layout 'vendormaster'	

    def index
		@products = Product.where("vendor_id = ?", session[:vendor_id])
	end

    def new

    	@page_title 	= VendorConstant::VENDOR_PANEL_TITLE + ' Dashboard'
		path_segments   = request.fullpath.split("/")
		@segment        = path_segments[-1]
		@product        = Product.new
	end

	def create
        @product = Product.new(product_params.merge(:vendor_id => session[:vendor_id]))
        if @product.valid?		
        	if @product.save
        		redirect_to vendor_product_index_path
       		 else
			    render 'new'
		    end
        else
        	render 'new'
        end
	end

	def edit

	end

	def update
        if @product.update(product_params)
        	redirect_to vendor_product_index_path
        else
       		render 'edit'
       end
	end

	def destroy
        @product = Product.find(params[:id])
 		@product.destroy
        redirect_to vendor_product_index_path
	end

	private

	  def set_product
         @product = Product.find(params[:id])
      end

	  def product_params
	      params.require(:product).permit(:category_id, :name, :price, :image, :link, :status)
	  end

end
