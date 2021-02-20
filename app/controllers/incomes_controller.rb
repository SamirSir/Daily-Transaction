class IncomesController < ApplicationController

  skip_before_action :verify_authenticity_token, except: [:index]
  before_action :set_group
  before_action :authenticate_user!

  def index
    if @group.id == 0
      @incomes = Income.all.where(user_id: current_user.id, group_id: @group.id).order('id desc')
      @incomes_for_graph = raw_data("SELECT INCOMES.SOURCE, INCOMES.AMOUNT FROM INCOMES WHERE INCOMES.USER_ID=#{current_user.id} AND INCOMES.GROUP_ID=#{@group.id} ORDER BY INCOMES.ID DESC")
    else
      @incomes = Income.all.where(group_id: @group.id).order('id desc')
      @incomes_for_graph = raw_data("SELECT INCOMES.SOURCE, INCOMES.AMOUNT FROM INCOMES WHERE INCOMES.GROUP_ID=#{@group.id} ORDER BY INCOMES.ID DESC")
    end
  end

  def create
    Income.create(source: params["title"], amount: params[:amount].to_f, description: params['description'], user_id: current_user.id, group_id: @group.id)
    redirect_to :incomes
  end

  def edit
    Income.find(params[:edit_id]).update(source: params[:title], amount: params[:amount].to_f, description: params[:description])
    redirect_to :incomes
  end

  def delete
    Income.find(params[:delete_id]).delete
  end  

  private
  
  def set_group
    @group = Group.find(params[:id])
  end

end
