class AddTokenAndQrcodeInMenu < ActiveRecord::Migration[6.1]
  def change
    add_column :menus, :token, :string, null: false
    add_column :menus, :qr_code, :text, null: false
  end
end
