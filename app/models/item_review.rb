class ItemReview < ActiveRecord::Base
	belongs_to :review
	has_many :images, dependent: :destroy
	
end
