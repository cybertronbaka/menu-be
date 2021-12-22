class CreateRestrictions < ActiveRecord::Migration[6.1]
  def change
    create_table :restrictions do |t|
      t.integer :restriction_type, null: false, default: 0
      t.string :value, null: false
      t.belongs_to :user
      t.timestamps
    end
  end
end
