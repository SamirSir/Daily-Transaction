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
end
