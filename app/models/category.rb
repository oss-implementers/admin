class Category < ApplicationRecord
	validates :status, presence: true
	validates :commission, numericality: {only_float: true}, presence: true
	validates :name, presence: true

end
