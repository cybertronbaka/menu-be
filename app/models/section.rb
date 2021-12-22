# frozen_string_literal: true

class Section < ApplicationRecord
  include RankConcern

  belongs_to :menu
  has_many :items

  validates_presence_of :name

  after_destroy :destroy_items

  def destroy_items
    items.destroy_all
  end
end