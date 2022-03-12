class QrCodeGenerator
  attr_accessor :token

  def initialize(token)
    @token = token
  end

  def run
    filename = "qr_#{Digest::SHA1.hexdigest([Time.now, rand, token].join)}_#{Time.now.strftime('%m_%d_%H_%M_%S')}.png"
    qr_composed.save(Rails.root.join("public/uploads/#{filename}"))
    "#{ENV['HOST']}/uploads/#{filename}"
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

# errors = []
# Menu.all.each do |menu|
#   begin
#     file_name = QrCodeGenerator.new(menu.token).run
#     menu.update!(qr_code: file_name)
#   rescue => e
#     errors << menu
#   end
# end

# errors = []
# OrderItem.all.each do |order|
#   begin
#     item = order.item
#     order.update!(name: item.name, description: item.description, pictures: item.pictures, price: item.price)
#   rescue => e
#     errors << order
#   end
# end