class Item < ApplicationRecord
  include RankConcern

  belongs_to :section

  enum status: { available: 0, unavailable: 1}
end
