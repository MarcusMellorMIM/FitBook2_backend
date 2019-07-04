class UsersController < ApplicationController

    def index
        users = User.all 
        render json: users
    end

    def show
        user = User.where(["user_name=?",params[:id]]).first
        render json: user
    end

    def create
        user = User.create user_params
        render json: user
    end

    def update
        user.assign_attributes(user_params)
        if user.valid?
            user.save
        end
        render json: user
    end

private

    def user_params
        params.require(:user).permit(:password_digest,
                    :email,
                    :name,
                    :dob,
                    :height_cm,
                    :gender)
        end

    end