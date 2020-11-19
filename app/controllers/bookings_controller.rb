class BookingsController < ApplicationController
  def index
    @bookings = Booking.where(user: current_user)
    @van_bookings = Booking.joins(:campervan).where(user: current_user)
    @user_vans = Campervan.where(user: current_user)
  end

  def new
    @campervan = Campervan.find(params[:campervan_id])
    @booking = Booking.new
  end

  def create
    @campervan = Campervan.find(params[:campervan_id])
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.campervan = @campervan
    if @booking.save
      redirect_to bookings_path
    else
      render "new"
    end
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
