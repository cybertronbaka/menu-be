class CreatePictures < ActiveRecord::Migration[6.1]
  def change
    create_table :pictures do |t|
      t.string :url
      t.text :image_data
      t.timestamps
    end
  end
end
