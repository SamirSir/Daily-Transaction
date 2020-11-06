class LoansController < ApplicationController
  
  skip_before_action :verify_authenticity_token, except: [:index]

  def index
    @loans = Loan.all.where(:user_id => current_user.id).order('id desc')
    @loans_for_graph = raw_data("SELECT LOANS.LOAN_FROM, LOANS.AMOUNT FROM LOANS WHERE LOANS.USER_ID = #{current_user.id} ORDER BY LOANS.ID DESC")
  end

  def create
    Loan.create(loan_from: params["title"], amount: params[:amount].to_f, description: params['description'], user_id: current_user.id)
    redirect_to :loans
  end

  def edit
    Loan.find(params[:id]).update(loan_from: params[:title], amount: params[:amount].to_f, description: params[:description] )
    redirect_to :loans
  end

  def delete
    Loan.find(params[:id]).delete
  end  

end
