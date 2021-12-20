module RestErrorHandler
    def self.included(clazz)
        clazz.class_eval do
            rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
            rescue_from Unauthenticated, with: :unauthenticated
            rescue_from StandardError, with: :standard_error
        end
    end

    private
    
    def standard_error(error)
        render_error(400, error.message)
    end

    def unauthenticated(error)
        render_error(401, error.message)
    end

    def record_not_found(_e)
        render_error(404, Helpers::Render.json(:record_not_found, _e.to_s))
    end

    def render_error(status, message)
        render json: { errors: message}, status: status
    end
end