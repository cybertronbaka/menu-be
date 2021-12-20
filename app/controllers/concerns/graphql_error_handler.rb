module GraphqlErrorHandler
    def self.included(clazz)
        clazz.class_eval do
            rescue_from ActiveRecord::RecordNotFound do |err, obj, args, ctx, field|
                render_error('NOT_FOUND', "#{field.type.unwrap.graphql_name} not found")
                raise GraphQL::ExecutionError.new(message, extenstions: { code: code })
            end
            rescue_from ActiveRecord::RecordInvalid do |err, obj, args, ctx, field|
                render_error('RECORD_INVALID', err.message)
            end
            rescue_from Unauthenticated do |err, obj, args, ctx, field|
                render_error('UNAUTHENTICATED', err.message)
            end
            rescue_from Unauthorized do |err, obj, args, ctx, field|
                render_error('UNAUTHORIZED', err.message)
            end
            rescue_from StandardError do |err, obj, args, ctx, field|
                render_error('INTERNAL_SERVER_ERROR', err.message)
            end
        end
    end
end