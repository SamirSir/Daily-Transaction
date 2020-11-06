module ReportsHelper

    # calculate the total of with second values of nested list, amount
    def total_ise_amount(ise)
        total = 0 
        ise.each do |obj|
          total = total + obj[1]  
        end
        return total
    end

    # convert singlton nested list to [indexe, value]
    def list_with_index(ise_amount_list)

        new_ise_amount_list = []

        ise_amount_list.each_with_index do |ise_amount, i|
        int_ise_amount = []
        int_ise_amount.push(i)
        int_ise_amount.push(ise_amount[0])
        new_ise_amount_list.push(int_ise_amount)
        end
        return new_ise_amount_list
    end

    # incremental summming of 2nd amount of list
    def cum_ise_amount_for_line(ise)
        mid_sum = 0
        ise_line_data = []
        ise.each do |obj|
            ise_tup = []
            mid_sum += obj[1]
            ise_tup.push(obj[0])
            ise_tup.push(mid_sum)
            ise_line_data.push(ise_tup)
        end
        return ise_line_data
    end



end
