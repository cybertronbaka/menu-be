class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.integer :notification_type, default: 0, null: false
      t.text :body, null: false
      t.string :link, null: true
      t.string :image
      t.boolean :read, default: false, null: false
      t.belongs_to :user
      t.timestamps
    end
  end
end
