class ReservationsController < ApplicationController
	def new
		@listing = Listing.find(params[:listing_id])
		@reservation = Reservation.new
	end

	def create
		@listing = Listing.find(params[:listing_id])
		@reservation = @listing.reservations.new(reservations_params)

		if @reservation.save
			redirect_to user_path(current_user.id)
        else
            @error = @reservation.errors.full_messages
            @unavailable = @reservation.unavailable_dates
  			#redirect_to new_listing_reservation_path(@listing.id)
  			render "new"
        end
	end

	def destroy #Using AJAX and JQUERY
		@reservation = Reservation.find(params[:id])
		@reservation.destroy
		respond_to do |format|
			format.html {redirect_to user_path(current_user.id)}
			format.js
		end
	end

	private
    def reservations_params
        params.require(:reservation).permit(:listing_id, :user_id, :start_date, :end_date)
    end
end
