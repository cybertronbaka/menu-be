class AddPictureAndDescriptionInProfile < ActiveRecord::Migration[6.1]
  def change
    add_column :profiles, :picture, :string
    add_column :profiles, :description, :text
  end
end
