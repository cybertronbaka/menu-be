class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|
      t.string :name, null: false
      t.text :address
      t.belongs_to :user
      t.timestamps
    end
  end
end
