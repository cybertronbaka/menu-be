class Unauthenticated < StandardError
  def initialize(msg = 'You need to sign in or sign up to perform this action.')
    super
  end
end
