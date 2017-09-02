class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.text :description
      t.string :restaurant_id
      t.float :rating

      t.timestamps null: false
    end
  end
end
