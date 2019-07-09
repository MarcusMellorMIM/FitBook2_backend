class WeightsController < ApplicationController

    def index
        user = User.where(["user_name=?",params[:id]]).first
        weights = user.weights
        render json: weights
    end

    def show
        weight = Weight.find(params[:id])
        render json: weight
    end

    def create
    # As we want to manipulate weight_date ... using the permitted params method
    # seems to cause issues - ideally I would like to set the date, and use weight_params
        user_id = params[:user_id]
        weight_kg=params[:weight_kg]
    # Dodgy method of sorting out the date
        weight_date_d=params[:weight_date_d];
        weight_date_t=params[:weight_date_t];
        if weight_date_d==nil || weight_date_d==""
            weight_date_d=Date.current.to_s
        end
        if weight_date_t==nil || weight_date_t==""
            weight_date_t=Time.current.strftime("%H:%M")
        end        
        weight_date = (weight_date_d + ' ' + weight_date_t).to_datetime

        weight = Weight.create( user_id:user_id,
                    weight_kg:weight_kg,
                    weight_date:weight_date)

        render json: weight

    end

    def destroy
        weight = Weight.find(params[:id]);
        # Re-rendering the weights is being handled in the form
        # user=weight.user;
        weight.destroy;
        # weights = user.weights
        # render json: weights
    end
    
    def update
# Really dodgy method of dealing with dates ... there has to be a better way
        weight = Weight.find(params[:id])
        weight_kg = params[:weight_kg]
        weight_date_d = params[:weight_date_d]
        weight_date_t = params[:weight_date_t]
        if weight_date_d==nil || weight_date_d==""
            weight_date_d=Date.current.to_s
        end
        if weight_date_t==nil || weight_date_t==""
            weight_date_t=Time.current.strftime("%H:%M")
        end        
        weight_date = (weight_date_d + ' ' + weight_date_t).to_datetime

        weight.assign_attributes( weight_kg:weight_kg,
                    weight_date:weight_date)

        if weight.valid?
            weight.save
        end
        render json: weight
    end

private

    def weight_params
        params.require(:weight).permit(:id,
            :user_id,
            :weight_kg,
            :weight_date)
    end

end