class Review < ActiveRecord::Base
	has_many :images, dependent: :destroy
	has_many :item_reviews, dependent: :destroy

	accepts_nested_attributes_for :item_reviews, :reject_if => lambda { |a| a[:file].blank? }, :allow_destroy => true

end
