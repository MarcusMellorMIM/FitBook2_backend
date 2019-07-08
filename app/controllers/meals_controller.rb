class MealsController < ApplicationController

    def index
        user = User.where(["user_name=?",params[:id]]).first
        meals = user.meals
        render json: meals,
            include: meal_details
    end

    def show
        meal = Meal.find(params[:id])
        render json: meal
    end

    def create
        byebug
        user_id=params[:food][:user_id]
        detail=params[:food][:foodDetail]
        #:foodDate,
        #:foodTime,
        meal=Meal.create(user_id:user_id, detail:detail)
        byebug
        params[:food][:details].map { |f|
            
            mealdetail=MealDetail.create(
                meal_id:f.id,
                detail:f.food_name,
                calories:f.nf_calories )            
            }

    #     { details: :serving_unit },
    #    { details: :serving_qty },
    #    { details: :nf_calories },
    #    { details: :serving_weight_grams }
        byebug
        render json: meal
    end

    def destroy
        meal = Meal.find(params[:id]);
        # Re-rendering the weights is being handled in the form
        # user=weight.user;
        meal.destroy;
        # weights = user.weights
        # render json: weights
    end
    
    def update
        meal = Meal.find(params[:id])
        meal.assign_attributes(meal_params)
        if meal.valid?
            meal.save
        end
        render json: meal
    end

private

    def meal_params
        params.require(:food).permit(
            :id,
            :user_id,
            :foodDetail,
            :foodDate,
            :foodTime,
            :totalCalories,
            { details: :food_name },
            { details: :serving_unit },
             { details: :serving_unit },
             { details: :serving_qty },
             { details: :nf_calories },
             { details: :serving_weight_grams }
            )
    end

end