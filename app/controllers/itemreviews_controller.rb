class ItemreviewsController < ApplicationController
	def index
		@item_review = Item_Review.all
	end

	def new
		@item_review = Item_Review.new
	end

	def create
		@item_review = Item_Review.new(item_review_params)
		

		if @item_review.save
			puts "item review saved-------------------------------"
		else
			puts "not saved"
		end
	end

	def item_review_params
    	params.require(:item_review).permit(:review_id, :title, :rating, :description)
    end
end

end
