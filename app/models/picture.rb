# frozen_string_literal: true

class Picture < ApplicationRecord
  include ImageUploader::Attachment(:image)

  before_create :set_url

  def set_url
    self.url = "#{ENV['HOST']}#{image_url}"
  end
end