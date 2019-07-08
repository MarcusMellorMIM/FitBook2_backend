class UsersController < ApplicationController

    def index
        users = User.all 
        render json: users
    end

    def show
        user = User.where(["user_name=?",params[:id]]).first
        render json: user
       
        # Current design seperates the gets ... ?? best practice ??
        #     ,
        # include: [:weights]
    end

    def create
        user = User.create!(user_params)
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
        params.require(:user).permit(
                    :user_name,
                    :email,
                    :name,
                    :dob,
                    :height_cm,
                    :password,
                    :weight,
                    :gender)
        end

    end