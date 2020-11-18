class CampervansController < ApplicationController
  before_action :set_campervan, only: %i[show destroy]

  def index
    @campervans = Campervan.all
  end

  def show
  end

  def new
    @campervan = Campervan.new
  end

  def create
    @campervan = Campervan.new(campervan_params)
    @campervan.user = current_user
    if @campervan.save
      redirect_to campervan_path(@campervan), notice: 'Your campervan was successfully created! 🚐'
    else
      render :new
    end
  end

  def destroy
    @campervan.destroy
  end

  private

  def campervan_params
    params.require(:campervan).permit(:title, :description, :brand, :model, :photo, :capacity, :price_per_night)
  end

  def set_campervan
    @campervan = Campervan.find(params[:id])
  end
end
