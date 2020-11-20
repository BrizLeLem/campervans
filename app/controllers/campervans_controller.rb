def convert_date_to_number(date)
  return (date - Date.new(2020, 11, 1)).to_i
end

def convert_number_to_date(number)
  return (Date.new(2020, 11, 1) + number.days)
end

class CampervansController < ApplicationController
  before_action :set_campervan, only: %i[show destroy]

  def index
    @campervans = Campervan.all

    # filter campervans for a certain city
    if params[:search][:city].present?
      @campervans = @campervans.near(params[:search][:city], 5)
    end

    # filter campervans for a certain brand
    if params[:search][:brand].present?
      @campervans = @campervans.where(brand: params[:search][:brand])
    end

    @markers = @campervans.geocoded.map do |campervan|
      {
        lat: campervan.latitude,
        lng: campervan.longitude,
        infoWindow: render_to_string(partial: "../views/campervans/infowindow", locals: {campervan: campervan})
      }
    end

    # filter campervans available for user's dates
    if params[:search][:start_date].present?
      userStart = convert_date_to_number(Date.parse(params[:search][:start_date]))
      userEnd = convert_date_to_number(Date.parse(params[:search][:end_date]))

      # hash table of each campervan's availability (for each day) of user search dates
      # key: campervan_id
      # value: array of 1s & 0s to represent whether that day is booked
      availability = Hash.new
      Campervan.all.each do |campervan|
        availability[campervan[:id]] = Array.new(userEnd - userStart + 1, 1)
      end

      # iterate through Booking table
      # any bookings that overlap with user's search are marked as 0 for that campervan's day
      Booking.all.each do |booking|
        bookingStart = convert_date_to_number(booking[:start_date])
        bookingEnd = convert_date_to_number(booking[:end_date])
        # if the booking dates overlap with user's searched dates
        if bookingEnd >= userStart && bookingStart <= userEnd
          # determine the range of dates it overlaps on in array of availabilities
          indexStart = bookingStart < userStart ? 0 : bookingStart - userStart
          indexEnd = bookingEnd > userEnd ? userEnd - userStart : bookingEnd - userStart
          # turn those booked dates for that campervan to 0 for availability
          (indexStart..indexEnd).each do |i|
            availability[booking[:campervan_id]][i] = 0
          end
        end
      end

      # filter through campervans list
      # only keep campervans that have a 1 in their availability list
      @campervans = @campervans.select do |campervan|
        !availability[campervan[:id]].include? 0
      end
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
