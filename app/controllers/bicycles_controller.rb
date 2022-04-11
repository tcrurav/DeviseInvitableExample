class BicyclesController < ApplicationController
    before_action :authenticate_user!
    
    def index
        @bicycles = Bicycle.all 
        render json: @bicycles
    end 

    def show
        @bicycle = Bicycle.find(params[:id])
        render json: @bicycle
    end 

    def create
        @bicycle = Bicycle.create(
            brand: params[:brand],
            model: params[:model],
        )
        render json: @bicycle
    end 

    def update
        @bicycle = Bicycle.find(params[:id])
        @bicycle.update(
            brand: params[:brand],
            model: params[:model],
        )
        render json: @bicycle
    end 

    def destroy
        @bicycles = Bicycle.all 
        @bicycle = Bicycle.find(params[:id])
        @bicycle.destroy
        render json: @bicycles
    end 
end
