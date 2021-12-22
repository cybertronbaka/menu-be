# frozen_string_literal: true

class Section < ApplicationRecord
  belongs_to :menu

  validates_presence_of :name

  before_create :set_rank, unless: :rank

  def set_rank
    self.rank = menu.sections.count + 1
  end
end