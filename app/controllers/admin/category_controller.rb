class Admin::CategoryController < ApplicationController

	before_action :authorize
	before_action :set_category, only: [:edit, :update, :destroy]
	skip_before_action :verify_authenticity_token, only: [:destroy]

    layout 'master'	

    def index
		@categories = Category.all
	end

    def new
		@category = Category.new
	end

	
	def create
        @category = Category.new(category_params)
        if @category.valid?
        	if @category.save
        		redirect_to admin_category_index_path
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
		#@category.update(category_params)
		#redirect_to admin_category_index_path
        #@category = Category.update(category_params)
        #@category = Category.new(category_params)
        if @category.update(category_params)
        	redirect_to admin_category_index_path
        else
       		render 'edit'
       end
	end

	def destroy
        @category = Category.find(params[:id])
 		@category.destroy
       redirect_to admin_category_index_path
	end

	private

	  def set_category
         @category = Category.find(params[:id])
      end

	  def category_params
	      params.require(:category).permit(:parent_id, :name, :commission, :status)
	  end

end
