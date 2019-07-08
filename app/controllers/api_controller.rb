class ApiController < ApplicationController

    def food
        api= Nutritionixapi.new
        food=api.get_mealinfo(params[:detail])
        render json: food
    end

    def exercise
        api= Nutritionixapi.new
        exercise=api.get_exerciseinfo(params[:detail], params[:user] )
        render json: exercise
    end
end