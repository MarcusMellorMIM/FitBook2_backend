class ExercisesController < ApplicationController

    def index
        # WORK TO DO ... USE FIND INSTEAD USING USER_NAME: AS AN ARG
        user = User.where(["user_name=?",params[:id]]).first
        exercises = user.exercises

        render json: exercises, except: [:created_at],
                include: [ :exercise_details ]
    end

    def show
        exercise = Exercise.find(params[:id])
        render json: exercise
    end

    def create
# WORK TO DO -- FIGURE OUT HOW TO USE PERMIT PARAMS WITH A LARGE HASH ARRAY
        user_id=params[:exercise][:user_id]
        detail=params[:exercise][:detail]
        exercise_type_id=params[:exercise][:exercise_type_id]
        exercise_date=params[:exercise][:exercise_date]
        exercise_date_d=params[:exercise][:exercise_date_d]
        exercise_date_t=params[:exercise][:exercise_date_t]


        # Probably long winded, but this allows for a null date
        # to default to today, and a null time to default to now.
        # So if a user enters a date, and no time ... time is set
        # if time and no date, the time goes against today etc etc
        if exercise_date_d==nil || exercise_date_d==""
            exercise_date_d=Date.current.to_s
        end
        if exercise_date_t==nil || exercise_date_t==""
            exercise_date_t=Time.current.strftime("%H:%M")
        end
        exercise_date = (exercise_date_d + ' ' + exercise_date_t).to_datetime

        # Just in case the person has not selected this -- its mandatory
        if exercise_type_id==nil || exercise_type_id==""
            exercise_type_id=1
        end

        # Create the Exercise
        exercise = Exercise.create(user_id:user_id, detail:detail, exercise_type_id:exercise_type_id, exercise_date:exercise_date )

        # Now create the meal detail records from the super huuuuge hash
        params[:exercise][:exercise_details].map { |e|            
            exercisedetail=ExerciseDetail.create(
                exercise_id:exercise.id,
                name:e[:name],
                unit_calories:e[:unit_calories],           
                duration_min:e[:duration_min],
                photo_thumb:e[:photo_thumb]
            )
        }

        render json: exercise

    end

    def destroy
        exercise = Exercise.find(params[:id]);
        # Re-rendering the weights is being handled in the form
        # user=weight.user;
        exercise.exercise_details.destroy;
        exercise.destroy;
        # weights = user.weights
        # render json: weights
    end
    
    def update
        # ?WORK TO DO
        # Currently just updates meal .... and does not do anything with meal_details 
        # May need to revisit to allow a change of meal_detail records
        exercise = Exercise.find(params[:id])
        exercise.assign_attributes(exercise_params)
        if exercise.valid?
            exercise.save
        end
        render json: exercise
    end

private

    def exercise_params
# WORK TO DO
# NEED TO ADD IN THE DETAILS SO THE CREATE WORKS
# CURRENTLY AN ISSUE AS DETAILS IS AN ARRAY, AND 
# PHOTO IS A HASH IN THE ARRAY
        params.require(:exercise).permit(
            :id,
            :user_id,
            :detail,
            :exercise_date,
            :exercise_date_d,
            :exercise_date_t,
            :exercise_type_id,
            :totalCalories
            )
    end

end