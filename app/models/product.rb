class Product < ApplicationRecord

	validates :status, presence: true
	validates :link, presence: true
	mount_uploader :image, ImageUploader # Tells rails to use this uploader for this model.
	validates :image, presence: true
	validates :price, numericality: {only_float: true}, presence: true
	validates :name, presence: true
	validates :category_id, presence: true

end