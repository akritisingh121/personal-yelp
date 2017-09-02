class RemovePhotoFromReview < ActiveRecord::Migration
  def change
    remove_column :reviews, :photo_file_name, :string
    remove_column :reviews, :photo_content_type, :string
    remove_column :reviews, :photo_file_size, :integer
    remove_column :reviews, :photo_updated_at, :datetime
  end
end
