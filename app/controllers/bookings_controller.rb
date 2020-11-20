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
    start_date = Date.parse(params[:booking][:start_date])
    end_date = Date.parse(params[:booking][:end_date])
    total_price = (end_date - start_date).to_i * @campervan.price_per_night
    @booking.total_price = total_price
    @booking.user = current_user
    @booking.campervan = @campervan
    if @booking.save
      render "confirmation"
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
