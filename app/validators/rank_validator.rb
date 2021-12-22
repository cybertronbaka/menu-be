# frozen_string_literal: true

class RankValidator < ActiveModel::Validator
  attr_accessor :record

  delegate :current_count, to: :record

  def validate(record)
    @record = record
    raise_error('Rank cannot be 0 or a negative number') if record.rank <= 0

    raise_error("Rank cannot be greater than #{current_count}") if record.rank > current_count

    true
  end

  private

  def raise_error(message)
    record.errors.add(:base, message)
  end
end
