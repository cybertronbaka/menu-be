class AddVegTypeToItem < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :veg_type, :integer, default: 0, null: false
  end
end
