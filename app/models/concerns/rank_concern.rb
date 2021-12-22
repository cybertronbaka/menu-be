# frozen_string_literal: true

module RankConcern
  extend ActiveSupport::Concern
  included do
    before_create :set_rank
    validates_with RankValidator, if: :rank_changed?, on: :update
  end

  def set_rank
    self.rank = current_count + 1
  end

  def current_count
    instance_of?(::Item) ? section.items.count : menu.sections.count
  end
end