class ApplicationController < ActionController::API
    def render_json(message, code, status, data = nil)
        render json: {
            meta: {
                message: message,
                code: code,
                status: status
            },
            data: data
        }, status: code
    end
end
