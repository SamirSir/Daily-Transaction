# frozen literal string

class GroupsController < ApplicationController
include ReportsHelper
before_action :set_group, only: %i[show personal setting]
before_action :authenticate_user!
require 'will_paginate/array'

def index; end

# ActiveRecord::Base.connection.exec_query("SELECT *  FROM incomes WHERE INCOMES.CREATED_AT BETWEEN '#{date_from}' AND '#{date_to# today}'").rows.count
def show
    # date filter
    @date_from = params['date_from'].present? ? params['date_from'] : Date.today - 1.months
    @date_to = params['date_to'].present? ? params['date_to'] : Date.today
    unless params['date_from'].nil?
        params.permit!
        if params['date_from'] != '' || params['date_to'] != ''
            if params['date_from'].to_date < params['date_to'].to_date
                @date_from = params['date_from'].to_date
                @date_to = params['date_to'].to_date
            else
                flash['alert'] = 'Date must not be empty!'
            end
        else
            flash['alert'] = 'To date must be greater than from date!'
        end
    end

    if @group.id.zero?
        @incomes_pair = raw_data("SELECT source, amount FROM incomes WHERE INCOMES.USER_ID=#{current_user.id} AND INCOMES.GROUP_ID=#{@group.id} AND INCOMES.CREATED_AT BETWEEN '#{@date_from}' AND '#{@date_to}'")
        @savings_pair = raw_data("SELECT saved_on, amount FROM savings WHERE SAVINGS.USER_ID=#{current_user.id} AND SAVINGS.GROUP_ID=#{@group.id} AND SAVINGS.CREATED_AT BETWEEN '#{@date_from}' AND '#{@date_to}'")
        @expenses_pair = raw_data("SELECT spent_on, amount FROM expenses WHERE EXPENSES.USER_ID=#{current_user.id} AND EXPENSES.GROUP_ID=#{@group.id} AND EXPENSES.CREATED_AT BETWEEN '#{@date_from}' AND '#{@date_to}'")
        @loans_pair = raw_data("SELECT loan_from, amount FROM loans WHERE LOANS.USER_ID=#{current_user.id} AND  LOANS.GROUP_ID=#{@group.id} AND LOANS.CREATED_AT BETWEEN '#{@date_from}' AND '#{@date_to}'")
        # for graph
        @income_amount_list = raw_data("SELECT INCOMES.AMOUNT FROM INCOMES WHERE INCOMES.USER_ID=#{current_user.id} AND INCOMES.GROUP_ID=#{@group.id} AND INCOMES.CREATED_AT BETWEEN '#{@date_from}' AND '#{@date_to}'")
        @saving_amount_list = raw_data("SELECT SAVINGS.AMOUNT FROM SAVINGS WHERE SAVINGS.USER_ID=#{current_user.id} AND SAVINGS.GROUP_ID=#{@group.id} AND SAVINGS.CREATED_AT BETWEEN '#{@date_from}' AND '#{@date_to}'")
        @expense_amount_list = raw_data("SELECT EXPENSES.AMOUNT FROM EXPENSES WHERE EXPENSES.USER_ID=#{current_user.id} AND EXPENSES.GROUP_ID=#{@group.id} AND EXPENSES.CREATED_AT BETWEEN '#{@date_from}' AND '#{@date_to}'")
        @loan_amount_list = raw_data("SELECT LOANS.AMOUNT FROM LOANS WHERE LOANS.USER_ID=#{current_user.id} AND  LOANS.GROUP_ID=#{@group.id} AND LOANS.CREATED_AT BETWEEN '#{@date_from}' AND '#{@date_to}'")
    else
        @incomes_pair = raw_data("SELECT source, amount FROM incomes WHERE INCOMES.GROUP_ID=#{@group.id} AND INCOMES.CREATED_AT BETWEEN '#{@date_from}' AND '#{@date_to}'")
        @savings_pair = raw_data("SELECT saved_on, amount FROM savings WHERE SAVINGS.GROUP_ID=#{@group.id} AND SAVINGS.CREATED_AT BETWEEN '#{@date_from}' AND '#{@date_to}'")
        @expenses_pair = raw_data("SELECT spent_on, amount FROM expenses WHERE EXPENSES.GROUP_ID=#{@group.id} AND EXPENSES.CREATED_AT BETWEEN '#{@date_from}' AND '#{@date_to}'")
        @loans_pair = raw_data("SELECT loan_from, amount FROM loans WHERE  LOANS.GROUP_ID=#{@group.id} AND LOANS.CREATED_AT BETWEEN '#{@date_from}' AND '#{@date_to}'")

        # for graph
        @income_amount_list = raw_data("SELECT INCOMES.AMOUNT FROM INCOMES WHERE INCOMES.GROUP_ID=#{@group.id} AND INCOMES.CREATED_AT BETWEEN '#{@date_from}' AND '#{@date_to}'")
        @saving_amount_list = raw_data("SELECT SAVINGS.AMOUNT FROM SAVINGS WHERE SAVINGS.GROUP_ID=#{@group.id} AND SAVINGS.CREATED_AT BETWEEN '#{@date_from}' AND '#{@date_to}'")
        @expense_amount_list = raw_data("SELECT EXPENSES.AMOUNT FROM EXPENSES WHERE EXPENSES.GROUP_ID=#{@group.id} AND EXPENSES.CREATED_AT BETWEEN '#{@date_from}' AND '#{@date_to}'")
        @loan_amount_list = raw_data("SELECT LOANS.AMOUNT FROM LOANS WHERE  LOANS.GROUP_ID=#{@group.id} AND LOANS.CREATED_AT BETWEEN '#{@date_from}' AND '#{@date_to}'")
    end

    @total_incomes = total_ise_amount @incomes_pair
    @total_savings = total_ise_amount @savings_pair
    @total_expenses = total_ise_amount @expenses_pair
    @total_loans = total_ise_amount @loans_pair
    @total_data = { "Total Incomes": @total_incomes, "Total Savings": @total_savings, "Total Expenses": @total_expenses, "Total Loans": @total_loans }
    # Setup for nested line  chart
    # multiple line chart requires multiple name, data pair
    # name must be unique and represents one line
    # data: for each line should contain same index with values

    @ise_amount_list = [
        { name: 'Incomes', data: cum_ise_amount_for_line(list_with_index(@income_amount_list)) },
        { name: 'Loan', data: cum_ise_amount_for_line(list_with_index(@loan_amount_list)) },
        { name: 'Expenses', data: cum_ise_amount_for_line(list_with_index(@expense_amount_list)) },
        { name: 'Saving', data: cum_ise_amount_for_line(list_with_index(@saving_amount_list)) }
    ]

    @incomes = @group.incomes
    @expenses = @group.expenses
    @savings = @group.savings
    @loans = @group.loans
end

def create
    fparams = params.permit!
    group_name = fparams['group_name']
    if !group_name.nil? && group_name != ''
        Group.create(name: group_name)
        group_id = Group.last.id
        # creator of group is admin and member
        Membership.create(group_id: group_id, user_id: current_user.id, confirmed: true, admin: true)
        flash['notice'] = 'Group created successfully!'
    else
        flash['alert'] = 'Empty group name !'
    end
end

def setting; end

private

def set_group
    @group = Group.find(params[:id])
end
end
