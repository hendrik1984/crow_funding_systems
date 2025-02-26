class UsersController < ApplicationController
    before_action :set_user, only: [:show, :update, :destroy]

    def index
        @users = User.all
        # render json: @users
        render_json("Users retrieved successfully", 200, "success", @users)
    end

    def show
        # render json: @user
        render_json("User retrieved successfully", 200, "success", @user)
    end

    def create
        @user = User.new(user_params)
        if @user.save
            # render json: @user, status: :created
            render_json("User created successfully", 201, "success", @user)
        else
            # render json: @user.errors, status: :unprocessable_entity
            render_json("User creation failed", 422, "error", @user.errors)
        end
    end

    def update
        if @user.update(user_params)
            # render json: @user
            render_json("User updated successfully", 200, "success", @user)
        else
            # render json: @user.errors, status: :unprocessable_entity
            render_json("User update failed", 422, "error", @user.errors)
        end
    end

    def destroy
        @user.destroy
        # head :no_content
        render_json("User deleted successfully", 200, "success")
    end

    private

    def set_user
        @user = User.find_by(id: params[:id])
        unless @user
            render_json("User not found!", 404, "error")
            return
        end
    end

    def user_params
        params.require(:user).permit(:name, :occupation, :email, :avatar_filename, :role, :password_hash, :token)
    end
end
