class ReviewsController < ApplicationController
	def index
		@reviews = Review.all
	end

	def new
	  @review = Review.new
	  #@review.images.new
	end

	def create
		@review = Review.new(review_params)
		@review.restaurant_id = params[:restaurant_id]
		puts params
		if @review.save
			if params[:files]
		        #===== The magic is here ;)
		        params[:files].each { |f|
		          @review.images.create(file: f)
		        }
    		end

    		if params[:item_reviews]
    			params[:item_reviews].each do |i|
    				@review.item_reviews.create(title: i["title"], rating: i["rating"], description: i["description"])
    			end
    		end
    		puts "--------------"
			puts "saved"
			puts "--------------"
		else
			puts "not saved"
		end
		redirect_to :back
	end

	def review_params
    	params.require(:review).permit(:rating, :description, :restaurant_id, :images, :item_reviews => [:file])
    end
end