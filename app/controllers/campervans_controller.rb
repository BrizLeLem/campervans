class CampervansController < ApplicationController
  before_action :set_campervan, only: [:show, :destroy]

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
    @campervan.save
  end

  def destroy
    @campervan.destroy
  end

  private

  def campervan_params
    params.require(:campervan).permit(:title, :description)
  end

  def set_campervan
    @campervan = Campervan.find(params[:id])
  end
end
