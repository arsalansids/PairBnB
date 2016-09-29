class UsersController < ApplicationController
	def index
	
	end

	def edit
		@user = current_user
	end

    def update
    	if current_user.update(user_params)

    	redirect_to user_path(current_user.id)
    	else
    	redirect_to edit_user_path(current_user.id)
  		end
  	end 

  private
  	def user_params
        params.require(:user).permit(:email, :password, {avatars:[]})
    end
end
