class ApplicationController < ActionController::Base
    before_action :authenticate_user!

    def raw_data(query) 
        return ActiveRecord::Base.connection.exec_query(query).rows
    end
end
