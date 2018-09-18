module VendorHelper

	def subcat_prefix(depth)
 		 ("&nbsp;" * 4 * depth).html_safe
	end

	def category_options_array(categories=[], parent_id=0, depth=0, flag=0)

	  if flag == 0
	    categories << [subcat_prefix(0) + '-- Select --', '']
	  end

	  Category.where(parent_id: parent_id).order(:id).each do |category|
	    categories << [subcat_prefix(depth) + category.name, category.id]
	    category_options_array(categories, category.id, depth + 1, 1)
      end  
        categories
    end
end
