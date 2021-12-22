class CreateSection < ActiveRecord::Migration[6.1]
  def change
    create_table :sections do |t|
      t.string :name, null: false
      t.integer :rank, null: false
      t.belongs_to :menu
      t.timestamps
    end
  end
end
