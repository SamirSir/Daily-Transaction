class ExpensesController < ApplicationController
  skip_before_action :verify_authenticity_token, except: [:index]

  def index
    @expenses = Expense.all.where(:user_id => current_user.id).order("id desc")
    @expenses_for_graph = raw_data("SELECT EXPENSES.SPENT_ON, EXPENSES.AMOUNT FROM EXPENSES WHERE EXPENSES.USER_ID = #{current_user.id}")
  end

  def create
    Expense.create(spent_on: params["title"], amount: params[:amount].to_f, description: params["description"], user_id: current_user.id)
    redirect_to :expenses
  end

  def edit
    Expense.find(params[:id]).update(spent_on: params[:title], amount: params[:amount].to_f, description: params[:description])
    redirect_to :expenses
  end

  def delete
    Expense.find(params[:id]).delete
  end
end
