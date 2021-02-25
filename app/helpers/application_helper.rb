module ApplicationHelper

    def username(email)
        return email.split('@')[0]
    end

    def admin?(group_id, user_id)
        if group_id == 0
            true
        else
            User.find(Membership.find_by(group_id: group_id, admin: true).user_id).id == user_id
        end
    end
    # takes the ise as title and amount pair or any that has attribute amount
    def total_ise_amount(ise)
        total = 0
        ise.each do |obj|
            total = total + obj[1]
        end
        return total
    end

    def cum_ise_amount(ise)
        mid_sum = 0
        mid_title = ""
        ise_line_data = []
        ise.each do |obj|
            ise_tup = []
            mid_title += obj[0]
            mid_sum += obj[1]
            ise_tup.push(mid_title)
            ise_tup.push(mid_sum)
            ise_line_data.push(ise_tup)
            mid_title += " + "
        end
        return ise_line_data
    end

    def lise_color(ise_type)
        ise_type == "Income" ? "lightblue" : ise_type == "Saving" ? "lightgreen" : ise_type == "Expense" ? "rgb(245, 204, 202)" : "#e6d3f0" 
    end

    # group id finder
    def group_of(lise)
        lise.last.group_id
    end

    # get first letter of each word in a sentence

    def get_each_first_letter(string)
        string.split.map(&:first).join
    end

end
