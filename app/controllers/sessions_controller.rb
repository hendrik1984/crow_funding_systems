class SessionsController < ApplicationController
    def login
        @user = User.find_by(email: params[:email])
        if @user&.authenticate(params[:password])
            render_json("Login Successfully", 200, "success", { user_id: @user.id, email: user.email })
        else
            render_json("Invalid email or password", 401, "error")
        end
    end
end
