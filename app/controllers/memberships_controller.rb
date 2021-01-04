class MembershipsController < ApplicationController

    def create
        fparams = params.permit!
        user = User.find_by(email: fparams["member_email"])
        if !user.nil?
            # if user exist
            user_id = user.id
            group_id = fparams["group_id"]
            member_ids = Group.find(group_id).members.pluck("id")
            pending_member_ids = Group.find(group_id).pending_members.pluck("id")
            if user_id.in? member_ids 
                flash.alert = "#{user.email} is already a member !"
            elsif user_id.in? pending_member_ids
                flash.alert = "Request already sent to #{user.email} !"
            else
                Membership.create(group_id: group_id, user_id: user_id, confirmed: false, admin: false)
                flash.notice = "Request sent successfully !"
            end
        else
            flash.alert = "User not found !"
        end
    end
    
    def accept_membership
        fparams = params.permit!
        group_id = fparams["group_id"]
        Membership.find_by(group_id: group_id, user_id: current_user.id).update(confirmed: true)
        flash.notice = "Now you are member of '#{Group.find(group_id).name}' Group !"
    end

    def reject_membership
        fparams = params.permit!
        group_id = fparams["group_id"]
        Membership.find_by(group_id: group_id, user_id: current_user.id).destroy
        flash.notice = "You rejected '#{Group.find(group_id).name}' invitation !"
    end 

    def invitations
    end
end
