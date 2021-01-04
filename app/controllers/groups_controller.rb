class GroupsController < ApplicationController
    include ReportsHelper
    before_action :set_group, only: [:show, :personal]
    require 'will_paginate/array'
    
    def index
    end

    def show
        if @group.id == 0
            @incomes_pair = raw_data("SELECT source, amount FROM incomes WHERE INCOMES.USER_ID=#{current_user.id} AND INCOMES.GROUP_ID=#{@group.id}")
            @savings_pair = raw_data("SELECT saved_on, amount FROM savings WHERE SAVINGS.USER_ID=#{current_user.id} AND SAVINGS.GROUP_ID=#{@group.id}")
            @expenses_pair = raw_data("SELECT spent_on, amount FROM expenses WHERE EXPENSES.USER_ID=#{current_user.id} AND EXPENSES.GROUP_ID=#{@group.id}")
            @loans_pair = raw_data("SELECT loan_from, amount FROM loans WHERE LOANS.USER_ID=#{current_user.id} AND  LOANS.GROUP_ID=#{@group.id}")
           
            # for graph 
            @income_amount_list = raw_data("SELECT INCOMES.AMOUNT FROM INCOMES WHERE INCOMES.USER_ID=#{current_user.id} AND INCOMES.GROUP_ID=#{@group.id}")
            @saving_amount_list = raw_data("SELECT SAVINGS.AMOUNT FROM SAVINGS WHERE SAVINGS.USER_ID=#{current_user.id} AND SAVINGS.GROUP_ID=#{@group.id}")
            @expense_amount_list = raw_data("SELECT EXPENSES.AMOUNT FROM EXPENSES WHERE EXPENSES.USER_ID=#{current_user.id} AND EXPENSES.GROUP_ID=#{@group.id}")
            @loan_amount_list = raw_data("SELECT LOANS.AMOUNT FROM LOANS WHERE LOANS.USER_ID=#{current_user.id} AND  LOANS.GROUP_ID=#{@group.id}")
        else
            @incomes_pair = raw_data("SELECT source, amount FROM incomes WHERE INCOMES.GROUP_ID=#{@group.id}")
            @savings_pair = raw_data("SELECT saved_on, amount FROM savings WHERE SAVINGS.GROUP_ID=#{@group.id}")
            @expenses_pair = raw_data("SELECT spent_on, amount FROM expenses WHERE EXPENSES.GROUP_ID=#{@group.id}")
            @loans_pair = raw_data("SELECT loan_from, amount FROM loans WHERE  LOANS.GROUP_ID=#{@group.id}")
           
            # for graph 
            @income_amount_list = raw_data("SELECT INCOMES.AMOUNT FROM INCOMES WHERE INCOMES.GROUP_ID=#{@group.id}")
            @saving_amount_list = raw_data("SELECT SAVINGS.AMOUNT FROM SAVINGS WHERE SAVINGS.GROUP_ID=#{@group.id}")
            @expense_amount_list = raw_data("SELECT EXPENSES.AMOUNT FROM EXPENSES WHERE EXPENSES.GROUP_ID=#{@group.id}")
            @loan_amount_list = raw_data("SELECT LOANS.AMOUNT FROM LOANS WHERE  LOANS.GROUP_ID=#{@group.id}")
        end

        @total_incomes = total_ise_amount @incomes_pair
        @total_savings = total_ise_amount @savings_pair
        @total_expenses = total_ise_amount @expenses_pair
        @total_loans = total_ise_amount @loans_pair
        @total_data = ({"Total Incomes": @total_incomes, "Total Savings": @total_savings, "Total Expenses": @total_expenses, "Total Loans": @total_loans})
        
        # Setup for nested line  chart
        # multiple line chart requires multiple name, data pair 
        # name must be unique and represents one line
        # data: for each line should contain same index with values 

        @ise_amount_list = [
            {name: "Incomes", data: cum_ise_amount_for_line(list_with_index(@income_amount_list))},
            {name: "Loan", data: cum_ise_amount_for_line(list_with_index(@loan_amount_list))}, 
            {name: "Expenses", data: cum_ise_amount_for_line(list_with_index(@expense_amount_list))}, 
            {name: "Saving", data: cum_ise_amount_for_line(list_with_index(@saving_amount_list))}
        ]

        @incomes = @group.incomes
        @expenses = @group.expenses
        @savings = @group.savings
        @loans = @group.loans

        # suggestion data in paginataion
        @suggestions = ["I am a super Hero", "I am not a super Hero 1", "I am a super Hero 2", "I am not a super Hero 4", "I am a super Hero 5", "I am not a super Hero 6"]
        @suggestions = @suggestions.paginate(page: params[:page], per_page: 1)
    end

    def create
        fparams = params.permit!
        group_name = fparams["group_name"]
        if !group_name.nil? && group_name != ""
            Group.create(name: group_name)
            group_id = Group.last.id
            # creator of group is admin and member
            Membership.create(group_id: group_id, user_id: current_user.id, confirmed: true, admin: true)
            flash["notice"] = "Group created successfully!"
        else
            flash["alert"] = "Empty group name !"
        end
    end
    
    private
    
    def set_group
        @group = Group.find(params[:id])
    end
end
