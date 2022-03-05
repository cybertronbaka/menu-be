# frozen_string_literal: true

class Menu < ApplicationRecord
  belongs_to :user
  has_many :sections
  has_many :tables
  include PgSearch::Model

  pg_search_scope :query, against: %i[name], using: {
    trigram: {
      threshold: 0.3,
      word_similarity: true
    },
    tsearch: {
      any_word: true
    }
  }

  validates_with MenuCountValidator, on: :create

  before_create :set_token, :attach_qr_code
  after_destroy :destroy_sections

  def destroy_sections
    sections.destroy_all
    tables.destroy_all
  end

  def set_token
    self.token = Digest::SHA1.hexdigest([Time.now, rand, id].join)
  end

  def attach_qr_code
    self.qr_code = RQRCode::QRCode.new(token).as_png(size: 300).to_data_url
  end
end
