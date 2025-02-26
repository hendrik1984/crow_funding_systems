class SessionsController < ApplicationController
    def login
        @user = User.find_by(email: params[:email])
        if @user&.authenticate(params[:password])
            render_json("Login Successfully", 200, "success", { token: @user.token })
        else
            render_json("Invalid email or password", 401, "error")
        end
    end
end
