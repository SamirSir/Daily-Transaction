class ProfilesController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def index
    @profile = labelled_data("SELECT * FROM PROFILES WHERE PROFILES.USER_ID = #{current_user.id}")
    # byebug
  end

  def create
    profile_params = params.permit!
    Profile.create(name: profile_params["person_name"], gender: profile_params["gender"], age: profile_params["age"].to_i, profile_pic: profile_params["profile_pic"], cover_pic: profile_params["cover_pic"], married: profile_params["married"], children: profile_params["children"].to_i, family_type: profile_params["family_type"], family_average_income: profile_params["family_average_income"].to_f, bio: profile_params["bio"], user_id: current_user.id)
    redirect_to profiles_path(current_user.id)
  end

end
