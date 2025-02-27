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
                    #token expired
                    render_json("Invalid token exp", 422, "error") if decoded[:exp] < Time.now.to_i

                    @current_user = { user_id: decoded[:user_id], role: decoded[:role], exp: decoded[:exp] }
                else
                    render_json("Invalid token", 401, "error")
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
