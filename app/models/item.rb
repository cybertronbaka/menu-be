class Item < ApplicationRecord
  include RankConcern

  belongs_to :section

  enum status: { available: 0, unavailable: 1 }
  enum veg_type: { veg: 0, nonveg: 1 }
end
