class Admin::PageController < ApplicationController

  layout 'master'	

  def index
  end

  def vendors
  	@vendors = Vendor.all
  end

  def vendorproducts
  	@vendordata      =  Vendor.where(id: params[:id]).limit(1).pluck(:id, :name).first
  	@products        =  Product.where(vendor_id: params[:id])
  end

  def users
  	@users = User.all
  end

end
