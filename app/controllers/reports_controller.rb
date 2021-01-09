class ReportsController < ApplicationController
  include ReportsHelper
  before_action :set_group

  require 'will_paginate/array'

  def index
  end

  def notifications
    # GROUP and AMount
    # ActiveRecord::Base.connection.exec_query("SELECT USER_ID, SUM(AMOUNT) AS TOTAL_AMOUNT FROM INCOMES WHERE GROUP_ID = 7 GROUP BY USER_ID")

    #  ActiveRecord::Base.connection.exec_query("SELECT USER_ID, SUM(AMOUNT) AS MAX_AMOUNT FROM INCOMES GROUP BY USER_ID ORDER BY MAX_AMOUNT DE
    # SC")[0]
    
  end

  private 

  def set_group
    @group = Group.find(params[:id]) 
  end

end

