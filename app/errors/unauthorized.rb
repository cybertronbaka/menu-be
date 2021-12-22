class Unauthorized < StandardError
  def initialize(msg = 'You are not authorized to perform this action')
    super
  end
end
