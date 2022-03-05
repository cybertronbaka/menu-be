class Profile < ApplicationRecord
  belongs_to :user

  after_create :create_menu
  before_update :update_name_in_menu, if: :name_changed?
  before_update :update_description_in_menu, if: :description_changed?

  def update_name_in_menu
    user.menus.update_all(name: name)
  end

  def update_description_in_menu
    user.menus.update_all(description: description)
  end

  def create_menu
    return if user.role_id == 1

    Menu.create!(name: name, description: description, user_id: user.id)
  end
end
