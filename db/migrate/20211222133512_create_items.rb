class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.text :description
      t.float :price, null: false
      t.integer :status, null: false, default: 0
      t.string :pictures, null: false, array: true, default: []
      t.integer :rank, null: false
      t.belongs_to :section
      t.timestamps
    end
  end
end
