class CreateItemReviews < ActiveRecord::Migration
  def change
    create_table :item_reviews do |t|
      t.integer :review_id
      t.string :title
      t.text :description
      t.float :rating

      t.timestamps null: false
    end
  end
end
