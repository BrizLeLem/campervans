class BookingsController < ApplicationController
  def new
    @campervan = Campervan.find(params[:id])
    @booking = Booking.new
  end

  def create
    @campervan = Campervan.find(params[:id])
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.campervan = @campervan
    if @booking.save
      redirect_to @campervan
    else
      render "new"
  end

  def index_by_user
    # @user =
    @booking = Booking.where(user: current_user)
  end


  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :total_price, :user_id, :campervan_id)
  end
end
