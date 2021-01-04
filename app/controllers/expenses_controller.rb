class ExpensesController < ApplicationController
  skip_before_action :verify_authenticity_token, except: [:index]
  before_action :set_group

  def index
    if @group.id == 0
      @expenses = Expense.all.where(user_id: current_user.id, group_id: @group.id).order("id desc")
      @expenses_for_graph = raw_data("SELECT EXPENSES.SPENT_ON, EXPENSES.AMOUNT FROM EXPENSES WHERE EXPENSES.USER_ID= #{current_user.id} AND EXPENSES.GROUP_ID=#{@group.id}")
    else
      @expenses = Expense.all.where(group_id: @group.id).order("id desc")
      @expenses_for_graph = raw_data("SELECT EXPENSES.SPENT_ON, EXPENSES.AMOUNT FROM EXPENSES WHERE EXPENSES.GROUP_ID=#{@group.id}")
    end
  end

  def create
    Expense.create(spent_on: params["title"], amount: params[:amount].to_f, description: params["description"], user_id: current_user.id, group_id: @group.id)
    redirect_to :expenses
  end

  def edit
    Expense.find(params[:edit_id]).update(spent_on: params[:title], amount: params[:amount].to_f, description: params[:description])
    redirect_to :expenses
  end

  def delete
    Expense.find(params[:delete_id]).delete
  end

  private
  
  def set_group
    @group = Group.find(params[:id])
  end

end
