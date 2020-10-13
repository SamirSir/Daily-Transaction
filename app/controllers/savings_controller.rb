class SavingsController < ApplicationController
  skip_before_action :verify_authenticity_token, except: [:index]

  def index 
    @savings = Saving.all.where(:user_id => current_user.id).order('id desc')
    @savings_for_graph = raw_data("SELECT SAVINGS.SAVED_ON, SAVINGS.AMOUNT FROM SAVINGS WHERE SAVINGS.USER_ID = #{current_user.id}")

  end

  def create
    Saving.create(saved_on: params["title"], amount: params[:amount].to_f, description: params['description'], user_id: current_user.id)
    redirect_to :savings
  end

  def edit
    Saving.find(params[:id]).update(saved_on: params[:title], amount: params[:amount].to_f, description: params[:description] )
    redirect_to :savings
  end

  def delete
    Saving.find(params[:id]).delete
  end  

end
