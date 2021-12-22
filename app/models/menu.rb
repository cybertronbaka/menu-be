# frozen_string_literal: true

class Menu < ApplicationRecord
  belongs_to :user
  has_many :sections

  validates_with MenuCountValidator
end
