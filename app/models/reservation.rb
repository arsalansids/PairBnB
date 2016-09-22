class Reservation < ActiveRecord::Base
	belongs_to :user
	belongs_to :listing
	validate :start_must_be_before_end_time
 	validate :start_must_be_from_today
 	validate :check_availability?

	def stay_duration
		stay = (self.end_date - self.start_date)/86400 
		return stay.to_i 
	end

	def total_price
		self.stay_duration * Listing.find(self.listing_id).price
	end

	def unavailable_dates
		previous_reserv_array = Reservation.where(listing_id: self.listing_id)
		date_array = []
		previous_reserv_array.each do |r|
			range = r.start_date.to_date..r.end_date.to_date-1

			(self.start_date.to_date..(self.end_date.to_date-1)).each do |date|
  			date_array << date if range === date
			end

		end
		return date_array if date_array[0] != nil
	end

 private

	def check_availability?
		previous_reserv_array = Reservation.where(listing_id: self.listing_id)
		x = 0
		previous_reserv_array.each do |r|
			range = r.start_date.to_date..r.end_date.to_date-1

			(self.start_date.to_date..(self.end_date.to_date-1)).each do |date|
  			x = 1 if range === date
			end

		end
		errors.add(:the, " dates listed below are already booked.") unless x == 0		
	end

    def start_must_be_before_end_time
        errors.add(:start_date, " must be before end date") unless
            start_date < end_date
    end

    def start_must_be_from_today
        errors.add(:booking, " must not begin before today") unless
            start_date >= Date::current()
    end
end


	# def check_availability?
	# 	previous_reserv_array = Reservation.where(self.listing_id)

	# 	previous_reserv_array.each do |r|
	# 		range = r.start_date..r.end_date

	# 		(self.start_date..self.end_date).each do |date|
 #  			return false if range === date
	# 		end

	# 	end
	# 	return true
	# end
