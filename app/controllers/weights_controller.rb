class WeightsController < ApplicationController

    def index
        user = User.find([params[:user_id]])
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

    def delete
        weight = Weight.find(params[:id]);
        user=weight.user;
        weight.destroy;
        weights = user.weights
        render json: weights
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
            :weight_kg,
            :weight_date)
    end

end