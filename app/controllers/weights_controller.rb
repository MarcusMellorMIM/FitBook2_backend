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
        weight = Weight.create weight_params
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
        weight = Weight.find(params[:id])
        weight.assign_attributes(weight_params)
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