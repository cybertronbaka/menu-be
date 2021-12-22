class CreateTables < ActiveRecord::Migration[6.1]
  def change
    create_table :tables do |t|
      t.integer :table_no, null: false
      t.string :token, null: false
      t.belongs_to :menu
      t.text :qr_code, null: false
      t.timestamps
    end
  end
end
