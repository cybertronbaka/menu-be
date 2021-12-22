# frozen_string_literal: true

module GraphqlErrorHandler
  def self.included(clazz)
    clazz.class_eval do
      rescue_from ActiveRecord::RecordNotFound do |err, _obj, _args, _ctx, field|
        render_error('NOT_FOUND', err.message)
      end
      rescue_from ActiveRecord::RecordInvalid do |err, _obj, _args, _ctx, _field|
        render_error('RECORD_INVALID', err.message.sub('Validation failed: ', ''))
      end
      rescue_from Unauthenticated do |err, _obj, _args, _ctx, _field|
        render_error('UNAUTHENTICATED', err.message)
      end
      rescue_from Unauthorized do |err, _obj, _args, _ctx, _field|
        render_error('UNAUTHORIZED', err.message)
      end
      rescue_from StandardError do |err, _obj, _args, _ctx, _field|
        render_error(err.respond_to?(:code) ? err.code : 'INTERNAL_SERVER_ERROR', err.message)
      end
    end
  end
end
