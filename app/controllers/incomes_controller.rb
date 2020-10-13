class IncomesController < ApplicationController

  skip_before_action :verify_authenticity_token, except: [:index]

  def index
    @incomes = Income.all.where(:user_id => current_user.id).order('id desc')
    @incomes_for_graph = raw_data("SELECT INCOMES.SOURCE, INCOMES.AMOUNT FROM INCOMES WHERE INCOMES.USER_ID = #{current_user.id} ORDER BY INCOMES.ID DESC")
  end

  def create
    Income.create(source: params["title"], amount: params[:amount].to_f, description: params['description'], user_id: current_user.id)
    redirect_to :incomes
  end

  def edit
    Income.find(params[:id]).update(source: params[:title], amount: params[:amount].to_f, description: params[:description] )
    redirect_to :incomes
  end

  def delete
    Income.find(params[:id]).delete
  end  

end
