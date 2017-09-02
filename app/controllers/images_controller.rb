class ImagesController < ApplicationController
	def index
		@images = Image.all
	end

	def new
		@image = Image.new
	end

	def create
		@image = Image.new(image_params)
		

		if @image.save
			puts "---------------"
		else
			puts "not saved"
		end

		puts "---------------"
		puts @image.file.url(:thumbnail)
		puts "---------------"
	end

	def image_params
    	params.require(:image).permit(:review_id, :file)
    end
end
