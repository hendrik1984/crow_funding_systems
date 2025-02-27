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

    private

    # Authentication the request using the jwt token
    def authenticate_request
        header = request.headers['Authorization']
        token = header.split(' ').last if header

        begin 
            if token
                decoded = JwtHelper.decode(token)
                if decoded
                    @current_user = User.select(:id, :name, :occupation, :email, :role).find(decoded[:user_id])
                else
                    render_json("Invalid_token", 401, "error")
                end
            else
                render_json("Authorization token missing", 422, "error")
            end
        rescue JWT::DecodeError
            render_json("Invalid token", 422, "error")
        end
    end

    def current_user
        @current_user
    end
end
