module ApplicationHelper
  def username(user_id)
    profile = Profile.find_by(user_id: user_id)
    profile.nil? ? User.find(user_id).email.split('@')[0].capitalize : profile.name
  end

  def admin?(group_id, user_id)
    if group_id == 0
      true
    else
      User.find(Membership.find_by(group_id: group_id, admin: true).user_id).id == user_id
    end
  end

  def members_of_group(group_id)
    raw_data("select users.id, users.email from memberships left join users on memberships.user_id = users.id where memberships.group_id = #{group_id} and memberships.confirmed")
  end

  # takes the ise as title and amount pair or any that has attribute amount
  def total_ise_amount(ise)
    total = 0
    ise.each do |obj|
      total += obj[1]
    end
    total
  end

  def total_amount(isel)
    total = 0
    if !isel.nil?
      isel.each do |item|
        total += item.amount
      end
    end
    return total
  end

  def cum_ise_amount(ise)
    mid_sum = 0
    mid_title = ''
    ise_line_data = []
    ise.each do |obj|
      ise_tup = []
      mid_title += obj[0]
      mid_sum += obj[1]
      ise_tup.push(mid_title)
      ise_tup.push(mid_sum)
      ise_line_data.push(ise_tup)
      mid_title += ' + '
    end
    ise_line_data
  end

  # made for line chart
  # convert singlton nested list to [indexe, value]
  # def list_with_index(ise_amount_list)
  #     new_ise_amount_list = []
  #     ise_amount_list.each_with_index do |ise_amount, i|
  #     int_ise_amount = []
  #     int_ise_amount.push(i)
  #     int_ise_amount.push(ise_amount[0])
  #     new_ise_amount_list.push(int_ise_amount)
  #     end
  #     return new_ise_amount_list
  # end

  # made for line chart
  # incremental summming of 2nd amount of list
  # def cum_ise_amount_for_line(ise)
  #     mid_sum = 0
  #     ise_line_data = []
  #     ise.each do |obj|
  #         ise_tup = []
  #         mid_sum += obj[1]
  #         ise_tup.push(obj[0])
  #         ise_tup.push(mid_sum)
  #         ise_line_data.push(ise_tup)
  #     end
  #     return ise_line_data
  # end

  def lise_color(ise_type)
    if ise_type == 'Income'
      'lightblue'
    else
      if ise_type == 'Saving'
        'lightgreen'
      else
        ise_type == 'Expense' ? 'rgb(245, 204, 202)' : '#e6d3f0'
      end
    end
  end

  # group id finder
  def group_of(lise)
    lise.last.group_id
  end

  def get_readable_date_time(dateTime)
    dateTime.strftime('%B %d, %Y - %I:%M %p')
  end
  # get first letter of each word in a sentence

  def get_each_first_letter(string)
    string.split.map(&:first).join
  end

  def raw_data(query)
      ActiveRecord::Base.connection.exec_query(query).rows
  end

  def labelled_data(query)
      ActiveRecord::Base.connection.execute(query)[0]
  end

end
