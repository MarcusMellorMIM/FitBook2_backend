class ApiController < ApplicationController

    def food
        api= Nutritionixapi.new
        food=api.get_mealinfo(params[:detail])
        render json: food
    end

    def exercise
        user = User.where(["user_name=?",params[:user_name]]).first
        api= Nutritionixapi.new
        exercise=api.get_exerciseinfo(params[:detail], user )
        render json: exercise
    end
end