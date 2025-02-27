class SessionsController < ApplicationController

    def login
        @user = User.find_by(email: params[:email])
        
        if @user&.authenticate(params[:password])
            # Generate jwt token
            payload = { user_id: @user.id, role: @user.role }
            token = JwtHelper.encode(payload)
            
            render_json("Login Successfully", 200, "success", { token: token })
        else
            render_json("Invalid email or password", 401, "error")
        end
    end
end
