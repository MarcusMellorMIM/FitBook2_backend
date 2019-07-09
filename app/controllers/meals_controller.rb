class MealsController < ApplicationController

    def index
        # WORK TO DO ... USE FIND INSTEAD USING USER_NAME: AS AN ARG
        user = User.where(["user_name=?",params[:id]]).first
        meals = user.meals

        # NEED TO FIGURE OUT HOW TO ADD SOME ATTRIBUTES FROM MEALS        
        render json: meals, except: [:created_at],
                include: [ :meal_details ]
    end

    def show
        meal = Meal.find(params[:id])
        render json: meal
    end

    def create
# WORK TO DO -- FIGURE OUT HOW TO USE PERMIT PARAMS WITH A LARGE HASH ARRAY
        user_id=params[:food][:user_id]
        detail=params[:food][:detail]
        meal_type_id=params[:food][:meal_type_id]
        meal_date=params[:food][:meal_date]
        meal_date_d=params[:food][:meal_date_d]
        meal_date_t=params[:food][:meal_date_t]


        # Probably long winded, but this allows for a null date
        # to default to today, and a null time to default to now.
        # So if a user enters a date, and no time ... time is set
        # if time and no date, the time goes against today etc etc
        if meal_date_d==nil
            meal_date_d=Date.current.to_s
        end
        if meal_date_t==nil
            meal_date_t=Time.current.strftime("%H:%M")
        end
        meal_date = (meal_date_d + ' ' + meal_date_t).to_datetime

        # Just in case the person has not selected this -- its mandatory
        if meal_type_id==nil
            meal_type_id=1
        end

        # Create the meal
        meal = Meal.create(user_id:user_id, detail:detail, meal_type_id:meal_type_id, meal_date:meal_date )

        # Now create the meal detail records from the super huuuuge hash
        params[:food][:details].map { |f|            
            mealdetail=MealDetail.create(
                meal_id:meal.id,
                food_name:f[:food_name],
                nf_calories:f[:nf_calories],           
                serving_unit:f[:serving_unit],
                serving_qty:f[:serving_qty],
                serving_weight_grams:f[:serving_weight_grams],
                photo_thumb:f[:photo][:thumb]
            )
        }

        render json: meal

    end

    def destroy
        meal = Meal.find(params[:id]);
        # Re-rendering the weights is being handled in the form
        # user=weight.user;
        meal.meal_details.destroy;
        meal.destroy;
        # weights = user.weights
        # render json: weights
    end
    
    def update
        # ?WORK TO DO
        # Currently just updates meal .... and does not do anything with meal_details 
        # May need to revisit to allow a change of meal_detail records
        meal = Meal.find(params[:id])
        meal.assign_attributes(meal_params)
        if meal.valid?
            meal.save
        end
        render json: meal
    end

private

    def meal_params
# WORK TO DO
# NEED TO ADD IN THE DETAILS SO THE CREATE WORKS
# CURRENTLY AN ISSUE AS DETAILS IS AN ARRAY, AND 
# PHOTO IS A HASH IN THE ARRAY
        params.require(:food).permit(
            :id,
            :user_id,
            :detail,
            :meal_date,
            :meal_date_d,
            :meal_date_t,
            :meal_type_id,
            :totalCalories
            )
    end

end