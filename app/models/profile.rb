class Profile < ApplicationRecord
  belongs_to :user

  after_create :create_menu

  def create_menu
    return if user.role_id == 1

    Menu.create!(name: name, description: description, user_id: user.id)
  end
end
