# frozen_string_literal: true

class Menu < ApplicationRecord
  belongs_to :user
  has_many :sections

  validates_with MenuCountValidator, on: :create

  after_destroy :destroy_sections

  def destroy_sections
    sections.destroy_all
  end
end
