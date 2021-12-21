# frozen_string_literal: true

class Restriction < ApplicationRecord
  belongs_to :user

  enum restriction_type: { menu_count: 0 }
end
