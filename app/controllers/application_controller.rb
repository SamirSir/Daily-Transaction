class ApplicationController < ActionController::Base
before_action :authenticate_user!

def raw_data(query)
    ActiveRecord::Base.connection.exec_query(query).rows
end

def labelled_data(query)
    ActiveRecord::Base.connection.execute(query)[0]
end

# GROUP and AMount
# ActiveRecord::Base.connection.exec_query("SELECT USER_ID, SUM(AMOUNT) AS TOTAL_AMOUNT FROM INCOMES WHERE GROUP_ID = 7 GROUP BY USER_ID")

#  ActiveRecord::Base.connection.exec_query("SELECT USER_ID, SUM(AMOUNT) AS MAX_AMOUNT FROM INCOMES GROUP BY USER_ID ORDER BY MAX_AMOUNT DE
# SC")[0]
def max_of(isel, group_id)
    raw_data("SELECT USER_ID, SUM(AMOUNT) AS MAX_AMOUNT FROM #{isel} WHERE GROUP_ID = #{group_id} GROUP BY USER_ID ORDER BY MAX_AMOUNT DESC")[0]
end

def min_of(isel, group_id)
    raw_data("SELECT USER_ID, SUM(AMOUNT) AS MIN_AMOUNT FROM #{isel} WHERE GROUP_ID = #{group_id} GROUP BY USER_ID ORDER BY MIN_AMOUNT")[0]
end

def get_formatted_date(dateTime)
    dateTime.strftime('%Y-%m-%d')
end
end
