class SavingsController < ApplicationController
  skip_before_action :verify_authenticity_token, except: [:index]
  before_action :set_group

  def index 
    if @group.id == 0
      @savings = Saving.all.where(user_id: current_user.id, group_id: @group.id).order('id desc')
      @savings_for_graph = raw_data("SELECT SAVINGS.SAVED_ON, SAVINGS.AMOUNT FROM SAVINGS WHERE SAVINGS.USER_ID=#{current_user.id} AND SAVINGS.GROUP_ID=#{@group.id}")
    else
      @savings = Saving.all.where(group_id: @group.id).order('id desc')
      @savings_for_graph = raw_data("SELECT SAVINGS.SAVED_ON, SAVINGS.AMOUNT FROM SAVINGS WHERE SAVINGS.GROUP_ID=#{@group.id}")
    end
  end

  def create
    Saving.create(saved_on: params["title"], amount: params[:amount].to_f, description: params['description'], user_id: current_user.id, group_id: @group.id)
    redirect_to :savings
  end

  def edit
    Saving.find(params[:edit_id]).update(saved_on: params[:title], amount: params[:amount].to_f, description: params[:description])
    redirect_to :savings
  end

  def delete
    Saving.find(params[:delete_id]).delete
  end 

  private
 
  def set_group
    @group = Group.find(params[:id])
  end

end
