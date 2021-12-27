class ApplicationController < ActionController::API
  include AuthHandler
  include RestErrorHandler

  attr_accessor :current_user
end
