class ListingsController < ApplicationController
before_action :set_listing, only: [:show, :update, :edit, :destroy]
    #this means that before executing show, update, edit, destroy method, it finds what is the listing id
    
    def new 
        @listing = Listing.new
    end

   def create
        params[:listing][:tag_list] = params[:listing][:tag_list].join(',')
        @listing = current_user.listings.new(listing_params)
        if @listing.save
            #i want to go to my listing show page
            redirect_to listing_path(@listing.id)
        else
            render "new"
        end

    end
    
   def destroy
        Reservation.where(listing_id: @listing.id).destroy_all
        @listing.destroy
        redirect_to listings_path
    end

    def show
        
    end

    def tag
       @tagged = Listing.tagged_with(params[:tag_id])
       @tag = params[:tag_id]
    end

    def index 
        listings_per_page = 3
        params[:page] = 1 unless params[:page]
        first_listing = (params[:page].to_i - 1) * listings_per_page
        listings = Listing.all
        @total_pages = listings.count/listings_per_page
        if listings.count % listings_per_page > 0
            @total_pages += 1
        end
        @listing = listings[first_listing...(first_listing + listings_per_page)]
    end 

    def update
    params[:listing][:tag_list] = params[:listing][:tag_list].join(',')
      if @listing.update(listing_params)
    	redirect_to listing_path(@listing.id)
      else
    	render 'edit'
      end
	end 

    private
    #i define a set_listing method, so that i dont have to find the listing id for (show, update, edit, destroy)
    def set_listing
        @listing = Listing.find(params[:id])
    end

    #allows us list all of the params of listing
    def listing_params
        params.require(:listing).permit(:title, :location, :home_type, :price, :num_of_people, :user_id, :tag_list, {avatars:[]})
    end



    #adding avatars array 
    # def listing_params
    # params.require(:listing).permit(:name, :price, :location, {avatars:[]})
    # end
end