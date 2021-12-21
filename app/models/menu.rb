# frozen_string_literal: true

class Menu < ApplicationRecord
  belongs_to :user

  validates_with MenuCountValidator
end
