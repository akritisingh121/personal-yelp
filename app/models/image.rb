class Image < ActiveRecord::Base

	# has_attached_file :file, styles: { thumbnail: '100x100x' }
	has_attached_file :file, styles: { thumbnail: "100x100#" }
	validates_attachment_content_type :file, content_type: /\Aimage/

	belongs_to :review
	belongs_to :item_review
end
