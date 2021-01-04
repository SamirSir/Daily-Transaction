class Group < ApplicationRecord

    has_many :loans
    has_many :incomes
    has_many :expenses
    has_many :savings

    has_many :memberships, :dependent => :destroy
    has_many :users, through: :memberships, :dependent => :destroy
   
    
    # helper
    #  requested member
    def pending_members
        memberships.map{ |membership| membership.user if !membership.confirmed }.compact
    end

    # confirmed
    def members
        memberships.map{ |membership| membership.user if membership.confirmed }.compact
    end

    # admin of group
    def group_admin
        memberships.map{ |membership| membership.user if membership.admin }.compact
    end

end
