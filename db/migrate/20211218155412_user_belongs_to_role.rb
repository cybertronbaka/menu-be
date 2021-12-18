class UserBelongsToRole < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :role_id, :bigint, null: false
  end
end
