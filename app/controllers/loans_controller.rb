class LoansController < ApplicationController

  skip_before_action :verify_authenticity_token, except: [:index]
  before_action :set_group
  before_action :authenticate_user!

  def index
    if @group.id == 0
      @loans = Loan.all.where(user_id: current_user.id, group_id: @group.id).order('id desc')
      @loans_for_graph = raw_data("SELECT LOANS.LOAN_FROM, LOANS.AMOUNT FROM LOANS WHERE LOANS.USER_ID=#{current_user.id} AND LOANS.GROUP_ID =#{@group.id} ORDER BY LOANS.ID DESC")
    else
      @loans = Loan.all.where( group_id: @group.id).order('id desc')
      @loans_for_graph = raw_data("SELECT LOANS.LOAN_FROM, LOANS.AMOUNT FROM LOANS WHERE LOANS.GROUP_ID =#{@group.id} ORDER BY LOANS.ID DESC")
    end
  end

  def create
    Loan.create(loan_from: params["title"], amount: params[:amount].to_f, description: params['description'], user_id: current_user.id, group_id: @group.id)
    redirect_to :loans
  end

  def edit
    Loan.find(params[:edit_id]).update(loan_from: params[:title], amount: params[:amount].to_f, description: params[:description])
    redirect_to :loans
  end

  def delete
    Loan.find(params[:delete_id]).delete
  end

  def pay_loan
    loan_id = params['pay_loan_id'].to_i
    actual_amount = Loan.find(loan_id).amount
    paid_amount = params['amount'].to_f
    remaining_amount = actual_amount - paid_amount
    Loan.find(loan_id).update(amount: remaining_amount)
    redirect_to :loans
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end


end
