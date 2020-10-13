class ReportsController < ApplicationController
  def home
    @incomes_pair =raw_data("SELECT source, amount FROM incomes")
  end

end
