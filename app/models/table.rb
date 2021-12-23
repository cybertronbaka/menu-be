# frozen_string_literal: true

class Table < ApplicationRecord
  belongs_to :menu

  before_create :set_token, :attach_qr_code

  def set_token
    self.token = Digest::SHA1.hexdigest([Time.now, rand, id].join)
  end

  def attach_qr_code
    self.qr_code = RQRCode::QRCode.new(token).as_png(size: 300).to_data_url
  end
end