class CreateMenu < ActiveRecord::Migration[6.1]
  def change
    create_table :menus do |t|
      t.string :name
      t.text :description
      t.belongs_to :user
      t.timestamps
    end
  end
end
