module ApplicationHelper

    def username(email)
        return email.split('@')[0]
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

end
