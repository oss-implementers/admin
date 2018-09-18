module Vendor::ProductHelper

	def get_product_cateory(category_id)
		Category.where(id: category_id).limit(1).pluck(:name).first
	end
end
