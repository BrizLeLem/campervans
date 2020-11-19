class CampervansController < ApplicationController
  before_action :set_campervan, only: %i[show destroy]

  def index
    if params[:search][:city].present?
      @campervans = Campervan.near(params[:search][:city], 5)
    elsif params[:search][:brand].present?
      @campervans = Campervan.where(brand: params[:search][:brand])
    elsif params[:search].present?
      @campervans = Campervan.near(params[:search][:city], 5).where(brand: params[:search][:brand])
    else
      @campervans = Campervan.all
    end

    @markers = @campervans.geocoded.map do |campervan|
      {
        lat: campervan.latitude,
        lng: campervan.longitude,
        infoWindow: render_to_string(partial: "../views/campervans/infowindow", locals: { campervan: campervan })
      }
    end
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
      redirect_to campervan_path(@campervan), alert: 'Your campervan was successfully created! 🚐'
    else
      render :new
    end
  end

  def destroy
    @campervan.destroy

    redirect_to bookings_path
  end

  private

  def campervan_params
    params.require(:campervan).permit(:title, :description, :brand, :model, :photo, :capacity, :price_per_night)
  end

  def set_campervan
    @campervan = Campervan.find(params[:id])
  end
end
