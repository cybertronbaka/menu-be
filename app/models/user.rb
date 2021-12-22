class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :role
  has_one :profile
  has_many :menus
  has_many :restrictions

  def super_admin?
    role.id == 1
  end

  def restuarant_owner?
    role.id == 2
  end
end
