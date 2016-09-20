class ListingsController < ApplicationController
before_action :set_listing, only: [:show, :update, :edit, :destroy]
    #this means that before executing show, update, edit, destroy method, it finds what is the listing id
    
    def new 
        @listing = Listing.new
    end

   def create
        @listing = current_user.listings.new(listing_params)
        if @listing.save
            #i want to go to my listing show page
            redirect_to listing_path(@listing.id)
        else
            render "new"
        end

    end
    
    def show
        
    end

	# def edit
        
 #    end

    def update
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
        params.require(:listing).permit(:title, :location, :home_type, :price, :num_of_people, :user_id, {avatars:[]})
    end

    #adding avatars array 
    # def listing_params
    # params.require(:listing).permit(:name, :price, :location, {avatars:[]})
    # end
end