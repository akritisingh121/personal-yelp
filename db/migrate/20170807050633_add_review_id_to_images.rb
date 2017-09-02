class AddReviewIdToImages < ActiveRecord::Migration
  def change
    add_column :images, :review_id, :integer
  end
end
