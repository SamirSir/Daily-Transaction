class ProfilesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!

  def index
    @profile = Profile.find_by_user_id(current_user.id)
  end

  def create
    Profile.create(name: params["name"], gender: params["gender"], age: params["age"].to_i, profile_pic: params["profile_pic"], cover_pic: params["cover_pic"], bio: params["bio"], user_id: current_user.id)
    redirect_to profiles_path(current_user.id)
  end

  def edit
    new_profile = Profile.find(params[:profile_id].to_i)
    new_profile.name = params[:name]
    new_profile.gender = params[:gender]
    new_profile.age = params[:age].to_i
    new_profile.bio = params[:bio]

    if (!params[:profile_pic].nil?)
      new_profile.profile_pic = params[:profile_pic]
    end

    if (!params[:cover_pic].nil?)
      new_profile.cover_pic = params[:cover_pic]
    end

    new_profile.save
    redirect_to profiles_path(current_user.id)
  end

end
