class AddMobileToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :mobile, :string, null: false
  end
end
