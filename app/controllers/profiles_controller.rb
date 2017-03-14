class ProfilesController < ApplicationController
    before_action :authenticate_user!
    before_action :only_current_user
    
    #Get to /user/:user_id/profile/new 
    def new
     @profile = Profile.new
    end
    
    def create
          # Ensure that we have the user who is filling out form
       @user = User.find(params[:user_id])
         # Create profile linked to this specific user
       @profile = @user.build_profile(profile_params)
       if @profile.save
           flash[:sucess] = "Profile Updated!"
           redirect_to user_path( params[:user_id] )
        else
            reder action: :new
       end
    end
    
    # Get request to edit the Profile
    def edit
        @user = User.find( params[:user_id])
        @profile = @user.profile
    end
    
    def update
       @user = User.find(params[:user_id])
       @profile = @user.profile
       # This update the private function of the whole profile information
       if @profile.update_attributes(profile_params)
         #if the update was sucessful, flash the message the update was sucessful and redirect it to the user path.
         flash[:sucess] = "Update Sucessful"
         redirect_to user_path(id: params[:user_id])
        else
         render action:edit
       end
    end
    
    private 
        def profile_params
        params.require(:profile).permit(:first_name, :last_name, :avatar, :job_title, :phone_number, :contact_email, :description)
        end
        
        def only_current_user
            @user = User.find( params[:user_id])
            redirect_to(root_url) unless @user == current_user
        end
end