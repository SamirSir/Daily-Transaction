module GroupsHelper
    def members_of_group(group_id)
        raw_data("select users.id, users.email from memberships left join users on memberships.user_id = users.id where memberships.group_id = #{group_id} and memberships.confirmed")
    end

    private

    def raw_data(query)
        ActiveRecord::Base.connection.exec_query(query).rows
    end

    def labelled_data(query)
        ActiveRecord::Base.connection.execute(query)[0]
    end
end
