class ReportsController < ApplicationController
  include ReportsHelper

  require 'will_paginate/array'

  def home
    @incomes_pair = raw_data("SELECT source, amount FROM incomes WHERE INCOMES.USER_ID=#{current_user.id}")
    @savings_pair = raw_data("SELECT saved_on, amount FROM savings WHERE savings.USER_ID=#{current_user.id}")
    @expenses_pair = raw_data("SELECT spent_on, amount FROM expenses WHERE expenses.USER_ID=#{current_user.id}")
    @loans_pair = raw_data("SELECT loan_from, amount FROM loans WHERE loans.USER_ID=#{current_user.id}")

    @total_incomes = total_ise_amount @incomes_pair
    @total_savings = total_ise_amount @savings_pair
    @total_expenses = total_ise_amount @expenses_pair
    @total_loans = total_ise_amount @loans_pair
    @total_data = ({"Total Incomes": @total_incomes, "Total Savings": @total_savings, "Total Expenses": @total_expenses, "Total Loans": @total_loans})
    
    # suggestions 
    if @total_expenses+@total_savings > @total_incomes
      @warning_suggest = "Your are spending more than you earn!"
    end
  
    # Setup for nested line  chart
    # multiple line chart requires multiple name, data pair 
    # name must be unique and represents one line
    # data: for each line should contain same index with values 

    @income_amount_list = raw_data("SELECT INCOMES.AMOUNT FROM INCOMES WHERE INCOMES.USER_ID=#{current_user.id}")
    @saving_amount_list = raw_data("SELECT SAVINGS.AMOUNT FROM SAVINGS WHERE SAVINGS.USER_ID=#{current_user.id}")
    @expense_amount_list = raw_data("SELECT EXPENSES.AMOUNT FROM EXPENSES WHERE EXPENSES.USER_ID=#{current_user.id}")
    @loan_amount_list = raw_data("SELECT LOANS.AMOUNT FROM LOANS WHERE LOANS.USER_ID=#{current_user.id}")

    @ise_amount_list = [
        {name: "Incomes", data: cum_ise_amount_for_line(list_with_index(@income_amount_list))},
        {name: "Loan", data: cum_ise_amount_for_line(list_with_index(@loan_amount_list))}, 
        {name: "Expenses", data: cum_ise_amount_for_line(list_with_index(@expense_amount_list))}, 
        {name: "Saving", data: cum_ise_amount_for_line(list_with_index(@saving_amount_list))}
      ]

     
    # suggestion data in paginataion
    @suggestions = ["I am a super Hero", "I am not a super Hero 1", "I am a super Hero 2", "I am not a super Hero 4", "I am a super Hero 5", "I am not a super Hero 6"]
    @suggestions = @suggestions.paginate(page: params[:page], per_page: 1)
    
  end


end
