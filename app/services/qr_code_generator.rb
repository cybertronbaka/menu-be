class QrCodeGenerator
  attr_accessor :token

  def initialize(token)
    @token = token
  end

  def run
    filename = "qr_#{Digest::SHA1.hexdigest([Time.now, rand, token].join)}_#{Time.now.strftime('%m_%d_%H_%M_%S')}.png"
    qr_composed.save(Rails.root.join("public/uploads/#{filename}"))
    "#{ENV['HOST']}#{filename}"
  end

  def logo
    @logo ||= ChunkyPNG::Image.from_file(Rails.root.join('app/services/logo.png'))
  end

  def qr_composed
    @qr_composed = qr_code.compose(logo, x_pos, y_pos)
  end

  def x_pos
    @x_pos ||= (qr_code.width - logo.width)/2.0
  end

  def y_pos
    @y_pos ||= (qr_code.height - logo.height)/2.0
  end

  def qr_code
    @qr_code ||= RQRCode::QRCode.new(token, level: :h).as_png(size: 450)
  end
end